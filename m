From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 16 Jun 2017 16:33:08 +0200
Subject: [PATCH v3 2/2] arm64: dts: Add Mediatek SoC MT2712 and evaluation
 board dts and Makefile
In-Reply-To: <1497620721-61444-3-git-send-email-yt.shen@mediatek.com>
References: <1497620721-61444-1-git-send-email-yt.shen@mediatek.com>
 <1497620721-61444-3-git-send-email-yt.shen@mediatek.com>
Message-ID: <d5509532-7ab6-c9ce-d951-4bcdcc1399ff@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/06/17 15:45, YT Shen wrote:
> This adds basic chip support for Mediatek 2712
> 
> Signed-off-by: YT Shen <yt.shen@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>   arch/arm64/boot/dts/mediatek/mt2712-evb.dts |  32 ++++++
>   arch/arm64/boot/dts/mediatek/mt2712e.dtsi   | 166 ++++++++++++++++++++++++++++
>   3 files changed, 199 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt2712-evb.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 9fbfd32..fcc0604 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -1,3 +1,4 @@
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
> new file mode 100644
> index 0000000..8c804df
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
> @@ -0,0 +1,32 @@
> +/*
> + * Copyright (c) 2017 MediaTek Inc.
> + * Author: YT Shen <yt.shen@mediatek.com>
> + *
> + * SPDX-License-Identifier: (GPL-2.0 OR MIT)
> + */
> +
> +/dts-v1/;
> +#include "mt2712e.dtsi"
> +
> +/ {
> +	model = "MediaTek MT2712 evaluation board";
> +	compatible = "mediatek,mt2712-evb", "mediatek,mt2712";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	memory at 40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0x80000000>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:921600n8";
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> new file mode 100644
> index 0000000..65cdd4a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> @@ -0,0 +1,166 @@
[...]
> +
> +	uart_clk: dummy26m {
> +		compatible = "fixed-clock";
> +		clock-frequency = <26000000>;
> +		#clock-cells = <0>;
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13
> +			      (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14
> +			      (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11
> +			      (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10
> +			      (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		uart5: serial at 1000f000 {
> +			compatible = "mediatek,mt2712-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x1000f000 0 0x400>;
> +			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&uart_clk>;

uart has two clocks, baud and bus clock. Please refer to the bindings 
descrption for more information, that's what they are for.

Please define the two dummy clocks with the correct frequency and use them.

Regards,
Matthias
