From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 3 Aug 2012 15:05:09 +0200
Subject: [PATCH 1/2] ARM: i.MX35: Add kernel oftree support
In-Reply-To: <1343922986-32469-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343922986-32469-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120803130509.GO1451@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 02, 2012 at 05:56:25PM +0200, Uwe Kleine-K?nig wrote:
> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 
> This patch adds basic support for imx35-based devices to the kernel.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx35.dtsi            |  246 +++++++++++++++++++++++++++++++
>  arch/arm/configs/imx_v6_v7_defconfig    |    1 +
>  arch/arm/mach-imx/Kconfig               |   13 ++
>  arch/arm/mach-imx/Makefile              |    1 +
>  arch/arm/mach-imx/imx35-dt.c            |  119 +++++++++++++++
>  arch/arm/plat-mxc/include/mach/common.h |    2 +
>  6 files changed, 382 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx35.dtsi
>  create mode 100644 arch/arm/mach-imx/imx35-dt.c
> 

> diff --git a/arch/arm/mach-imx/imx35-dt.c b/arch/arm/mach-imx/imx35-dt.c
> new file mode 100644
> index 0000000..8b9cc84
> --- /dev/null
> +++ b/arch/arm/mach-imx/imx35-dt.c
> @@ -0,0 +1,119 @@
> +/*
> + * Copyright 2012 Steffen Trumtrar, Pengutronix
> + *
> + * based on imx27-dt.c
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License version 2 as published by the
> + * Free Software Foundation.
> + */
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/pinctrl/machine.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/time.h>
> +#include <mach/common.h>
> +#include <mach/mx35.h>
> +
> +static const struct of_dev_auxdata imx35_auxdata_lookup[] __initconst = {
> +	OF_DEV_AUXDATA("fsl,imx35-uart", MX35_UART1_BASE_ADDR, "imx21-uart.0", NULL),
> +	OF_DEV_AUXDATA("fsl,imx35-uart", MX35_UART2_BASE_ADDR, "imx21-uart.1", NULL),
> +	OF_DEV_AUXDATA("fsl,imx35-uart", MX35_UART3_BASE_ADDR, "imx21-uart.2", NULL),
> +	OF_DEV_AUXDATA("fsl,imx35-fec", MX35_FEC_BASE_ADDR, "imx27-fec.0", NULL),
> +	OF_DEV_AUXDATA("fsl,imx35-wdt", MX35_WDOG_BASE_ADDR, "imx2-wdt.0", NULL),
> +	OF_DEV_AUXDATA("fsl,imx35-i2c", MX35_I2C1_BASE_ADDR, "imx-i2c.0", NULL),
> +	OF_DEV_AUXDATA("fsl,imx35-i2c", MX35_I2C2_BASE_ADDR, "imx-i2c.1", NULL),
> +	OF_DEV_AUXDATA("fsl,imx35-i2c", MX35_I2C3_BASE_ADDR, "imx-i2c.2", NULL),
> +	OF_DEV_AUXDATA("fsl,imx35-sdhc", MX35_ESDHC1_BASE_ADDR, "sdhci-esdhc-imx35.0", NULL),
> +	OF_DEV_AUXDATA("fsl,imx35-sdhc", MX35_ESDHC2_BASE_ADDR, "sdhci-esdhc-imx35.1", NULL),
> +	OF_DEV_AUXDATA("fsl,imx35-sdhc", MX35_ESDHC3_BASE_ADDR, "sdhci-esdhc-imx35.2", NULL),
> +	OF_DEV_AUXDATA("fsl,imx35-nand", MX35_NFC_BASE_ADDR, "mxc_nand.0", NULL),
> +	{ /* sentinel */ }
> +};
> +
> +static int __init imx35_avic_add_irq_domain(struct device_node *np,
> +				struct device_node *interrupt_parent)
> +{
> +	irq_domain_add_legacy(np, 64, 0, 0, &irq_domain_simple_ops, NULL);
> +	return 0;
> +}
> +
> +static int __init imx35_gpio_add_irq_domain(struct device_node *np,
> +				struct device_node *interrupt_parent)
> +{
> +	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
> +
> +	gpio_irq_base -= 32;
> +	irq_domain_add_legacy(np, 32, gpio_irq_base, 0, &irq_domain_simple_ops,
> +				NULL);
> +
> +	return 0;
> +}

The gpio/irq drivers now call irq_domain_add_legacy themselves.

> +
> +static const struct of_device_id imx35_irq_match[] __initconst = {
> +	{ .compatible = "fsl,imx35-avic", .data = imx35_avic_add_irq_domain, },
> +	{ .compatible = "fsl,imx35-gpio", .data = imx35_gpio_add_irq_domain, },
> +	{ /* sentinel */ }
> +};
> +
> +static const struct of_device_id imx35_of_mixed_devices_match[] __initconst = {
> +	{ /* END OF LIST */ }
> +};
> +
> +static void __init of_mixed_device_hook(void)
> +{
> +	struct device_node *np;
> +	const struct of_device_id *of_id;
> +
> +	np = of_find_matching_node(NULL, imx35_of_mixed_devices_match);
> +	if (np) {
> +		void (*func)(void);
> +
> +		of_id = of_match_node(imx35_of_mixed_devices_match, np);
> +		func = of_id->data;
> +		func();
> +	}
> +}

What is the intention of this? I suppose currently it does nothing,
right?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
