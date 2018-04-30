From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Mon, 30 Apr 2018 14:42:01 +0200
Subject: [PATCH 06/17] irqchip/irq-mvebu-icu: switch to regmap
In-Reply-To: <20180421135537.24716-7-miquel.raynal@bootlin.com> (Miquel
 Raynal's message of "Sat, 21 Apr 2018 15:55:26 +0200")
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
 <20180421135537.24716-7-miquel.raynal@bootlin.com>
Message-ID: <87muxkc1d2.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,
 
 On sam., avril 21 2018, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> The ICU DT nodes have now the 'syscon' compatible, we can switch to
> regmap before splitting the code to support multiple platform devices to
> be probed (one for the ICU, one per interrupt group).
>

How do you handle the case when you receive an old dtb (without the
syscon compatible) ?

Gregory

> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/irqchip/irq-mvebu-icu.c | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
> index 5af2520445c4..580586240781 100644
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
> @@ -40,7 +42,7 @@
>  
>  struct mvebu_icu {
>  	struct irq_chip irq_chip;
> -	void __iomem *base;
> +	struct regmap *regmap;
>  	struct irq_domain *domain;
>  	struct device *dev;
>  };
> @@ -69,7 +71,7 @@ static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
>  		icu_int = 0;
>  	}
>  
> -	writel_relaxed(icu_int, icu->base + ICU_INT_CFG(d->hwirq));
> +	regmap_write(icu->regmap, ICU_INT_CFG(d->hwirq), icu_int);
>  
>  	/*
>  	 * The SATA unit has 2 ports, and a dedicated ICU entry per
> @@ -81,10 +83,10 @@ static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
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
> @@ -208,12 +210,13 @@ static int mvebu_icu_probe(struct platform_device *pdev)
>  
>  	icu->dev = &pdev->dev;
>  
> +	icu->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, NULL);
> +	if (IS_ERR(icu->regmap))
> +		return PTR_ERR(icu->regmap);
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	icu->base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(icu->base)) {
> -		dev_err(&pdev->dev, "Failed to map icu base address.\n");
> -		return PTR_ERR(icu->base);
> -	}
> +	if (!res)
> +		return -ENODEV;
>  
>  	icu->irq_chip.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>  					    "ICU.%x",
> @@ -247,10 +250,10 @@ static int mvebu_icu_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	/* Set Clear/Set ICU SPI message address in AP */
> -	writel_relaxed(upper_32_bits(setspi), icu->base + ICU_SETSPI_NSR_AH);
> -	writel_relaxed(lower_32_bits(setspi), icu->base + ICU_SETSPI_NSR_AL);
> -	writel_relaxed(upper_32_bits(clrspi), icu->base + ICU_CLRSPI_NSR_AH);
> -	writel_relaxed(lower_32_bits(clrspi), icu->base + ICU_CLRSPI_NSR_AL);
> +	regmap_write(icu->regmap, ICU_SETSPI_NSR_AH, upper_32_bits(setspi));
> +	regmap_write(icu->regmap, ICU_SETSPI_NSR_AL, lower_32_bits(setspi));
> +	regmap_write(icu->regmap, ICU_CLRSPI_NSR_AH, upper_32_bits(clrspi));
> +	regmap_write(icu->regmap, ICU_CLRSPI_NSR_AL, lower_32_bits(clrspi));
>  
>  	/*
>  	 * Clean all ICU interrupts with type SPI_NSR, required to
> @@ -259,11 +262,11 @@ static int mvebu_icu_probe(struct platform_device *pdev)
>  	for (i = 0 ; i < ICU_MAX_IRQS ; i++) {
>  		u32 icu_int, icu_grp;
>  
> -		icu_int = readl(icu->base + ICU_INT_CFG(i));
> +		regmap_read(icu->regmap, ICU_INT_CFG(i), &icu_int);
>  		icu_grp = icu_int >> ICU_GROUP_SHIFT;
>  
>  		if (icu_grp == ICU_GRP_NSR)
> -			writel_relaxed(0x0, icu->base + ICU_INT_CFG(i));
> +			regmap_write(icu->regmap, ICU_INT_CFG(i), 0);
>  	}
>  
>  	icu->domain =
> -- 
> 2.14.1
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
