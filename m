From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 28 Jun 2018 13:05:05 +0100
Subject: [PATCH v3 06/17] irqchip/irq-mvebu-icu: switch to regmap
In-Reply-To: <20180622151432.1566-7-miquel.raynal@bootlin.com>
References: <20180622151432.1566-1-miquel.raynal@bootlin.com>
 <20180622151432.1566-7-miquel.raynal@bootlin.com>
Message-ID: <ebdd4cb8-7cc8-3efa-d4be-f5d8860e848d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/06/18 16:14, Miquel Raynal wrote:
> Before splitting the code to support multiple platform devices to
> be probed (one for the ICU, one per interrupt group), let's switch to
> regmap first by creating one in the ->probe().

What's the benefit of doing so? I assume that has to do with supporting
multiple devices that share an MMIO range?

> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/irqchip/irq-mvebu-icu.c | 45 +++++++++++++++++++++++++++--------------
>  1 file changed, 30 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
> index 0f2655d7f19e..3694c0d73c0d 100644
> --- a/drivers/irqchip/irq-mvebu-icu.c
> +++ b/drivers/irqchip/irq-mvebu-icu.c
> @@ -18,6 +18,8 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
>  
>  #include <dt-bindings/interrupt-controller/mvebu-icu.h>
>  
> @@ -38,7 +40,7 @@
>  
>  struct mvebu_icu {
>  	struct irq_chip irq_chip;
> -	void __iomem *base;
> +	struct regmap *regmap;
>  	struct irq_domain *domain;
>  	struct device *dev;
>  	atomic_t initialized;
> @@ -56,10 +58,10 @@ static void mvebu_icu_init(struct mvebu_icu *icu, struct msi_msg *msg)
>  		return;
>  
>  	/* Set Clear/Set ICU SPI message address in AP */
> -	writel_relaxed(msg[0].address_hi, icu->base + ICU_SETSPI_NSR_AH);
> -	writel_relaxed(msg[0].address_lo, icu->base + ICU_SETSPI_NSR_AL);
> -	writel_relaxed(msg[1].address_hi, icu->base + ICU_CLRSPI_NSR_AH);
> -	writel_relaxed(msg[1].address_lo, icu->base + ICU_CLRSPI_NSR_AL);
> +	regmap_write(icu->regmap, ICU_SETSPI_NSR_AH, msg[0].address_hi);
> +	regmap_write(icu->regmap, ICU_SETSPI_NSR_AL, msg[0].address_lo);
> +	regmap_write(icu->regmap, ICU_CLRSPI_NSR_AH, msg[1].address_hi);
> +	regmap_write(icu->regmap, ICU_CLRSPI_NSR_AL, msg[1].address_lo);

Isn't this a change in the way we write things to the MMIO registers?
You're now trading a writel_relaxed for a writel, plus some locking...

Talking about which: Are you always in a context where you can take that
lock? The bit of documentation I've just read seems to imply that the
default lock is a mutex. Is that always safe? My guess is that it isn't,
and any callback that can end-up here after having taken something like
the desc lock is going to blow in your face.

Have you tried lockdep?

>  }
>  
>  static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
> @@ -82,7 +84,7 @@ static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
>  		icu_int = 0;
>  	}
>  
> -	writel_relaxed(icu_int, icu->base + ICU_INT_CFG(d->hwirq));
> +	regmap_write(icu->regmap, ICU_INT_CFG(d->hwirq), icu_int);
>  
>  	/*
>  	 * The SATA unit has 2 ports, and a dedicated ICU entry per
> @@ -94,10 +96,10 @@ static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
>  	 * configured (regardless of which port is actually in use).
>  	 */
>  	if (d->hwirq == ICU_SATA0_ICU_ID || d->hwirq == ICU_SATA1_ICU_ID) {
> -		writel_relaxed(icu_int,
> -			       icu->base + ICU_INT_CFG(ICU_SATA0_ICU_ID));
> -		writel_relaxed(icu_int,
> -			       icu->base + ICU_INT_CFG(ICU_SATA1_ICU_ID));
> +		regmap_write(icu->regmap, ICU_INT_CFG(ICU_SATA0_ICU_ID),
> +			     icu_int);
> +		regmap_write(icu->regmap, ICU_INT_CFG(ICU_SATA1_ICU_ID),
> +			     icu_int);
>  	}
>  }
>  
> @@ -204,12 +206,20 @@ static const struct irq_domain_ops mvebu_icu_domain_ops = {
>  	.free      = mvebu_icu_irq_domain_free,
>  };
>  
> +static struct regmap_config mvebu_icu_regmap_config = {
> +	.reg_bits	= 32,
> +	.val_bits	= 32,
> +	.reg_stride	= 4,
> +	.name		= "mvebu_icu",
> +};
> +
>  static int mvebu_icu_probe(struct platform_device *pdev)
>  {
>  	struct mvebu_icu *icu;
>  	struct device_node *node = pdev->dev.of_node;
>  	struct device_node *gicp_dn;
>  	struct resource *res;
> +	void __iomem *regs;
>  	int i;
>  
>  	icu = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_icu),
> @@ -220,12 +230,17 @@ static int mvebu_icu_probe(struct platform_device *pdev)
>  	icu->dev = &pdev->dev;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	icu->base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(icu->base)) {
> +	regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(regs)) {
>  		dev_err(&pdev->dev, "Failed to map icu base address.\n");
> -		return PTR_ERR(icu->base);
> +		return PTR_ERR(regs);
>  	}
>  
> +	icu->regmap = devm_regmap_init_mmio(icu->dev, regs,
> +					    &mvebu_icu_regmap_config);
> +	if (IS_ERR(icu->regmap))
> +		return PTR_ERR(icu->regmap);
> +
>  	icu->irq_chip.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>  					    "ICU.%x",
>  					    (unsigned int)res->start);
> @@ -260,11 +275,11 @@ static int mvebu_icu_probe(struct platform_device *pdev)
>  	for (i = 0 ; i < ICU_MAX_IRQS ; i++) {
>  		u32 icu_int, icu_grp;
>  
> -		icu_int = readl_relaxed(icu->base + ICU_INT_CFG(i));
> +		regmap_read(icu->regmap, ICU_INT_CFG(i), &icu_int);
>  		icu_grp = icu_int >> ICU_GROUP_SHIFT;
>  
>  		if (icu_grp == ICU_GRP_NSR)
> -			writel_relaxed(0x0, icu->base + ICU_INT_CFG(i));
> +			regmap_write(icu->regmap, ICU_INT_CFG(i), 0);
>  	}
>  
>  	icu->domain =
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
