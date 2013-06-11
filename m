From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 11 Jun 2013 13:21:22 +0100
Subject: [PATCH 1/2] add irq priodrop support
In-Reply-To: <51B6D3B4.1020800@huawei.com>
References: <51B6D3B4.1020800@huawei.com>
Message-ID: <20130611122122.478603E0A90@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Jun 2013 09:37:24 +0200, Mario Smarduch <mario.smarduch@huawei.com> wrote:
> This is the same Interrupt Priority Drop/Deactivation patch 
> emailed some time back (except for 3.10-rc4) used by the initial 
> device pass-through support. 
> 
> When enabled all IRQs on host write to distributor EOIR and 
> DIR reg to dr-prioritize/de-activate an interrupt. For device 
> that's passed through only the EOIR is written
> to drop the priority, the Guest deactivates it when 
> it handles its EOI. This supports exitless EOI that's agnostic
> to bus type (i.e. PCI)
> 
> The patch has been tested for all configurations:
> Host: No Prio Drop  Guest: No Prio Drop
> Host: Prio DROP	    Guest: No Prio Drop
> Host: Prio Drop     Guest: Prio Drop 
> 
> - Mario
> 
> Signed-off-by: Mario Smarduch <mario.smarduch@huawei.com>

Hi Mario,

Comments below. I'm rather weak on how irq passthough is intended to
work, so I don't have a lot of comments on that, but I did notice some
things in this patch that should be addressed.

> ---
>  arch/arm/kvm/Kconfig            |    8 +++
>  drivers/irqchip/irq-gic.c       |  145 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/irqchip/arm-gic.h |    6 ++
>  3 files changed, 156 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
> index 370e1a8..c0c9f3c 100644
> --- a/arch/arm/kvm/Kconfig
> +++ b/arch/arm/kvm/Kconfig
> @@ -59,6 +59,14 @@ config KVM_ARM_VGIC
>  	---help---
>  	  Adds support for a hardware assisted, in-kernel GIC emulation.
>  
> +config KVM_ARM_INT_PRIO_DROP
> +        bool "KVM support for Interrupt pass-through"
> +        depends on KVM_ARM_VGIC && OF
> +        default n
> +        ---help---
> +          Seperates interrupt priority drop and deactivation to enable device
> +          pass-through to Guests.
> +

Nit: check your whitespace (tabs vs. spaces)

>  config KVM_ARM_TIMER
>  	bool "KVM support for Architected Timers"
>  	depends on KVM_ARM_VGIC && ARM_ARCH_TIMER
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 1760ceb..9fb4ef3 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -41,10 +41,13 @@
>  #include <linux/slab.h>
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqchip/arm-gic.h>
> +#include <linux/irqflags.h>
> +#include <linux/bitops.h>
>  
>  #include <asm/irq.h>
>  #include <asm/exception.h>
>  #include <asm/smp_plat.h>
> +#include <asm/virt.h>
>  
>  #include "irqchip.h"
>  
> @@ -99,6 +102,20 @@ struct irq_chip gic_arch_extn = {
>  
>  static struct gic_chip_data gic_data[MAX_GIC_NR] __read_mostly;
>  
> +#ifdef CONFIG_KVM_ARM_INT_PRIO_DROP
> +/*
> + * Priority drop/deactivation bit map, 1st 16 bits used for SGIs, this bit map
> + * is shared by several guests. If bit is set only execute EOI which drops
> + * current priority but not deactivation.
> + */
> +static u32  gic_irq_prio_drop[DIV_ROUND_UP(1020, 32)] __read_mostly;

I believe it is possible to have more than one GIC in a system. This map
assumes only one. The prio_drop map should probably be part of
gic_chip_data so that it is per-instance.

Also, as discussed below, the code should be using DECLARE_BITMAP()

> +static void gic_eoi_irq_priodrop(struct irq_data *);
> +#endif
> +
> +static void gic_enable_gicc(void __iomem *);
> +static void gic_eoi_sgi(u32, void __iomem *);
> +static void gic_priodrop_remap_eoi(struct irq_chip *);
> +

The typical pattern here is to actually define the static functions
above the code that uses them so that forward declarations are not
required.

>  #ifdef CONFIG_GIC_NON_BANKED
>  static void __iomem *gic_get_percpu_base(union gic_base *base)
>  {
> @@ -296,7 +313,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
>  			continue;
>  		}
>  		if (irqnr < 16) {
> -			writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
> +			gic_eoi_sgi(irqstat, cpu_base);
>  #ifdef CONFIG_SMP
>  			handle_IPI(irqnr, regs);
>  #endif
> @@ -450,7 +467,7 @@ static void __cpuinit gic_cpu_init(struct gic_chip_data *gic)
>  		writel_relaxed(0xa0a0a0a0, dist_base + GIC_DIST_PRI + i * 4 / 4);
>  
>  	writel_relaxed(0xf0, base + GIC_CPU_PRIMASK);
> -	writel_relaxed(1, base + GIC_CPU_CTRL);
> +	gic_enable_gicc(base);
>  }
>  
>  #ifdef CONFIG_CPU_PM
> @@ -585,7 +602,7 @@ static void gic_cpu_restore(unsigned int gic_nr)
>  		writel_relaxed(0xa0a0a0a0, dist_base + GIC_DIST_PRI + i * 4);
>  
>  	writel_relaxed(0xf0, cpu_base + GIC_CPU_PRIMASK);
> -	writel_relaxed(1, cpu_base + GIC_CPU_CTRL);
> +	gic_enable_gicc(cpu_base);
>  }
>  
>  static int gic_notifier(struct notifier_block *self, unsigned long cmd,	void *v)
> @@ -666,6 +683,7 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>  static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
>  				irq_hw_number_t hw)
>  {
> +	gic_priodrop_remap_eoi(&gic_chip);

gic_priodrop_remap_eoi() is used exactly once. You should instead put
the body of it inline like so:

	if (IS_ENABLED(CONFIG_KVM_ARM_INT_PRIO_DROP) && is_hyp_mode_available())
		chip->irq_eoi = gic_eoi_irq_priodrop;

However, this block is problematic. For each map call it modifies the
/global/ gic_chip. It's not a per-interrupt thing, but rather changes
the callback for all gic interrupts, on *any* gic in the system. Is this
really what you want?

If it is, then I would expect the callback to be modified once sometime
around gic_init_bases() time.

If it is not, and what you really want is per-irq behaviour, then what
you need to do is have a separate gic_priodrop_chip that can be used on
a per-irq basis instead of the gic_chip.

>  	if (hw < 32) {
>  		irq_set_percpu_devid(irq);
>  		irq_set_chip_and_handler(irq, &gic_chip,
> @@ -857,4 +875,125 @@ IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
>  IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
>  IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
>  
> +#ifdef CONFIG_KVM_ARM_INT_PRIO_DROP
> +/* If HYP mode enabled and PRIO DROP set EOIR function to handle PRIO DROP */
> +static inline void gic_priodrop_remap_eoi(struct irq_chip *chip)
> +{
> +	if (is_hyp_mode_available())
> +		chip->irq_eoi = gic_eoi_irq_priodrop;
> +}
> +
> +/* If HYP mode set enable interrupt priority drop/deactivation, and mark
> + * SGIs to deactive through writes to GCICC_DIR. For Guest only enable normal
> + * mode.
> + */

Nit: Read Documentation/kernel-doc-nano-HOWTO.txt. It's a good idea to
stick to that format when writing function documenation. Also,
convention is for multiline comments to have an empty /* line before the
first line of text.

> +static void gic_enable_gicc(void __iomem *gicc_base)
> +{
> +	if (is_hyp_mode_available()) {
> +		/* Allow Priority Drop in host, but not in Guest */
> +		gic_irq_prio_drop[0] = (u32) (1 << 16) - 1;
> +		writel_relaxed(0x201, gicc_base + GIC_CPU_CTRL);
> +	} else
> +		writel_relaxed(1, gicc_base + GIC_CPU_CTRL);
> +}
> +
> +/* If Host write to EOIR and DIR to drop priority and deactivate, Guest
> + * only write to EOIR.
> + */
> +static void gic_eoi_sgi(u32 irqstat, void __iomem *gicc_base)
> +{
> +	unsigned long flags;
> +	if (unlikely(gic_irq_prio_drop[0] & (1<<((irqstat & ~0x1c00) % 16)))) {
> +		raw_local_irq_save(flags);
> +		writel_relaxed(irqstat, gicc_base + GIC_CPU_EOI);
> +		writel_relaxed(irqstat, gicc_base + GIC_CPU_DIR);
> +		raw_local_irq_restore(flags);
> +		return;
> +	}
> +	writel_relaxed(irqstat, gicc_base + GIC_CPU_EOI);
> +}
> +
> +/* EOIR handler to manage PRIO DROP, if interrupt passed-through only write to
> + * EOIR the Guest will deactivate it through its write to EOIR. Otherwise for
> + * non pass-through write to EOIR and DIR. GICC_DIR _must_ be mapped.
> + */
> +
> +static void gic_eoi_irq_priodrop(struct irq_data *d)
> +{
> +	if (gic_arch_extn.irq_eoi) {
> +		raw_spin_lock(&irq_controller_lock);
> +		gic_arch_extn.irq_eoi(d);
> +		raw_spin_unlock(&irq_controller_lock);
> +	}
> +
> +	/* Set from KVM device passthrough to determine which interrupts
> +	 * must be deactivated by the Guest.
> +	 */
> +	if (unlikely(gic_spi_get_priodrop(gic_irq(d)))) {
> +		/* IRQ marked for priority drop, deactivation is deferred
> +		 * in this case the Guest deactivates the interrupt, or regular
> +		 * path if GCTLR.EOImodeNS=0 or not suppored.
> +		 */
> +		writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
> +	} else {
> +		/* De-prioritize/de-activate interrupt, disable interrupts
> +		 * so lower priority interrupt does not stall this one.
> +		 */
> +		unsigned long flags;
> +		raw_local_irq_save(flags);
> +		writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
> +		writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_DIR);
> +		raw_local_irq_restore(flags);
> +	}
> +}
> +
> +/* Next 3 called from KVM Interrupt Device Passthrough code */
> +void gic_spi_set_priodrop(int irq)
> +{
> +	if (likely(irq >= 32 && irq <= 1019))
> +		set_bit(irq % 32, (void *) &gic_irq_prio_drop[irq/32]);

Tip: If you have to (void*) cast a value, then you're probably doing
something wrong. There certainly are times when compiler type checking
needs to be overridden, but you should always think hard before doing
it. In this case, if gic_irq_prio_drop[] is declared with
DECLARE_BITMAP(), then set_bit can be used directly without any munging
around with /32 or %32 and no casts needed.

This becomes merely:
	set_bit(irq, gic_irq_prio_drop);

> +}
> +
> +void gic_spi_clr_priodrop(int irq)
> +{
> +	struct irq_data *d = irq_get_irq_data(irq);
> +	if (likely(irq >= 32 && irq < 1019)) {

"< 1019" ...

> +		clear_bit(irq % 32, (void *) &gic_irq_prio_drop[irq/32]);
> +		writel_relaxed(irq, gic_cpu_base(d) + GIC_CPU_DIR);
> +	}
> +}
> +
> +int gic_spi_get_priodrop(int irq)
> +{
> +	if (likely(irq >= 32 && irq <= 1019))

... "<= 1019"

Looks like some off-by-one errors going on here. Also, the rest of the
gic code uses 1020, not 1019 as the upper limit. What is the reason for
being difference in this code block?

> +		return gic_irq_prio_drop[irq/32] & (1 << (irq % 32));
> +	return 0;

return test_bit(irq, gic_irq_prio_drop)

> +}
> +
> +#else /* CONFIG_KVM_ARM_INT_PRIO_DROP */
> +static inline void gic_priodrop_remap_eoi(struct irq_chip *gic_chip)
> +{
> +}
> +static inline void gic_enable_gicc(void __iomem *gicc_base)
> +{
> +	writel_relaxed(1, gicc_base + GIC_CPU_CTRL);
> +}
> +static void gic_eoi_sgi(u32 irqstat, void __iomem *gicc_base)
> +{
> +	writel_relaxed(irqstat, gicc_base + GIC_CPU_EOI);
> +}
> +static inline void gic_deactivate_sgi(u32 irqstat, void __iomem *gicc_base)
> +{
> +}
> +void gic_spi_set_priodrop(int irq)
> +{
> +}
> +void gic_spi_clr_priodrop(int irq)
> +{
> +}
> +int gic_spi_get_priodrop(int irq)
> +{
> +	return 0;
> +}
> +#endif

Making good use of the IS_ENABLED(CONFIG_KVM_ARM_INT_PRIO_DROP) macro in
the code will allow you to eliminate the #if/#else/#endif block and
still allow the compiler to optimize out code paths that are not
enabled. That will be better to read than the above.

>  #endif
> diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
> index 3e203eb..adb5d00 100644
> --- a/include/linux/irqchip/arm-gic.h
> +++ b/include/linux/irqchip/arm-gic.h
> @@ -17,6 +17,7 @@
>  #define GIC_CPU_EOI			0x10
>  #define GIC_CPU_RUNNINGPRI		0x14
>  #define GIC_CPU_HIGHPRI			0x18
> +#define GIC_CPU_DIR                     0x1000
>  
>  #define GIC_DIST_CTRL			0x000
>  #define GIC_DIST_CTR			0x004
> @@ -73,6 +74,11 @@ static inline void gic_init(unsigned int nr, int start,
>  	gic_init_bases(nr, start, dist, cpu, 0, NULL);
>  }
>  
> +/* Functions to manage interrupt pass-through via priority drop/deactivation */
> +void gic_spi_set_priodrop(int);
> +void gic_spi_clr_priodrop(int);
> +int gic_spi_get_priodrop(int);

Use bool as return type.

> +
>  #endif /* __ASSEMBLY */
>  
>  #endif
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
