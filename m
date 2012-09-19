From: mporter@ti.com (Matt Porter)
Date: Wed, 19 Sep 2012 09:52:08 -0400
Subject: [PATCH V6 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <1347662517-4210-2-git-send-email-jon-hunter@ti.com>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com>
 <1347662517-4210-2-git-send-email-jon-hunter@ti.com>
Message-ID: <20120919135208.GA16522@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 05:41:56PM -0500, Jon Hunter wrote:

...

Typo nits in the binding examples below...

>  Documentation/devicetree/bindings/dma/dma.txt |   81 +++++++++
>  drivers/of/Makefile                           |    2 +-
>  drivers/of/dma.c                              |  219 +++++++++++++++++++++++++
>  include/linux/of_dma.h                        |   45 +++++
>  4 files changed, 346 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/dma.txt
>  create mode 100644 drivers/of/dma.c
>  create mode 100644 include/linux/of_dma.h
> 
> diff --git a/Documentation/devicetree/bindings/dma/dma.txt b/Documentation/devicetree/bindings/dma/dma.txt
> new file mode 100644
> index 0000000..a4f59a5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/dma.txt
> @@ -0,0 +1,81 @@
> +* Generic DMA Controller and DMA request bindings
> +
> +Generic binding to provide a way for a driver using DMA Engine to retrieve the
> +DMA request or channel information that goes from a hardware device to a DMA
> +controller.
> +
> +
> +* DMA controller
> +
> +Required property:
> +- #dma-cells: 		Must be at least 1. Used to provide DMA controller
> +			specific information. See DMA client binding below for
> +			more details.
> +
> +Optional properties:
> +- #dma-channels: 	Number of DMA channels supported by the controller.
> +- #dma-requests: 	Number of DMA requests signals supported by the
> +			controller.
> +
> +Example:
> +
> +	dma: dma at 48000000 {
> +		compatible = "ti,omap-sdma"

; here

> +		reg = <0x48000000 0x1000>;
> +		interrupts = <0 12 0x4
> +			      0 13 0x4
> +			      0 14 0x4
> +			      0 15 0x4>;
> +		#dma-cells = <1>;
> +		#dma-channels = <32>;
> +		#dma-requests = <127>;
> +	};
> +
> +
> +* DMA client
> +
> +Client drivers should specify the DMA property using a phandle to the controller
> +followed by DMA controller specific data.
> +
> +Required property:
> +- dmas:			List of one or more DMA specifiers, each consisting of
> +			- A phandle pointing to DMA controller node
> +			- A number of integer cells, as determined by the
> +			  #dma-cells property in the node referenced by phandle
> +			  containing DMA controller specific information. This
> +			  typically contains a DMA request line number or a
> +			  channel number, but can contain any data that is used
> +			  required for configuring a channel.
> +- dma-names: 		Contains one identifier string for each DMA specifier in
> +			the dmas property. The specific strings that can be used
> +			are defined in the binding of the DMA client device.
> +			Multiple DMA specifiers can be used to represent
> +			alternatives and in this case the dma-names for those
> +			DMA specifiers must be identical (see examples).
> +
> +Examples:
> +
> +1. A device with one DMA read channel, one DMA write channel:
> +
> +	i2c1: i2c at 1 {
> +		...
> +		dmas = <&dma 2		/* read channel */
> +			&dma 3>;	/* write channel */
> +		dma-names = "rx", "tx"

; here too

> +		...
> +	};
> +
> +2. A single read-write channel with three alternative DMA controllers:
> +
> +	dmas = <&dma1 5
> +		&dma2 7
> +		&dma3 2>;
> +	dma-names = "rx-tx", "rx-tx", "rx-tx"

again ;

> +
> +3. A device with three channels, one of which has two alternatives:
> +
> +	dmas = <&dma1 2			/* read channel */
> +		&dma1 3			/* write channel */
> +		&dma2 0			/* error read */
> +		&dma3 0>;		/* alternative error read */
> +	dma-names = "rx", "tx", "error", "error";

Patch for these posted separately.

-Matt
