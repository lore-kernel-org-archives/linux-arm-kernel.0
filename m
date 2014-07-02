From: zhangfei.gao@linaro.org (zhangfei)
Date: Wed, 02 Jul 2014 23:19:45 +0800
Subject: [PATCH v2 2/2] phy: add hix5hd2-sata-phy driver
In-Reply-To: <53B3EC62.80202@ti.com>
References: <1403687648-29082-1-git-send-email-zhangfei.gao@linaro.org>
 <1403687648-29082-3-git-send-email-zhangfei.gao@linaro.org>
 <53B3EC18.5020509@ti.com> <53B3EC62.80202@ti.com>
Message-ID: <53B42311.5010009@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi, Kishon

On 07/02/2014 07:26 PM, Kishon Vijay Abraham I wrote:

>>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>>> index 16a2f06..782953d 100644
>>> --- a/drivers/phy/Kconfig
>>> +++ b/drivers/phy/Kconfig
>>> @@ -109,6 +109,14 @@ config PHY_EXYNOS5250_SATA
>>>   	  SATA 3.0 Gb/s, SATA 6.0 Gb/s speeds. It supports one SATA host
>>>   	  port to accept one SATA device.
>>>
>>> +config PHY_HIX5HD2_SATA
>>> +	tristate "HIX5HD2 SATA PHY Driver"
>>> +	depends on ARCH_HIX5HD2 && OF
>>
>> depends on HAS_IOMEM?

Yes, will add it.
HAS_IOMEM is select by default and not notice it at all.
>>> +	select GENERIC_PHY
>>> +	select MFD_SYSCON
>>> +	help
>>> +	  Support for SATA PHY on Hisilicon hix5hd2 Soc.
>>> +
>>>   config PHY_SUN4I_USB
>>>   	tristate "Allwinner sunxi SoC USB PHY driver"
>>>   	depends on ARCH_SUNXI && HAS_IOMEM && OF
>>> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
>>> index b4f1d57..54f04d0 100644
>>> --- a/drivers/phy/Makefile
>>> +++ b/drivers/phy/Makefile
>>> @@ -12,6 +12,7 @@ obj-$(CONFIG_OMAP_USB2)			+= phy-omap-usb2.o
>>>   obj-$(CONFIG_TI_PIPE3)			+= phy-ti-pipe3.o
>>>   obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
>>>   obj-$(CONFIG_PHY_EXYNOS5250_SATA)	+= phy-exynos5250-sata.o
>>> +obj-$(CONFIG_PHY_HIX5HD2_SATA)		+= phy-hix5hd2-sata.o
>>>   obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
>>>   obj-$(CONFIG_PHY_SAMSUNG_USB2)		+= phy-exynos-usb2.o
>>>   phy-exynos-usb2-y			+= phy-samsung-usb2.o
>>> diff --git a/drivers/phy/phy-hix5hd2-sata.c b/drivers/phy/phy-hix5hd2-sata.c
>>> new file mode 100644
>>> index 0000000..6f1e3ea
>>> --- /dev/null
>>> +++ b/drivers/phy/phy-hix5hd2-sata.c
>>> @@ -0,0 +1,192 @@
>>> +/*
>>> + * Copyright (c) 2014 Linaro Ltd.
>>> + * Copyright (c) 2014 Hisilicon Limited.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + */
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/mfd/syscon.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/phy/phy.h>
>>> +#include <linux/io.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/delay.h>
>>
>> can this be arranged alphabetically? Helps while adding new header files.
Sure

>>> +static int hix5hd2_sata_phy_probe(struct platform_device *pdev)
>>> +{
>>> +	struct phy_provider *phy_provider;
>>> +	struct device *dev = &pdev->dev;
>>> +	struct resource *res;
>>> +	struct phy *phy;
>>> +	struct hix5hd2_priv *priv;
>>> +
>>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>> +	if (!priv)
>>> +		return -ENOMEM;
>>> +
>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	priv->base = devm_ioremap(dev, res->start, resource_size(res));
>
> It should be devm_ioremap_resource().
Since these memory region shared by other device, devm_ioremap_resource 
will fail, since devm_request_mem_region.

>
> -Kishon
>>> +	if (!priv->base)
>>> +		return -ENOMEM;
>>> +
>>> +	priv->peri_ctrl = syscon_regmap_lookup_by_phandle(dev->of_node,
>>> +						"hisilicon,peripheral-syscon");
>>> +	if (IS_ERR(priv->peri_ctrl))
>>> +		priv->peri_ctrl = NULL;
>>
>> if syscon_regmap_lookup_by_phandle returns EPROBE_DEFER, you have to return
>> EPROBE_DEFER no?
Sure,
However, postcore_initcall(syscon_init) is bound to init before 
module_platform_driver probe, so EPROBE_DEFER will not occur.

>>
>> Rest looks fine to me.
>>
>> Thanks
>> Kishon
>>
