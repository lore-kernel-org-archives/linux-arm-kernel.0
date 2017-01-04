From: balbi@kernel.org (Felipe Balbi)
Date: Wed, 04 Jan 2017 15:32:40 +0200
Subject: [RFC PATCH] usb: dwc3: host: add support for OTG in DWC3 host
 driver
In-Reply-To: <1483536181-22356-5-git-send-email-mnarani@xilinx.com>
References: <1483536181-22356-1-git-send-email-mnarani@xilinx.com>
 <1483536181-22356-5-git-send-email-mnarani@xilinx.com>
Message-ID: <87o9znvtl3.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Manish Narani <manish.narani@xilinx.com> writes:
> This patch adds support for OTG host mode initialization in DWC3
> host driver. Before the host initialization sequence begins. The
> driver has to make sure the no OTG peripheral mode is enabled.
>
> Signed-off-by: Manish Narani <mnarani@xilinx.com>
> ---
>  drivers/usb/dwc3/host.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index 487f0ff..4caa3fe 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -16,6 +16,8 @@
>   */
>  
>  #include <linux/platform_device.h>
> +#include <linux/usb.h>
> +#include <linux/usb/hcd.h>
>  
>  #include "core.h"
>  
> @@ -111,6 +113,18 @@ int dwc3_host_init(struct dwc3 *dwc)
>  	phy_create_lookup(dwc->usb3_generic_phy, "usb3-phy",
>  			  dev_name(dwc->dev));
>  
> +	if (dwc->dr_mode == USB_DR_MODE_OTG) {
> +		struct usb_phy *phy;
> +		/* Switch otg to host mode */
> +		phy = usb_get_phy(USB_PHY_TYPE_USB3);
> +		if (!IS_ERR(phy)) {
> +			if (phy && phy->otg)
> +				otg_set_host(phy->otg,
> +						(struct usb_bus *)(long)1);
> +			usb_put_phy(phy);
> +		}
> +	}

NAK. Don't change default mode for everybody. Default mode should
actually be peripheral, but let's not touch whatever HW designer has
set; at least for now.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170104/357ae1ce/attachment-0001.sig>
