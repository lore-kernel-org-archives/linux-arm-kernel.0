From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 06 Aug 2014 16:26:50 +0100
Subject: [PATCH v16 8/9] irq: enable hip04 irq chip
In-Reply-To: <1407121088-4151-9-git-send-email-haojian.zhuang@linaro.org>
References: <1407121088-4151-1-git-send-email-haojian.zhuang@linaro.org>
 <1407121088-4151-9-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <53E2493A.1080202@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

to me this looks much better than the version integrated into irq-gic.c
and is reasonably small and self-contained.

See for comments below...

On 04/08/14 03:58, Haojian Zhuang wrote:
> HiP04 GIC is the variate of ARM GICv2.
> 
> ARM GICv2 supports 8 cores. HiP04 GIC extends to support 16 cores. It
> results that bit fields in GIC_DIST_TARGET & GIC_DIST_SOFTINT are
> different from ARM GICv2. And the maximium IRQ is downgrade from 1020 to 510.
> 
> Since different register offset & bitfields definitation breaks
> compartible with ARM GICv2, create a new hip04 irq driver.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  drivers/irqchip/Makefile    |   1 +
>  drivers/irqchip/irq-hip04.c | 429 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 430 insertions(+)
>  create mode 100644 drivers/irqchip/irq-hip04.c
> 
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index c57e642..23dcf45 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -2,6 +2,7 @@ obj-$(CONFIG_IRQCHIP)			+= irqchip.o
>  
>  obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
>  obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
> +obj-$(CONFIG_ARCH_HIP04)		+= irq-hip04.o
>  obj-$(CONFIG_ARCH_MMP)			+= irq-mmp.o
>  obj-$(CONFIG_ARCH_MVEBU)		+= irq-armada-370-xp.o
>  obj-$(CONFIG_ARCH_MXS)			+= irq-mxs.o
> diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
> new file mode 100644
> index 0000000..751a7ee
> --- /dev/null
> +++ b/drivers/irqchip/irq-hip04.c
> @@ -0,0 +1,429 @@
> +/*
> + * Hisilicon HiP04 INTC
> + *
> + * Copyright (C) 2002-2014 ARM Limited.
> + * Copyright (c) 2013-2014 Hisilicon Ltd.
> + * Copyright (c) 2013-2014 Linaro Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Interrupt architecture for the HIP04 INTC:
> + *
> + * o There is one Interrupt Distributor, which receives interrupts
> + *   from system devices and sends them to the Interrupt Controllers.
> + *
> + * o There is one CPU Interface per CPU, which sends interrupts sent
> + *   by the Distributor, and interrupts generated locally, to the
> + *   associated CPU. The base address of the CPU interface is usually
> + *   aliased so that the same address points to different chips depending
> + *   on the CPU it is accessed from.
> + *
> + * Note that IRQs 0-31 are special - they are local to each CPU.
> + * As such, the enable set/clear, pending set/clear and active bit
> + * registers are banked per-cpu for these sources.
> + */

I'd find it more useful to have a reference to the GIC code here and
only list the delta of the two drivers.
Since you removed (almost) any references to GIC, to an uninitiated
reader it's not obvious that this is in fact a stripped and tweaked GIC.

So you could copy some of the rationale from the commit message into
here, something along the lines of:
---------
This is derived from irq-gic.c to support the HiSilicon HiP04 interrupt
controller, which is similar to the GIC, but deviates at some points.
Support for power management, non-banked registers, cascaded GICs (and
multiple controllers in general) and bigLittle support has been removed
from the GIC driver.
Affinity related functions have been adjusted to match the HiSilicon
hardware implementation.
---------

By the way, you removed CONFIG_CPU_PM support, is there any reason for
that? I don't see an issue code-wise with keeping this in.

[...]

> +
> +void hip04_cpu_if_down(void)
> +{
> +	writel_relaxed(0, hip04_data.cpu_base + GIC_CPU_CTRL);
> +}

Where is this used? The GIC counterpart is only called by some VExpress
code, does your platform need a similar call? Otherwise (and since you
don't seem to provide a public prototype) this function can be removed.


> +
> +#ifdef CONFIG_SMP
> +static void hip04_raise_softirq(const struct cpumask *mask, unsigned int irq)
> +{
> +	int cpu;
> +	unsigned long flags, map = 0;
> +
> +	raw_spin_lock_irqsave(&irq_controller_lock, flags);
> +
> +	/* Convert our logical CPU mask into a physical one. */
> +	for_each_cpu(cpu, mask)
> +		map |= hip04_cpu_map[cpu];

Are we sure that mask does not contain any CPU number higher than
NR_HIP04_CPU_IF?

Regards,
Andre.

> +
> +	/*
> +	 * Ensure that stores to Normal memory are visible to the
> +	 * other CPUs before they observe us issuing the IPI.
> +	 */
> +	dmb(ishst);
> +
> +	/* this always happens on GIC0 */
> +	writel_relaxed(map << 8 | irq, hip04_data.dist_base + GIC_DIST_SOFTINT);
> +
> +	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
> +}
> +#endif
> +
> +static int hip04_irq_domain_map(struct irq_domain *d, unsigned int irq,
> +				irq_hw_number_t hw)
> +{
> +	if (hw < 32) {
> +		irq_set_percpu_devid(irq);
> +		irq_set_chip_and_handler(irq, &hip04_irq_chip,
> +					 handle_percpu_devid_irq);
> +		set_irq_flags(irq, IRQF_VALID | IRQF_NOAUTOEN);
> +	} else {
> +		irq_set_chip_and_handler(irq, &hip04_irq_chip,
> +					 handle_fasteoi_irq);
> +		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
> +	}
> +	irq_set_chip_data(irq, d->host_data);
> +	return 0;
> +}
> +
> +static int hip04_irq_domain_xlate(struct irq_domain *d,
> +				  struct device_node *controller,
> +				  const u32 *intspec, unsigned int intsize,
> +				  unsigned long *out_hwirq,
> +				  unsigned int *out_type)
> +{
> +	unsigned long ret = 0;
> +
> +	if (d->of_node != controller)
> +		return -EINVAL;
> +	if (intsize < 3)
> +		return -EINVAL;
> +
> +	/* Get the interrupt number and add 16 to skip over SGIs */
> +	*out_hwirq = intspec[1] + 16;
> +
> +	/* For SPIs, we need to add 16 more to get the irq ID number */
> +	if (!intspec[0])
> +		*out_hwirq += 16;
> +
> +	*out_type = intspec[2] & IRQ_TYPE_SENSE_MASK;
> +
> +	return ret;
> +}
> +
> +#ifdef CONFIG_SMP
> +static int hip04_irq_secondary_init(struct notifier_block *nfb,
> +				    unsigned long action,
> +				    void *hcpu)
> +{
> +	if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
> +		hip04_irq_cpu_init(&hip04_data);
> +	return NOTIFY_OK;
> +}
> +
> +/*
> + * Notifier for enabling the INTC CPU interface. Set an arbitrarily high
> + * priority because the GIC needs to be up before the ARM generic timers.
> + */
> +static struct notifier_block hip04_irq_cpu_notifier = {
> +	.notifier_call	= hip04_irq_secondary_init,
> +	.priority	= 100,
> +};
> +#endif
> +
> +static const struct irq_domain_ops hip04_irq_domain_ops = {
> +	.map	= hip04_irq_domain_map,
> +	.xlate	= hip04_irq_domain_xlate,
> +};
> +
> +static int __init
> +hip04_of_init(struct device_node *node, struct device_node *parent)
> +{
> +	irq_hw_number_t hwirq_base = 16;
> +	int nr_irqs, irq_base, i;
> +
> +	if (WARN_ON(!node))
> +		return -ENODEV;
> +
> +	hip04_data.dist_base = of_iomap(node, 0);
> +	WARN(!hip04_data.dist_base, "fail to map hip04 intc dist registers\n");
> +
> +	hip04_data.cpu_base = of_iomap(node, 1);
> +	WARN(!hip04_data.cpu_base, "unable to map hip04 intc cpu registers\n");
> +
> +	/*
> +	 * Initialize the CPU interface map to all CPUs.
> +	 * It will be refined as each CPU probes its ID.
> +	 */
> +	for (i = 0; i < NR_HIP04_CPU_IF; i++)
> +		hip04_cpu_map[i] = 0xff;
> +
> +	/*
> +	 * Find out how many interrupts are supported.
> +	 * The HIP04 INTC only supports up to 510 interrupt sources.
> +	 */
> +	nr_irqs = readl_relaxed(hip04_data.dist_base + GIC_DIST_CTR) & 0x1f;
> +	nr_irqs = (nr_irqs + 1) * 32;
> +	if (nr_irqs > HIP04_MAX_IRQS)
> +		nr_irqs = HIP04_MAX_IRQS;
> +	hip04_data.nr_irqs = nr_irqs;
> +
> +	nr_irqs -= hwirq_base; /* calculate # of irqs to allocate */
> +
> +	irq_base = irq_alloc_descs(-1, hwirq_base, nr_irqs, numa_node_id());
> +	if (IS_ERR_VALUE(irq_base)) {
> +		pr_err("failed to allocate IRQ numbers\n");
> +		return -EINVAL;
> +	}
> +
> +	hip04_data.domain = irq_domain_add_legacy(node, nr_irqs, irq_base,
> +						  hwirq_base,
> +						  &hip04_irq_domain_ops,
> +						  &hip04_data);
> +
> +	if (WARN_ON(!hip04_data.domain))
> +		return -EINVAL;
> +
> +#ifdef CONFIG_SMP
> +	set_smp_cross_call(hip04_raise_softirq);
> +	register_cpu_notifier(&hip04_irq_cpu_notifier);
> +#endif
> +	set_handle_irq(hip04_handle_irq);
> +
> +	hip04_irq_dist_init(&hip04_data);
> +	hip04_irq_cpu_init(&hip04_data);
> +
> +	return 0;
> +}
> +IRQCHIP_DECLARE(hip04_intc, "hisilicon,hip04-intc", hip04_of_init);
> 
