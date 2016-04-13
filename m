From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 13 Apr 2016 18:50:22 +0530
Subject: [PATCH v3 09/16] phy: da8xx-usb: new driver for DA8xx SoC USB PHY
In-Reply-To: <1458863503-31121-10-git-send-email-david@lechnology.com>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
 <1458863503-31121-10-git-send-email-david@lechnology.com>
Message-ID: <570E4796.7070005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 25 March 2016 05:21 AM, David Lechner wrote:
> This is a new phy driver for the SoC USB controllers on the TI DA8xx
> family of microcontrollers. The USB 1.1 PHY is just a simple on/off.
> The USB 2.0 PHY also allows overriding the VBUS and ID pins.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v3 changes:
> 
> * Uses syscon device for CFGCHIP2 instead of using it directly.
> * Got rid of nop inline funtions
> * Correct suffix on funtions to match ops.*
> * Added header file for extern method.
> 
> 
>  drivers/phy/Kconfig               |  10 ++
>  drivers/phy/Makefile              |   1 +
>  drivers/phy/phy-da8xx-usb.c       | 249 ++++++++++++++++++++++++++++++++++++++
>  include/linux/phy/phy-da8xx-usb.h |  19 +++
>  4 files changed, 279 insertions(+)
>  create mode 100644 drivers/phy/phy-da8xx-usb.c
>  create mode 100644 include/linux/phy/phy-da8xx-usb.h
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 26566db..c1d315f 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -35,6 +35,16 @@ config ARMADA375_USBCLUSTER_PHY
>  	depends on OF && HAS_IOMEM
>  	select GENERIC_PHY
>  
> +config PHY_DA8XX_USB
> +	tristate "TI DA8xx USB PHY Driver"
> +	depends on ARCH_DAVINCI_DA8XX
> +	select GENERIC_PHY
> +	select MFD_SYSCON
> +	help
> +	  Enable this to support the USB PHY on DA8xx SoCs.
> +
> +	  This driver controls both the USB 1.1 PHY and the USB 2.0 PHY.
> +
>  config PHY_DM816X_USB
>  	tristate "TI dm816x USB PHY driver"
>  	depends on ARCH_OMAP2PLUS
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 24596a9..722e01c 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -5,6 +5,7 @@
>  obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
>  obj-$(CONFIG_PHY_BERLIN_USB)		+= phy-berlin-usb.o
>  obj-$(CONFIG_PHY_BERLIN_SATA)		+= phy-berlin-sata.o
> +obj-$(CONFIG_PHY_DA8XX_USB)		+= phy-da8xx-usb.o
>  obj-$(CONFIG_PHY_DM816X_USB)		+= phy-dm816x-usb.o
>  obj-$(CONFIG_ARMADA375_USBCLUSTER_PHY)	+= phy-armada375-usb2.o
>  obj-$(CONFIG_BCM_KONA_USB2_PHY)		+= phy-bcm-kona-usb2.o
> diff --git a/drivers/phy/phy-da8xx-usb.c b/drivers/phy/phy-da8xx-usb.c
> new file mode 100644
> index 0000000..687d9a0
> --- /dev/null
> +++ b/drivers/phy/phy-da8xx-usb.c
> @@ -0,0 +1,249 @@
> +/*
> + * phy-da8xx-usb - TI DaVinci DA8xx USB PHY driver
> + *
> + * Copyright (C) 2016 David Lechner <david@lechnology.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/mfd/da8xx-cfgchip.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/phy/phy-da8xx-usb.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/usb/gadget.h>
> +#include <linux/usb/otg.h>
> +
> +struct da8xx_usbphy {
> +	struct phy_provider	*phy_provider;
> +	struct phy		*usb11_phy;
> +	struct phy		*usb20_phy;
> +	struct clk		*usb11_clk;
> +	struct clk		*usb20_clk;
> +	struct regmap		*regmap;
> +};
> +
> +static int da8xx_usb11_phy_power_on(struct phy *phy)
> +{
> +	struct da8xx_usbphy *d_phy = phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret = clk_prepare_enable(d_phy->usb11_clk);
> +	if (ret)
> +		return ret;
> +
> +	regmap_write_bits(d_phy->regmap, CFGCHIP2_REG, CFGCHIP2_USB1SUSPENDM,
> +			  CFGCHIP2_USB1SUSPENDM);
> +
> +	return 0;
> +}
> +
> +static int da8xx_usb11_phy_power_off(struct phy *phy)
> +{
> +	struct da8xx_usbphy *d_phy = phy_get_drvdata(phy);
> +
> +	regmap_write_bits(d_phy->regmap, CFGCHIP2_REG, CFGCHIP2_USB1SUSPENDM, 0);
> +
> +	clk_disable_unprepare(d_phy->usb11_clk);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops da8xx_usb11_phy_ops = {
> +	.power_on	= da8xx_usb11_phy_power_on,
> +	.power_off	= da8xx_usb11_phy_power_off,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int da8xx_usb20_phy_init(struct phy *phy)
> +{
> +	struct da8xx_usbphy *d_phy = phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret = clk_prepare_enable(d_phy->usb20_clk);
> +	if (ret)
> +		return ret;
> +
> +	regmap_write_bits(d_phy->regmap, CFGCHIP2_REG, CFGCHIP2_OTGPWRDN, 0);
> +
> +	return 0;
> +}
> +
> +static int da8xx_usb20_phy_shutdown(struct phy *phy)
> +{
> +	struct da8xx_usbphy *d_phy = phy_get_drvdata(phy);
> +
> +	regmap_write_bits(d_phy->regmap, CFGCHIP2_REG, CFGCHIP2_OTGPWRDN,
> +			  CFGCHIP2_OTGPWRDN);
> +
> +	clk_disable_unprepare(d_phy->usb20_clk);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops da8xx_usb20_phy_ops = {
> +	.power_on	= da8xx_usb20_phy_init,
> +	.power_off	= da8xx_usb20_phy_shutdown,
> +	.owner		= THIS_MODULE,
> +};
> +
> +int da8xx_usb20_phy_set_mode(struct phy *phy, enum musb_mode mode)
> +{
> +	struct da8xx_usbphy *d_phy = phy_get_drvdata(phy);
> +	u32 val;
> +
> +	switch (mode) {
> +	case MUSB_HOST:		/* Force VBUS valid, ID = 0 */
> +		val = CFGCHIP2_FORCE_HOST;
> +		break;
> +	case MUSB_PERIPHERAL:	/* Force VBUS valid, ID = 1 */
> +		val = CFGCHIP2_FORCE_DEVICE;
> +		break;
> +	case MUSB_OTG:		/* Don't override the VBUS/ID comparators */
> +		val = CFGCHIP2_NO_OVERRIDE;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	regmap_write_bits(d_phy->regmap, CFGCHIP2_REG, CFGCHIP2_OTGMODE_MASK,
> +			  val);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(da8xx_usb20_phy_set_mode);

Don't prefer export symbols from PHY driver. That'll create unnecessary
dependencies between the controller and the PHY.

To see how to fix it, please see my comment for the previous version of your patch.

Thanks
Kishon
