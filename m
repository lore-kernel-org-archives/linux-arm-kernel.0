From: robh@kernel.org (Rob Herring)
Date: Wed, 26 Sep 2018 15:23:32 -0500
Subject: [PATCH v1 3/7] dt-bindings: stm32-mdma: Add DMA/MDMA chaining
 support bindings
In-Reply-To: <1536650820-16076-4-git-send-email-pierre-yves.mordret@st.com>
References: <1536650820-16076-1-git-send-email-pierre-yves.mordret@st.com>
 <1536650820-16076-4-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20180926202332.GA13585@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2018 at 09:26:56AM +0200, Pierre-Yves MORDRET wrote:
> This patch adds the description of the 2 properties needed to support M2M
> transfer triggered by STM32 DMA when his transfer is complete.

Same problem here.

> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>   Version history:
>     v1:
>        * Initial
> ---
> ---
>  .../devicetree/bindings/dma/stm32-mdma.txt         | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/stm32-mdma.txt b/Documentation/devicetree/bindings/dma/stm32-mdma.txt
> index d18772d..1810f87 100644
> --- a/Documentation/devicetree/bindings/dma/stm32-mdma.txt
> +++ b/Documentation/devicetree/bindings/dma/stm32-mdma.txt
> @@ -10,7 +10,7 @@ Required properties:
>  - interrupts: Should contain the MDMA interrupt.
>  - clocks: Should contain the input clock of the DMA instance.
>  - resets: Reference to a reset controller asserting the DMA controller.
> -- #dma-cells : Must be <5>. See DMA client paragraph for more details.
> +- #dma-cells : Must be <6>. See DMA client paragraph for more details.
>  
>  Optional properties:
>  - dma-channels: Number of DMA channels supported by the controller.
> @@ -26,7 +26,7 @@ Example:
>  		interrupts = <122>;
>  		clocks = <&timer_clk>;
>  		resets = <&rcc 992>;
> -		#dma-cells = <5>;
> +		#dma-cells = <6>;
>  		dma-channels = <16>;
>  		dma-requests = <32>;
>  		st,ahb-addr-masks = <0x20000000>, <0x00000000>;
> @@ -35,8 +35,8 @@ Example:
>  * DMA client
>  
>  DMA clients connected to the STM32 MDMA controller must use the format
> -described in the dma.txt file, using a five-cell specifier for each channel:
> -a phandle to the MDMA controller plus the following five integer cells:
> +described in the dma.txt file, using a six-cell specifier for each channel:
> +a phandle to the MDMA controller plus the following six integer cells:
>  
>  1. The request line number
>  2. The priority level
> @@ -76,19 +76,23 @@ a phandle to the MDMA controller plus the following five integer cells:
>     if no HW ack signal is used by the MDMA client
>  5. A 32bit mask specifying the value to be written to acknowledge the request
>     if no HW ack signal is used by the MDMA client
> +6. A bitfield value specifying if the MDMA client wants to generate M2M
> +   transfer with HW trigger (1) or not (0). This bitfield should be only
> +   enabled for M2M transfer triggered by STM32 DMA client. The memory devices
> +   involved in this kind of transfer are SRAM and DDR.
>  
>  Example:
>  
>  	i2c4: i2c at 5c002000 {
>  		compatible = "st,stm32f7-i2c";
>  		reg = <0x5c002000 0x400>;
> -		interrupts = <95>,
> -			     <96>;
> -		clocks = <&timer_clk>;
> +		interrupts = <GIC_SPI 95 IRQ_TYPE_NONE>,
> +			     <GIC_SPI 96 IRQ_TYPE_NONE>;
> +		clocks = <&clk_hsi>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> -		dmas = <&mdma1 36 0x0 0x40008 0x0 0x0>,
> -		       <&mdma1 37 0x0 0x40002 0x0 0x0>;
> +		dmas = <&mdma1 36 0x0 0x40008 0x0 0x0 0>,
> +		       <&mdma1 37 0x0 0x40002 0x0 0x0 0>;
>  		dma-names = "rx", "tx";
>  		status = "disabled";
>  	};
> -- 
> 2.7.4
> 
