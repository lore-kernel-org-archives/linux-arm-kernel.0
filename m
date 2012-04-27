From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 27 Apr 2012 13:00:20 -0600
Subject: [PATCH 2/2] ARM: VIC: use the domain mapping function to assign
 handlers
In-Reply-To: <1334763054-19340-1-git-send-email-linus.walleij@stericsson.com>
References: <1334763054-19340-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120427190020.EDB813E0B4D@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Apr 2012 17:30:54 +0200, Linus Walleij <linus.walleij@stericsson.com> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This removes the internal functions for assigning IRQ
> handlers to each interrupt in favor of using the internal
> map iterator in the irq domain code.
> 
> Cc: Jamie Iles <jamie@jamieiles.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/common/vic.c |   44 ++++++++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
> index c558a3e..e0d5388 100644
> --- a/arch/arm/common/vic.c
> +++ b/arch/arm/common/vic.c
> @@ -39,6 +39,7 @@
>   * struct vic_device - VIC PM device
>   * @irq: The IRQ number for the base of the VIC.
>   * @base: The register base for the VIC.
> + * @valid_sources: A bitmask of valid interrupts
>   * @resume_sources: A bitmask of interrupts for resume.
>   * @resume_irqs: The IRQs enabled for resume.
>   * @int_select: Save for VIC_INT_SELECT.
> @@ -50,6 +51,7 @@
>  struct vic_device {
>  	void __iomem	*base;
>  	int		irq;
> +	u32		valid_sources;
>  	u32		resume_sources;
>  	u32		resume_irqs;
>  	u32		int_select;
> @@ -164,6 +166,27 @@ static int __init vic_pm_init(void)
>  late_initcall(vic_pm_init);
>  #endif /* CONFIG_PM */
>  
> +static struct irq_chip vic_chip;
> +
> +static int vic_irqdomain_map(struct irq_domain *d, unsigned int irq,
> +			     irq_hw_number_t hwirq)
> +{
> +	struct vic_device *v = d->host_data;
> +
> +	/* Skip invalid IRQs, only register handlers for the real ones */
> +	if (!(v->valid_sources & (1 << hwirq)))
> +		return -ENOTSUPP;
> +	irq_set_chip_and_handler(irq, &vic_chip, handle_level_irq);
> +	irq_set_chip_data(irq, v->base);
> +	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
> +	return 0;
> +}
> +
> +static struct irq_domain_ops vic_irqdomain_ops = {
> +	.map = vic_irqdomain_map,
> +	.xlate = irq_domain_xlate_onetwocell,
> +};

It looks like this patch also needs to update the
irq_domain_add_legacy() call to use this ops structure instead of
irq_domain_simple_ops.

g.
