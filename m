From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Sep 2017 15:53:00 -0500
Subject: [PATCH v2 06/10] arm64: allwinner: a64: Add devicetree binding
 for DMA controller
In-Reply-To: <20170917031956.28010-7-stefan.bruens@rwth-aachen.de>
References: <20170917031956.28010-1-stefan.bruens@rwth-aachen.de>
 <20170917031956.28010-7-stefan.bruens@rwth-aachen.de>
Message-ID: <20170920205300.io3ghr54kzk763kt@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 17, 2017 at 05:19:52AM +0200, Stefan Br?ns wrote:
> The A64 is register compatible with the H3, but has a different number
> of dma channels and request ports.
> 
> Attach additional properties to the node to allow future reuse of the
> compatible for controllers with different number of channels/requests.
> 
> If dma-requests is not specified, the register layout defined maximum
> of 32 is used.
> 
> Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
> ---
>  .../devicetree/bindings/dma/sun6i-dma.txt          | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/sun6i-dma.txt b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
> index 98fbe1a5c6dd..6ebc79f95202 100644
> --- a/Documentation/devicetree/bindings/dma/sun6i-dma.txt
> +++ b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
> @@ -27,6 +27,32 @@ Example:
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
> +- all properties above, i.e. reg, interrupts, clocks, resets and #dma-cells
> +
> +Optional properties:
> +- dma-requests: Number of DMA request signals supported by the controller.
> +		Refer to Documentation/devicetree/bindings/dma/dma.txt
> +
> +Example:
> +	dma: dma-controller at 01c02000 {

Drop the leading 0. Building dtbs with W=2 will tell you this.

With that,

Acked-by: Rob Herring <robh@kernel.org>

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
