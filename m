From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Tue, 02 Oct 2018 16:41:59 +0200
Subject: [PATCH v6 13/14] arm64: dts: marvell: use new bindings for CP110
 interrupts
In-Reply-To: <20181001141358.31508-14-miquel.raynal@bootlin.com> (Miquel
 Raynal's message of "Mon, 1 Oct 2018 16:13:57 +0200")
References: <20181001141358.31508-1-miquel.raynal@bootlin.com>
 <20181001141358.31508-14-miquel.raynal@bootlin.com>
Message-ID: <87wor0mmvc.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,
 
 On lun., oct. 01 2018, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Create an ICU subnode for the NSR interrupts. This subnode becomes the
> CP110 interrupt parent, removing the need for the ICU_GRP_NSR parameter.
> Move all DT110 nodes to use these new bindings.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Could you rebase this patch and the following on mvebu/dt64?

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 117 ++++++++++--------
>  1 file changed, 62 insertions(+), 55 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> index 840c8454d03e..261c35855ce3 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> @@ -25,7 +25,7 @@
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>  	compatible = "simple-bus";
> -	interrupt-parent = <&CP110_LABEL(icu)>;
> +	interrupt-parent = <&CP110_LABEL(icu_nsr)>;
>  	ranges;
>  
>  	config-space at CP110_BASE {
> @@ -47,12 +47,12 @@
>  			dma-coherent;
>  
>  			CP110_LABEL(eth0): eth0 {
> -				interrupts = <ICU_GRP_NSR 39 IRQ_TYPE_LEVEL_HIGH>,
> -					<ICU_GRP_NSR 43 IRQ_TYPE_LEVEL_HIGH>,
> -					<ICU_GRP_NSR 47 IRQ_TYPE_LEVEL_HIGH>,
> -					<ICU_GRP_NSR 51 IRQ_TYPE_LEVEL_HIGH>,
> -					<ICU_GRP_NSR 55 IRQ_TYPE_LEVEL_HIGH>,
> -					<ICU_GRP_NSR 129 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupts = <39 IRQ_TYPE_LEVEL_HIGH>,
> +					     <43 IRQ_TYPE_LEVEL_HIGH>,
> +					     <47 IRQ_TYPE_LEVEL_HIGH>,
> +					     <51 IRQ_TYPE_LEVEL_HIGH>,
> +					     <55 IRQ_TYPE_LEVEL_HIGH>,
> +					     <129 IRQ_TYPE_LEVEL_HIGH>;
>  				interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
>  					"tx-cpu3", "rx-shared", "link";
>  				port-id = <0>;
> @@ -61,12 +61,12 @@
>  			};
>  
>  			CP110_LABEL(eth1): eth1 {
> -				interrupts = <ICU_GRP_NSR 40 IRQ_TYPE_LEVEL_HIGH>,
> -					<ICU_GRP_NSR 44 IRQ_TYPE_LEVEL_HIGH>,
> -					<ICU_GRP_NSR 48 IRQ_TYPE_LEVEL_HIGH>,
> -					<ICU_GRP_NSR 52 IRQ_TYPE_LEVEL_HIGH>,
> -					<ICU_GRP_NSR 56 IRQ_TYPE_LEVEL_HIGH>,
> -					<ICU_GRP_NSR 128 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupts = <40 IRQ_TYPE_LEVEL_HIGH>,
> +					     <44 IRQ_TYPE_LEVEL_HIGH>,
> +					     <48 IRQ_TYPE_LEVEL_HIGH>,
> +					     <52 IRQ_TYPE_LEVEL_HIGH>,
> +					     <56 IRQ_TYPE_LEVEL_HIGH>,
> +					     <128 IRQ_TYPE_LEVEL_HIGH>;
>  				interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
>  					"tx-cpu3", "rx-shared", "link";
>  				port-id = <1>;
> @@ -75,12 +75,12 @@
>  			};
>  
>  			CP110_LABEL(eth2): eth2 {
> -				interrupts = <ICU_GRP_NSR 41 IRQ_TYPE_LEVEL_HIGH>,
> -					<ICU_GRP_NSR 45 IRQ_TYPE_LEVEL_HIGH>,
> -					<ICU_GRP_NSR 49 IRQ_TYPE_LEVEL_HIGH>,
> -					<ICU_GRP_NSR 53 IRQ_TYPE_LEVEL_HIGH>,
> -					<ICU_GRP_NSR 57 IRQ_TYPE_LEVEL_HIGH>,
> -					<ICU_GRP_NSR 127 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupts = <41 IRQ_TYPE_LEVEL_HIGH>,
> +					     <45 IRQ_TYPE_LEVEL_HIGH>,
> +					     <49 IRQ_TYPE_LEVEL_HIGH>,
> +					     <53 IRQ_TYPE_LEVEL_HIGH>,
> +					     <57 IRQ_TYPE_LEVEL_HIGH>,
> +					     <127 IRQ_TYPE_LEVEL_HIGH>;
>  				interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
>  					"tx-cpu3", "rx-shared", "link";
>  				port-id = <2>;
> @@ -150,16 +150,23 @@
>  		CP110_LABEL(icu): interrupt-controller at 1e0000 {
>  			compatible = "marvell,cp110-icu";
>  			reg = <0x1e0000 0x440>;
> -			#interrupt-cells = <3>;
> -			interrupt-controller;
> -			msi-parent = <&gicp>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			CP110_LABEL(icu_nsr): interrupt-controller at 10 {
> +				compatible = "marvell,cp110-icu-nsr";
> +				reg = <0x10 0x20>;
> +				#interrupt-cells = <2>;
> +				interrupt-controller;
> +				msi-parent = <&gicp>;
> +			};
>  		};
>  
>  		CP110_LABEL(rtc): rtc at 284000 {
>  			compatible = "marvell,armada-8k-rtc";
>  			reg = <0x284000 0x20>, <0x284080 0x24>;
>  			reg-names = "rtc", "rtc-soc";
> -			interrupts = <ICU_GRP_NSR 77 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <77 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
>  		CP110_LABEL(thermal): thermal at 400078 {
> @@ -185,10 +192,10 @@
>  				#gpio-cells = <2>;
>  				gpio-ranges = <&CP110_LABEL(pinctrl) 0 0 32>;
>  				interrupt-controller;
> -				interrupts = <ICU_GRP_NSR 86 IRQ_TYPE_LEVEL_HIGH>,
> -					<ICU_GRP_NSR 85 IRQ_TYPE_LEVEL_HIGH>,
> -					<ICU_GRP_NSR 84 IRQ_TYPE_LEVEL_HIGH>,
> -					<ICU_GRP_NSR 83 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupts = <86 IRQ_TYPE_LEVEL_HIGH>,
> +					     <85 IRQ_TYPE_LEVEL_HIGH>,
> +					     <84 IRQ_TYPE_LEVEL_HIGH>,
> +					     <83 IRQ_TYPE_LEVEL_HIGH>;
>  				status = "disabled";
>  			};
>  
> @@ -200,10 +207,10 @@
>  				#gpio-cells = <2>;
>  				gpio-ranges = <&CP110_LABEL(pinctrl) 0 32 31>;
>  				interrupt-controller;
> -				interrupts = <ICU_GRP_NSR 82 IRQ_TYPE_LEVEL_HIGH>,
> -					<ICU_GRP_NSR 81 IRQ_TYPE_LEVEL_HIGH>,
> -					<ICU_GRP_NSR 80 IRQ_TYPE_LEVEL_HIGH>,
> -					<ICU_GRP_NSR 79 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupts = <82 IRQ_TYPE_LEVEL_HIGH>,
> +					     <81 IRQ_TYPE_LEVEL_HIGH>,
> +					     <80 IRQ_TYPE_LEVEL_HIGH>,
> +					     <79 IRQ_TYPE_LEVEL_HIGH>;
>  				status = "disabled";
>  			};
>  		};
> @@ -213,7 +220,7 @@
>  			"generic-xhci";
>  			reg = <0x500000 0x4000>;
>  			dma-coherent;
> -			interrupts = <ICU_GRP_NSR 106 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <106 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "core", "reg";
>  			clocks = <&CP110_LABEL(clk) 1 22>,
>  				 <&CP110_LABEL(clk) 1 16>;
> @@ -225,7 +232,7 @@
>  			"generic-xhci";
>  			reg = <0x510000 0x4000>;
>  			dma-coherent;
> -			interrupts = <ICU_GRP_NSR 105 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <105 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "core", "reg";
>  			clocks = <&CP110_LABEL(clk) 1 23>,
>  				 <&CP110_LABEL(clk) 1 16>;
> @@ -237,7 +244,7 @@
>  			"generic-ahci";
>  			reg = <0x540000 0x30000>;
>  			dma-coherent;
> -			interrupts = <ICU_GRP_NSR 107 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <107 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&CP110_LABEL(clk) 1 15>,
>  				 <&CP110_LABEL(clk) 1 16>;
>  			status = "disabled";
> @@ -290,7 +297,7 @@
>  			reg = <0x701000 0x20>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -			interrupts = <ICU_GRP_NSR 120 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <120 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "core", "reg";
>  			clocks = <&CP110_LABEL(clk) 1 21>,
>  				 <&CP110_LABEL(clk) 1 17>;
> @@ -302,7 +309,7 @@
>  			reg = <0x701100 0x20>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -			interrupts = <ICU_GRP_NSR 121 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <121 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "core", "reg";
>  			clocks = <&CP110_LABEL(clk) 1 21>,
>  				 <&CP110_LABEL(clk) 1 17>;
> @@ -313,7 +320,7 @@
>  			compatible = "snps,dw-apb-uart";
>  			reg = <0x702000 0x100>;
>  			reg-shift = <2>;
> -			interrupts = <ICU_GRP_NSR 122 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <122 IRQ_TYPE_LEVEL_HIGH>;
>  			reg-io-width = <1>;
>  			clock-names = "baudclk", "apb_pclk";
>  			clocks = <&CP110_LABEL(clk) 1 21>,
> @@ -325,7 +332,7 @@
>  			compatible = "snps,dw-apb-uart";
>  			reg = <0x702100 0x100>;
>  			reg-shift = <2>;
> -			interrupts = <ICU_GRP_NSR 123 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <123 IRQ_TYPE_LEVEL_HIGH>;
>  			reg-io-width = <1>;
>  			clock-names = "baudclk", "apb_pclk";
>  			clocks = <&CP110_LABEL(clk) 1 21>,
> @@ -337,7 +344,7 @@
>  			compatible = "snps,dw-apb-uart";
>  			reg = <0x702200 0x100>;
>  			reg-shift = <2>;
> -			interrupts = <ICU_GRP_NSR 124 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <124 IRQ_TYPE_LEVEL_HIGH>;
>  			reg-io-width = <1>;
>  			clock-names = "baudclk", "apb_pclk";
>  			clocks = <&CP110_LABEL(clk) 1 21>,
> @@ -349,7 +356,7 @@
>  			compatible = "snps,dw-apb-uart";
>  			reg = <0x702300 0x100>;
>  			reg-shift = <2>;
> -			interrupts = <ICU_GRP_NSR 125 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <125 IRQ_TYPE_LEVEL_HIGH>;
>  			reg-io-width = <1>;
>  			clock-names = "baudclk", "apb_pclk";
>  			clocks = <&CP110_LABEL(clk) 1 21>,
> @@ -368,7 +375,7 @@
>  			reg = <0x720000 0x54>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -			interrupts = <ICU_GRP_NSR 115 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <115 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "core", "reg";
>  			clocks = <&CP110_LABEL(clk) 1 2>,
>  				 <&CP110_LABEL(clk) 1 17>;
> @@ -380,7 +387,7 @@
>  			compatible = "marvell,armada-8k-rng",
>  			"inside-secure,safexcel-eip76";
>  			reg = <0x760000 0x7d>;
> -			interrupts = <ICU_GRP_NSR 95 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <95 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "core", "reg";
>  			clocks = <&CP110_LABEL(clk) 1 25>,
>  				 <&CP110_LABEL(clk) 1 17>;
> @@ -390,7 +397,7 @@
>  		CP110_LABEL(sdhci0): sdhci at 780000 {
>  			compatible = "marvell,armada-cp110-sdhci";
>  			reg = <0x780000 0x300>;
> -			interrupts = <ICU_GRP_NSR 27 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <27 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "core", "axi";
>  			clocks = <&CP110_LABEL(clk) 1 4>, <&CP110_LABEL(clk) 1 18>;
>  			dma-coherent;
> @@ -400,12 +407,12 @@
>  		CP110_LABEL(crypto): crypto at 800000 {
>  			compatible = "inside-secure,safexcel-eip197b";
>  			reg = <0x800000 0x200000>;
> -			interrupts = <ICU_GRP_NSR 87 IRQ_TYPE_LEVEL_HIGH>,
> -				<ICU_GRP_NSR 88 IRQ_TYPE_LEVEL_HIGH>,
> -				<ICU_GRP_NSR 89 IRQ_TYPE_LEVEL_HIGH>,
> -				<ICU_GRP_NSR 90 IRQ_TYPE_LEVEL_HIGH>,
> -				<ICU_GRP_NSR 91 IRQ_TYPE_LEVEL_HIGH>,
> -				<ICU_GRP_NSR 92 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <87 IRQ_TYPE_LEVEL_HIGH>,
> +				     <88 IRQ_TYPE_LEVEL_HIGH>,
> +				     <89 IRQ_TYPE_LEVEL_HIGH>,
> +				     <90 IRQ_TYPE_LEVEL_HIGH>,
> +				     <91 IRQ_TYPE_LEVEL_HIGH>,
> +				     <92 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "mem", "ring0", "ring1",
>  				"ring2", "ring3", "eip";
>  			clock-names = "core", "reg";
> @@ -434,8 +441,8 @@
>  		/* non-prefetchable memory */
>  		0x82000000 0 CP110_PCIEx_MEM_BASE(0) 0  CP110_PCIEx_MEM_BASE(0) 0 0xf00000>;
>  		interrupt-map-mask = <0 0 0 0>;
> -		interrupt-map = <0 0 0 0 &CP110_LABEL(icu) ICU_GRP_NSR 22 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupts = <ICU_GRP_NSR 22 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-map = <0 0 0 0 &CP110_LABEL(icu_nsr) 22 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
>  		num-lanes = <1>;
>  		clock-names = "core", "reg";
>  		clocks = <&CP110_LABEL(clk) 1 13>, <&CP110_LABEL(clk) 1 14>;
> @@ -461,8 +468,8 @@
>  		/* non-prefetchable memory */
>  		0x82000000 0 CP110_PCIEx_MEM_BASE(1) 0  CP110_PCIEx_MEM_BASE(1) 0 0xf00000>;
>  		interrupt-map-mask = <0 0 0 0>;
> -		interrupt-map = <0 0 0 0 &CP110_LABEL(icu) ICU_GRP_NSR 24 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupts = <ICU_GRP_NSR 24 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-map = <0 0 0 0 &CP110_LABEL(icu_nsr) 24 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
>  
>  		num-lanes = <1>;
>  		clock-names = "core", "reg";
> @@ -489,8 +496,8 @@
>  		/* non-prefetchable memory */
>  		0x82000000 0 CP110_PCIEx_MEM_BASE(2) 0  CP110_PCIEx_MEM_BASE(2) 0 0xf00000>;
>  		interrupt-map-mask = <0 0 0 0>;
> -		interrupt-map = <0 0 0 0 &CP110_LABEL(icu) ICU_GRP_NSR 23 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupts = <ICU_GRP_NSR 23 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-map = <0 0 0 0 &CP110_LABEL(icu_nsr) 23 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupts = <23 IRQ_TYPE_LEVEL_HIGH>;
>  
>  		num-lanes = <1>;
>  		clock-names = "core", "reg";
> -- 
> 2.17.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
