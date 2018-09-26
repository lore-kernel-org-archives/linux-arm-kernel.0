From: robh@kernel.org (Rob Herring)
Date: Wed, 26 Sep 2018 15:21:12 -0500
Subject: [PATCH v1 1/7] dt-bindings: stm32-dma: Add DMA/MDMA chaining
 support bindings
In-Reply-To: <1536650820-16076-2-git-send-email-pierre-yves.mordret@st.com>
References: <1536650820-16076-1-git-send-email-pierre-yves.mordret@st.com>
 <1536650820-16076-2-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20180926202112.GA6426@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2018 at 09:26:54AM +0200, Pierre-Yves MORDRET wrote:
> This patch adds dma bindings to support DMA/MDMA chaining transfer.
> 1 bit is to manage both DMA FIFO Threshold
> 1 bit is to manage DMA/MDMA Chaining features.
> 2 bits are used to specify SDRAM size to use for DMA/MDMA chaining.
> The size in bytes of a certain order is given by the formula:
>     (2 ^ order) * PAGE_SIZE.
> The order is given by those 2 bits.
> For cyclic, whether chaining is chosen, any value above 1 can be set :
> SRAM buffer size will rely on period size and not on this DT value.
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>   Version history:
>     v1:
>        * Initial
> ---
> ---
>  .../devicetree/bindings/dma/stm32-dma.txt          | 32 +++++++++++++++++++---
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/stm32-dma.txt b/Documentation/devicetree/bindings/dma/stm32-dma.txt
> index c5f5190..163be09 100644
> --- a/Documentation/devicetree/bindings/dma/stm32-dma.txt
> +++ b/Documentation/devicetree/bindings/dma/stm32-dma.txt
> @@ -17,6 +17,12 @@ Optional properties:
>  - resets: Reference to a reset controller asserting the DMA controller
>  - st,mem2mem: boolean; if defined, it indicates that the controller supports
>    memory-to-memory transfer
> +- dmas: A list of eight dma specifiers, one for each entry in dma-names.
> +  Refer to stm32-mdma.txt for more details.
> +- dma-names: should contain "ch0", "ch1", "ch2", "ch3", "ch4", "ch5", "ch6" and
> +  "ch7" and represents each STM32 DMA channel connected to a STM32 MDMA one.
> +- memory-region : phandle to a node describing memory to be used for
> +  M2M intermediate transfer between DMA and MDMA.
>  
>  Example:
>  
> @@ -36,6 +42,16 @@ Example:
>  		st,mem2mem;
>  		resets = <&rcc 150>;
>  		dma-requests = <8>;
> +		dmas = <&mdma1 8 0x10 0x1200000a 0x40026408 0x00000020 1>,
> +		       <&mdma1 9 0x10 0x1200000a 0x40026408 0x00000800 1>,
> +		       <&mdma1 10 0x10 0x1200000a 0x40026408 0x00200000 1>,
> +		       <&mdma1 11 0x10 0x1200000a 0x40026408 0x08000000 1>,
> +		       <&mdma1 12 0x10 0x1200000a 0x4002640C 0x00000020 1>,
> +		       <&mdma1 13 0x10 0x1200000a 0x4002640C 0x00000800 1>,
> +		       <&mdma1 14 0x10 0x1200000a 0x4002640C 0x00200000 1>,
> +		       <&mdma1 15 0x10 0x1200000a 0x4002640C 0x08000000 1>;
> +		dma-names = "ch0", "ch1", "ch2", "ch3", "ch4", "ch5", "ch6", "ch7";
> +		memory-region = <&sram_dmapool>;
>  	};
>  
>  * DMA client
> @@ -62,13 +78,21 @@ channel: a phandle to the DMA controller plus the following four integer cells:
>  	0x1: medium
>  	0x2: high
>  	0x3: very high
> -4. A 32bit bitfield value specifying DMA features which are device dependent:
> +4. A bitfield value specifying DMA features which are device dependent:

It's still a 32-bit value, right?

>   -bit 0-1: DMA FIFO threshold selection
>  	0x0: 1/4 full FIFO
>  	0x1: 1/2 full FIFO
>  	0x2: 3/4 full FIFO
>  	0x3: full FIFO
> -
> + -bit 2: Intermediate M2M transfer from/to DDR to/from SRAM throughout MDMA
> +	0: MDMA not used to generate an intermediate M2M transfer
> +	1: MDMA used to generate an intermediate M2M transfer.
> + -bit 3-4: indicated SRAM Buffer size in (2^order)*PAGE_SIZE.

What's PAGE_SIZE? That's not defined for DT.

> +	Order is given by those 2 bits starting at 0.
> +	Valid only whether Intermediate M2M transfer is set.
> +	For cyclic, whether Intermediate M2M transfer is chosen, any value can
> +	be set: SRAM buffer size will rely on period size and not on this DT
> +	value.
>  
>  Example:
>  
> @@ -77,7 +101,7 @@ Example:
>  		reg = <0x40011000 0x400>;
>  		interrupts = <37>;
>  		clocks = <&clk_pclk2>;
> -		dmas = <&dma2 2 4 0x10400 0x3>,
> -		       <&dma2 7 5 0x10200 0x3>;
> +		dmas = <&dma2 2 4 0x10400 0x1>,
> +		       <&dma2 7 5 0x10200 0x1>;
>  		dma-names = "rx", "tx";
>  	};
> -- 
> 2.7.4
> 
