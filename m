From: balbi@kernel.org (Felipe Balbi)
Date: Wed, 04 Jan 2017 16:03:00 +0200
Subject: [RFC PATCH] usb: dwc3: gadget: add support for OTG in gadget
 framework
In-Reply-To: <1483536181-22356-4-git-send-email-mnarani@xilinx.com>
References: <1483536181-22356-1-git-send-email-mnarani@xilinx.com>
 <1483536181-22356-4-git-send-email-mnarani@xilinx.com>
Message-ID: <87k2aax6qz.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Manish Narani <manish.narani@xilinx.com> writes:
> This patch adds support for OTG in DWC3 gadget framework. This
> also adds support for HNP polling by host while in OTG mode.
>
> Modifications in couple of functions to make it in sync with
> OTG driver while keeping its original functionality intact.
>
> Signed-off-by: Manish Narani <mnarani@xilinx.com>
> ---
>  drivers/usb/dwc3/ep0.c    | 49 +++++++++++++++++++++++---
>  drivers/usb/dwc3/gadget.c | 87 +++++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 116 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> index 4878d18..aa78c1b 100644
> --- a/drivers/usb/dwc3/ep0.c
> +++ b/drivers/usb/dwc3/ep0.c
> @@ -334,6 +334,8 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
>  				usb_status |= 1 << USB_DEV_STAT_U2_ENABLED;
>  		}
>  
> +		usb_status |= dwc->remote_wakeup << USB_DEVICE_REMOTE_WAKEUP;
> +
>  		break;
>  
>  	case USB_RECIP_INTERFACE:
> @@ -448,11 +450,45 @@ static int dwc3_ep0_handle_device(struct dwc3 *dwc,
>  
>  	switch (wValue) {
>  	case USB_DEVICE_REMOTE_WAKEUP:
> +		if (set)
> +			dwc->remote_wakeup = 1;
> +		else
> +			dwc->remote_wakeup = 0;
>  		break;
> -	/*
> -	 * 9.4.1 says only only for SS, in AddressState only for
> -	 * default control pipe
> -	 */
> +	case USB_DEVICE_B_HNP_ENABLE:
> +		dev_dbg(dwc->dev,
> +			"SET_FEATURE: USB_DEVICE_B_HNP_ENABLE\n");

sorry, but no thanks. It has taken me a lot of work to come up with
proper tracers so I could get rid of all dev_dbg() calls here. I'm not
accepting any new one :-)

> +		if (set && dwc->gadget.is_otg) {
> +			if (dwc->gadget.host_request_flag) {
> +				struct usb_phy *phy =
> +					usb_get_phy(USB_PHY_TYPE_USB3);
> +
> +				dwc->gadget.b_hnp_enable = 0;
> +				dwc->gadget.host_request_flag = 0;
> +				otg_start_hnp(phy->otg);
> +				usb_put_phy(phy);
> +			} else {
> +				dwc->gadget.b_hnp_enable = 1;
> +			}
> +		} else
> +			return -EINVAL;
> +		break;
> +
> +	case USB_DEVICE_A_HNP_SUPPORT:
> +		/* RH port supports HNP */
> +		dev_dbg(dwc->dev,
> +			"SET_FEATURE: USB_DEVICE_A_HNP_SUPPORT\n");

ditto

> +		break;
> +
> +	case USB_DEVICE_A_ALT_HNP_SUPPORT:
> +		/* other RH port does */
> +		dev_dbg(dwc->dev,
> +			"SET_FEATURE: USB_DEVICE_A_ALT_HNP_SUPPORT\n");

ditto

> +		break;
> +		/*
> +		 * 9.4.1 says only only for SS, in AddressState only for
> +		 * default control pipe
> +		 */
>  	case USB_DEVICE_U1_ENABLE:
>  		ret = dwc3_ep0_handle_u1(dwc, state, set);
>  		break;
> @@ -759,7 +795,10 @@ static int dwc3_ep0_std_request(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
>  
>  	switch (ctrl->bRequest) {
>  	case USB_REQ_GET_STATUS:
> -		ret = dwc3_ep0_handle_status(dwc, ctrl);
> +		if (le16_to_cpu(ctrl->wIndex) == OTG_STS_SELECTOR)
> +			ret = dwc3_ep0_delegate_req(dwc, ctrl);
> +		else
> +			ret = dwc3_ep0_handle_status(dwc, ctrl);
>  		break;
>  	case USB_REQ_CLEAR_FEATURE:
>  		ret = dwc3_ep0_handle_feature(dwc, ctrl, 0);
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 6785595..3b0b771 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -34,6 +34,7 @@
>  #include "core.h"
>  #include "gadget.h"
>  #include "io.h"
> +#include "otg.h"
>  
>  /**
>   * dwc3_gadget_set_test_mode - Enables USB2 Test Modes
> @@ -1792,25 +1793,51 @@ static int dwc3_gadget_start(struct usb_gadget *g,
>  	int			ret = 0;
>  	int			irq;
>  
> -	irq = dwc->irq_gadget;
> -	ret = request_threaded_irq(irq, dwc3_interrupt, dwc3_thread_interrupt,
> -			IRQF_SHARED, "dwc3", dwc->ev_buf);
> -	if (ret) {
> -		dev_err(dwc->dev, "failed to request irq #%d --> %d\n",
> -				irq, ret);
> -		goto err0;
> -	}
> -
>  	spin_lock_irqsave(&dwc->lock, flags);
>  	if (dwc->gadget_driver) {
>  		dev_err(dwc->dev, "%s is already bound to %s\n",
>  				dwc->gadget.name,
>  				dwc->gadget_driver->driver.name);
>  		ret = -EBUSY;
> -		goto err1;
> +		goto err0;
>  	}
>  
> -	dwc->gadget_driver	= driver;
> +	if (g->is_otg) {
> +		static struct usb_gadget_driver *prev_driver;

hehe, there's no way I'm taking this. There are platforms with more than
one dwc3 instance. Please go back to drawing board.

> +		/* There are two instances where OTG functionality is enabled :
> +		 * 1. This function will be called from OTG driver to start the
> +		 * gadget
> +		 * 2. This function will be called by the Linux Class Driver to
> +		 * start the gadget
> +		 * Below code will keep synchronization between these calls. The
> +		 * "driver" argument will be NULL when it is called from the OTG
> +		 * driver, so we are maintaning a global variable "prev_driver"
> +		 * to assign value of argument "driver" (from class driver) to
> +		 * dwc->gadget_driver when it is called from OTG.
> +		 */
> +		if (driver) {
> +			prev_driver	= driver;
> +			if (dwc->otg) {
> +				struct dwc3_otg		*otg = dwc->otg;
> +
> +				if ((otg->host_started ||
> +						(!otg->peripheral_started)))
> +					goto err0;
> +			}
> +			dwc->gadget_driver	= driver;
> +		} else
> +			dwc->gadget_driver	= prev_driver;
> +	} else
> +		dwc->gadget_driver	= driver;
> +
> +	irq = dwc->irq_gadget;
> +	ret = request_threaded_irq(irq, dwc3_interrupt, dwc3_thread_interrupt,
> +			IRQF_SHARED, "dwc3", dwc->ev_buf);
> +	if (ret) {
> +		dev_err(dwc->dev, "failed to request irq #%d --> %d\n",
> +				irq, ret);
> +		goto err0;
> +	}
>  
>  	if (pm_runtime_active(dwc->dev))
>  		__dwc3_gadget_start(dwc);
> @@ -1819,11 +1846,9 @@ static int dwc3_gadget_start(struct usb_gadget *g,
>  
>  	return 0;
>  
> -err1:
> -	spin_unlock_irqrestore(&dwc->lock, flags);
> -	free_irq(irq, dwc);
> -
>  err0:
> +	dwc->gadget_driver = NULL;
> +	spin_unlock_irqrestore(&dwc->lock, flags);
>  	return ret;
>  }

you shouldn't have to change anything in this file to add OTG. If you
are changing then it's likely something's wrong with your approach. I
need further clarification as to why you think this change is necessary.

> @@ -2977,6 +3002,18 @@ int dwc3_gadget_init(struct dwc3 *dwc)
>  
>  	dwc->irq_gadget = irq;
>  
> +	if (dwc->dr_mode == USB_DR_MODE_OTG) {
> +		struct usb_phy *phy;
> +		/* Switch otg to peripheral mode */
> +		phy = usb_get_phy(USB_PHY_TYPE_USB3);

serioulsy? Did you not notice we already *HAVE* a handle to the PHY
which we get during probe?? You don't need to contantly get the PHY like this.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170104/97549732/attachment-0001.sig>
