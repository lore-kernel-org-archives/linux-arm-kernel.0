From: balbi@ti.com (Felipe Balbi)
Date: Mon, 25 Nov 2013 09:56:30 -0600
Subject: [RESEND PATCH v3 1/4] usb: musb: gadget, stay IDLE without
 gadget driver
In-Reply-To: <1384790078-15366-2-git-send-email-mpa@pengutronix.de>
References: <1384790078-15366-1-git-send-email-mpa@pengutronix.de>
 <1384790078-15366-2-git-send-email-mpa@pengutronix.de>
Message-ID: <20131125155630.GE18046@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 18, 2013 at 04:54:35PM +0100, Markus Pargmann wrote:
> If there is no gadget driver musb should stay in B_IDLE state.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/usb/musb/musb_core.c   |  3 ---
>  drivers/usb/musb/musb_gadget.c | 14 ++++++++++++--
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 4db987f..8b7d903 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -831,12 +831,9 @@ b_host:
>  			case OTG_STATE_B_WAIT_ACON:
>  				dev_dbg(musb->controller, "HNP: RESET (%s), to b_peripheral\n",
>  					usb_otg_state_string(musb->xceiv->state));
> -				musb->xceiv->state = OTG_STATE_B_PERIPHERAL;
>  				musb_g_reset(musb);
>  				break;
>  			case OTG_STATE_B_IDLE:
> -				musb->xceiv->state = OTG_STATE_B_PERIPHERAL;
> -				/* FALLTHROUGH */
>  			case OTG_STATE_B_PERIPHERAL:
>  				musb_g_reset(musb);
>  				break;

this is not the right way to fix it. We in OTG or host-only builds of
this driver, we should never show up in the USB bus until a gadget
driver has been probed. That's what we have ->pullup() for.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131125/bd0c4529/attachment.sig>
