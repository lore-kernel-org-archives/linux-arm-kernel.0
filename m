From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 28 Nov 2017 20:35:00 +0100
Subject: [PATCH v1] usb: xhci: allow imod-interval to be configurable
In-Reply-To: <1511889106-9239-1-git-send-email-awallis@codeaurora.org>
References: <1511889106-9239-1-git-send-email-awallis@codeaurora.org>
Message-ID: <20171128193500.GA30609@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 12:11:46PM -0500, Adam Wallis wrote:
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
>  Documentation/devicetree/bindings/usb/usb-xhci.txt |  1 +
>  drivers/usb/host/xhci-plat.c                       | 15 +++++++++++++++
>  drivers/usb/host/xhci.c                            |  7 ++-----
>  drivers/usb/host/xhci.h                            |  2 ++
>  4 files changed, 20 insertions(+), 5 deletions(-)
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
> index 09f164f..f7730c8 100644
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
> @@ -269,6 +270,20 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  	if (device_property_read_bool(&pdev->dev, "quirk-broken-port-ped"))
>  		xhci->quirks |= XHCI_BROKEN_PORT_PED;
>  
> +	/* imod interval in nanoseconds */
> +	if (device_property_read_u32(sysdev,
> +		"imod-interval", &xhci->imod_interval))
> +		xhci->imod_interval = 40000;

So no matter what value you read, you set it to 40000?  Or am I reading
this code incorrectly?

There's a good reason putting function calls inside if() is considered a
bad coding style :)

thanks,

greg k-h
