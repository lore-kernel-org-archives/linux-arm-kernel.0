From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 15 Oct 2015 17:16:00 +0100
Subject: [PATCH 05/13] irqchip/gic: assign irqchip dynamically
In-Reply-To: <1444916813-31024-6-git-send-email-linus.walleij@linaro.org>
References: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
 <1444916813-31024-6-git-send-email-linus.walleij@linaro.org>
Message-ID: <561FD140.4010809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 15/10/15 14:46, Linus Walleij wrote:
> Instead of having the irqchip being a static struct, make it part
> of the per-instance data so we can assign it a dynamic name. This
> has the usable side effect of displaying the GIC with an instance
> number as GIC0, GIC1 ... GICn in /proc/interrupts, which is helpful
> when debugging cascaded GICs, such as on the ARM PB11MPCore.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Fellas please say what you think about this:
> Yes / No / Linus is an idiot
> This can be applied directly to the irqchip tree if you like
> it, AFAIK it has no dependencies.
> ---
>  drivers/irqchip/irq-gic.c | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index bd021e1e4847..478279cf9517 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -58,6 +58,7 @@ union gic_base {
>  };
>  
>  struct gic_chip_data {
> +	struct irq_chip chip;
>  	union gic_base dist_base;
>  	union gic_base cpu_base;
>  #ifdef CONFIG_CPU_PM
> @@ -369,22 +370,6 @@ static void gic_handle_cascade_irq(struct irq_desc *desc)
>  	chained_irq_exit(chip, desc);
>  }
>  
> -static struct irq_chip gic_chip = {
> -	.name			= "GIC",
> -	.irq_mask		= gic_mask_irq,
> -	.irq_unmask		= gic_unmask_irq,
> -	.irq_eoi		= gic_eoi_irq,
> -	.irq_set_type		= gic_set_type,
> -#ifdef CONFIG_SMP
> -	.irq_set_affinity	= gic_set_affinity,
> -#endif
> -	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
> -	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
> -	.flags			= IRQCHIP_SET_TYPE_MASKED |
> -				  IRQCHIP_SKIP_SET_WAKE |
> -				  IRQCHIP_MASK_ON_SUSPEND,
> -};
> -
>  static struct irq_chip gic_eoimode1_chip = {
>  	.name			= "GICv2",
>  	.irq_mask		= gic_eoimode1_mask_irq,
> @@ -880,7 +865,8 @@ void __init gic_init_physaddr(struct device_node *node)
>  static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
>  				irq_hw_number_t hw)
>  {
> -	struct irq_chip *chip = &gic_chip;
> +	struct gic_chip_data *gic = d->host_data;
> +	struct irq_chip *chip = &gic->chip;
>  
>  	if (static_key_true(&supports_deactivate)) {
>  		if (d->host_data == (void *)&gic_data[0])
> @@ -989,6 +975,22 @@ static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
>  	BUG_ON(gic_nr >= MAX_GIC_NR);
>  
>  	gic = &gic_data[gic_nr];
> +
> +	/* Initialize irq_chip */
> +	gic->chip.name = kasprintf(GFP_KERNEL, "GIC%d", gic_nr);
> +	gic->chip.irq_mask = gic_mask_irq;
> +	gic->chip.irq_unmask = gic_unmask_irq;
> +	gic->chip.irq_eoi = gic_eoi_irq;
> +	gic->chip.irq_set_type	= gic_set_type;
> +#ifdef CONFIG_SMP
> +	gic->chip.irq_set_affinity = gic_set_affinity;
> +#endif
> +	gic->chip.irq_get_irqchip_state = gic_irq_get_irqchip_state;
> +	gic->chip.irq_set_irqchip_state = gic_irq_set_irqchip_state;
> +	gic->chip.flags = IRQCHIP_SET_TYPE_MASKED |
> +		IRQCHIP_SKIP_SET_WAKE |
> +		IRQCHIP_MASK_ON_SUSPEND;
> +

How does it work when we want to use the ops from gic_eoimode1_chip? I
don't think it breaks, but it is a bit weird.

You could also replace this sequence by keeping the original structure
and assigning it to the embedded one (I don't think you save much by
replacing this with discreet field assignment).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
