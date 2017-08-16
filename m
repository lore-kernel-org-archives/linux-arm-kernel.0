From: alex.g@adaptrum.com (Alexandru Gagniuc)
Date: Wed, 16 Aug 2017 13:50:51 -0700
Subject: [PATCH v3 4/5] reset: zx2967: use the reset-simple driver
In-Reply-To: <20170816094701.30678-5-p.zabel@pengutronix.de>
References: <20170816094701.30678-1-p.zabel@pengutronix.de>
 <20170816094701.30678-5-p.zabel@pengutronix.de>
Message-ID: <1d7cb10e-b233-aaa9-cd33-fca33ae6627e@adaptrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/16/2017 02:47 AM, Philipp Zabel wrote:
> The reset-simple driver can be used without changes.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Reviewed-by: Alexandru Gagniuc <alex.g@adaptrum.com>

> ---
>  MAINTAINERS                  |  1 -
>  drivers/reset/Kconfig        | 10 +----
>  drivers/reset/Makefile       |  1 -
>  drivers/reset/reset-simple.c |  2 +
>  drivers/reset/reset-zx2967.c | 99 --------------------------------------------
>  5 files changed, 4 insertions(+), 109 deletions(-)
>  delete mode 100644 drivers/reset/reset-zx2967.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 57853844969bf..30af04516d8a0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2061,7 +2061,6 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	arch/arm/mach-zx/
>  F:	drivers/clk/zte/
> -F:	drivers/reset/reset-zx2967.c
>  F:	drivers/soc/zte/
>  F:	Documentation/devicetree/bindings/arm/zte.txt
>  F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 29f4487c290fc..6dfea01023618 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -70,14 +70,14 @@ config RESET_PISTACHIO
>
>  config RESET_SIMPLE
>  	bool "Simple Reset Controller Driver" if COMPILE_TEST
> -	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_SUNXI
> +	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_SUNXI || ARCH_ZX
>  	help
>  	  This enables a simple reset controller driver for reset lines that
>  	  that can be asserted and deasserted by toggling bits in a contiguous,
>  	  exclusive register space.
>
>  	  Currently this driver supports Altera SoCFPGAs, the RCC reset
> -	  controller in STM32 MCUs, and Allwinner SoCs.
> +	  controller in STM32 MCUs, Allwinner SoCs, and ZTE's zx2967 family.
>
>  config RESET_SUNXI
>  	bool "Allwinner SoCs Reset Driver" if COMPILE_TEST && !ARCH_SUNXI
> @@ -114,12 +114,6 @@ config RESET_UNIPHIER
>  	  Say Y if you want to control reset signals provided by System Control
>  	  block, Media I/O block, Peripheral Block.
>
> -config RESET_ZX2967
> -	bool "ZTE ZX2967 Reset Driver"
> -	depends on ARCH_ZX || COMPILE_TEST
> -	help
> -	  This enables the reset controller driver for ZTE's zx2967 family.
> -
>  config RESET_ZYNQ
>  	bool "ZYNQ Reset Driver" if COMPILE_TEST
>  	default ARCH_ZYNQ
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index e8c3a032f4780..3a70c254b5ea5 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -16,6 +16,5 @@ obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
>  obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
>  obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
>  obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
> -obj-$(CONFIG_RESET_ZX2967) += reset-zx2967.o
>  obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
>
> diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
> index e54a29b8b532d..13e7d5559acc9 100644
> --- a/drivers/reset/reset-simple.c
> +++ b/drivers/reset/reset-simple.c
> @@ -123,6 +123,8 @@ static const struct of_device_id reset_simple_dt_ids[] = {
>  	{ .compatible = "st,stm32-rcc", },
>  	{ .compatible = "allwinner,sun6i-a31-clock-reset",
>  		.data = &reset_simple_active_low },
> +	{ .compatible = "zte,zx296718-reset",
> +		.data = &reset_simple_active_low },
>  	{ /* sentinel */ },
>  };
>
> diff --git a/drivers/reset/reset-zx2967.c b/drivers/reset/reset-zx2967.c
> deleted file mode 100644
> index 4f319f7753d4d..0000000000000
> --- a/drivers/reset/reset-zx2967.c
> +++ /dev/null
> @@ -1,99 +0,0 @@
> -/*
> - * ZTE's zx2967 family reset controller driver
> - *
> - * Copyright (C) 2017 ZTE Ltd.
> - *
> - * Author: Baoyou Xie <baoyou.xie@linaro.org>
> - *
> - * License terms: GNU General Public License (GPL) version 2
> - */
> -
> -#include <linux/of_address.h>
> -#include <linux/platform_device.h>
> -#include <linux/reset-controller.h>
> -
> -struct zx2967_reset {
> -	void __iomem			*reg_base;
> -	spinlock_t			lock;
> -	struct reset_controller_dev	rcdev;
> -};
> -
> -static int zx2967_reset_act(struct reset_controller_dev *rcdev,
> -			    unsigned long id, bool assert)
> -{
> -	struct zx2967_reset *reset = NULL;
> -	int bank = id / 32;
> -	int offset = id % 32;
> -	u32 reg;
> -	unsigned long flags;
> -
> -	reset = container_of(rcdev, struct zx2967_reset, rcdev);
> -
> -	spin_lock_irqsave(&reset->lock, flags);
> -
> -	reg = readl_relaxed(reset->reg_base + (bank * 4));
> -	if (assert)
> -		reg &= ~BIT(offset);
> -	else
> -		reg |= BIT(offset);
> -	writel_relaxed(reg, reset->reg_base + (bank * 4));
> -
> -	spin_unlock_irqrestore(&reset->lock, flags);
> -
> -	return 0;
> -}
> -
> -static int zx2967_reset_assert(struct reset_controller_dev *rcdev,
> -			       unsigned long id)
> -{
> -	return zx2967_reset_act(rcdev, id, true);
> -}
> -
> -static int zx2967_reset_deassert(struct reset_controller_dev *rcdev,
> -				 unsigned long id)
> -{
> -	return zx2967_reset_act(rcdev, id, false);
> -}
> -
> -static const struct reset_control_ops zx2967_reset_ops = {
> -	.assert		= zx2967_reset_assert,
> -	.deassert	= zx2967_reset_deassert,
> -};
> -
> -static int zx2967_reset_probe(struct platform_device *pdev)
> -{
> -	struct zx2967_reset *reset;
> -	struct resource *res;
> -
> -	reset = devm_kzalloc(&pdev->dev, sizeof(*reset), GFP_KERNEL);
> -	if (!reset)
> -		return -ENOMEM;
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	reset->reg_base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(reset->reg_base))
> -		return PTR_ERR(reset->reg_base);
> -
> -	spin_lock_init(&reset->lock);
> -
> -	reset->rcdev.owner = THIS_MODULE;
> -	reset->rcdev.nr_resets = resource_size(res) * 8;
> -	reset->rcdev.ops = &zx2967_reset_ops;
> -	reset->rcdev.of_node = pdev->dev.of_node;
> -
> -	return devm_reset_controller_register(&pdev->dev, &reset->rcdev);
> -}
> -
> -static const struct of_device_id zx2967_reset_dt_ids[] = {
> -	 { .compatible = "zte,zx296718-reset", },
> -	 {},
> -};
> -
> -static struct platform_driver zx2967_reset_driver = {
> -	.probe	= zx2967_reset_probe,
> -	.driver = {
> -		.name		= "zx2967-reset",
> -		.of_match_table	= zx2967_reset_dt_ids,
> -	},
> -};
> -builtin_platform_driver(zx2967_reset_driver);
>
