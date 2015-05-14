From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 14 May 2015 11:52:26 +0200
Subject: [PATCH 14/15] thermal: Add Mediatek thermal controller support
In-Reply-To: <1431507163-19933-15-git-send-email-s.hauer@pengutronix.de>
References: <1431507163-19933-1-git-send-email-s.hauer@pengutronix.de>
 <1431507163-19933-15-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1431597146.2650.59.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-05-13 at 10:52 +0200, Sascha Hauer wrote:
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig

> +config MTK_THERMAL
> +	tristate "Temperature sensor driver for mediatek SoCs"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	default y
> +	help
> +	  Enable this option if you want to have support for thermal management
> +	  controller present in Mediatek SoCs

> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile

> +obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o

> --- /dev/null
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -0,0 +1,728 @@

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

> +#include <linux/module.h>

> +static const struct of_device_id mtk_thermal_of_match[] = {
> +	{
> +		.compatible = "mediatek,mt8173-thermal",
> +	}, {
> +	},
> +};
> +
> +static struct platform_driver mtk_thermal_driver = {
> +	.probe = mtk_thermal_probe,
> +	.remove = mtk_thermal_remove,
> +	.driver = {
> +		.name = THERMAL_NAME,
> +		.of_match_table = mtk_thermal_of_match,
> +	},
> +};
> +
> +module_platform_driver(mtk_thermal_driver);

If MTK_THERMAL is set to 'm' a mtk_thermal.ko module will be built. I
didn't spot a MODULE_LICENSE() macro in this file. So I think that, if
mtk_thermal.ko gets loaded - I guess through the of_match_table magic -
a warning will be issued and the kernel will be tainted.

(I didn't actually test any of this, so I've wasted your time if I've
overlooked something here.)


Paul Bolle
