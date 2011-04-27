From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Apr 2011 09:36:57 +0100
Subject: [PATCH] ARM: tegra: consolidate GIC extension usage
In-Reply-To: <1303297104-18887-1-git-send-email-marc.zyngier@arm.com>
References: <1303297104-18887-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110427083657.GI17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 11:58:24AM +0100, Marc Zyngier wrote:
> Tegra uses its own GIC extension mechanism to drive another interrupt
> controller, used as a wake-up source.
> 
> Move this functionality to the recently introduced gic_arch_extn.
> Adding an eoi method also ensures that the knowledge of the interrupt
> flow control is removed from the Tegra code.

A good follow-on step would be...

>  static void tegra_mask(struct irq_data *d)
>  {
> -	tegra_gic_mask_irq(d);
>  	tegra_legacy_mask_irq(d->irq);
>  }

... arranging tegra_legacy_mask_irq() etc to take struct irq_data directly.
These functions could then be removed entirely as they serve no useful
purpose other than transforming the new API back to the old API.

>  
>  static void tegra_unmask(struct irq_data *d)
>  {
> -	tegra_gic_unmask_irq(d);
>  	tegra_legacy_unmask_irq(d->irq);
>  }
>  
>  static void tegra_ack(struct irq_data *d)
>  {
>  	tegra_legacy_force_irq_clr(d->irq);
> -	tegra_gic_ack_irq(d);
> +}
> +
> +static void tegra_eoi(struct irq_data *d)
> +{
> +	tegra_legacy_force_irq_clr(d->irq);
>  }
>  
>  static int tegra_retrigger(struct irq_data *d)
> @@ -125,36 +123,16 @@ static int tegra_retrigger(struct irq_data *d)
>  	return 1;
>  }
>  
> -static struct irq_chip tegra_irq = {
> -	.name			= "PPI",
> -	.irq_ack		= tegra_ack,
> -	.irq_mask		= tegra_mask,
> -	.irq_unmask		= tegra_unmask,
> -	.irq_retrigger		= tegra_retrigger,
> -};
> -
>  void __init tegra_init_irq(void)
>  {
> -	struct irq_chip *gic;
> -	unsigned int i;
> -	int irq;
> -
>  	tegra_init_legacy_irq();
>  
> +	gic_arch_extn.irq_eoi		= tegra_eoi;
> +	gic_arch_extn.irq_ack		= tegra_ack;
> +	gic_arch_extn.irq_mask		= tegra_mask;
> +	gic_arch_extn.irq_unmask	= tegra_unmask;
> +	gic_arch_extn.irq_retrigger	= tegra_retrigger;

Hmm, gic_arch_extn should've been a pointer rather than a structure to avoid
architectures repeatedly doing this kind of initialization...
