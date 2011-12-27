From: richard.zhao@linaro.org (Richard Zhao)
Date: Tue, 27 Dec 2011 16:24:15 +0800
Subject: [PATCH V5 0/7] add a generic cpufreq driver
Message-ID: <1324974262-30963-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver is based on clock and regulator APIs and  support single core
and multi core ARM SoCs. For multi core, it assume all cores share the
same clock and voltage.

Thanks Arnd, Mark, Jamie, Rob, for your review.

Changes in V5:
 - add more comments
 - rename trans-latency to clk-trans-latency, and it only describe clk
   latency. Regulator latency is got from regulator_set_voltage_time.

Changes in v4:
 - add depends on HAVE_CLK && OF && REGULATOR
 - add set_cpu_freq fail check
 - regulator_put wehn module exit
 - add pr_fmt and convert all printk to pr_xxx
 - use voltage range
 - comment and doc fix
 - add cpu_volts value pre-check in module init
 - add helpfull module parameter max_freq
 - remove compatible string check on Arnd's comment.
 - remove generic-cpufreq to clk-reg-cpufreq

Changes in v3:
 - move adjusting smp loops_per_jiffy to arm common code,
   and also adjust global loops_per_jiffy.
 - remove adjusting loops_per_jiffy in imx and omap cpufreq drivers.
 - check compatible "generic-cpufreq" when module_init
 - change printk to pr_xxx
 - add generic-cpufreq DT binding doc

Changes in v2:
 - add volatage change support
 - change '_' in property name to '-'
 - use initial value to calculate loops_per_jiffy
 - fix reading cpu_volts property bug 
 - let cpufreq_frequency_table_cpuinfo routines handle cpu_freq_khz_max/min
 - don't change freq in arm_cpufreq_exit, because every core share the same freq.
 - use unsigned long describe frequency as much as possible. Because clk use
   unsigned long, but cpufreq use unsigned int.


[PATCH V5 1/7] ARM: add cpufreq transiton notifier to adjust
[PATCH V5 2/7] arm/imx: cpufreq: remove loops_per_jiffy recalculate
[PATCH V5 3/7] cpufreq: OMAP: remove loops_per_jiffy recalculate for
[PATCH V5 4/7] cpufreq: add clk-reg cpufreq driver
[PATCH V5 5/7] dts/imx6q: add cpufreq property
[PATCH V5 6/7] arm/imx6q: register arm_clk as cpu to clkdev
[PATCH V5 7/7] arm/imx6q: select ARCH_HAS_CPUFREQ

Thanks
Richard
