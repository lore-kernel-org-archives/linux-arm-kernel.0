From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 20 May 2013 11:32:09 +0800
Subject: [PATCH v3 1/2] pinctrl: add MVF600 pinctrl driver
In-Reply-To: <1368685224-17915-1-git-send-email-b35083@freescale.com>
References: <1368685224-17915-1-git-send-email-b35083@freescale.com>
Message-ID: <20130520033207.GD25113@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 02:20:23PM +0800, Jingchang Lu wrote:
> Adds Freescale Vybrid Family MVF600 pin controller
> driver to IMX iomuxc common driver framework.
> 
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
> v3:
>   clean up code.
>   update binding document according recommendation.
> 
>  .../bindings/pinctrl/fsl,mvf600-pinctrl.txt        |  41 +++
>  drivers/pinctrl/Kconfig                            |   8 +
>  drivers/pinctrl/Makefile                           |   1 +
>  drivers/pinctrl/pinctrl-mvf600.c                   | 338 +++++++++++++++++++++
>  4 files changed, 388 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,mvf600-pinctrl.txt
>  create mode 100644 drivers/pinctrl/pinctrl-mvf600.c
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,mvf600-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,mvf600-pinctrl.txt
> new file mode 100644
> index 0000000..a4d04d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,mvf600-pinctrl.txt
> @@ -0,0 +1,41 @@
> +Freescale Vybrid IOMUX Controller

Freescale Vybrid MVF600 IOMUX Controller

> +
> +Please refer to fsl,imx-pinctrl.txt in this directory for common binding part
> +and usage.
> +
> +Required properties:
> +- compatible: "fsl,mvf600-iomuxc"
> +- fsl,pins: two integers array, represents a group of pins mux and config
> +  setting. The format is fsl,pins = < PIN_FUNC_ID >, PIN_FUNC_ID is a pin

fsl,pins = <PIN_FUNC_ID CONFIG>

> +  working on a specific function, CONFIG is the pad setting value such as
> +  pull-up, speed, ode for this pin. Please refer to Vybrid MVF600 datasheet
> +  for the valid pad config settings.
> +
> +CONFIG bits definition:
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

for Vybrid MVF600.

> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 8f66924..5cb3987 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -108,6 +108,14 @@ config PINCTRL_IMX6SL
>  	help
>  	  Say Y here to enable the imx6sl pinctrl driver
>  
> +config PINCTRL_MVF600
> +	bool "Freescale Vybrid MVF600 pinctrl driver"
> +	depends on OF
> +	depends on SOC_MVF600
> +	select PINCTRL_IMX
> +	help
> +	  Say Y here to enable the Freescale Vybrid MVF600 pinctrl driver
> +
>  config PINCTRL_LANTIQ
>  	bool
>  	depends on LANTIQ
> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> index 34c4ae6..dfec292 100644
> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile
> @@ -46,6 +46,7 @@ obj-$(CONFIG_PINCTRL_EXYNOS5440)	+= pinctrl-exynos5440.o
>  obj-$(CONFIG_PINCTRL_S3C64XX)	+= pinctrl-s3c64xx.o
>  obj-$(CONFIG_PINCTRL_XWAY)	+= pinctrl-xway.o
>  obj-$(CONFIG_PINCTRL_LANTIQ)	+= pinctrl-lantiq.o
> +obj-$(CONFIG_PINCTRL_MVF600)	+= pinctrl-mvf600.o
>  
>  obj-$(CONFIG_PLAT_ORION)        += mvebu/
>  obj-$(CONFIG_ARCH_SHMOBILE)	+= sh-pfc/
> diff --git a/drivers/pinctrl/pinctrl-mvf600.c b/drivers/pinctrl/pinctrl-mvf600.c
> new file mode 100644
> index 0000000..6e2bcc0
> --- /dev/null
> +++ b/drivers/pinctrl/pinctrl-mvf600.c
> @@ -0,0 +1,338 @@
> +/*
> + * MVF600 pinctrl driver based on imx pinmux and pinconf core
> + *
> + * Copyright 2013 Freescale Semiconductor, Inc.
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
> +
> +enum mvf600_pads {
> +	MVF600_PAD_PTA6 = 0,
> +	MVF600_PAD_PTA8 = 1,
> +	MVF600_PAD_PTA9 = 2,
...
> +	MVF600_PAD_PTE27 = 132,
> +	MVF600_PAD_PTE28 = 133,
> +	MVF600_PAD_PTA7 = 134,
> +	};

No tab here, please.

> +
> +/* Pad names for the pinmux subsystem */
> +static const struct pinctrl_pin_desc mvf600_pinctrl_pads[] = {
...
> +};
> +
> +static struct imx_pinctrl_soc_info mvf600_pinctrl_info = {
> +	.pins = mvf600_pinctrl_pads,
> +	.npins = ARRAY_SIZE(mvf600_pinctrl_pads),
> +	.flags = ZERO_OFFSET_VALID | SHARE_MUX_CONF_REG,

The flags should be introduced in the same patch where they are used
in the first place.

Shawn

> +};
> +
> +static struct of_device_id mvf600_pinctrl_of_match[] = {
> +	{ .compatible = "fsl,mvf600-iomuxc", },
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
> +
> +MODULE_DESCRIPTION("Freescale MVF600 pinctrl driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.8.0
> 
> 
