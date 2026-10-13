#!/bin/bash
echo "===== SERVER HEALTH REPORT ====="
echo "Hostname: $(hostname)"
echo "IP Address: $(hostname -I)"

DISK_USAGE=$(df -P / |awk 'NR==2 {print $5}' | tr -d '%')
echo "Disk Usage: ${DISK_USAGE}%"
if [ "$DISK_USAGE" -ge 80 ];then
   echo "WARNING : Disk is high"
else
   echo "Disk status :Normal"
fi
echo "RAM Used: $(free -h | awk 'NR==2 {print $3}')"
echo "CPU Usage: $(top -bn1 | grep '%Cpu(s)' | awk '{print 100 - $8 "%"}')"
echo "Network: $(ping -c 1 -W 1 google.com >/dev/null 2>&1 && echo "UP" || echo "DOWN")"
echo "===== END OF REPORT ====="
