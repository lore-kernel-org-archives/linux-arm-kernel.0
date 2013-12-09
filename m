From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 09 Dec 2013 09:41:54 +0100
Subject: [PATCH v5 12/15] usb: phy: Add set_wakeup API
In-Reply-To: <1386570664-6713-13-git-send-email-peter.chen@freescale.com>
References: <1386570664-6713-1-git-send-email-peter.chen@freescale.com>
 <1386570664-6713-13-git-send-email-peter.chen@freescale.com>
Message-ID: <52A58252.6090502@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/2013 07:31 AM, Peter Chen wrote:
> This API is used to set wakeup enable at PHY registers, in that
> case, the PHY can be waken up from suspend due to external events,

I' no native speaker, but I think it's "to be woken up".

> like vbus change, dp/dm change and id change.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  include/linux/usb/phy.h |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
> index a747960..c6ebe1d 100644
> --- a/include/linux/usb/phy.h
> +++ b/include/linux/usb/phy.h
> @@ -111,6 +111,13 @@ struct usb_phy {
>  	int	(*set_suspend)(struct usb_phy *x,
>  				int suspend);
>  
> +	/*
> +	 * Set wakeup enable for PHY, in that case, the PHY can be
> +	 * waken up from suspend status due to external events,
> +	 * like vbus change, dp/dm change and id.
> +	 */
> +	int	(*set_wakeup)(struct usb_phy *x, bool enabled);
> +
>  	/* notify phy connect status change */
>  	int	(*notify_connect)(struct usb_phy *x,
>  			enum usb_device_speed speed);
> @@ -270,6 +277,15 @@ usb_phy_set_suspend(struct usb_phy *x, int suspend)
>  }
>  
>  static inline int
> +usb_phy_set_wakeup(struct usb_phy *x, bool enabled)
> +{
> +	if (x && x->set_wakeup)

can x be NULL?

> +		return x->set_wakeup(x, enabled);
> +	else
> +		return 0;
> +}
> +
> +static inline int
>  usb_phy_notify_connect(struct usb_phy *x, enum usb_device_speed speed)
>  {
>  	if (x && x->notify_connect)
> 

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131209/b30773b6/attachment.sig>
