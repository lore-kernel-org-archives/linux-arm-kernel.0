From: b-liu@ti.com (Bin Liu)
Date: Fri, 1 Apr 2016 09:45:10 -0500
Subject: [PATCH v2 06/11] phy: da8xx-usb: new driver for DA8XX SoC USB PHY
In-Reply-To: <56FE74AC.6080303@ti.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
 <1458181615-27782-7-git-send-email-david@lechnology.com>
 <56FE74AC.6080303@ti.com>
Message-ID: <20160401144510.GA6264@uda0271908>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 01, 2016 at 06:46:28PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Thursday 17 March 2016 07:56 AM, David Lechner wrote:
> > This is a new phy driver for the SoC USB controllers on the TI DA8XX
> > family of microcontrollers. The USB 1.1 PHY is just a simple on/off.
> > The USB 2.0 PHY also allows overriding the VBUS and ID pins.
> > 
> > Signed-off-by: David Lechner <david@lechnology.com>
> > ---
> > 
> > v2 changes: This is new patch in v2.
> > 
> > 
> > 
> >  drivers/phy/Kconfig         |   9 ++
> >  drivers/phy/Makefile        |   1 +
> >  drivers/phy/phy-da8xx-usb.c | 295 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 305 insertions(+)
> >  create mode 100644 drivers/phy/phy-da8xx-usb.c
> > 
> > diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> > index 26566db..a6060ea 100644
> > --- a/drivers/phy/Kconfig
> > +++ b/drivers/phy/Kconfig
> > @@ -35,6 +35,15 @@ config ARMADA375_USBCLUSTER_PHY
> >  	depends on OF && HAS_IOMEM
> >  	select GENERIC_PHY
> >  
> > +config PHY_DA8XX_USB
> > +	tristate "TI DA8XX USB PHY Driver"
> > +	depends on ARCH_DAVINCI_DA8XX
> > +	select GENERIC_PHY
> > +	help
> > +	  Enable this to support the USB PHY on DA8XX SoCs.
> > +
> > +	  This driver controls both the USB 1.1 PHY and the USB 2.0 PHY.
> > +
> >  config PHY_DM816X_USB
> >  	tristate "TI dm816x USB PHY driver"
> >  	depends on ARCH_OMAP2PLUS
> > diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> > index 24596a9..722e01c 100644
> > --- a/drivers/phy/Makefile
> > +++ b/drivers/phy/Makefile
> > @@ -5,6 +5,7 @@
> >  obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
> >  obj-$(CONFIG_PHY_BERLIN_USB)		+= phy-berlin-usb.o
> >  obj-$(CONFIG_PHY_BERLIN_SATA)		+= phy-berlin-sata.o
> > +obj-$(CONFIG_PHY_DA8XX_USB)		+= phy-da8xx-usb.o
> >  obj-$(CONFIG_PHY_DM816X_USB)		+= phy-dm816x-usb.o
> >  obj-$(CONFIG_ARMADA375_USBCLUSTER_PHY)	+= phy-armada375-usb2.o
> >  obj-$(CONFIG_BCM_KONA_USB2_PHY)		+= phy-bcm-kona-usb2.o
> > diff --git a/drivers/phy/phy-da8xx-usb.c b/drivers/phy/phy-da8xx-usb.c
> > new file mode 100644
> > index 0000000..93a5f4d
> > --- /dev/null
> > +++ b/drivers/phy/phy-da8xx-usb.c
> > @@ -0,0 +1,295 @@
> > +/*
> > + * phy-da8xx-usb - TI DaVinci DA8XX USB PHY driver
> > + *
> > + * Copyright (C) 2016 David Lechner <david@lechnology.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/module.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/usb/gadget.h>
> > +#include <linux/usb/musb.h>
> > +#include <linux/usb/otg.h>
> > +
> > +/* DA8xx CFGCHIP2 (USB PHY Control) register bits */
> > +#define PHYCLKGD		(1 << 17)
> > +#define VBUSSENSE		(1 << 16)
> > +#define RESET			(1 << 15)
> > +#define OTGMODE_MASK		(3 << 13)
> > +#define NO_OVERRIDE		(0 << 13)
> > +#define FORCE_HOST		(1 << 13)
> > +#define FORCE_DEVICE		(2 << 13)
> > +#define FORCE_HOST_VBUS_LOW	(3 << 13)
> > +#define USB1PHYCLKMUX		(1 << 12)
> > +#define USB2PHYCLKMUX		(1 << 11)
> > +#define PHYPWRDN		(1 << 10)
> > +#define OTGPWRDN		(1 << 9)
> > +#define DATPOL			(1 << 8)
> > +#define USB1SUSPENDM		(1 << 7)
> > +#define PHY_PLLON		(1 << 6)
> > +#define SESENDEN		(1 << 5)
> > +#define VBDTCTEN		(1 << 4)
> > +#define REFFREQ_MASK		(0xf << 0)
> > +#define REFFREQ_12MHZ		(1 << 0)
> > +#define REFFREQ_24MHZ		(2 << 0)
> > +#define REFFREQ_48MHZ		(3 << 0)
> > +#define REFFREQ_19_2MHZ		(4 << 0)
> > +#define REFFREQ_38_4MHZ		(5 << 0)
> > +#define REFFREQ_13MHZ		(6 << 0)
> > +#define REFFREQ_26MHZ		(7 << 0)
> > +#define REFFREQ_20MHZ		(8 << 0)
> > +#define REFFREQ_40MHZ		(9 << 0)
> > +
> > +struct da8xx_usbphy {
> > +	struct phy_provider	*phy_provider;
> > +	struct phy		*usb11_phy;
> > +	struct phy		*usb20_phy;
> > +	struct clk		*usb11_clk;
> > +	struct clk		*usb20_clk;
> > +	void __iomem		*phy_ctrl;
> > +};
> > +
> > +static inline u32 da8xx_usbphy_readl(void __iomem *base)
> > +{
> > +	return readl(base);
> > +}
> > +
> > +static inline void da8xx_usbphy_writel(void __iomem *base, u32 value)
> > +{
> > +	writel(value, base);
> > +}
> > +
> > +static int da8xx_usb11_phy_init(struct phy *phy)
> > +{
> > +	struct da8xx_usbphy *d_phy = phy_get_drvdata(phy);
> > +	int ret;
> > +	u32 val;
> > +
> > +	ret = clk_prepare_enable(d_phy->usb11_clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	val = da8xx_usbphy_readl(d_phy->phy_ctrl);
> > +	val |= USB1SUSPENDM;
> > +	da8xx_usbphy_writel(d_phy->phy_ctrl, val);
> > +
> > +	return 0;
> > +}
> > +
> > +static int da8xx_usb11_phy_shutdown(struct phy *phy)
> > +{
> > +	struct da8xx_usbphy *d_phy = phy_get_drvdata(phy);
> > +	u32 val;
> > +
> > +	val = da8xx_usbphy_readl(d_phy->phy_ctrl);
> > +	val &= ~USB1SUSPENDM;
> > +	da8xx_usbphy_writel(d_phy->phy_ctrl, val);
> > +
> > +	clk_disable_unprepare(d_phy->usb11_clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct phy_ops da8xx_usb11_phy_ops = {
> > +	.power_on	= da8xx_usb11_phy_init,
> > +	.power_off	= da8xx_usb11_phy_shutdown,
> > +	.owner		= THIS_MODULE,
> > +};
> > +
> > +static int da8xx_usb20_phy_init(struct phy *phy)
> > +{
> > +	struct da8xx_usbphy *d_phy = phy_get_drvdata(phy);
> > +	int ret;
> > +	u32 val;
> > +
> > +	ret = clk_prepare_enable(d_phy->usb20_clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	val = da8xx_usbphy_readl(d_phy->phy_ctrl);
> > +	val &= ~OTGPWRDN;
> > +	da8xx_usbphy_writel(d_phy->phy_ctrl, val);
> > +
> > +	return 0;
> > +}
> > +
> > +static int da8xx_usb20_phy_shutdown(struct phy *phy)
> > +{
> > +	struct da8xx_usbphy *d_phy = phy_get_drvdata(phy);
> > +	u32 val;
> > +
> > +	val = da8xx_usbphy_readl(d_phy->phy_ctrl);
> > +	val |= OTGPWRDN;
> > +	da8xx_usbphy_writel(d_phy->phy_ctrl, val);
> > +
> > +	clk_disable_unprepare(d_phy->usb20_clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct phy_ops da8xx_usb20_phy_ops = {
> > +	.power_on	= da8xx_usb20_phy_init,
> > +	.power_off	= da8xx_usb20_phy_shutdown,
> > +	.owner		= THIS_MODULE,
> > +};
> > +
> > +int da8xx_usb20_phy_set_mode(struct phy *phy, enum musb_mode mode)
> > +{
> > +	struct da8xx_usbphy *d_phy = phy_get_drvdata(phy);
> > +	u32 val;
> > +
> > +	val = da8xx_usbphy_readl(d_phy->phy_ctrl);
> > +
> > +	val &= ~OTGMODE_MASK;
> > +	switch (mode) {
> > +	case MUSB_HOST:		/* Force VBUS valid, ID = 0 */
> > +		val |= FORCE_HOST;
> > +		break;
> > +	case MUSB_PERIPHERAL:	/* Force VBUS valid, ID = 1 */
> > +		val |= FORCE_DEVICE;
> > +		break;
> > +	case MUSB_OTG:		/* Don't override the VBUS/ID comparators */
> > +		val |= NO_OVERRIDE;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	da8xx_usbphy_writel(d_phy->phy_ctrl, val);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(da8xx_usb20_phy_set_mode);
> 
> Don't prefer export symbols from PHY driver. That'll create unnecessary
> dependencies between the controller and the PHY.

Agreed.

> 
> I think it'll be better to create a new attribute and use it?

Another simpler option is to not support _set_mode() for DA8xx, and the
phy driver set the otgmode bit in probe() based on dr_mode of the
controller.

Regards,
-Bin.
