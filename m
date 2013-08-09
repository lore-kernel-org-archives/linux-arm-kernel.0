From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 09 Aug 2013 16:23:11 +0300
Subject: [PATCH v14 11/12] usb: chipidea: udc: misuse flag
 CI_HDRC_REGS_SHARED and CI_HDRC_PULLUP_ON_VBUS
In-Reply-To: <1375432445-31918-12-git-send-email-peter.chen@freescale.com>
References: <1375432445-31918-1-git-send-email-peter.chen@freescale.com>
 <1375432445-31918-12-git-send-email-peter.chen@freescale.com>
Message-ID: <874nazathc.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Chen <peter.chen@freescale.com> writes:

> CI_HDRC_REGS_SHARED stands for the controller registers is shared
> with other USB drivers, if all USB drivers are at chipidea/, it doesn't
> needed to set.

We still have the msm driver that uses REGS_SHARED.

> CI_HDRC_PULLUP_ON_VBUS stands for pullup dp when the vbus is on. This
> flag doesn't need to set if the vbus is always on for gadget
> since dp has always pulled up after the gadget has initialized.

Didn't we agree at some point to get rid of this flag altogether once we
have proper VBUS detection?

>
> So, the current code seems to misuse this two flags.
> - When the gadget initializes, the controller doesn't need to run if
> it depends on vbus (CI_HDRC_PULLUP_ON_VBUS), it does not
> relate to shared register.
> - When the gadget starts (load one gadget module), the controller
> can run if vbus is on (CI_HDRC_PULLUP_ON_VBUS), it also does not
> relate to shared register.
>
> Tested-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/chipidea/udc.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> index c70ce38..45abf4d 100644
> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -1637,8 +1637,7 @@ static int ci_udc_start(struct usb_gadget *gadget,
>  	pm_runtime_get_sync(&ci->gadget.dev);
>  	if (ci->platdata->flags & CI_HDRC_PULLUP_ON_VBUS) {
>  		if (ci->vbus_active) {
> -			if (ci->platdata->flags & CI_HDRC_REGS_SHARED)
> -				hw_device_reset(ci, USBMODE_CM_DC);
> +			hw_device_reset(ci, USBMODE_CM_DC);
>  		} else {
>  			pm_runtime_put_sync(&ci->gadget.dev);
>  			goto done;
> @@ -1801,7 +1800,7 @@ static int udc_start(struct ci_hdrc *ci)
>  		}
>  	}
>  
> -	if (!(ci->platdata->flags & CI_HDRC_REGS_SHARED)) {
> +	if (!(ci->platdata->flags & CI_HDRC_PULLUP_ON_VBUS)) {
>  		retval = hw_device_reset(ci, USBMODE_CM_DC);
>  		if (retval)
>  			goto put_transceiver;
> -- 
> 1.7.0.4
