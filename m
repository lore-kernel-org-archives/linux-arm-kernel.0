From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 25 Sep 2018 17:10:02 +0200
Subject: [PATCH v1 1/5] arm64: dts: mt7622: add timer, CCI-400 and PMU
 nodes
In-Reply-To: <7d3ce6a89ffeb221dc3197b763521582bf300577.1534607107.git.ryder.lee@mediatek.com>
References: <7d3ce6a89ffeb221dc3197b763521582bf300577.1534607107.git.ryder.lee@mediatek.com>
Message-ID: <5cd2bf92-251d-7a48-5bb0-95060d6ccb51@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whole series pushed to v4.19-next/dts64

Thanks!

On 18/08/2018 18:02, Ryder Lee wrote:
> Add device tree entries for timer, ARM CCI-400 and its PMU.
> Otherwise, we add a cortex-a53-pmu node to enable hw perfevents.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
> change since v1:
> - add a pmu node.
> ---
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi | 55 ++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index de2c47bd..d297100 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -79,6 +79,7 @@
>  			#cooling-cells = <2>;
>  			enable-method = "psci";
>  			clock-frequency = <1300000000>;
> +			cci-control-port = <&cci_control2>;
>  		};
>  
>  		cpu1: cpu at 1 {
> @@ -92,6 +93,7 @@
>  			#cooling-cells = <2>;
>  			enable-method = "psci";
>  			clock-frequency = <1300000000>;
> +			cci-control-port = <&cci_control2>;
>  		};
>  	};
>  
> @@ -113,6 +115,13 @@
>  		method      = "smc";
>  	};
>  
> +	pmu {
> +		compatible = "arm,cortex-a53-pmu";
> +		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 9 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-affinity = <&cpu0>, <&cpu1>;
> +	};
> +
>  	reserved-memory {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -218,6 +227,16 @@
>  		#reset-cells = <1>;
>  	};
>  
> +        timer: timer at 10004000 {
> +                compatible = "mediatek,mt7622-timer",
> +                             "mediatek,mt6577-timer";
> +                reg = <0 0x10004000 0 0x80>;
> +                interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_LOW>;
> +                clocks = <&infracfg CLK_INFRA_APXGPT_PD>,
> +                         <&topckgen CLK_TOP_RTC>;
> +                clock-names = "system-clk", "rtc-clk";
> +        };
> +
>  	scpsys: scpsys at 10006000 {
>  		compatible = "mediatek,mt7622-scpsys",
>  			     "syscon";
> @@ -325,6 +344,42 @@
>  		      <0 0x10360000 0 0x2000>;
>  	};
>  
> +	cci: cci at 10390000 {
> +		compatible = "arm,cci-400";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0 0x10390000 0 0x1000>;
> +		ranges = <0 0 0x10390000 0x10000>;
> +
> +		cci_control0: slave-if at 1000 {
> +			compatible = "arm,cci-400-ctrl-if";
> +			interface-type = "ace-lite";
> +			reg = <0x1000 0x1000>;
> +		};
> +
> +		cci_control1: slave-if at 4000 {
> +			compatible = "arm,cci-400-ctrl-if";
> +			interface-type = "ace";
> +			reg = <0x4000 0x1000>;
> +		};
> +
> +		cci_control2: slave-if at 5000 {
> +			compatible = "arm,cci-400-ctrl-if";
> +			interface-type = "ace";
> +			reg = <0x5000 0x1000>;
> +		};
> +
> +		pmu at 9000 {
> +			compatible = "arm,cci-400-pmu,r1";
> +			reg = <0x9000 0x5000>;
> +			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +	};
> +
>  	auxadc: adc at 11001000 {
>  		compatible = "mediatek,mt7622-auxadc";
>  		reg = <0 0x11001000 0 0x1000>;
> 
