From: robh@kernel.org (Rob Herring)
Date: Tue, 12 Sep 2017 11:52:20 -0500
Subject: [PATCH 06/10] arm64: allwinner: a64: Add devicetree binding for
 DMA controller
In-Reply-To: <20170903224100.17893-7-stefan.bruens@rwth-aachen.de>
References: <20170903224100.17893-1-stefan.bruens@rwth-aachen.de>
 <20170903224100.17893-7-stefan.bruens@rwth-aachen.de>
Message-ID: <20170912165220.yj4bcpd4yg3wujyh@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 04, 2017 at 12:40:57AM +0200, Stefan Br?ns wrote:
> The A64 is register compatible with the H3, but has a different number
> of dma channels and request ports.
> 
> Attach additional properties to the node to allow future reuse of the
> compatible for controllers with different number of channels/requests.
> 
> If dma-requests is not specified, the register layout defined maximum
> of 32 is used.

This belongs in the binding.

> 
> Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
> ---
>  .../devicetree/bindings/dma/sun6i-dma.txt          | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/sun6i-dma.txt b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
> index 6b267045f522..66195fb31296 100644
> --- a/Documentation/devicetree/bindings/dma/sun6i-dma.txt
> +++ b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
> @@ -26,6 +26,32 @@ Example:
>  		#dma-cells = <1>;
>  	};
>  
> +------------------------------------------------------------------------------
> +For A64 DMA controller:
> +
> +Required properties:
> +- compatible:	"allwinner,sun50i-a64-dma"
> +- dma-channels: Number of DMA channels supported by the controller.
> +		Refer to Documentation/devicetree/bindings/dma/dma.txt

dma.txt already explains what these properties are. You just need to 
state what are valid values.

> +- all properties above, i.e. reg, interrupts, clocks, resets and #dma-cells
> +
> +Optional properties:
> +- dma-requests: Number of DMA request signals supported by the controller.
> +		Refer to Documentation/devicetree/bindings/dma/dma.txt
> +
> +Example:
> +	dma: dma-controller at 01c02000 {

Drop the leading 0. Building dtbs with W=2 will tell you this.

> +		compatible = "allwinner,sun50i-a64-dma";
> +		reg = <0x01c02000 0x1000>;
> +		interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&ccu CLK_BUS_DMA>;
> +		dma-channels = <8>;
> +		dma-requests = <27>;
> +		resets = <&ccu RST_BUS_DMA>;
> +		#dma-cells = <1>;
> +	};
> +------------------------------------------------------------------------------
> +
>  Clients:
>  
>  DMA clients connected to the A31 DMA controller must use the format
> -- 
> 2.14.1
> 
