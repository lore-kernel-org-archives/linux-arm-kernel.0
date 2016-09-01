From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 1 Sep 2016 10:56:36 -0700
Subject: [PATCH v5] Axi-usb: Add support for 64-bit addressing.
In-Reply-To: <1472719976-25410-1-git-send-email-navam@xilinx.com>
References: <1472719976-25410-1-git-send-email-navam@xilinx.com>
Message-ID: <20160901175636.GV16583@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-09-01 at 14:22:56 +0530, Nava kishore Manne wrote:
> This patch updates the driver to support 64-bit DMA addressing.
> 
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes for v5:
>                 -None.
> 
> Changes for v4:
>                 -Used boolen property insted of addrwith property in the DT
>                  as suggested by Arnd Bergmann.
>                 -Adopt the DT relevant changes into the driver.
> 
> Changes for v3:
>                 -Added new compatable string for 5.00 IP version as suggested by
>                  Arnd Bergmann.
>                 -Used write_fn() insted of lo_hi_writeq() as suggested by
>                  Arnd Bergmann.
> Changes for v2:
>                 -Added dma-ranges property in device tree as suggested by
>                  Arnd Bergmann.
>                 -Modified the driver code based on the xlnx,addrwidth.
> 
>  .../devicetree/bindings/usb/udc-xilinx.txt         |  5 ++-
>  drivers/usb/gadget/udc/udc-xilinx.c                | 52 +++++++++++++++++++++-
>  2 files changed, 54 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/udc-xilinx.txt b/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> index 47b4e39..d08d972 100644
> --- a/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> +++ b/Documentation/devicetree/bindings/usb/udc-xilinx.txt
> @@ -1,12 +1,14 @@
>  Xilinx USB2 device controller
>  
>  Required properties:
> -- compatible		: Should be "xlnx,usb2-device-4.00.a"
> +- compatible		: Should be "xlnx,usb2-device-4.00.a" or
> +			  "xlnx,usb2-device-5.00"
>  - reg			: Physical base address and size of the USB2
>  			  device registers map.
>  - interrupts		: Should contain single irq line of USB2 device
>  			  controller
>  - xlnx,has-builtin-dma	: if DMA is included
> +- xlnx,has-64bit-dma	: if DMA is included 64-bit addressing support.

We add these properties to describe the IP configuration + we have the
version indicator in the compatible string. Do we really need both? It
seems that all versions use the same driver and differentiation is made
through the DT properties that describe the IP configuration parameters.
Wouldn't it be better to just have one generic 'xlnx,axi-usb2' (or
whatever) compatible string instead of patching the driver for each new
version without really needing to differentiate the IP versions through
it?

	S?ren
