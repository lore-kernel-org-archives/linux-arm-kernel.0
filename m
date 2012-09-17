From: B29397@freescale.com (Chen Peter-B29397)
Date: Mon, 17 Sep 2012 08:52:59 +0000
Subject: [PATCH] USB: chipidea: use OTGSC_BSV to detect vbus valid
In-Reply-To: <1347871821-14643-1-git-send-email-richard.zhao@freescale.com>
References: <1347871821-14643-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803C8284B@039-SN2MPN1-022.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

 
> 
> OTGSC_AVVIS cannot be set when vbus voltage goes valid or invalid on
> imx, so convert to use OTGSC_BSV.
> 

Not just on imx, from the IC guys, it is chipidea's feature.
the AVVIS will not go to 1 when the vbus goes to high if ID = 1.

> OTGSC_BSVIE and OTGSC_BSVIS is not cleared when hw_device_reset, so we
> don't need to call hw_enable_vbus_intr after hw_device_reset.
> 
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  drivers/usb/chipidea/udc.c |   17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> index 2f45bba..b158a04 100644
> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -307,14 +307,13 @@ static u32 hw_test_and_clear_intr_active(struct
> ci13xxx *ci)
> 
>  static void hw_enable_vbus_intr(struct ci13xxx *ci)
>  {
> -	hw_write(ci, OP_OTGSC, OTGSC_AVVIS, OTGSC_AVVIS);
> -	hw_write(ci, OP_OTGSC, OTGSC_AVVIE, OTGSC_AVVIE);
> -	queue_work(ci->wq, &ci->vbus_work);
> +	hw_write(ci, OP_OTGSC, OTGSC_BSVIS, OTGSC_BSVIS);
> +	hw_write(ci, OP_OTGSC, OTGSC_BSVIE, OTGSC_BSVIE);
>  }
> 
>  static void hw_disable_vbus_intr(struct ci13xxx *ci)
>  {
> -	hw_write(ci, OP_OTGSC, OTGSC_AVVIE, 0);
> +	hw_write(ci, OP_OTGSC, OTGSC_BSVIE, 0);
>  }
> 
>  /**
> @@ -387,7 +386,7 @@ static void vbus_work(struct work_struct *work)
>  {
>  	struct ci13xxx *ci = container_of(work, struct ci13xxx, vbus_work);
> 
> -	if (hw_read(ci, OP_OTGSC, OTGSC_AVV))
> +	if (hw_read(ci, OP_OTGSC, OTGSC_BSV))
>  		usb_gadget_vbus_connect(&ci->gadget);
>  	else
>  		usb_gadget_vbus_disconnect(&ci->gadget);
> @@ -1392,7 +1391,6 @@ static int ci13xxx_vbus_session(struct usb_gadget
> *_gadget, int is_active)
>  		if (is_active) {
>  			pm_runtime_get_sync(&_gadget->dev);
>  			hw_device_reset(ci, USBMODE_CM_DC);
> -			hw_enable_vbus_intr(ci);
>  			hw_device_state(ci, ci->ep0out->qh.dma);
>  		} else {
>  			hw_device_state(ci, 0);
> @@ -1569,7 +1567,6 @@ static int ci13xxx_start(struct usb_gadget *gadget,
>  		if (ci->vbus_active) {
>  			if (ci->platdata->flags & CI13XXX_REGS_SHARED) {
>  				hw_device_reset(ci, USBMODE_CM_DC);
> -				hw_enable_vbus_intr(ci);
>  			}
>  		} else {
>  			pm_runtime_put_sync(&ci->gadget.dev);
> @@ -1680,7 +1677,7 @@ static irqreturn_t udc_irq(struct ci13xxx *ci)
>  	intr = hw_read(ci, OP_OTGSC, ~0);
>  	hw_write(ci, OP_OTGSC, ~0, intr);
> 
> -	if (intr & (OTGSC_AVVIE & OTGSC_AVVIS))
> +	if ((intr & OTGSC_BSVIE) && (intr & OTGSC_BSVIS))
>  		queue_work(ci->wq, &ci->vbus_work);
> 
>  	spin_unlock(&ci->lock);
> @@ -1758,7 +1755,6 @@ static int udc_start(struct ci13xxx *ci)
>  		retval = hw_device_reset(ci, USBMODE_CM_DC);
>  		if (retval)
>  			goto put_transceiver;
> -		hw_enable_vbus_intr(ci);
>  	}
> 
>  	retval = device_register(&ci->gadget.dev);
> @@ -1782,6 +1778,9 @@ static int udc_start(struct ci13xxx *ci)
>  	if (retval)
>  		goto remove_trans;
> 
> +	queue_work(ci->wq, &ci->vbus_work);
> +	hw_enable_vbus_intr(ci);
> +
>  	pm_runtime_no_callbacks(&ci->gadget.dev);
>  	pm_runtime_enable(&ci->gadget.dev);
> 
> --
> 1.7.9.5
