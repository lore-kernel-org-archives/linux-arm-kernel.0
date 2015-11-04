From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 04 Nov 2015 17:20:40 +0900
Subject: [PATCH v5 3/4] drivers: exynos-srom: Add support for bank
 configuration
In-Reply-To: <72fa025c634fa477b1d7a89c254bd3c9c43f2b27.1446542020.git.p.fedin@samsung.com>
References: <cover.1446542020.git.p.fedin@samsung.com>
 <72fa025c634fa477b1d7a89c254bd3c9c43f2b27.1446542020.git.p.fedin@samsung.com>
Message-ID: <5639BFD8.6040006@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.11.2015 18:16, Pavel Fedin wrote:
> Implement handling properties in subnodes and adding child devices to the
> system. Child devices will not be added if configuration fails.
> 
> Since the driver now does more than suspend-resume support, dependency on
> CONFIG_PM is removed.
> 
> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig      |  2 +-
>  drivers/soc/samsung/Kconfig       |  2 +-
>  drivers/soc/samsung/exynos-srom.c | 60 +++++++++++++++++++++++++++++++++++++--
>  3 files changed, 60 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 83c85f5..c22dc42 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -16,7 +16,7 @@ menuconfig ARCH_EXYNOS
>  	select ARM_GIC
>  	select COMMON_CLK_SAMSUNG
>  	select EXYNOS_THERMAL
> -	select EXYNOS_SROM if PM
> +	select EXYNOS_SROM
>  	select HAVE_ARM_SCU if SMP
>  	select HAVE_S3C2410_I2C if I2C
>  	select HAVE_S3C2410_WATCHDOG if WATCHDOG
> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
> index 2833b5b..ea4bc2a 100644
> --- a/drivers/soc/samsung/Kconfig
> +++ b/drivers/soc/samsung/Kconfig
> @@ -8,6 +8,6 @@ config SOC_SAMSUNG
>  
>  config EXYNOS_SROM
>  	bool
> -	depends on ARM && ARCH_EXYNOS && PM
> +	depends on ARM && ARCH_EXYNOS
>  
>  endmenu
> diff --git a/drivers/soc/samsung/exynos-srom.c b/drivers/soc/samsung/exynos-srom.c
> index 57a232d..49b5c9e 100644
> --- a/drivers/soc/samsung/exynos-srom.c
> +++ b/drivers/soc/samsung/exynos-srom.c
> @@ -14,6 +14,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> @@ -67,11 +68,50 @@ static struct exynos_srom_reg_dump *exynos_srom_alloc_reg_dump(
>  	return rd;
>  }
>  
> +static int decode_sromc(struct exynos_srom *srom, struct device_node *np)

I missed that one previously: add prefix and more descriptive name, like:
exynos_srom_parse_child()

> +{
> +	u32 bank, width, pmc;
> +	u32 timing[6];
> +	u32 cs, bw;
> +
> +	if (of_property_read_u32(np, "reg", &bank))
> +		return -EINVAL;
> +	if (of_property_read_u32(np, "reg-io-width", &width))
> +		width = 1;
> +	if (of_property_read_u32(np, "samsung,srom-page-mode", &pmc))
> +		pmc = 0;
> +	if (of_property_read_u32_array(np, "samsung,srom-timing", timing,
> +				       ARRAY_SIZE(timing)))
> +		return -EINVAL;
> +
> +	bank *= 4; /* Convert bank into shift/offset */
> +
> +	cs = 1 << EXYNOS_SROM_BW__BYTEENABLE__SHIFT;
> +	if (width == 2)
> +		cs |= 1 << EXYNOS_SROM_BW__DATAWIDTH__SHIFT;
> +
> +	bw = __raw_readl(srom->reg_base + EXYNOS_SROM_BW);
> +	bw = (bw & ~(EXYNOS_SROM_BW__CS_MASK << bank)) | (cs << bank);
> +	__raw_writel(bw, srom->reg_base + EXYNOS_SROM_BW);
> +
> +	__raw_writel((pmc << EXYNOS_SROM_BCX__PMC__SHIFT) |
> +		    (timing[0] << EXYNOS_SROM_BCX__TACP__SHIFT) |
> +		    (timing[1] << EXYNOS_SROM_BCX__TCAH__SHIFT) |
> +		    (timing[2] << EXYNOS_SROM_BCX__TCOH__SHIFT) |
> +		    (timing[3] << EXYNOS_SROM_BCX__TACC__SHIFT) |
> +		    (timing[4] << EXYNOS_SROM_BCX__TCOS__SHIFT) |
> +		    (timing[5] << EXYNOS_SROM_BCX__TACS__SHIFT),
> +		    srom->reg_base + EXYNOS_SROM_BC0 + bank);
> +
> +	return 0;
> +}
> +
>  static int exynos_srom_probe(struct platform_device *pdev)
>  {
> -	struct device_node *np;
> +	struct device_node *np, *child;
>  	struct exynos_srom *srom;
>  	struct device *dev = &pdev->dev;
> +	bool error = false;

The 'error' name is misleading - like error for entire probe which is
not true.

Instead split it to separate function like:

+static int exynos_srom_parse_children(....) {
+       int ret = 0;
+
+	for_each_child_of_node(np, child) {
+               ret = exynos_srom_parse_child(srom, child);
+		if (ret) {
+			dev_err(dev,
+				"Could not decode bank configuration for %s: %d\n",
+				child->name, ret);
+			break;
+		}
+	}
+
+       return ret;
+}

Best regards,
Krzysztof

>  
>  	np = dev->of_node;
>  	if (!np) {
> @@ -100,7 +140,23 @@ static int exynos_srom_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> -	return 0;
> +	for_each_child_of_node(np, child) {
> +		if (decode_sromc(srom, child)) {
> +			dev_err(dev,
> +				"Could not decode bank configuration for %s\n",
> +				child->name);
> +			error = true;
> +		}
> +	}
> +
> +	/*
> +	 * If any bank failed to configure, we still provide suspend/resume,
> +	 * but do not probe child devices
> +	 */
> +	if (error)
> +		return 0;
> +
> +	return of_platform_populate(np, NULL, NULL, dev);
>  }
>  
>  static int exynos_srom_remove(struct platform_device *pdev)
> 
