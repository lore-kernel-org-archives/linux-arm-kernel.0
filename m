From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 8 Dec 2014 08:46:29 +0000
Subject: [PATCH v3 2/8] mfd: MT6397: Add support for PMIC MT6397 MFD
In-Reply-To: <1417752479-4749-3-git-send-email-flora.fu@mediatek.com>
References: <1417752479-4749-1-git-send-email-flora.fu@mediatek.com>
 <1417752479-4749-3-git-send-email-flora.fu@mediatek.com>
Message-ID: <20141208084629.GB3951@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 05 Dec 2014, Flora Fu wrote:

> Add core files for MT6397 MFD driver.
> 
> Signed-off-by: Flora Fu <flora.fu@mediatek.com>
> ---
>  drivers/mfd/Kconfig                  |  10 +
>  drivers/mfd/Makefile                 |   1 +
>  drivers/mfd/mt6397-core.c            |  87 +++++++++
>  include/linux/mfd/mt6397/core.h      |  23 +++
>  include/linux/mfd/mt6397/registers.h | 362 +++++++++++++++++++++++++++++++++++
>  5 files changed, 483 insertions(+)
>  create mode 100644 drivers/mfd/mt6397-core.c
>  create mode 100644 include/linux/mfd/mt6397/core.h
>  create mode 100644 include/linux/mfd/mt6397/registers.h

[...]

> +++ b/drivers/mfd/mt6397-core.c
> @@ -0,0 +1,87 @@
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
> +	{
> +		.name = "mt6397-regulator",
> +		.of_compatible = "mediatek,mt6397-regulator",
> +	},
> +	{
> +		.name = "mt6397-codec",
> +		.of_compatible = "mediatek,mt6397-codec",
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
> +	if (!pdev->dev.parent)
> +		return -ENODEV;
> +
> +	wrp = dev_get_drvdata(pdev->dev.parent);

You're _still_ not checking the return value prior to dereferencing.

> +	mt6397 = devm_kzalloc(&pdev->dev, sizeof(*mt6397), GFP_KERNEL);
> +	if (!mt6397)
> +		return -ENOMEM;
> +
> +	mt6397->dev = &pdev->dev;
> +	mt6397->regmap = wrp->regmap;

> +	platform_set_drvdata(pdev, mt6397);
> +
> +	ret = mfd_add_devices(&pdev->dev, -1, &mt6397_devs[0],

Just mt6397_devs here.

> +			ARRAY_SIZE(mt6397_devs), NULL, 0, NULL);
> +	if (ret)
> +		dev_err(&pdev->dev, "failed to add child devices: %d\n", ret);

There is no point in printing ret.  The kernel will do that for you.

[...]

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
