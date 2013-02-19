From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 19 Feb 2013 12:38:20 +0000
Subject: [PATCH V4 4/4] ARM: dts: pl330: Add #dma-cells for generic dma
 binding support
In-Reply-To: <1360813208-9498-5-git-send-email-padma.v@samsung.com>
References: <1360813208-9498-1-git-send-email-padma.v@samsung.com>
 <1360813208-9498-5-git-send-email-padma.v@samsung.com>
Message-ID: <20130219123820.GF1978@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 09:10:08AM +0530, Padmavathi Venna wrote:
> This patch adds #dma-cells property to PL330 DMA controller
> nodes for supporting generic dma dt bindings on samsung
> exynos5250 platform.

Can you comment on the following thread?

https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-February/028188.html


Describing DMA controllers is part of a wider problem of how to describe
bus masters in DT.

The key problem is that nobody knows what subset of the bus hierarchy is
accessed by a DMA controller (or something else) in its master role.
Currently I think that the PCI-oriented standard bindings in the ePAPR
specification are not adequate to describe arbitrary SoC platforms,
but maybe I'm missing something or being too pessimistic...

The "what does a master see" problem is mostly independent of your
DMA bindings, except that coherency is not specific to DMA controllers,
and ideally we would describe that in a common way for all masters.
(Also, in general most devices don't power up coherent -- configuration
both in the peripheral and in the bus fabric may be needed before
coherency is established).

Cheers
---Dave

> 
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../devicetree/bindings/dma/arm-pl330.txt          |   21 +++++++++++++++----
>  arch/arm/boot/dts/exynos5250.dtsi                  |   12 +++++++++++
>  2 files changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/arm-pl330.txt b/Documentation/devicetree/bindings/dma/arm-pl330.txt
> index 36e27d5..2675658 100644
> --- a/Documentation/devicetree/bindings/dma/arm-pl330.txt
> +++ b/Documentation/devicetree/bindings/dma/arm-pl330.txt
> @@ -10,7 +10,11 @@ Required properties:
>    - interrupts: interrupt number to the cpu.
>  
>  Optional properties:
> -- dma-coherent      : Present if dma operations are coherent
> +  - dma-coherent      : Present if dma operations are coherent
> +  - #dma-cells: must be <1>. used to represent the number of integer
> +    cells in the dmas property of client device.
> +  - dma-channels: contains the total number of DMA channels supported by the DMAC
> +  - dma-requests: contains the total number of DMA requests supported by the DMAC
>  
>  Example:
>  
> @@ -18,16 +22,23 @@ Example:
>  		compatible = "arm,pl330", "arm,primecell";
>  		reg = <0x12680000 0x1000>;
>  		interrupts = <99>;
> +		#dma-cells = <1>;
> +		#dma-channels = <8>;
> +		#dma-requests = <32>;
>  	};
>  
>  Client drivers (device nodes requiring dma transfers from dev-to-mem or
> -mem-to-dev) should specify the DMA channel numbers using a two-value pair
> +mem-to-dev) should specify the DMA channel numbers and dma channel names
>  as shown below.
>  
>    [property name]  = <[phandle of the dma controller] [dma request id]>;
> +  [property name]  = <[dma channel name]>
>  
>        where 'dma request id' is the dma request number which is connected
> -      to the client controller. The 'property name' is recommended to be
> -      of the form <name>-dma-channel.
> +      to the client controller. The 'property name' 'dmas' and 'dma-names'
> +      as required by the generic dma device tree binding helpers. The dma
> +      names correspond 1:1 with the dma request ids in the dmas property.
>  
> -  Example:  tx-dma-channel = <&pdma0 12>;
> +  Example:  dmas = <&pdma0 12
> +		    &pdma1 11>;
> +	    dma-names = "tx", "rx";
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 2e3b6ef..c774aae 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -280,24 +280,36 @@
>  			compatible = "arm,pl330", "arm,primecell";
>  			reg = <0x121A0000 0x1000>;
>  			interrupts = <0 34 0>;
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
>  		};
>  
>  		pdma1: pdma at 121B0000 {
>  			compatible = "arm,pl330", "arm,primecell";
>  			reg = <0x121B0000 0x1000>;
>  			interrupts = <0 35 0>;
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
>  		};
>  
>  		mdma0: mdma at 10800000 {
>  			compatible = "arm,pl330", "arm,primecell";
>  			reg = <0x10800000 0x1000>;
>  			interrupts = <0 33 0>;
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <1>;
>  		};
>  
>  		mdma1: mdma at 11C10000 {
>  			compatible = "arm,pl330", "arm,primecell";
>  			reg = <0x11C10000 0x1000>;
>  			interrupts = <0 124 0>;
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <1>;
>  		};
>  	};
>  
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
