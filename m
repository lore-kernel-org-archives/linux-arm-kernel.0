From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 25 Nov 2014 11:57:47 -0800
Subject: [PATCH v12 0/6] cpufreq: use generic cpufreq drivers for exynos
 platforms
In-Reply-To: <7hioi4l92v.fsf@deeprootsystems.com>
References: <1416576682-5255-1-git-send-email-thomas.ab@samsung.com>
 <7hioi4l92v.fsf@deeprootsystems.com>
Message-ID: <CAMAWPa87AFhtFaCo3RSY_qD+1DSmvhU8idOLvYwadkk5GLwaOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Mon, Nov 24, 2014 at 10:58 AM, Kevin Hilman <khilman@kernel.org> wrote:

[...]

> Second, as with earlier versions of this series, I'm still seeing lots
> of "wait_until_divider_stable: timeout in divider stablization" messages
> coming out when running powertop.

I found a simpler way to reproduce these messages.  If I simply use
the userspace governor and cycle through all the A7 OPPs, I'll hit
this message (script below[1]).  Note that I'm also using my DTS
change that fixes the vdd_arm and vdd_kfc voltages to a voltage that
is high enough for all the OPPs.

Kevin

[1]
#!/bin/sh
cpu=cpu4
reg_name=vdd_kfc
cpu_reg=$(dirname `find /sys/class/regulator/regulator.*/ -name name
-exec grep -l $reg_name {} \;`)
echo $cpu_reg

# Cycle through frequencies (and check voltage)
cd /sys/devices/system/cpu/$cpu/cpufreq
echo userspace > scaling_governor
for freq in `cat scaling_available_frequencies`; do
  echo ${freq} > scaling_setspeed
  echo -n "current freq: "
  cat scaling_cur_freq
  echo -n "current voltage: "
  cat ${cpu_reg}/microvolts
  sleep 1
done
