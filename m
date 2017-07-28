From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 28 Jul 2017 14:30:03 +0200
Subject: [RESEND PATCH] ARM: dts: stm32: Add DMA support for STM32H743 SoC
In-Reply-To: <1499756176-540-1-git-send-email-pierre-yves.mordret@st.com>
References: <1499756176-540-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <d7ae8c15-1c73-9711-5c6f-3364c4d9ddbe@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/11/2017 08:56 AM, Pierre-Yves MORDRET wrote:
> This patch adds DMA support for STM32H743 SoC.
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>   arch/arm/boot/dts/stm32h743.dtsi | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
> index 4685629..3d1cd88 100644
> --- a/arch/arm/boot/dts/stm32h743.dtsi
> +++ b/arch/arm/boot/dts/stm32h743.dtsi
> @@ -74,6 +74,38 @@
>   			interrupts = <50>;
>   			clocks = <&timer_clk>;
>   		};
> +
> +		dma1: dma at 40020000 {
> +			compatible = "st,stm32-dma";
> +			reg = <0x40020000 0x400>;
> +			interrupts = <11>,
> +				     <12>,
> +				     <13>,
> +				     <14>,
> +				     <15>,
> +				     <16>,
> +				     <17>,
> +				     <47>;
> +			clocks = <&timer_clk>;
> +			#dma-cells = <4>;
> +			st,mem2mem;
> +		};
> +
> +		dma2: dma at 40020400 {
> +			compatible = "st,stm32-dma";
> +			reg = <0x40020400 0x400>;
> +			interrupts = <56>,
> +				     <57>,
> +				     <58>,
> +				     <59>,
> +				     <60>,
> +				     <68>,
> +				     <69>,
> +				     <70>;
> +			clocks = <&timer_clk>;
> +			#dma-cells = <4>;
> +			st,mem2mem;
> +		};
>   	};
>   };
>   
> 
Applied on stm32-dt-for-v4.14 branch.

However, I prefer to keep DMA nodes disabled.
Indeed on cortex-M7, dma allocations have to be done in a 
"strongly-ordered" area. So If you want to use DMA you need to create in 
your device tree a "reserved memory" area like that:

+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		linux,dma {
+			compatible = "shared-dma-pool";
+			linux,dma-default;
+			no-map;
+			reg = <0xd1c00000 0x400000>;
+		};
+	};

In the same time, you have to configure in the same way the cortex-m7 
MPU in your bootloader.

FYI, patches are under review to configure MPU directly in the kernel 
(bootloader will not longer have to configure it). It seems also that 
discussions are ongoing about the way to declare "linux,dma" area in 
devicetree.
As soon all discussions will close and MPU patches applied, we will be 
able to enable DMA.

Regards
Alex
