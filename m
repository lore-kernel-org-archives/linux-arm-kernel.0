From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 27 Sep 2016 15:18:24 +0100
Subject: [RFC] irqchip/gic-v3: Implement suspend and resume callbacks
In-Reply-To: <57EA6774.2060807@codeaurora.org>
References: <1474447359-29551-1-git-send-email-clingutla@codeaurora.org>
 <57E25C8E.7080502@arm.com> <57EA6774.2060807@codeaurora.org>
Message-ID: <20160927151824.51f5fa09@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Sep 2016 18:05:00 +0530
Chandra Sekhar Lingutla <clingutla@codeaurora.org> wrote:

> On 09/21/2016 03:40 PM, Marc Zyngier wrote:
> > +Sudeep, Lorenzo,
> >
> > On 21/09/16 09:42, Lingutla Chandrasekhar wrote:  
> >> Implement suspend and resume syscore_ops to disable and
> >> enable non wake up capable interrupts.
> >>
> >> When system enters suspend, enable only wakeup capable
> >> interrupts. While resuming, enable previously enabled interrupts
> >> and show triggered/pending interrupts.  
> >
> > The fundamental problem (which you're not mentioning at all) is that the
> > GICv3 architecture doesn't mention wake-up interrupts at all, so this
> > has to be entirely handled in firmware. Is that what is happening?
> >  
> >>
> >> Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
> >>
> >> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> >> index ede5672..511a5a1 100644
> >> --- a/drivers/irqchip/irq-gic-v3.c
> >> +++ b/drivers/irqchip/irq-gic-v3.c
> >> @@ -33,6 +33,7 @@
> >>   #include <linux/irqchip/arm-gic-common.h>
> >>   #include <linux/irqchip/arm-gic-v3.h>
> >>   #include <linux/irqchip/irq-partition-percpu.h>
> >> +#include <linux/syscore_ops.h>
> >>
> >>   #include <asm/cputype.h>
> >>   #include <asm/exception.h>
> >> @@ -57,6 +58,10 @@ struct gic_chip_data {
> >>   	u32			nr_redist_regions;
> >>   	unsigned int		irq_nr;
> >>   	struct partition_desc	*ppi_descs[16];
> >> +#ifdef CONFIG_PM
> >> +	unsigned int wakeup_irqs[32];
> >> +	unsigned int enabled_irqs[32];  
> >
> > Do not use ambiguous types for something that comes from the HW. Where
> > does this '32' comes from?  
> Expecting wakeup capable irq can be any of maximum 1024 interrupt lines, so
> used array of size 32 (32 * 32 bits).

And why only 1024? What about the PPIs? What about LPIs? You're
shoehorning your particular platform into something that caters for the
whole architecture, and that's not a very good move.

> 
> >  
> >> +#endif
> >>   };
> >>
> >>   static struct gic_chip_data gic_data __read_mostly;
> >> @@ -330,6 +335,81 @@ static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
> >>   	return 0;
> >>   }
> >>
> >> +#ifdef CONFIG_PM
> >> +static int gic_suspend(void)
> >> +{
> >> +	unsigned int i;
> >> +	void __iomem *base = gic_data.dist_base;
> >> +
> >> +	for (i = 0; i * 32 < gic->irq_nr; i++) {
> >> +		gic->enabled_irqs[i]
> >> +			= readl_relaxed(base + GICD_ISENABLER + i * 4);  
> >
> > Do you realize that GICD_ISENABLER0 is always zero? What do you do for
> > PPIs? Please keep the assignment on a single line.  
> Agreed, will update.
> 
> >  
> >> +		/* disable all of them */
> >> +		writel_relaxed(0xffffffff, base + GICD_ICENABLER + i * 4);
> >> +		/* enable the wakeup set */
> >> +		writel_relaxed(gic->wakeup_irqs[i],
> >> +			base + GICD_ISENABLER + i * 4);  
> >
> > On a single line as well.
> >  
> >> +	}
> >> +	return 0;
> >> +}
> >> +
> >> +static void gic_show_pending(void)
> >> +{
> >> +	unsigned int i;
> >> +	u32 enabled;
> >> +	u32 pending[32];
> >> +	void __iomem *base = gic_data.dist_base;
> >> +
> >> +	for (i = 0; i * 32 < gic->irq_nr; i++) {
> >> +		enabled = readl_relaxed(base + GICD_ICENABLER + i * 4);
> >> +		pending[i] = readl_relaxed(base + GICD_ISPENDR + i * 4);
> >> +		pending[i] &= enabled;
> >> +	}
> >> +
> >> +	for_each_set_bit(i, (unsigned long *)pending, gic->irq_nr) {
> >> +		unsigned int irq = irq_find_mapping(gic->domain, i);
> >> +		struct irq_desc *desc = irq_to_desc(irq);
> >> +		const char *name = "null";
> >> +
> >> +		if (desc == NULL)
> >> +			name = "stray irq";
> >> +		else if (desc->action && desc->action->name)
> >> +			name = desc->action->name;
> >> +
> >> +		pr_debug("Pending IRQ: %d [%s]\n", __func__, irq, name);
> >> +	}
> >> +}  
> >
> > Please drop this function from this patch, it doesn't serve any purpose
> > other than your own debugging.
> >  
> I think, this function is useful for debugging to know wakeup reason.
> Can we move this function under PM_DEBUG flag or debugfs entry ?

No. I want this code entirely gone. If we need more debugging code than
we already have, then it needs to be added at the generic level, and
not for the perceived benefit of a single interrupt controller.

> 
> >> +
> >> +static void gic_resume(void)
> >> +{
> >> +	unsigned int i;
> >> +	void __iomem *base = gic_data.dist_base;
> >> +
> >> +	gic_show_pending();
> >> +
> >> +	for (i = 0; i * 32 < gic->irq_nr; i++) {
> >> +		/* disable all of them */
> >> +		writel_relaxed(0xffffffff, base + GICD_ICENABLER + i * 4);
> >> +		/* enable the enabled set */
> >> +		writel_relaxed(gic->enabled_irqs[i],
> >> +			base + GICD_ISENABLER + i * 4);  
> >
> > Same remarks as the suspend side.
> >  
> >> +	}
> >> +}
> >> +
> >> +static struct syscore_ops gic_syscore_ops = {
> >> +	.suspend = gic_suspend,
> >> +	.resume = gic_resume,
> >> +};
> >> +
> >> +static int __init gic_init_sys(void)
> >> +{
> >> +	register_syscore_ops(&gic_syscore_ops);
> >> +	return 0;
> >> +}
> >> +device_initcall(gic_init_sys);
> >> +
> >> +#endif
> >> +
> >>   static u64 gic_mpidr_to_affinity(unsigned long mpidr)
> >>   {
> >>   	u64 aff;
> >> @@ -666,6 +746,32 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
> >>   #define gic_smp_init()		do { } while(0)
> >>   #endif
> >>
> >> +#ifdef CONFIG_PM
> >> +int gic_set_wake(struct irq_data *d, unsigned int on)
> >> +{
> >> +	int ret = -ENXIO;
> >> +	unsigned int reg_offset, bit_offset;
> >> +	unsigned int gicirq = gic_irq(d);
> >> +	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
> >> +
> >> +	/* per-cpu interrupts cannot be wakeup interrupts */
> >> +	WARN_ON(gicirq < 32);  
> >
> > How did you decide that? There is no such specification anywhere.
> >  
> I am basically looking at system suspend, where cores would be in power collapse.

And? Why would that be exclusive of PPIs? Again, you seem to have a
very restrictive view of what should (or shouldn't) be supported.

> 
> >> +
> >> +	reg_offset = gicirq / 32;
> >> +	bit_offset = gicirq % 32;
> >> +
> >> +	if (on)
> >> +		gic_data->wakeup_irqs[reg_offset] |=  1 << bit_offset;
> >> +	else
> >> +		gic_data->wakeup_irqs[reg_offset] &=  ~(1 << bit_offset);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +#else
> >> +#define gic_set_wake	NULL
> >> +#endif
> >> +
> >>   #ifdef CONFIG_CPU_PM
> >>   /* Check whether it's single security state view */
> >>   static bool gic_dist_security_disabled(void)
> >> @@ -707,6 +813,7 @@ static struct irq_chip gic_chip = {
> >>   	.irq_eoi		= gic_eoi_irq,
> >>   	.irq_set_type		= gic_set_type,
> >>   	.irq_set_affinity	= gic_set_affinity,
> >> +	.irq_set_wake           = gic_set_wake,
> >>   	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
> >>   	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
> >>   	.flags			= IRQCHIP_SET_TYPE_MASKED,
> >> @@ -723,6 +830,7 @@ static struct irq_chip gic_eoimode1_chip = {
> >>   	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
> >>   	.irq_set_vcpu_affinity	= gic_irq_set_vcpu_affinity,
> >>   	.flags			= IRQCHIP_SET_TYPE_MASKED,
> >> +	.irq_set_wake		= gic_set_wake,  
> >
> > Keep the fields in the same order.
> >  
> >>   };
> >>
> >>   #define GIC_ID_NR		(1U << gic_data.rdists.id_bits)
> >>  
> >
> > But here's my fundamental objection: None of that should be required and
> > setting (IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND) as part of the
> > irqchip flags should be enough.
> >
> > Can you explain why this doesn't work for you?
> >  
> These flags work for me, I will remove suspend/resume functions, but i think
> it is very useful to know the wakeup source for debugging purposes.
> Please let me know, if you have any better way to achieve this.

We already have extensive sysfs features for this. If that's not
enough, please state exactly what is missing and we'll discuss how to
add it at the generic infrastructure level.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
