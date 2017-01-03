From: hzpeterchen@gmail.com (Peter Chen)
Date: Tue, 3 Jan 2017 14:53:19 +0800
Subject: [PATCH v6 23/25] usb: chipidea: Pullup D+ in device mode via phy
 APIs
In-Reply-To: <20161228225711.698-24-stephen.boyd@linaro.org>
References: <20161228225711.698-1-stephen.boyd@linaro.org>
 <20161228225711.698-24-stephen.boyd@linaro.org>
Message-ID: <20170103065318.GB14542@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 28, 2016 at 02:57:09PM -0800, Stephen Boyd wrote:
> If the phy supports it, call phy_set_mode() to pull up D+ when
> required by setting the mode to PHY_MODE_USB_DEVICE. If we want
> to remove the pullup, set the mode to PHY_MODE_USB_HOST.
> 
> Cc: Peter Chen <peter.chen@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  drivers/usb/chipidea/udc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> index 0d532a724d48..6d61fa0689b0 100644
> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -18,6 +18,7 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/phy/phy.h>
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
>  #include <linux/usb/otg-fsm.h>
> @@ -1609,10 +1610,15 @@ static int ci_udc_pullup(struct usb_gadget *_gadget, int is_on)
>  		return 0;
>  
>  	pm_runtime_get_sync(&ci->gadget.dev);
> -	if (is_on)
> +	if (is_on) {
> +		if (ci->phy)
> +			phy_set_mode(ci->phy, PHY_MODE_USB_DEVICE);
>  		hw_write(ci, OP_USBCMD, USBCMD_RS, USBCMD_RS);
> -	else
> +	} else {
>  		hw_write(ci, OP_USBCMD, USBCMD_RS, 0);
> +		if (ci->phy)
> +			phy_set_mode(ci->phy, PHY_MODE_USB_HOST);
> +	}
>  	pm_runtime_put_sync(&ci->gadget.dev);
>  
>  	return 0;
> -- 

Would you describe the use case for it? Why not adding it at
role switch routine?

-- 

Best Regards,
Peter Chen
