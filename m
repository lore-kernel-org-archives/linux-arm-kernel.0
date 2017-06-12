From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 12 Jun 2017 11:13:43 +0200
Subject: [PATCH 3/3] arm: dts: mt2701: Add display subsystem related nodes
 for MT2701
In-Reply-To: <1496297324-21091-4-git-send-email-erin.lo@mediatek.com>
References: <1496297324-21091-1-git-send-email-erin.lo@mediatek.com>
 <1496297324-21091-4-git-send-email-erin.lo@mediatek.com>
Message-ID: <dc75371a-b9f4-9393-4c09-0a07d20ee169@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/06/17 08:08, Erin Lo wrote:
> From: YT Shen <yt.shen@mediatek.com>
> 
> This patch adds the device nodes for the DISP function blocks for MT2701
> 
> Signed-off-by: YT Shen <yt.shen@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
>   arch/arm/boot/dts/mt2701.dtsi | 84 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 84 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
> index 4f110d5..e20b65c 100644
> --- a/arch/arm/boot/dts/mt2701.dtsi
> +++ b/arch/arm/boot/dts/mt2701.dtsi
> @@ -17,6 +17,7 @@
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/reset/mt2701-resets.h>
> +#include <dt-bindings/memory/mt2701-larb-port.h>
>   #include "skeleton64.dtsi"
>   #include "mt2701-pinfunc.h"
>   
> @@ -24,6 +25,11 @@
>   	compatible = "mediatek,mt2701";
>   	interrupt-parent = <&sysirq>;
>   
> +	aliases {
> +		rdma0 = &rdma0;
> +		rdma1 = &rdma1;
> +	};
> +
>   	cpus {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
> @@ -201,6 +207,16 @@
>   		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
>   	};
>   
> +	mipi_tx0: mipi-dphy at 10010000 {
> +		compatible = "mediatek,mt2701-mipi-tx";
> +		reg = <0 0x10010000 0 0x90>;
> +		clocks = <&clk26m>;
> +		clock-output-names = "mipi_tx0_pll";
> +		#clock-cells = <0>;
> +		#phy-cells = <0>;
> +		status = "disabled";
> +	};
> +
>   	sysirq: interrupt-controller at 10200100 {
>   		compatible = "mediatek,mt2701-sysirq",
>   			     "mediatek,mt6577-sysirq";
> @@ -366,6 +382,39 @@
>   		#clock-cells = <1>;
>   	};
>   
> +	display_components: dispsys at 14000000 {
> +		compatible = "mediatek,mt2701-mmsys";
> +		reg = <0 0x14000000 0 0x1000>;
> +		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
> +	};

Can you please rebase on a recent kernel version. mt2701-mmsys node is 
already present.

Thanks,
Matthias

> +
> +	ovl at 14007000 {
> +		compatible = "mediatek,mt2701-disp-ovl";
> +		reg = <0 0x14007000 0 0x1000>;
> +		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&mmsys CLK_MM_DISP_OVL>;
> +		iommus = <&iommu MT2701_M4U_PORT_DISP_OVL_0>;
> +		mediatek,larb = <&larb0>;
> +	};
> +
> +	rdma0: rdma at 14008000 {
> +		compatible = "mediatek,mt2701-disp-rdma";
> +		reg = <0 0x14008000 0 0x1000>;
> +		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&mmsys CLK_MM_DISP_RDMA>;
> +		iommus = <&iommu MT2701_M4U_PORT_DISP_RDMA>;
> +		mediatek,larb = <&larb0>;
> +	};
> +
> +	wdma at 14009000 {
> +		compatible = "mediatek,mt2701-disp-wdma";
> +		reg = <0 0x14009000 0 0x1000>;
> +		interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&mmsys CLK_MM_DISP_WDMA>;
> +		iommus = <&iommu MT2701_M4U_PORT_DISP_WDMA>;
> +		mediatek,larb = <&larb0>;
> +	};
> +
>   	bls: bls at 1400a000 {
>   		compatible = "mediatek,mt2701-disp-pwm";
>   		reg = <0 0x1400a000 0 0x1000>;
> @@ -375,6 +424,32 @@
>   		status = "disabled";
>   	};
>   
> +	color at 1400b000 {
> +		compatible = "mediatek,mt2701-disp-color";
> +		reg = <0 0x1400b000 0 0x1000>;
> +		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&mmsys CLK_MM_DISP_COLOR>;
> +	};
> +
> +	dsi: dsi at 1400c000 {
> +		compatible = "mediatek,mt2701-dsi";
> +		reg = <0 0x1400c000 0 0x1000>;
> +		interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&mmsys CLK_MM_DSI_ENGINE>, <&mmsys CLK_MM_DSI_DIG>,
> +			 <&mipi_tx0>;
> +		clock-names = "engine", "digital", "hs";
> +		phys = <&mipi_tx0>;
> +		phy-names = "dphy";
> +		status = "disabled";
> +	};
> +
> +	mutex: mutex at 1400e000 {
> +		compatible = "mediatek,mt2701-disp-mutex";
> +		reg = <0 0x1400e000 0 0x1000>;
> +		interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&mmsys CLK_MM_MUTEX_32K>;
> +	};
> +
>   	larb0: larb at 14010000 {
>   		compatible = "mediatek,mt2701-smi-larb";
>   		reg = <0 0x14010000 0 0x1000>;
> @@ -385,6 +460,15 @@
>   		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
>   	};
>   
> +	rdma1: rdma at 14012000 {
> +		compatible = "mediatek,mt2701-disp-rdma";
> +		reg = <0 0x14012000 0 0x1000>;
> +		interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&mmsys CLK_MM_DISP_RDMA1>;
> +		iommus = <&iommu MT2701_M4U_PORT_DISP_RDMA1>;
> +		mediatek,larb = <&larb0>;
> +	};
> +
>   	imgsys: syscon at 15000000 {
>   		compatible = "mediatek,mt2701-imgsys", "syscon";
>   		reg = <0 0x15000000 0 0x1000>;
> 
