From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 6 May 2013 10:54:48 +0800
Subject: [PATCH V2 1/2] pinctrl/mvf: add MVF pinctrl driver
In-Reply-To: <1367480932-22318-1-git-send-email-b35083@freescale.com>
References: <1367480932-22318-1-git-send-email-b35083@freescale.com>
Message-ID: <20130506025447.GF1749@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 03:48:51PM +0800, Jingchang Lu wrote:
> It adds Freescale Vybrid Family pin controller
> driver to IMX iomuxc common driver framework.
> 
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
> V2:
>   Update the driver according to the IMX new pinctrl framework
> 
>  .../bindings/pinctrl/fsl,mvf-pinctrl.txt           |  48 +++

fsl,mvf600-pinctrl.txt

>  drivers/pinctrl/Kconfig                            |   8 +
>  drivers/pinctrl/Makefile                           |   1 +
>  drivers/pinctrl/pinctrl-mvf.c                      | 337 +++++++++++++++++++++

pinctrl-mvf600.c

>  4 files changed, 394 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,mvf-pinctrl.txt
>  create mode 100644 drivers/pinctrl/pinctrl-mvf.c
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,mvf-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,mvf-pinctrl.txt
> new file mode 100644
> index 0000000..60f06cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,mvf-pinctrl.txt
> @@ -0,0 +1,48 @@
> +Freescale Vybrid IOMUX Controller
> +
> +Please refer to fsl,imx-pinctrl.txt in this directory for common binding part
> +and usage.
> +
> +Note:
> +- On Vybrid, pin's mux mode and pad control are in one 32-bit register.
> +  mux mode bits occupy bit[20:22] and config bits occupy bit[[0:15].
> +  So the config word is a combination of mux_mode and pad control value.
> +
> +Required properties:
> +- compatible: "fsl,mvf-iomuxc"

fsl,mvf600-iomuxc

> +- fsl,pins: A pin function macro with one argument, represents a group of
> +  pin's mux and pad control setting.
> +  The format is fsl,pins = < PIN_FUNC_ID(CONFIG) >, PIN_FUNC_ID is a pin
> +  working on a specific function, CONFIG is the pad setting value such as
> +  pull-up, spedd, ode and so on for this pin.
> +  Please refer to Vybrid datasheet for the valid pad mux and control settings.
> +
> +CONFIG bits definition:
> +PAD_MUX_MODE(x)			(x << 20)
> +PAD_CTL_SPEED_LOW		(1 << 12)
> +PAD_CTL_SPEED_MED		(2 << 12)
> +PAD_CTL_SPEED_HIGH		(3 << 12)
> +PAD_CTL_SRE_FAST		(1 << 11)
> +PAD_CTL_SRE_SLOW		(0 << 11)
> +PAD_CTL_ODE			(1 << 10)
> +PAD_CTL_HYS			(1 << 9)
> +PAD_CTL_DSE_DISABLE		(0 << 6)
> +PAD_CTL_DSE_150ohm		(1 << 6)
> +PAD_CTL_DSE_75ohm		(2 << 6)
> +PAD_CTL_DSE_50ohm		(3 << 6)
> +PAD_CTL_DSE_37ohm		(4 << 6)
> +PAD_CTL_DSE_30ohm		(5 << 6)
> +PAD_CTL_DSE_25ohm		(6 << 6)
> +PAD_CTL_DSE_20ohm		(7 << 6)
> +PAD_CTL_PUS_100K_DOWN		(0 << 4)
> +PAD_CTL_PUS_47K_UP		(1 << 4)
> +PAD_CTL_PUS_100K_UP		(2 << 4)
> +PAD_CTL_PUS_22K_UP		(3 << 4)
> +PAD_CTL_PKE			(1 << 3)
> +PAD_CTL_PUE			(1 << 2)
> +PAD_CTL_OBE_ENABLE		(1 << 1)
> +PAD_CTL_IBE_ENABLE		(1 << 0)
> +PAD_CTL_OBE_IBE_ENABLE		(3 << 0)
> +
> +Please refer to mvf600-pinfunc.h in device tree source folder
> +for all available PIN_FUNC_ID for Vybrid.
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 8f66924..885859c 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -108,6 +108,14 @@ config PINCTRL_IMX6SL
>  	help
>  	  Say Y here to enable the imx6sl pinctrl driver
>  
> +config PINCTRL_MVF

PINCTRL_MVF600

> +	bool "Vybrid pinctrl driver"
> +	depends on OF
> +	depends on SOC_MVF600
> +	select PINCTRL_IMX
> +	help
> +	  Say Y here to enable the Freescale Vybrid pinctrl driver
> +
>  config PINCTRL_LANTIQ
>  	bool
>  	depends on LANTIQ
> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> index 9bdaeb8..ec6d7b9 100644
> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile
> @@ -45,6 +45,7 @@ obj-$(CONFIG_PINCTRL_EXYNOS5440)	+= pinctrl-exynos5440.o
>  obj-$(CONFIG_PINCTRL_S3C64XX)	+= pinctrl-s3c64xx.o
>  obj-$(CONFIG_PINCTRL_XWAY)	+= pinctrl-xway.o
>  obj-$(CONFIG_PINCTRL_LANTIQ)	+= pinctrl-lantiq.o
> +obj-$(CONFIG_PINCTRL_MVF)	+= pinctrl-mvf.o
>  
>  obj-$(CONFIG_PLAT_ORION)        += mvebu/
>  obj-$(CONFIG_ARCH_SHMOBILE)	+= sh-pfc/
> diff --git a/drivers/pinctrl/pinctrl-mvf.c b/drivers/pinctrl/pinctrl-mvf.c
> new file mode 100644
> index 0000000..65041f9
> --- /dev/null
> +++ b/drivers/pinctrl/pinctrl-mvf.c
> @@ -0,0 +1,337 @@
> +/*
> + * Vybrid pinctrl driver based on imx pinmux and pinconf core
> + *
> + * Copyright 2013 Freescale Semiconductor, Inc.
> + *
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pinctrl/pinctrl.h>
> +
> +#include "pinctrl-imx.h"

...

> +static struct imx_pinctrl_soc_info mvf600_pinctrl_info = {
> +	.pins = mvf600_pinctrl_pads,
> +	.npins = ARRAY_SIZE(mvf600_pinctrl_pads),
> +};
> +
> +static struct of_device_id mvf600_pinctrl_of_match[] = {
> +	{ .compatible = "fsl,mvf-iomuxc", },
> +	{ /* sentinel */ }
> +};
> +
> +static int mvf600_pinctrl_probe(struct platform_device *pdev)
> +{
> +	return imx_pinctrl_probe(pdev, &mvf600_pinctrl_info);
> +}
> +
> +static struct platform_driver mvf600_pinctrl_driver = {
> +	.driver = {
> +		.name = "mvf600-pinctrl",
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(mvf600_pinctrl_of_match),
> +	},
> +	.probe = mvf600_pinctrl_probe,
> +	.remove = imx_pinctrl_remove,
> +};
> +
> +static int __init mvf600_pinctrl_init(void)
> +{
> +	return platform_driver_register(&mvf600_pinctrl_driver);
> +}
> +arch_initcall(mvf600_pinctrl_init);
> +
> +static void __exit mvf600_pinctrl_exit(void)
> +{
> +	platform_driver_unregister(&mvf600_pinctrl_driver);
> +}
> +module_exit(mvf600_pinctrl_exit);

Put a blank line here.

Shawn

> +MODULE_DESCRIPTION("Freescale MVF600 pinctrl driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.8.0
> 
> 
