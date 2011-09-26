From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 26 Sep 2011 23:29:18 +0100
Subject: [PATCH 3/3] ARM: gic: add OF based initialization
In-Reply-To: <1316550244-3655-4-git-send-email-robherring2@gmail.com>
References: <1316550244-3655-1-git-send-email-robherring2@gmail.com>
	<1316550244-3655-4-git-send-email-robherring2@gmail.com>
Message-ID: <20110926222918.GG9194@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Apologies for the noise!  One minor comment below.

Jamie

On Tue, Sep 20, 2011 at 03:24:04PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This adds ARM gic interrupt controller initialization using device tree
> data.
> 
> The initialization function is intended to be called by of_irq_init
> function like this:
> 
> const static struct of_device_id irq_match[] = {
>         { .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
>         {}
> };
> 
> static void __init init_irqs(void)
> {
>         of_irq_init(irq_match);
> }
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
[...]
> diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
> index 435d3f8..2862d0e 100644
> --- a/arch/arm/include/asm/hardware/gic.h
> +++ b/arch/arm/include/asm/hardware/gic.h
> @@ -33,10 +33,21 @@
>  #define GIC_DIST_SOFTINT		0xf00
>  
>  #ifndef __ASSEMBLY__
> +#include <linux/irqdomain.h>
> +
>  extern void __iomem *gic_cpu_base_addr;
>  extern struct irq_chip gic_arch_extn;
>  
>  void gic_init(unsigned int, unsigned int, void __iomem *, void __iomem *);
> +#ifdef CONFIG_OF
> +int gic_of_init(struct device_node *node, struct device_node *parent);
> +#else
> +static inline void gic_of_init(struct device_node *node,
> +			       struct device_node *parent)

This should return int?

> +{
> +	return -ENODEV;
> +}
> +#endif
