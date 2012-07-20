From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 20 Jul 2012 20:33:19 +0800
Subject: [PATCH 3/3] cpufreq: Add a generic cpufreq-cpu0 driver
In-Reply-To: <CAMQu2gw32LogXJJa+K5ZjmCZzBNK3FY2wYwZXU8fsftsVzEO2Q@mail.gmail.com>
References: <1342713281-31114-1-git-send-email-shawn.guo@linaro.org>
 <1342713281-31114-4-git-send-email-shawn.guo@linaro.org>
 <CAMQu2gw32LogXJJa+K5ZjmCZzBNK3FY2wYwZXU8fsftsVzEO2Q@mail.gmail.com>
Message-ID: <20120720123317.GA32263@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the reviewing, Santosh.

On Fri, Jul 20, 2012 at 12:22:14PM +0530, Shilimkar, Santosh wrote:
> > +config GENERIC_CPUFREQ_CPU0
> > +       bool "Generic cpufreq driver for CPU0"
> > +       depends on HAVE_CLK && REGULATOR && PM_OPP && OF
> > +       select CPU_FREQ_TABLE
> > +       help
> > +         This adds a generic cpufreq driver for CPU0 frequency management.
> > +         It supports both uniprocessor (UP) and symmetric multiprocessor (SMP)
> > +         systems which share clock and voltage across all CPUs.
> > +
> > +         If in doubt, say N.
> > +
> This *_CPU0 doesn't seems to be appropriate since this infrastructure will be
> used on SMP systems where CPUs shares clock/voltage rails. May be you can
> get rid of that unless there is a strong need.
> 
All the resource handlers, clk, regulator, opp, DT node, are retrieved
from CPU0 device even for SMP.  I hope the naming of the driver could
tell:

- The driver supports UP
- The driver supports SMP where CPUs shares clock/voltage rails by
  managing CPU0 (resource)
- The driver does not support SMP where individual CPU can scale
  clock/voltage independently.

I also thought about naming the driver cpufreq-coupled, but the name
misses the implication of UP support somehow, so I chose cpufreq-cpu0.

> > +static int cpu0_set_target(struct cpufreq_policy *policy,
> > +                          unsigned int target_freq, unsigned int relation)
> > +{
> > +       struct cpufreq_freqs freqs;
> > +       struct opp *opp;
> > +       unsigned long freq_Hz, volt = 0, volt_old = 0, tol = 0;
> > +       unsigned int index, cpu;
> > +       int ret = 0;
> > +
> > +       ret = cpufreq_frequency_table_target(policy, freq_table, target_freq,
> > +                                            relation, &index);
> > +       if (ret) {
> > +               pr_err("failed to match target freqency %d: %d\n",
> > +                      target_freq, ret);
> > +               return ret;
> > +       }
> > +
> > +       freq_Hz = clk_round_rate(cpu_clk, freq_table[index].frequency * 1000);
> > +       if (freq_Hz < 0)
> > +               freq_Hz = freq_table[index].frequency * 1000;
> > +       freqs.new = freq_Hz / 1000;
> > +       freqs.old = clk_get_rate(cpu_clk) / 1000;
> > +
> > +       if (freqs.old == freqs.new)
> > +               return 0;
> > +
> > +       for_each_cpu(cpu, policy->cpus) {
> You need for_each_online_cpu() here o.w you will end up calling the
> notifier on CPU which is are hot-plugged out or not online yet.
> 
Yes, that's sensible.  Since we have all the CPUs set in policy->cpus
in this driver, we do not have to enumerate policy->cpus, and checking
online CPUs should be better for the cases you mentioned.

> > +               freqs.cpu = cpu;
> > +               cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> > +       }
> > +
> > +       if (cpu_reg) {
> > +               opp = opp_find_freq_ceil(cpu_dev, &freq_Hz);
> > +               if (IS_ERR(opp)) {
> > +                       pr_err("failed to find OPP for %ld\n", freq_Hz);
> > +                       return PTR_ERR(opp);
> > +               }
> > +               volt = opp_get_voltage(opp);
> > +               tol = volt * voltage_tolerance / 100;
> > +               volt_old = regulator_get_voltage(cpu_reg);
> > +       }
> > +
> > +       pr_debug("%u MHz, %ld mV --> %u MHz, %ld mV\n",
> > +                freqs.old / 1000, volt_old ? volt_old / 1000 : -1,
> > +                freqs.new / 1000, volt ? volt / 1000 : -1);
> > +
> > +       /* scaling up?  scale voltage before frequency */
> > +       if (cpu_reg && freqs.new > freqs.old) {
> > +               if (regulator_set_voltage(cpu_reg, volt - tol, volt + tol)) {
> > +                       pr_warn("Unable to scale voltage up\n");
> > +                       freqs.new = freqs.old;
> > +                       goto done;
> Do you need a POST notifier in case of the failure ?
> 
Honestly, I'm not quite sure about that.  This is a piece of code
reused from omap-cpufreq driver.  Looking at cpufreq_notify_transition,
it seems to me that the POST notifier is not really necessary for
failure case.

> > +static struct cpufreq_driver cpu0_cpufreq_driver = {
> > +       .flags = CPUFREQ_STICKY,
> > +       .verify = cpu0_verify_speed,
> > +       .target = cpu0_set_target,
> > +       .get = cpu0_get_speed,
> > +       .init = cpu0_cpufreq_init,
> > +       .exit = cpu0_cpufreq_exit,
> > +       .name = "generic_cpu0",
> > +       .attr = cpu0_cpufreq_attr,
> > +};
> > +
> > +static int __devinit cpu0_cpufreq_driver_init(void)
> > +{
> > +       return cpufreq_register_driver(&cpu0_cpufreq_driver);
> > +}
> > +late_initcall(cpu0_cpufreq_driver_init);
> 
> Can you also add support to build this as loadable module ?
> 
I'm just following the common pattern of ARM cpufreq drivers to have
CPUFREQ_STICKY set in cpufreq_driver.flag and use "bool" for the driver
Kconfig.  I'm not sure about the necessity of building this as a module.

-- 
Regards,
Shawn
