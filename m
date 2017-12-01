From: robh@kernel.org (Rob Herring)
Date: Thu, 30 Nov 2017 20:02:58 -0600
Subject: [PATCH v1] usb: xhci: allow imod-interval to be configurable
In-Reply-To: <1511889106-9239-1-git-send-email-awallis@codeaurora.org>
References: <1511889106-9239-1-git-send-email-awallis@codeaurora.org>
Message-ID: <20171201020258.jbhn3xzsdusflose@rob-hp-laptop>
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

Needs a unit suffix as defined in property-units.txt.

Rob
