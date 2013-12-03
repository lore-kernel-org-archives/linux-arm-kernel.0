From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 03 Dec 2013 09:38:20 +0100
Subject: [PATCH v4 02/17] usb: phy-mxs: Add platform judgement code
In-Reply-To: <1386056231-17258-3-git-send-email-peter.chen@freescale.com>
References: <1386056231-17258-1-git-send-email-peter.chen@freescale.com>
 <1386056231-17258-3-git-send-email-peter.chen@freescale.com>
Message-ID: <529D987C.8080905@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2013 08:36 AM, Peter Chen wrote:
> The mxs-phy has several bugs and features at different
> versions, the driver code can get it through of_device_id.data.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/phy/phy-mxs-usb.c |   58 ++++++++++++++++++++++++++++++++++------
>  1 files changed, 49 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> index 545844b..f6cbc78 100644
> --- a/drivers/usb/phy/phy-mxs-usb.c
> +++ b/drivers/usb/phy/phy-mxs-usb.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright 2012 Freescale Semiconductor, Inc.
> + * Copyright 2012-2013 Freescale Semiconductor, Inc.
>   * Copyright (C) 2012 Marek Vasut <marex@denx.de>
>   * on behalf of DENX Software Engineering GmbH
>   *
> @@ -20,6 +20,7 @@
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/of_device.h>
>  
>  #define DRIVER_NAME "mxs_phy"
>  
> @@ -34,13 +35,55 @@
>  #define BM_USBPHY_CTRL_ENUTMILEVEL2		BIT(14)
>  #define BM_USBPHY_CTRL_ENHOSTDISCONDETECT	BIT(1)
>  
> +#define to_mxs_phy(p) container_of((p), struct mxs_phy, phy)
> +
> +/* Do disconnection between PHY and controller without vbus */
> +#define MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS	BIT(0)
> +
> +/*
> + * The PHY will be in messy if there is an wakeup after putting
                                           ^^
                                           a
Do you mean "messy state"?

> + * bus to suspend (set portsc.suspendM) but before setting PHY to low
> + * power mode (set portsc.phcd).
> + */

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131203/4676e553/attachment.sig>
