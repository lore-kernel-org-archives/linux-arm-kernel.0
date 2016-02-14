From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sun, 14 Feb 2016 15:06:27 +0900
Subject: [next] Odroid XU3 easily over-heats
Message-ID: <56C01963.3080106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

With recent addition of cpufreq-dt support to Exynos5422
it is very easy to over-heat the Odroid XU3 leading to critical shutdown:
[  132.622032] thermal thermal_zone3: critical temperature reached(121 C),shutting down


Reproduction:
0. next-20160212 (with recent fix for OPP from Viresh)
1. multi_v7 (on exynos defconfig there is no cpufreq for Exynos5422)
2. Run following test script:
https://github.com/krzk/tools/blob/master/tests/odroid-xu3-cpu-mmc-stress.sh

(the script essentially does only "cat /dev/mmcblk0p2 | gzip -c > /dev/null" for each CPU)

Observe, just before shutdown:
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq:1300000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq:200000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency:154000
/sys/devices/system/cpu/cpu0/cpufreq/related_cpus:0 1 2 3
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies:200000 300000 400000 500000 600000 700000 800000 900000 1000000 1100000 1200000 1300000 
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors:ondemand performance 
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:1300000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_driver:cpufreq-dt
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:ondemand
/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq:1300000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq:200000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed:<unsupported>

/sys/class/thermal/thermal_zone0/temp:90000
/sys/class/thermal/thermal_zone1/temp:98000
/sys/class/thermal/thermal_zone2/temp:113000
/sys/class/thermal/thermal_zone3/temp:119000
/sys/class/thermal/thermal_zone4/temp:81000

/sys/class/thermal/cooling_device0/cur_state:3
/sys/class/thermal/cooling_device0/max_state:3
/sys/class/thermal/cooling_device0/type:pwm-fan

Fan is working but shutdown is immediate.

What about cpufreq as cooling device? Probably that part
is missing now, right?

Best regards,
Krzysztof
