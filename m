From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 29 Nov 2017 17:46:19 +0000
Subject: [PATCH v2] usb: xhci: allow imod-interval to be configurable
In-Reply-To: <1511970775-11103-1-git-send-email-awallis@codeaurora.org>
References: <1511970775-11103-1-git-send-email-awallis@codeaurora.org>
Message-ID: <20171129174619.GB22267@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 10:52:55AM -0500, Adam Wallis wrote:
> The xHCI driver currently has the IMOD set to 160, which
> translates to an IMOD interval of 40,000ns (160 * 250)ns
> 
> Commit 0cbd4b34cda9 ("xhci: mediatek: support MTK xHCI host controller")
> introduced a QUIRK for the MTK platform to adjust this interval to 20,
> which translates to an IMOD interval of 5,000ns (20 * 250)ns. This is
> due to the fact that the MTK controller IMOD interval is 8 times
> as much as defined in xHCI spec.
> 
> Instead of adding more quirk bits for additional platforms, this patch
> introduces the ability for vendors to set the IMOD_INTERVAL as is
> optimal for their platform. By using device_property_read_u32() on
> "imod-interval", the IMOD INTERVAL can be specified in nano seconds. If
> no interval is specified, the default of 40,000ns (IMOD=160) will be
> used.
> 
> No bounds checking has been implemented due to the fact that a vendor
> may have violated the spec and would need to specify a value outside of
> the max 8,000 IRQs/second limit specified in the xHCI spec.
> 
> Backwards compatibility is maintained for MTK_HOSTS through the quirk
> bit, however, imod_interval should be pushed into device tree at a
> future point and this quirk should be removed from xhci_plat_probe
> 
> Signed-off-by: Adam Wallis <awallis@codeaurora.org>
> ---
> changes from v1:
>   * Removed device_property_read_u32() per suggestion from greg k-h
>   * Used ER_IRQ_INTERVAL_MASK in place of (u16) cast
> 
>  Documentation/devicetree/bindings/usb/usb-xhci.txt |  1 +
>  drivers/usb/host/xhci-plat.c                       | 13 +++++++++++++
>  drivers/usb/host/xhci.c                            |  7 ++-----
>  drivers/usb/host/xhci.h                            |  2 ++
>  4 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> index ae6e484..3998459 100644
> --- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> @@ -29,6 +29,7 @@ Optional properties:
>    - usb2-lpm-disable: indicate if we don't want to enable USB2 HW LPM
>    - usb3-lpm-capable: determines if platform is USB3 LPM capable
>    - quirk-broken-port-ped: set if the controller has broken port disable mechanism
> +  - imod-interval: IMOD_INTERVAL in nano-seconds. Default is 40000
>  
>  Example:
>  	usb at f0931000 {
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 09f164f..3c63de1 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -23,6 +23,7 @@
>  #include "xhci-plat.h"
>  #include "xhci-mvebu.h"
>  #include "xhci-rcar.h"
> +#include "xhci-mtk.h"
>  
>  static struct hc_driver __read_mostly xhci_plat_hc_driver;
>  
> @@ -269,6 +270,18 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  	if (device_property_read_bool(&pdev->dev, "quirk-broken-port-ped"))
>  		xhci->quirks |= XHCI_BROKEN_PORT_PED;
>  
> +	/*
> +	 * imod_interval is the interrupt modulation value in nanoseconds.
> +	 * The increment interval is 8 times as much as that defined in
> +	 * the xHCI spec on MTK's controller. This quirk check exists to provide
> +	 * backwards compatibility, however, this should be pushed into
> +	 * the device tree files at some point in the future and
> +	 * checking the quirk should be removed from xhci_plat_probe.
> +	 */
> +	xhci->imod_interval = xhci->quirks & XHCI_MTK_HOST ? 5000 : 40000;

Personally I hate ? : logic, just write the if statement out.  It
doesn't save anything except make it harder to read.

Yeah, the original code had it too.  Oh well, I'll leave it up to the
xhci maintainer, he is the one that has to maintain this, not me :)

thanks,

greg k-h
