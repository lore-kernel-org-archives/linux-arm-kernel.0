From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 21 Jun 2012 09:18:22 +0200
Subject: [PATCH v6 12/14] usb: chipidea: permit driver bindings pass phy
 pointer
In-Reply-To: <1340260875-21934-13-git-send-email-richard.zhao@freescale.com>
References: <1340260875-21934-1-git-send-email-richard.zhao@freescale.com>
 <1340260875-21934-13-git-send-email-richard.zhao@freescale.com>
Message-ID: <4FE2CABE.7050708@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2012 08:41 AM, Richard Zhao wrote:
> Sometimes, the driver bindings may know what phy they use.
> For example, when using device tree, the usb controller may have a
> phandler pointing to usb phy.
> 
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> Reviewed-by: Marek Vasut <marex@denx.de>
> Acked-by: Felipe Balbi <balbi@ti.com>
> Tested-by: Subodh Nijsure <snijsure@grid-net.com>

[...]

> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -1684,7 +1684,8 @@ static int udc_start(struct ci13xxx *ci)
>  
>  	ci->gadget.ep0 = &ci->ep0in->ep;
>  
> -	ci->transceiver = usb_get_transceiver();
> +	if (ci->global_phy) {
                           ^^^

This doesn't compile, closing curly brackets are missing.

> +		ci->transceiver = usb_get_transceiver();
>  
>  	if (ci->platdata->flags & CI13XXX_REQUIRE_TRANSCEIVER) {
>  		if (ci->transceiver == NULL) {
> @@ -1728,7 +1729,8 @@ static int udc_start(struct ci13xxx *ci)
>  remove_trans:
>  	if (ci->transceiver) {
>  		otg_set_peripheral(ci->transceiver->otg, &ci->gadget);
> -		usb_put_transceiver(ci->transceiver);
> +		if (ci->global_phy)
> +			usb_put_transceiver(ci->transceiver);
>  	}
>  
>  	dev_err(dev, "error = %i\n", retval);
> @@ -1737,7 +1739,7 @@ remove_dbg:
>  unreg_device:
>  	device_unregister(&ci->gadget.dev);
>  put_transceiver:
> -	if (ci->transceiver)
> +	if (ci->transceiver && ci->global_phy)
>  		usb_put_transceiver(ci->transceiver);
>  free_pools:
>  	dma_pool_destroy(ci->td_pool);
> @@ -1771,7 +1773,8 @@ static void udc_stop(struct ci13xxx *ci)
>  
>  	if (ci->transceiver) {
>  		otg_set_peripheral(ci->transceiver->otg, NULL);
> -		usb_put_transceiver(ci->transceiver);
> +		if (ci->global_phy)
> +			usb_put_transceiver(ci->transceiver);
>  	}
>  	dbg_remove_files(&ci->gadget.dev);
>  	device_unregister(&ci->gadget.dev);
> diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
> index be078f0..544825d 100644

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
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120621/92e518aa/attachment.sig>
