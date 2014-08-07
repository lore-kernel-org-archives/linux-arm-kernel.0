From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 7 Aug 2014 13:26:23 +0800
Subject: [PATCH v16 8/9] irq: enable hip04 irq chip
In-Reply-To: <53E2493A.1080202@arm.com>
References: <1407121088-4151-1-git-send-email-haojian.zhuang@linaro.org>
 <1407121088-4151-9-git-send-email-haojian.zhuang@linaro.org>
 <53E2493A.1080202@arm.com>
Message-ID: <CAD6h2NTitNd8CEu0YGgb5PBasYzbtUspgeCD3fCBnx23h2tMWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 August 2014 23:26, Andre Przywara <andre.przywara@arm.com> wrote:
> Hi,
>
> to me this looks much better than the version integrated into irq-gic.c
> and is reasonably small and self-contained.
>
> See for comments below...
>
> On 04/08/14 03:58, Haojian Zhuang wrote:
>> HiP04 GIC is the variate of ARM GICv2.
>>
>> ARM GICv2 supports 8 cores. HiP04 GIC extends to support 16 cores. It
>> results that bit fields in GIC_DIST_TARGET & GIC_DIST_SOFTINT are
>> different from ARM GICv2. And the maximium IRQ is downgrade from 1020 to 510.
>>
>> Since different register offset & bitfields definitation breaks
>> compartible with ARM GICv2, create a new hip04 irq driver.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> ---
>>  drivers/irqchip/Makefile    |   1 +
>>  drivers/irqchip/irq-hip04.c | 429 ++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 430 insertions(+)
>>  create mode 100644 drivers/irqchip/irq-hip04.c
>>
>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index c57e642..23dcf45 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -2,6 +2,7 @@ obj-$(CONFIG_IRQCHIP)                 += irqchip.o
>>
>>  obj-$(CONFIG_ARCH_BCM2835)           += irq-bcm2835.o
>>  obj-$(CONFIG_ARCH_EXYNOS)            += exynos-combiner.o
>> +obj-$(CONFIG_ARCH_HIP04)             += irq-hip04.o
>>  obj-$(CONFIG_ARCH_MMP)                       += irq-mmp.o
>>  obj-$(CONFIG_ARCH_MVEBU)             += irq-armada-370-xp.o
>>  obj-$(CONFIG_ARCH_MXS)                       += irq-mxs.o
>> diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
>> new file mode 100644
>> index 0000000..751a7ee
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-hip04.c
>> @@ -0,0 +1,429 @@
>> +/*
>> + * Hisilicon HiP04 INTC
>> + *
>> + * Copyright (C) 2002-2014 ARM Limited.
>> + * Copyright (c) 2013-2014 Hisilicon Ltd.
>> + * Copyright (c) 2013-2014 Linaro Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * Interrupt architecture for the HIP04 INTC:
>> + *
>> + * o There is one Interrupt Distributor, which receives interrupts
>> + *   from system devices and sends them to the Interrupt Controllers.
>> + *
>> + * o There is one CPU Interface per CPU, which sends interrupts sent
>> + *   by the Distributor, and interrupts generated locally, to the
>> + *   associated CPU. The base address of the CPU interface is usually
>> + *   aliased so that the same address points to different chips depending
>> + *   on the CPU it is accessed from.
>> + *
>> + * Note that IRQs 0-31 are special - they are local to each CPU.
>> + * As such, the enable set/clear, pending set/clear and active bit
>> + * registers are banked per-cpu for these sources.
>> + */
>
> I'd find it more useful to have a reference to the GIC code here and
> only list the delta of the two drivers.
> Since you removed (almost) any references to GIC, to an uninitiated
> reader it's not obvious that this is in fact a stripped and tweaked GIC.
>
> So you could copy some of the rationale from the commit message into
> here, something along the lines of:
> ---------
> This is derived from irq-gic.c to support the HiSilicon HiP04 interrupt
> controller, which is similar to the GIC, but deviates at some points.
> Support for power management, non-banked registers, cascaded GICs (and
> multiple controllers in general) and bigLittle support has been removed
> from the GIC driver.
> Affinity related functions have been adjusted to match the HiSilicon
> hardware implementation.
> ---------
>
> By the way, you removed CONFIG_CPU_PM support, is there any reason for
> that? I don't see an issue code-wise with keeping this in.
>
Since we didn't enable power management on HiP04 yet, I removed them.
If we enable power management later, I could append them again.

>
>> +
>> +void hip04_cpu_if_down(void)
>> +{
>> +     writel_relaxed(0, hip04_data.cpu_base + GIC_CPU_CTRL);
>> +}
>
> Where is this used? The GIC counterpart is only called by some VExpress
> code, does your platform need a similar call? Otherwise (and since you
> don't seem to provide a public prototype) this function can be removed.
>

I should remove it. It doesn't help me.

>
>> +
>> +#ifdef CONFIG_SMP
>> +static void hip04_raise_softirq(const struct cpumask *mask, unsigned int irq)
>> +{
>> +     int cpu;
>> +     unsigned long flags, map = 0;
>> +
>> +     raw_spin_lock_irqsave(&irq_controller_lock, flags);
>> +
>> +     /* Convert our logical CPU mask into a physical one. */
>> +     for_each_cpu(cpu, mask)
>> +             map |= hip04_cpu_map[cpu];
>
> Are we sure that mask does not contain any CPU number higher than
> NR_HIP04_CPU_IF?
>
Yes, the maximum CPU number is 16. We shouldn't configure higher CPU
numbers in HiP04.

Regards
Haojian
