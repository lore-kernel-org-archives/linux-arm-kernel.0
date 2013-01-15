From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 15 Jan 2013 12:02:39 +0530
Subject: [PATCH 06/16] ARM: b.L: generic SMP secondary bringup and hotplug
 support
In-Reply-To: <CAMpgmWCxQMoncnMqy_bzB+mBU7eGO_L4fR+Q5uMaxdFn4mL5PA@mail.gmail.com>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-7-git-send-email-nicolas.pitre@linaro.org>
 <50F053BF.8090302@ti.com>
 <CAMpgmWCxQMoncnMqy_bzB+mBU7eGO_L4fR+Q5uMaxdFn4mL5PA@mail.gmail.com>
Message-ID: <50F4F807.3010806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 January 2013 11:35 PM, Achin Gupta wrote:
> Hi Santosh,
>
> On Fri, Jan 11, 2013 at 6:02 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>> On Thursday 10 January 2013 05:50 AM, Nicolas Pitre wrote:
>>>
>>> Now that the b.L power API is in place, we can use it for SMP secondary
>>> bringup and CPU hotplug in a generic fashion.
>>>
>>> Signed-off-by: Nicolas Pitre <nico@linaro.org>
>>> ---
>>>    arch/arm/common/Makefile     |  2 +-
>>>    arch/arm/common/bL_platsmp.c | 79
>>> ++++++++++++++++++++++++++++++++++++++++++++
>>>    2 files changed, 80 insertions(+), 1 deletion(-)
>>>    create mode 100644 arch/arm/common/bL_platsmp.c
>>>
>>> diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
>>> index 894c2ddf9b..59b36db7cc 100644
>>> --- a/arch/arm/common/Makefile
>>> +++ b/arch/arm/common/Makefile
>>> @@ -15,4 +15,4 @@ obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
>>>    obj-$(CONFIG_ARM_TIMER_SP804) += timer-sp.o
>>>    obj-$(CONFIG_FIQ_GLUE)                += fiq_glue.o fiq_glue_setup.o
>>>    obj-$(CONFIG_FIQ_DEBUGGER)    += fiq_debugger.o
>>> -obj-$(CONFIG_BIG_LITTLE)       += bL_head.o bL_entry.o vlock.o
>>> +obj-$(CONFIG_BIG_LITTLE)       += bL_head.o bL_entry.o bL_platsmp.o
>>> vlock.o
>>> diff --git a/arch/arm/common/bL_platsmp.c b/arch/arm/common/bL_platsmp.c
>>> new file mode 100644
>>> index 0000000000..0acb9f4685
>>> --- /dev/null
>>> +++ b/arch/arm/common/bL_platsmp.c
>>> @@ -0,0 +1,79 @@
>>> +/*
>>> + * linux/arch/arm/mach-vexpress/bL_platsmp.c
>>> + *
>>> + * Created by:  Nicolas Pitre, November 2012
>>> + * Copyright:   (C) 2012  Linaro Limited
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + *
>>> + * Code to handle secondary CPU bringup and hotplug for the bL power API.
>>> + */
>>> +
>>> +#include <linux/init.h>
>>> +#include <linux/smp.h>
>>> +
>>> +#include <asm/bL_entry.h>
>>> +#include <asm/smp_plat.h>
>>> +#include <asm/hardware/gic.h>
>>> +
>>> +static void __init simple_smp_init_cpus(void)
>>> +{
>>> +       set_smp_cross_call(gic_raise_softirq);
>>> +}
>>> +
>>> +static int __cpuinit bL_boot_secondary(unsigned int cpu, struct
>>> task_struct *idle)
>>> +{
>>> +       unsigned int pcpu, pcluster, ret;
>>> +       extern void secondary_startup(void);
>>> +
>>> +       pcpu = cpu_logical_map(cpu) & 0xff;
>>> +       pcluster = (cpu_logical_map(cpu) >> 8) & 0xff;
>>> +       pr_debug("%s: logical CPU %d is physical CPU %d cluster %d\n",
>>> +                __func__, cpu, pcpu, pcluster);
>>> +
>>> +       bL_set_entry_vector(pcpu, pcluster, NULL);
>>> +       ret = bL_cpu_power_up(pcpu, pcluster);
>>> +       if (ret)
>>> +               return ret;
>>> +       bL_set_entry_vector(pcpu, pcluster, secondary_startup);
>>> +       gic_raise_softirq(cpumask_of(cpu), 0);
>>> +       sev();
>>
>> softirq() should be enough to break a CPU if it is in standby with
>> wfe state. Is that additional sev() needed here ?
>
> Not if the target cpu has its I & F bits disabled and that would be the
> case with a secondary waiting to be woken up
>
This is interesting since CPU is actually in standby state and this
was not my understanding so far. Your statement at least contradicts
the ARM ARM (B1.8.12 Wait For Interrupt)
-----------------------
The processor can remain in the WFI low-power state until it is reset, 
or it detects one of the following WFI wake-up
events:
? a physical IRQ interrupt, regardless of the value of the CPSR.I bit
? a physical FIQ interrupt, regardless of the value of the CPSR.F bit
----------------------------------

Are you referring to some new behavior on latest ARMv7 CPUs ?

Regards,
Santosh
