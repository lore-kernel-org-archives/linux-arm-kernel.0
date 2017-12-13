From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 13 Dec 2017 10:06:36 +0000
Subject: [PATCH 1/3] ARM: dts: stm32: add DMA memory pool on MCU which
 embed a cortex-M7
In-Reply-To: <1513101746-18030-2-git-send-email-alexandre.torgue@st.com>
References: <1513101746-18030-1-git-send-email-alexandre.torgue@st.com>
 <1513101746-18030-2-git-send-email-alexandre.torgue@st.com>
Message-ID: <ab9a2ef4-4944-c935-af6e-12503b477879@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/17 18:02, Alexandre Torgue wrote:
> On cortex-M7 MCU, DMA have to use a non cache-able memory area. For this
> reason a dedicated memory pool is created for DMA.
> This patch creates a DMA memory pool of 1MB of each STM32 MCU which
> embeds a cortex-M7 expect stm32f746-disco. Indeed, as stm32f746-disco has
                     ^^^^^^
                     except?

> only a 8MB SDRAM and it's tricky to reduce memory used by Kernel.

I guess that 1MB is a kind of "should be enough" estimate, probably something
along with [1] would give you exact numbers...

> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> 
> diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
> index 2d4e717..3f52a7b 100644
> --- a/arch/arm/boot/dts/stm32746g-eval.dts
> +++ b/arch/arm/boot/dts/stm32746g-eval.dts
> @@ -57,6 +57,19 @@
>  		reg = <0xc0000000 0x2000000>;
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		linux,dma {
> +			compatible = "shared-dma-pool";
> +			linux,dma-default;
> +			no-map;
> +			reg = <0xc1f00000 0x100000>;
> +		};
> +	};
> +
>  	aliases {
>  		serial0 = &usart1;
>  	};
> diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/stm32f769-disco.dts
> index 4463ca1..08699a2 100644
> --- a/arch/arm/boot/dts/stm32f769-disco.dts
> +++ b/arch/arm/boot/dts/stm32f769-disco.dts
> @@ -57,6 +57,19 @@
>  		reg = <0xC0000000 0x1000000>;
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		linux,dma {
> +			compatible = "shared-dma-pool";
> +			linux,dma-default;
> +			no-map;
> +			reg = <0xc0f00000 0x100000>;
> +		};
> +	};
> +
>  	aliases {
>  		serial0 = &usart1;
>  	};
> diff --git a/arch/arm/boot/dts/stm32h743i-disco.dts b/arch/arm/boot/dts/stm32h743i-disco.dts
> index 79e841d..104545a 100644
> --- a/arch/arm/boot/dts/stm32h743i-disco.dts
> +++ b/arch/arm/boot/dts/stm32h743i-disco.dts
> @@ -57,6 +57,19 @@
>  		reg = <0xd0000000 0x2000000>;
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		linux,dma {
> +			compatible = "shared-dma-pool";
> +			linux,dma-default;
> +			no-map;
> +			reg = <0xc1f00000 0x100000>;
> +		};
> +	};
> +
>  	aliases {
>  		serial0 = &usart2;
>  	};
> diff --git a/arch/arm/boot/dts/stm32h743i-eval.dts b/arch/arm/boot/dts/stm32h743i-eval.dts
> index 9f0e72c..5bd4b16 100644
> --- a/arch/arm/boot/dts/stm32h743i-eval.dts
> +++ b/arch/arm/boot/dts/stm32h743i-eval.dts
> @@ -57,6 +57,19 @@
>  		reg = <0xd0000000 0x2000000>;
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		linux,dma {
> +			compatible = "shared-dma-pool";
> +			linux,dma-default;
> +			no-map;
> +			reg = <0xc1f00000 0x100000>;
> +		};
> +	};
> +
>  	aliases {
>  		serial0 = &usart1;
>  	};
> 

Usage of dma-default looks correct to me, so FWIW

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

[1] https://lkml.org/lkml/2017/7/7/296

Vladimir
