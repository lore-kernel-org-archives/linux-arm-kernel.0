From: mcuos.com@gmail.com (Wan ZongShun)
Date: Tue, 22 Dec 2009 16:04:21 +0800
Subject: [PATCH v2 RESEND] ARM: NUC900: Add cpufreq driver for nuc900 CPUs
In-Reply-To: <4B2F841C.3040800@gmail.com>
References: <8fb2581d0912210151s6402b33ci6415b75fb73df95a@mail.gmail.com>
	<4B2F841C.3040800@gmail.com>
Message-ID: <e68bb3470912220004l1e782588qaded96061ad0f319@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Li

Some errors occur below!

Please check your patch.

scripts/checkpatch.pl ../patch-winbond/lijie-nuc900/cpufreq-for-nuc900-v2.patch
ERROR: patch seems to be corrupt (line wrapped?)
#55: FILE: arch/arm/mach-w90x900/cpu.h:48:
unsigned char *src);

WARNING: space prohibited between function name and open parenthesis '('
#217: FILE: arch/arm/mach-w90x900/cpufreq.c:149:
+MODULE_AUTHOR ("Li Jie <eltshanli@gmail.com>");

WARNING: space prohibited between function name and open parenthesis '('
#218: FILE: arch/arm/mach-w90x900/cpufreq.c:150:
+MODULE_DESCRIPTION ("cpufreq driver for NUC900");

WARNING: space prohibited between function name and open parenthesis '('
#219: FILE: arch/arm/mach-w90x900/cpufreq.c:151:
+MODULE_LICENSE ("GPL");

ERROR: Missing Signed-off-by: line(s)

total: 2 errors, 3 warnings, 193 lines checked



2009/12/21 Wan ZongShun <mcuos.com@gmail.com>:
> Dear Li Jie,
>
> Okay, please send your patch to me as a attached file.
>
> Li Jie :
>>
>> Hi, Wan:
>>
>> This this the cpufreq_driver for NUC900 v2
>> Problems which you and Russell mentioned in v1 have been fixed:
>>
>> 1. declare nuc900_set_clkval() in cpu.h
>> 2. use macros instead of numbers
>> 3. rename module, nuc900 -> nuc900-cpufreq
>> 4. include linux/io.h, not asm/io.h
>> ....and so on
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 233a222..600b313 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -539,6 +539,7 @@ config ARCH_W90X900
>> ? ? ? ?select COMMON_CLKDEV
>> ? ? ? ?select GENERIC_TIME
>> ? ? ? ?select GENERIC_CLOCKEVENTS
>> + ? ? ? select ARCH_HAS_CPUFREQ
>> ? ? ? ?help
>> ? ? ? ? ?Support for Nuvoton (Winbond logic dept.) ARM9 processor,
>> ? ? ? ? ?At present, the w90x900 has been renamed nuc900, regarding
>> diff --git a/arch/arm/mach-w90x900/Makefile
>> b/arch/arm/mach-w90x900/Makefile
>> index 828c032..7f114fb 100644
>> --- a/arch/arm/mach-w90x900/Makefile
>> +++ b/arch/arm/mach-w90x900/Makefile
>> @@ -5,7 +5,7 @@
>> ?# Object file lists.
>>
>> ?obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?:= irq.o time.o mfp.o gpio.o clock.o
>> -obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?+= clksel.o dev.o cpu.o
>> +obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?+= clksel.o dev.o cpu.o cpufreq.o
>> ?# W90X900 CPU support files
>>
>> ?obj-$(CONFIG_CPU_W90P910) ? ? ?+= nuc910.o
>> diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
>> index 921cef9..7b608b8 100644
>> --- a/arch/arm/mach-w90x900/cpu.c
>> +++ b/arch/arm/mach-w90x900/cpu.c
>> @@ -107,7 +107,7 @@ struct platform_device nuc900_serial_device = {
>> ?};
>>
>> ?/*Set NUC900 series cpu frequence*/
>> -static int __init nuc900_set_clkval(unsigned int cpufreq)
>> +int nuc900_set_clkval(unsigned int cpufreq)
>> ?{
>> ? ? ? ?unsigned int pllclk, ahbclk, apbclk, val;
>>
>> @@ -156,6 +156,8 @@ static int __init nuc900_set_clkval(unsigned int
>> cpufreq)
>>
>> ? ? ? ?return ?0;
>> ?}
>> +EXPORT_SYMBOL(nuc900_set_clkval);
>> +
>> ?static int __init nuc900_set_cpufreq(char *str)
>> ?{
>> ? ? ? ?unsigned long cpufreq, val;
>> diff --git a/arch/arm/mach-w90x900/cpu.h b/arch/arm/mach-w90x900/cpu.h
>> index 4d58ba1..ca0bce5 100644
>> --- a/arch/arm/mach-w90x900/cpu.h
>> +++ b/arch/arm/mach-w90x900/cpu.h
>> @@ -49,6 +49,7 @@ extern void nuc900_clock_source(struct device *dev,
>> unsigned char *src);
>> ?extern void nuc900_init_clocks(void);
>> ?extern void nuc900_map_io(struct map_desc *mach_desc, int mach_size);
>> ?extern void nuc900_board_init(struct platform_device **device, int size);
>> +extern int nuc900_set_clkval(unsigned int cpufreq);
>>
>> ?/* for either public between 910 and 920, or between 920 and 950 */
>>
>> diff --git a/arch/arm/mach-w90x900/cpufreq.c
>> b/arch/arm/mach-w90x900/cpufreq.c
>> new file mode 100644
>> index 0000000..467fc26
>> --- /dev/null
>> +++ b/arch/arm/mach-w90x900/cpufreq.c
>> @@ -0,0 +1,154 @@
>> +/* linux/arch/arm/mach-w90x900/cpufreq.c
>> + *
>> + * NUC900 CPUfreq Support
>> + *
>> + * Li Jie <eltshanli@gmail.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/types.h>
>> +#include <linux/init.h>
>> +#include <linux/cpufreq.h>
>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include <asm/mach/map.h>
>> +#include <mach/hardware.h>
>> +#include <mach/regs-clock.h>
>> +
>> +#include "cpu.h"
>> +
>> +#define ? ? ? ?CPUFREQ_66M ? ? 66000
>> +#define ? ? ? ?CPUFREQ_100M ? ?100000
>> +#define ? ? ? ?CPUFREQ_120M ? ?120000
>> +#define ? ? ? ?CPUFREQ_166M ? ?166000
>> +#define ? ? ? ?CPUFREQ_200M ? ?200000
>> +
>> +static struct cpufreq_frequency_table nuc900_freq_table[] = {
>> + ? ? ? { 0, CPUFREQ_66M ?},
>> + ? ? ? { 1, CPUFREQ_100M },
>> + ? ? ? { 2, CPUFREQ_120M },
>> + ? ? ? { 3, CPUFREQ_166M },
>> + ? ? ? { 4, CPUFREQ_200M },
>> + ? ? ? { 5, CPUFREQ_TABLE_END },
>> +};
>> +
>> +static int nuc900_cpufreq_verify_speed(struct cpufreq_policy *policy)
>> +{
>> + ? ? ? if (policy->cpu != 0)
>> + ? ? ? ? ? ? ? return -EINVAL;
>> +
>> + ? ? ? return cpufreq_frequency_table_verify(policy, nuc900_freq_table);
>> +}
>> +
>> +static unsigned int nuc900_cpufreq_get_speed(unsigned int cpu)
>> +{
>> + ? ? ? int pllclk;
>> +
>> + ? ? ? if (cpu != 0)
>> + ? ? ? ? ? ? ? return 0;
>> +
>> + ? ? ? pllclk = __raw_readl(REG_PLLCON0);
>> +
>> + ? ? ? switch (pllclk) {
>> + ? ? ? case PLL_66MHZ:
>> + ? ? ? ? ? ? ? return CPUFREQ_66M;
>> + ? ? ? case PLL_100MHZ:
>> + ? ? ? ? ? ? ? return CPUFREQ_100M;
>> + ? ? ? case PLL_120MHZ:
>> + ? ? ? ? ? ? ? return CPUFREQ_120M;
>> + ? ? ? case PLL_166MHZ:
>> + ? ? ? ? ? ? ? return CPUFREQ_166M;
>> + ? ? ? case PLL_200MHZ:
>> + ? ? ? ? ? ? ? return CPUFREQ_200M;
>> + ? ? ? }
>> +
>> + ? ? ? pr_err("cpufreq: Failed to get frequency: %x\n", pllclk);
>> + ? ? ? return 0;
>> +}
>> +
>> +static int nuc900_cpufreq_set_target(struct cpufreq_policy *policy,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned int target_freq,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned int relation)
>> +{
>> + ? ? ? int ret;
>> + ? ? ? unsigned int i;
>> + ? ? ? struct cpufreq_freqs freqs;
>> +
>> + ? ? ? ret = cpufreq_frequency_table_target(policy, nuc900_freq_table,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?target_freq, relation, &i);
>> + ? ? ? if (ret != 0)
>> + ? ? ? ? ? ? ? return ret;
>> +
>> + ? ? ? freqs.cpu = 0;
>> + ? ? ? freqs.old = nuc900_cpufreq_get_speed(0);
>> + ? ? ? freqs.new = nuc900_freq_table[i].frequency;
>> + ? ? ? freqs.flags = 0;
>> +
>> + ? ? ? if (freqs.old == freqs.new)
>> + ? ? ? ? ? ? ? return 0;
>> +
>> + ? ? ? pr_debug("cpufreq: Transition %d-%dkHz\n", freqs.old, freqs.new);
>> +
>> + ? ? ? cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
>> +
>> + ? ? ? nuc900_set_clkval(freqs.new / 1000);
>> + ? ? ? cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
>> +
>> + ? ? ? return 0;
>> +}
>> +
>> +static int __init nuc900_cpufreq_driver_init(struct cpufreq_policy
>> *policy)
>> +{
>> + ? ? ? int ret;
>> +
>> + ? ? ? if (policy->cpu != 0)
>> + ? ? ? ? ? ? ? return -EINVAL;
>> +
>> + ? ? ? policy->cur = nuc900_cpufreq_get_speed(0);
>> +
>> + ? ? ? policy->cpuinfo.transition_latency = 2 * 1000; /* FIXME, assumed
>> */
>> + ? ? ? policy->cpuinfo.min_freq = 66000; ? ? ? ? ? ? ?/* khz */
>> + ? ? ? policy->cpuinfo.max_freq = 200000;
>> + ? ? ? policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
>> +
>> + ? ? ? ret = cpufreq_frequency_table_cpuinfo(policy, nuc900_freq_table);
>> + ? ? ? if (ret != 0)
>> + ? ? ? ? ? ? ? pr_err("cpufreq: Failed to configure frequency table:
>> %d\n",
>> + ? ? ? ? ? ? ? ? ? ? ?ret);
>> +
>> + ? ? ? return ret;
>> +}
>> +
>> +static struct cpufreq_driver nuc900_cpufreq_driver = {
>> + ? ? ? .owner ? ? ? ? ?= THIS_MODULE,
>> + ? ? ? .flags ? ? ? ? ?= 0,
>> + ? ? ? .verify ? ? ? ? = nuc900_cpufreq_verify_speed,
>> + ? ? ? .target ? ? ? ? = nuc900_cpufreq_set_target,
>> + ? ? ? .get ? ? ? ? ? ?= nuc900_cpufreq_get_speed,
>> + ? ? ? .init ? ? ? ? ? = nuc900_cpufreq_driver_init,
>> + ? ? ? .name ? ? ? ? ? = "nuc900-cpufreq",
>> +};
>> +
>> +static int __init nuc900_cpufreq_init(void)
>> +{
>> + ? ? ? return cpufreq_register_driver(&nuc900_cpufreq_driver);
>> +}
>> +
>> +static void __exit nuc900_cpufreq_exit(void)
>> +{
>> + ? ? ? cpufreq_unregister_driver(&nuc900_cpufreq_driver);
>> +}
>> +
>> +MODULE_AUTHOR ("Li Jie <eltshanli@gmail.com>");
>> +MODULE_DESCRIPTION ("cpufreq driver for NUC900");
>> +MODULE_LICENSE ("GPL");
>> +
>> +module_init(nuc900_cpufreq_init);
>> +module_exit(nuc900_cpufreq_exit);
>>
>
>



-- 
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
