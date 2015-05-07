From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Thu, 7 May 2015 17:40:36 +0800
Subject: [PATCH 1/2] cpufreq: mediatek: Add MT8173 cpufreq driver
In-Reply-To: <20150430074218.GH4946@pengutronix.de>
References: <1429522047-16675-1-git-send-email-pi-cheng.chen@linaro.org>
 <1429522047-16675-2-git-send-email-pi-cheng.chen@linaro.org>
 <20150430074218.GH4946@pengutronix.de>
Message-ID: <CALx668VMQG98fL943Kku=i4bG5RXRxpTdHu9SerooCBLHKuQBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 3:42 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Mon, Apr 20, 2015 at 05:27:26PM +0800, pi-cheng.chen wrote:
>> This patch implements MT8173 specific cpufreq driver with OPP table defined
>> in the driver code.
>>
>> Signed-off-by: pi-cheng.chen <pi-cheng.chen@linaro.org>
>> ---
>>  drivers/cpufreq/Kconfig.arm      |   6 +
>>  drivers/cpufreq/Makefile         |   1 +
>>  drivers/cpufreq/mt8173-cpufreq.c | 509 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 516 insertions(+)
>>  create mode 100644 drivers/cpufreq/mt8173-cpufreq.c
>>
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index 1b06fc4..25643c7 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> +
>> +static int mt8173_cpufreq_dvfs_init(struct cpu_dvfs_info *info)
>> +{
>> +     struct device *cpu_dev;
>> +     struct regulator *proc_reg, *sram_reg;
>> +     struct clk *cpu_clk, *inter_pll;
>> +     unsigned long rate;
>> +     int cpu, ret;
>> +
>> +     cpu = cpumask_first(&info->cpus);
>> +
>> +try_next_cpu:
>> +     cpu_dev = get_cpu_device(cpu);
>> +     proc_reg = regulator_get_exclusive(cpu_dev, "proc");
>> +     sram_reg = regulator_get_exclusive(cpu_dev, "sram");
>> +     cpu_clk = clk_get(cpu_dev, "cpu");
>> +     inter_pll = clk_get(cpu_dev, "intermediate");
>> +
>> +     if (IS_ERR_OR_NULL(proc_reg) || IS_ERR_OR_NULL(cpu_clk) ||
>> +         IS_ERR_OR_NULL(inter_pll)) {
>> +             cpu = cpumask_next(cpu, &info->cpus);
>> +             if (cpu >= nr_cpu_ids)
>> +                     return -ENODEV;
>> +
>> +             goto try_next_cpu;
>> +     }
>
> Please keep an eye on the error pathes. This one is quite broken. You
> get references to resources here which you never release. Also
> -EPROBE_DEFER is a valid return value from regulator_get which is not
> handled here.
>
> Also IS_ERR_OR_NULL() is most probably wrong here. Should be IS_ERR().

I'll review the error handling path and fix them.
Thanks for reviewing.

Best Regards,
Pi-Cheng

>
> Sascha
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
