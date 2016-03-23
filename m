From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 23 Mar 2016 22:51:49 +0530
Subject: [PATCH v2 06/11] phy: da8xx-usb: new driver for DA8XX SoC USB PHY
In-Reply-To: <1458181615-27782-7-git-send-email-david@lechnology.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
 <1458181615-27782-7-git-send-email-david@lechnology.com>
Message-ID: <56F2D0AD.4040005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 March 2016 07:56 AM, David Lechner wrote:
> This is a new phy driver for the SoC USB controllers on the TI DA8XX
> family of microcontrollers. The USB 1.1 PHY is just a simple on/off.
> The USB 2.0 PHY also allows overriding the VBUS and ID pins.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

> diff --git a/drivers/phy/phy-da8xx-usb.c b/drivers/phy/phy-da8xx-usb.c
> new file mode 100644
> index 0000000..93a5f4d
> --- /dev/null
> +++ b/drivers/phy/phy-da8xx-usb.c
> @@ -0,0 +1,295 @@
> +/*
> + * phy-da8xx-usb - TI DaVinci DA8XX USB PHY driver
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
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/usb/gadget.h>
> +#include <linux/usb/musb.h>
> +#include <linux/usb/otg.h>
> +
> +/* DA8xx CFGCHIP2 (USB PHY Control) register bits */
> +#define PHYCLKGD		(1 << 17)
> +#define VBUSSENSE		(1 << 16)
> +#define RESET			(1 << 15)
> +#define OTGMODE_MASK		(3 << 13)
> +#define NO_OVERRIDE		(0 << 13)
> +#define FORCE_HOST		(1 << 13)
> +#define FORCE_DEVICE		(2 << 13)
> +#define FORCE_HOST_VBUS_LOW	(3 << 13)
> +#define USB1PHYCLKMUX		(1 << 12)
> +#define USB2PHYCLKMUX		(1 << 11)
> +#define PHYPWRDN		(1 << 10)
> +#define OTGPWRDN		(1 << 9)
> +#define DATPOL			(1 << 8)
> +#define USB1SUSPENDM		(1 << 7)
> +#define PHY_PLLON		(1 << 6)
> +#define SESENDEN		(1 << 5)
> +#define VBDTCTEN		(1 << 4)
> +#define REFFREQ_MASK		(0xf << 0)
> +#define REFFREQ_12MHZ		(1 << 0)
> +#define REFFREQ_24MHZ		(2 << 0)
> +#define REFFREQ_48MHZ		(3 << 0)
> +#define REFFREQ_19_2MHZ		(4 << 0)
> +#define REFFREQ_38_4MHZ		(5 << 0)
> +#define REFFREQ_13MHZ		(6 << 0)
> +#define REFFREQ_26MHZ		(7 << 0)
> +#define REFFREQ_20MHZ		(8 << 0)
> +#define REFFREQ_40MHZ		(9 << 0)

Many of these register bits are unused. I guess opinion varies around
this, but I get confused with unnecessary bit definitions and register
offsets. I tend to search for it and its sort of disappointing to see
that its basically unused. Of course, you should wait for PHY
maintainers preference.

> +
> +struct da8xx_usbphy {
> +	struct phy_provider	*phy_provider;
> +	struct phy		*usb11_phy;
> +	struct phy		*usb20_phy;
> +	struct clk		*usb11_clk;
> +	struct clk		*usb20_clk;
> +	void __iomem		*phy_ctrl;
> +};
> +
> +static inline u32 da8xx_usbphy_readl(void __iomem *base)
> +{
> +	return readl(base);
> +}
> +
> +static inline void da8xx_usbphy_writel(void __iomem *base, u32 value)
> +{
> +	writel(value, base);
> +}

Agree with Sergei that these don't add much value.

> +int da8xx_usb20_phy_set_mode(struct phy *phy, enum musb_mode mode)
> +{
> +	struct da8xx_usbphy *d_phy = phy_get_drvdata(phy);
> +	u32 val;
> +
> +	val = da8xx_usbphy_readl(d_phy->phy_ctrl);
> +
> +	val &= ~OTGMODE_MASK;
> +	switch (mode) {
> +	case MUSB_HOST:		/* Force VBUS valid, ID = 0 */
> +		val |= FORCE_HOST;
> +		break;
> +	case MUSB_PERIPHERAL:	/* Force VBUS valid, ID = 1 */
> +		val |= FORCE_DEVICE;
> +		break;
> +	case MUSB_OTG:		/* Don't override the VBUS/ID comparators */
> +		val |= NO_OVERRIDE;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	da8xx_usbphy_writel(d_phy->phy_ctrl, val);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(da8xx_usb20_phy_set_mode);

Hmm, since this driver exports this symbol, I think it should also
provide an include file in include/linux/phy for users of the symbol. Or
perhaps there should be a generic API around this since it looks like
most USB phys will need something similar?

Thanks,
Sekhar
