From: balbi@ti.com (Felipe Balbi)
Date: Fri, 8 May 2015 11:06:36 -0500
Subject: [PATCH 1/3] phy-sun4i-usb: Add a sunxi specific function for
 setting squelch-detect
In-Reply-To: <1427626248-6257-2-git-send-email-hdegoede@redhat.com>
References: <1427626248-6257-1-git-send-email-hdegoede@redhat.com>
 <1427626248-6257-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150508160636.GD16571@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Mar 29, 2015 at 12:50:46PM +0200, Hans de Goede wrote:
> The sunxi otg phy has a bug where it wrongly detects a high speed squelch
> when reset on the root port gets de-asserted with a lo-speed device.
> 
> The workaround for this is to disable squelch detect before de-asserting
> reset, and re-enabling it after the reset de-assert is done. Add a sunxi
> specific phy function to allow the sunxi-musb glue to do this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/phy/phy-sun4i-usb.c       |  9 +++++++++
>  include/linux/phy/phy-sun4i-usb.h | 26 ++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>  create mode 100644 include/linux/phy/phy-sun4i-usb.h
> 
> diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
> index 221e8ab..01eb08d 100644
> --- a/drivers/phy/phy-sun4i-usb.c
> +++ b/drivers/phy/phy-sun4i-usb.c
> @@ -33,6 +33,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_gpio.h>
>  #include <linux/phy/phy.h>
> +#include <linux/phy/phy-sun4i-usb.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
> @@ -75,6 +76,7 @@
>  #define PHY_OTG_FUNC_EN			0x28
>  #define PHY_VBUS_DET_EN			0x29
>  #define PHY_DISCON_TH_SEL		0x2a
> +#define PHY_SQUELCH_DETECT		0x3c  
>  
>  #define MAX_PHYS			3
>  
> @@ -322,6 +324,13 @@ static int sun4i_usb_phy_power_off(struct phy *_phy)
>  	return 0;
>  }
>  
> +void sun4i_usb_phy_set_squelch_detect(struct phy *_phy, bool enabled)
> +{
> +	struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
> +
> +	sun4i_usb_phy_write(phy, PHY_SQUELCH_DETECT, enabled ? 0 : 2, 2);
> +}
> +
>  static struct phy_ops sun4i_usb_phy_ops = {
>  	.init		= sun4i_usb_phy_init,
>  	.exit		= sun4i_usb_phy_exit,
> diff --git a/include/linux/phy/phy-sun4i-usb.h b/include/linux/phy/phy-sun4i-usb.h
> new file mode 100644
> index 0000000..50aed92
> --- /dev/null
> +++ b/include/linux/phy/phy-sun4i-usb.h
> @@ -0,0 +1,26 @@
> +/*
> + * Copyright (c) 2015 Hans de Goede <hdegoede@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef PHY_SUN4I_USB_H_
> +#define PHY_SUN4I_USB_H_
> +
> +#include "phy.h"
> +
> +/**
> + * sun4i_usb_phy_set_squelch_detect() - Enable/disable squelch detect
> + * @phy: reference to a sun4i usb phy
> + * @enabled: wether to enable or disable squelch detect
> + */
> +void sun4i_usb_phy_set_squelch_detect(struct phy *phy, bool enabled);

breaks build if MUSB=y and SUN41_PHY=m

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150508/60352e85/attachment.sig>
