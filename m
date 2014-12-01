From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 1 Dec 2014 11:47:17 +0000
Subject: [PATCH v2 2/8] mfd: MT6397: Add support for PMIC MT6397 MFD
In-Reply-To: <1417146874-5232-3-git-send-email-flora.fu@mediatek.com>
References: <1417146874-5232-1-git-send-email-flora.fu@mediatek.com>
 <1417146874-5232-3-git-send-email-flora.fu@mediatek.com>
Message-ID: <20141201114717.GD15845@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Nov 2014, Flora Fu wrote:

> 
> Add core files for MT6397 MFD driver.
> 
> Signed-off-by: Flora Fu <flora.fu@mediatek.com>
> ---
>  drivers/mfd/Kconfig                  |  10 +
>  drivers/mfd/Makefile                 |   1 +
>  drivers/mfd/mt6397-core.c            |  84 ++++++++
>  include/linux/mfd/mt6397/core.h      |  23 +++
>  include/linux/mfd/mt6397/registers.h | 362 +++++++++++++++++++++++++++++++++++
>  5 files changed, 480 insertions(+)
>  create mode 100644 drivers/mfd/mt6397-core.c
>  create mode 100644 include/linux/mfd/mt6397/core.h
>  create mode 100644 include/linux/mfd/mt6397/registers.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 1456ea7..f0b3efc 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1318,6 +1318,16 @@ config MFD_STW481X
>  	  in various ST Microelectronics and ST-Ericsson embedded
>  	  Nomadik series.
>  
> +config MFD_MT6397
> +	tristate "MediaTek MT6397 PMIC Support"
> +	select MFD_CORE
> +	select IRQ_DOMAIN
> +	help
> +	  Say yes here to add support for MediaTek MT6397 PMIC. This is
> +	  a Power Management IC. This driver provides common support for
> +	  accessing the device; additional drivers must be enabled in order
> +	  to use the functionality of the device.
> +
>  menu "Multimedia Capabilities Port drivers"
>  	depends on ARCH_SA1100
>  
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 8bd54b1..7168193 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -177,3 +177,4 @@ obj-$(CONFIG_MFD_HI6421_PMIC)	+= hi6421-pmic-core.o
>  
>  intel-soc-pmic-objs		:= intel_soc_pmic_core.o intel_soc_pmic_crc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
> +obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> new file mode 100644
> index 0000000..d1a6913
> --- /dev/null
> +++ b/drivers/mfd/mt6397-core.c
> @@ -0,0 +1,84 @@
> +/*
> + * Copyright (c) 2014 MediaTek Inc.
> + * Author: Flora Fu <flora.fu@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/mt6397/core.h>
> +#include <linux/soc/mediatek/mtk-pmic-wrap.h>
> +
> +static const struct mfd_cell mt6397_devs[] = {
> +	{ .name = "mt6397-rtc" },
> +	{ .name = "mt6397-regulator" },
> +	{
> +		.name = "mt6397-codec",
> +		.of_compatible = "mediatek,mt6397-codec"
> +	},
> +};
> +
> +static int mt6397_probe(struct platform_device *pdev)
> +{
> +	u32 ret;
> +	struct mt6397_chip *mt6397;
> +	struct pmic_wrapper *wrp;
> +
> +	/* mt6397 MFD is child device of soc pmic wrapper. */
> +	wrp = dev_get_drvdata(pdev->dev.parent);

You might want to check this prior to dereferencing it.

> +	mt6397 = devm_kzalloc(&pdev->dev,
> +			sizeof(*mt6397), GFP_KERNEL);

Why is this wrapped?

> +	if (!mt6397)
> +		return -ENOMEM;
> +
> +	mt6397->dev = &pdev->dev;

Is this used else where?  If not, I think you can remove it.

> +	mt6397->regmap = wrp->regmap;
> +	platform_set_drvdata(pdev, mt6397);

Then you can platform_set_drvdata(pdev, regmap);

Although I don't see this being used either.  Is it used in the child
devices?

> +	ret = mfd_add_devices(mt6397->dev, -1, &mt6397_devs[0],
> +			ARRAY_SIZE(mt6397_devs), NULL, 0, NULL);
> +	if (ret)
> +		dev_err(mt6397->dev, "failed to add child devices: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int mt6397_remove(struct platform_device *pdev)
> +{
> +	struct mt6397_chip *mt6397 = platform_get_drvdata(pdev);

No need for this.

> +	mfd_remove_devices(mt6397->dev);

Just use &pdev->dev, as you did when you registered.

> +	return 0;
> +}

[...]

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
