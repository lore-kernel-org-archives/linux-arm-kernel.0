From: niklas.soderlund@ragnatech.se (Niklas =?iso-8859-1?Q?S=F6derlund?=)
Date: Thu, 18 Jan 2018 02:43:08 +0100
Subject: [PATCH v2 11/16] ARM: dts: r8a7793: sort subnodes of soc node
In-Reply-To: <20180117161717.14589-12-horms+renesas@verge.net.au>
References: <20180117161717.14589-1-horms+renesas@verge.net.au>
 <20180117161717.14589-12-horms+renesas@verge.net.au>
Message-ID: <20180118014308.GK11924@bigcity.dyn.berto.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Thanks for your patch.

On 2018-01-17 17:17:12 +0100, Simon Horman wrote:
> Sort the subnodes of the soc node to improve maintainability.
> The sort key is the address on the bus with instances of the same
> IP block grouped together.
> 
> This patch should not introduce any functional change.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> v2
> * New patch
> ---
>  arch/arm/boot/dts/r8a7793.dtsi | 872 ++++++++++++++++++++---------------------
>  1 file changed, 436 insertions(+), 436 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
> index d18a65c647bb..f2b58a28cee9 100644
> --- a/arch/arm/boot/dts/r8a7793.dtsi
> +++ b/arch/arm/boot/dts/r8a7793.dtsi
> @@ -81,28 +81,6 @@
>  		#size-cells = <2>;
>  		ranges;
>  
> -		apmu at e6152000 {
> -			compatible = "renesas,r8a7793-apmu", "renesas,apmu";
> -			reg = <0 0xe6152000 0 0x188>;
> -			cpus = <&cpu0 &cpu1>;
> -		};
> -
> -		gic: interrupt-controller at f1001000 {
> -			compatible = "arm,gic-400";
> -			#interrupt-cells = <3>;
> -			#address-cells = <0>;
> -			interrupt-controller;
> -			reg = <0 0xf1001000 0 0x1000>,
> -				<0 0xf1002000 0 0x2000>,
> -				<0 0xf1004000 0 0x2000>,
> -				<0 0xf1006000 0 0x2000>;
> -			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
> -			clocks = <&cpg CPG_MOD 408>;
> -			clock-names = "clk";
> -			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> -			resets = <&cpg 408>;
> -		};
> -
>  		gpio0: gpio at e6050000 {
>  			compatible = "renesas,gpio-r8a7793",
>  				     "renesas,rcar-gen2-gpio";
> @@ -223,50 +201,37 @@
>  			resets = <&cpg 904>;
>  		};
>  
> -		thermal: thermal at e61f0000 {
> -			compatible = "renesas,thermal-r8a7793",
> -				     "renesas,rcar-gen2-thermal",
> -				     "renesas,rcar-thermal";
> -			reg = <0 0xe61f0000 0 0x10>, <0 0xe61f0100 0 0x38>;
> -			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cpg CPG_MOD 522>;
> -			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> -			resets = <&cpg 522>;
> -			#thermal-sensor-cells = <0>;
> +		pfc: pin-controller at e6060000 {
> +			compatible = "renesas,pfc-r8a7793";
> +			reg = <0 0xe6060000 0 0x250>;
>  		};
>  
> -		cmt0: timer at ffca0000 {
> -			compatible = "renesas,r8a7793-cmt0",
> -				     "renesas,rcar-gen2-cmt0";
> -			reg = <0 0xffca0000 0 0x1004>;
> -			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cpg CPG_MOD 124>;
> -			clock-names = "fck";
> -			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> -			resets = <&cpg 124>;
> +		/* Special CPG clocks */
> +		cpg: clock-controller at e6150000 {
> +			compatible = "renesas,r8a7793-cpg-mssr";
> +			reg = <0 0xe6150000 0 0x1000>;
> +			clocks = <&extal_clk>, <&usb_extal_clk>;
> +			clock-names = "extal", "usb_extal";
> +			#clock-cells = <2>;
> +			#power-domain-cells = <0>;
> +			#reset-cells = <1>;
> +		};
>  
> -			status = "disabled";
> +		apmu at e6152000 {
> +			compatible = "renesas,r8a7793-apmu", "renesas,apmu";
> +			reg = <0 0xe6152000 0 0x188>;
> +			cpus = <&cpu0 &cpu1>;
>  		};
>  
> -		cmt1: timer at e6130000 {
> -			compatible = "renesas,r8a7793-cmt1",
> -				     "renesas,rcar-gen2-cmt1";
> -			reg = <0 0xe6130000 0 0x1004>;
> -			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cpg CPG_MOD 329>;
> -			clock-names = "fck";
> -			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> -			resets = <&cpg 329>;
> +		rst: reset-controller at e6160000 {
> +			compatible = "renesas,r8a7793-rst";
> +			reg = <0 0xe6160000 0 0x0100>;
> +		};
>  
> -			status = "disabled";
> +		sysc: system-controller at e6180000 {
> +			compatible = "renesas,r8a7793-sysc";
> +			reg = <0 0xe6180000 0 0x0200>;
> +			#power-domain-cells = <1>;
>  		};
>  
>  		irqc0: interrupt-controller at e61c0000 {
> @@ -289,132 +254,101 @@
>  			resets = <&cpg 407>;
>  		};
>  
> -		dmac0: dma-controller at e6700000 {
> -			compatible = "renesas,dmac-r8a7793",
> -				     "renesas,rcar-dmac";
> -			reg = <0 0xe6700000 0 0x20000>;
> -			interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "error",
> -					"ch0", "ch1", "ch2", "ch3",
> -					"ch4", "ch5", "ch6", "ch7",
> -					"ch8", "ch9", "ch10", "ch11",
> -					"ch12", "ch13", "ch14";
> -			clocks = <&cpg CPG_MOD 219>;
> -			clock-names = "fck";
> +		thermal: thermal at e61f0000 {
> +			compatible = "renesas,thermal-r8a7793",
> +				     "renesas,rcar-gen2-thermal",
> +				     "renesas,rcar-thermal";
> +			reg = <0 0xe61f0000 0 0x10>, <0 0xe61f0100 0 0x38>;
> +			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 522>;
>  			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> -			resets = <&cpg 219>;
> -			#dma-cells = <1>;
> -			dma-channels = <15>;
> +			resets = <&cpg 522>;
> +			#thermal-sensor-cells = <0>;
>  		};
>  
> -		dmac1: dma-controller at e6720000 {
> -			compatible = "renesas,dmac-r8a7793",
> -				     "renesas,rcar-dmac";
> -			reg = <0 0xe6720000 0 0x20000>;
> -			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "error",
> -					"ch0", "ch1", "ch2", "ch3",
> -					"ch4", "ch5", "ch6", "ch7",
> -					"ch8", "ch9", "ch10", "ch11",
> -					"ch12", "ch13", "ch14";
> -			clocks = <&cpg CPG_MOD 218>;
> -			clock-names = "fck";
> -			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> -			resets = <&cpg 218>;
> -			#dma-cells = <1>;
> -			dma-channels = <15>;
> +		ipmmu_sy0: mmu at e6280000 {
> +			compatible = "renesas,ipmmu-r8a7793",
> +				     "renesas,ipmmu-vmsa";
> +			reg = <0 0xe6280000 0 0x1000>;
> +			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
> +			#iommu-cells = <1>;
> +			status = "disabled";
>  		};
>  
> -		audma0: dma-controller at ec700000 {
> -			compatible = "renesas,dmac-r8a7793",
> -				     "renesas,rcar-dmac";
> -			reg = <0 0xec700000 0 0x10000>;
> -			interrupts = <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "error",
> -					"ch0", "ch1", "ch2", "ch3",
> -					"ch4", "ch5", "ch6", "ch7",
> -					"ch8", "ch9", "ch10", "ch11",
> -					"ch12";
> -			clocks = <&cpg CPG_MOD 502>;
> -			clock-names = "fck";
> -			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> -			resets = <&cpg 502>;
> -			#dma-cells = <1>;
> -			dma-channels = <13>;
> +		ipmmu_sy1: mmu at e6290000 {
> +			compatible = "renesas,ipmmu-r8a7793",
> +				     "renesas,ipmmu-vmsa";
> +			reg = <0 0xe6290000 0 0x1000>;
> +			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
> +			#iommu-cells = <1>;
> +			status = "disabled";
>  		};
>  
> -		audma1: dma-controller at ec720000 {
> -			compatible = "renesas,dmac-r8a7793",
> -				     "renesas,rcar-dmac";
> -			reg = <0 0xec720000 0 0x10000>;
> -			interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH
> -				      GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "error",
> -					"ch0", "ch1", "ch2", "ch3",
> -					"ch4", "ch5", "ch6", "ch7",
> -					"ch8", "ch9", "ch10", "ch11",
> -					"ch12";
> -			clocks = <&cpg CPG_MOD 501>;
> -			clock-names = "fck";
> -			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> -			resets = <&cpg 501>;
> -			#dma-cells = <1>;
> -			dma-channels = <13>;
> +		ipmmu_ds: mmu at e6740000 {
> +			compatible = "renesas,ipmmu-r8a7793",
> +				     "renesas,ipmmu-vmsa";
> +			reg = <0 0xe6740000 0 0x1000>;
> +			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
> +			#iommu-cells = <1>;
> +			status = "disabled";
> +		};
> +
> +		ipmmu_mp: mmu at ec680000 {
> +			compatible = "renesas,ipmmu-r8a7793",
> +				     "renesas,ipmmu-vmsa";
> +			reg = <0 0xec680000 0 0x1000>;
> +			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
> +			#iommu-cells = <1>;
> +			status = "disabled";
> +		};
> +
> +		ipmmu_mx: mmu at fe951000 {
> +			compatible = "renesas,ipmmu-r8a7793",
> +				     "renesas,ipmmu-vmsa";
> +			reg = <0 0xfe951000 0 0x1000>;
> +			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
> +			#iommu-cells = <1>;
> +			status = "disabled";
> +		};
> +
> +		ipmmu_rt: mmu at ffc80000 {
> +			compatible = "renesas,ipmmu-r8a7793",
> +				     "renesas,ipmmu-vmsa";
> +			reg = <0 0xffc80000 0 0x1000>;
> +			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
> +			#iommu-cells = <1>;
> +			status = "disabled";
> +		};
> +
> +		ipmmu_gp: mmu at e62a0000 {
> +			compatible = "renesas,ipmmu-r8a7793",
> +				     "renesas,ipmmu-vmsa";
> +			reg = <0 0xe62a0000 0 0x1000>;
> +			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>;
> +			#iommu-cells = <1>;
> +			status = "disabled";
> +		};
> +
> +		icram0:	sram at e63a0000 {
> +			compatible = "mmio-sram";
> +			reg = <0 0xe63a0000 0 0x12000>;
> +		};
> +
> +		icram1:	sram at e63c0000 {
> +			compatible = "mmio-sram";
> +			reg = <0 0xe63c0000 0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0xe63c0000 0x1000>;
> +
> +			smp-sram at 0 {
> +				compatible = "renesas,smp-sram";
> +				reg = <0 0x10>;
> +			};
>  		};
>  
>  		/* The memory map in the User's Manual maps the cores to
> @@ -557,70 +491,86 @@
>  			status = "disabled";
>  		};
>  
> -		pfc: pin-controller at e6060000 {
> -			compatible = "renesas,pfc-r8a7793";
> -			reg = <0 0xe6060000 0 0x250>;
> -		};
> -
> -		sdhi0: sd at ee100000 {
> -			compatible = "renesas,sdhi-r8a7793",
> -				     "renesas,rcar-gen2-sdhi";
> -			reg = <0 0xee100000 0 0x328>;
> -			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cpg CPG_MOD 314>;
> -			dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
> -			       <&dmac1 0xcd>, <&dmac1 0xce>;
> -			dma-names = "tx", "rx", "tx", "rx";
> -			max-frequency = <195000000>;
> -			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> -			resets = <&cpg 314>;
> -			status = "disabled";
> -		};
> -
> -		sdhi1: sd at ee140000 {
> -			compatible = "renesas,sdhi-r8a7793",
> -				     "renesas,rcar-gen2-sdhi";
> -			reg = <0 0xee140000 0 0x100>;
> -			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cpg CPG_MOD 312>;
> -			dmas = <&dmac0 0xc1>, <&dmac0 0xc2>,
> -			       <&dmac1 0xc1>, <&dmac1 0xc2>;
> -			dma-names = "tx", "rx", "tx", "rx";
> -			max-frequency = <97500000>;
> +		dmac0: dma-controller at e6700000 {
> +			compatible = "renesas,dmac-r8a7793",
> +				     "renesas,rcar-dmac";
> +			reg = <0 0xe6700000 0 0x20000>;
> +			interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "error",
> +					  "ch0", "ch1", "ch2", "ch3",
> +					  "ch4", "ch5", "ch6", "ch7",
> +					  "ch8", "ch9", "ch10", "ch11",
> +					  "ch12", "ch13", "ch14";
> +			clocks = <&cpg CPG_MOD 219>;
> +			clock-names = "fck";
>  			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> -			resets = <&cpg 312>;
> -			status = "disabled";
> +			resets = <&cpg 219>;
> +			#dma-cells = <1>;
> +			dma-channels = <15>;
>  		};
>  
> -		sdhi2: sd at ee160000 {
> -			compatible = "renesas,sdhi-r8a7793",
> -				     "renesas,rcar-gen2-sdhi";
> -			reg = <0 0xee160000 0 0x100>;
> -			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cpg CPG_MOD 311>;
> -			dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
> -			       <&dmac1 0xd3>, <&dmac1 0xd4>;
> -			dma-names = "tx", "rx", "tx", "rx";
> -			max-frequency = <97500000>;
> +		dmac1: dma-controller at e6720000 {
> +			compatible = "renesas,dmac-r8a7793",
> +				     "renesas,rcar-dmac";
> +			reg = <0 0xe6720000 0 0x20000>;
> +			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "error",
> +					  "ch0", "ch1", "ch2", "ch3",
> +					  "ch4", "ch5", "ch6", "ch7",
> +					  "ch8", "ch9", "ch10", "ch11",
> +					  "ch12", "ch13", "ch14";
> +			clocks = <&cpg CPG_MOD 218>;
> +			clock-names = "fck";
>  			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> -			resets = <&cpg 311>;
> -			status = "disabled";
> +			resets = <&cpg 218>;
> +			#dma-cells = <1>;
> +			dma-channels = <15>;
>  		};
>  
> -		mmcif0: mmc at ee200000 {
> -			compatible = "renesas,mmcif-r8a7793",
> -				     "renesas,sh-mmcif";
> -			reg = <0 0xee200000 0 0x80>;
> -			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cpg CPG_MOD 315>;
> -			dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
> -			       <&dmac1 0xd1>, <&dmac1 0xd2>;
> +		qspi: spi at e6b10000 {
> +			compatible = "renesas,qspi-r8a7793", "renesas,qspi";
> +			reg = <0 0xe6b10000 0 0x2c>;
> +			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 917>;
> +			dmas = <&dmac0 0x17>, <&dmac0 0x18>,
> +			       <&dmac1 0x17>, <&dmac1 0x18>;
>  			dma-names = "tx", "rx", "tx", "rx";
>  			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> -			resets = <&cpg 315>;
> -			reg-io-width = <4>;
> +			resets = <&cpg 917>;
> +			num-cs = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
>  			status = "disabled";
> -			max-frequency = <97500000>;
>  		};
>  
>  		scifa0: serial at e6c40000 {
> @@ -902,117 +852,6 @@
>  			status = "disabled";
>  		};
>  
> -		icram0:	sram at e63a0000 {
> -			compatible = "mmio-sram";
> -			reg = <0 0xe63a0000 0 0x12000>;
> -		};
> -
> -		icram1:	sram at e63c0000 {
> -			compatible = "mmio-sram";
> -			reg = <0 0xe63c0000 0 0x1000>;
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			ranges = <0 0 0xe63c0000 0x1000>;
> -
> -			smp-sram at 0 {
> -				compatible = "renesas,smp-sram";
> -				reg = <0 0x10>;
> -			};
> -		};
> -
> -		ether: ethernet at ee700000 {
> -			compatible = "renesas,ether-r8a7793",
> -				     "renesas,rcar-gen2-ether";
> -			reg = <0 0xee700000 0 0x400>;
> -			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cpg CPG_MOD 813>;
> -			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> -			resets = <&cpg 813>;
> -			phy-mode = "rmii";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			status = "disabled";
> -		};
> -
> -		vin0: video at e6ef0000 {
> -			compatible = "renesas,vin-r8a7793",
> -				     "renesas,rcar-gen2-vin";
> -			reg = <0 0xe6ef0000 0 0x1000>;
> -			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cpg CPG_MOD 811>;
> -			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> -			resets = <&cpg 811>;
> -			status = "disabled";
> -		};
> -
> -		vin1: video at e6ef1000 {
> -			compatible = "renesas,vin-r8a7793",
> -				     "renesas,rcar-gen2-vin";
> -			reg = <0 0xe6ef1000 0 0x1000>;
> -			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cpg CPG_MOD 810>;
> -			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> -			resets = <&cpg 810>;
> -			status = "disabled";
> -		};
> -
> -		vin2: video at e6ef2000 {
> -			compatible = "renesas,vin-r8a7793",
> -				     "renesas,rcar-gen2-vin";
> -			reg = <0 0xe6ef2000 0 0x1000>;
> -			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cpg CPG_MOD 809>;
> -			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> -			resets = <&cpg 809>;
> -			status = "disabled";
> -		};
> -
> -		qspi: spi at e6b10000 {
> -			compatible = "renesas,qspi-r8a7793", "renesas,qspi";
> -			reg = <0 0xe6b10000 0 0x2c>;
> -			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cpg CPG_MOD 917>;
> -			dmas = <&dmac0 0x17>, <&dmac0 0x18>,
> -			       <&dmac1 0x17>, <&dmac1 0x18>;
> -			dma-names = "tx", "rx", "tx", "rx";
> -			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> -			resets = <&cpg 917>;
> -			num-cs = <1>;
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			status = "disabled";
> -		};
> -
> -		du: display at feb00000 {
> -			compatible = "renesas,du-r8a7793";
> -			reg = <0 0xfeb00000 0 0x40000>,
> -			      <0 0xfeb90000 0 0x1c>;
> -			reg-names = "du", "lvds.0";
> -			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cpg CPG_MOD 724>,
> -				 <&cpg CPG_MOD 723>,
> -				 <&cpg CPG_MOD 726>;
> -			clock-names = "du.0", "du.1", "lvds.0";
> -			status = "disabled";
> -
> -			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port at 0 {
> -					reg = <0>;
> -					du_out_rgb: endpoint {
> -					};
> -				};
> -				port at 1 {
> -					reg = <1>;
> -					du_out_lvds0: endpoint {
> -					};
> -				};
> -			};
> -		};
> -
>  		can0: can at e6e80000 {
>  			compatible = "renesas,can-r8a7793",
>  				     "renesas,rcar-gen2-can";
> @@ -1039,86 +878,36 @@
>  			status = "disabled";
>  		};
>  
> -		rst: reset-controller at e6160000 {
> -			compatible = "renesas,r8a7793-rst";
> -			reg = <0 0xe6160000 0 0x0100>;
> -		};
> -
> -		prr: chipid at ff000044 {
> -			compatible = "renesas,prr";
> -			reg = <0 0xff000044 0 4>;
> -		};
> -
> -		sysc: system-controller at e6180000 {
> -			compatible = "renesas,r8a7793-sysc";
> -			reg = <0 0xe6180000 0 0x0200>;
> -			#power-domain-cells = <1>;
> -		};
> -
> -		ipmmu_sy0: mmu at e6280000 {
> -			compatible = "renesas,ipmmu-r8a7793",
> -				     "renesas,ipmmu-vmsa";
> -			reg = <0 0xe6280000 0 0x1000>;
> -			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
> -			#iommu-cells = <1>;
> -			status = "disabled";
> -		};
> -
> -		ipmmu_sy1: mmu at e6290000 {
> -			compatible = "renesas,ipmmu-r8a7793",
> -				     "renesas,ipmmu-vmsa";
> -			reg = <0 0xe6290000 0 0x1000>;
> -			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
> -			#iommu-cells = <1>;
> -			status = "disabled";
> -		};
> -
> -		ipmmu_ds: mmu at e6740000 {
> -			compatible = "renesas,ipmmu-r8a7793",
> -				     "renesas,ipmmu-vmsa";
> -			reg = <0 0xe6740000 0 0x1000>;
> -			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
> -			#iommu-cells = <1>;
> -			status = "disabled";
> -		};
> -
> -		ipmmu_mp: mmu at ec680000 {
> -			compatible = "renesas,ipmmu-r8a7793",
> -				     "renesas,ipmmu-vmsa";
> -			reg = <0 0xec680000 0 0x1000>;
> -			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
> -			#iommu-cells = <1>;
> -			status = "disabled";
> -		};
> -
> -		ipmmu_mx: mmu at fe951000 {
> -			compatible = "renesas,ipmmu-r8a7793",
> -				     "renesas,ipmmu-vmsa";
> -			reg = <0 0xfe951000 0 0x1000>;
> -			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
> -			#iommu-cells = <1>;
> +		vin0: video at e6ef0000 {
> +			compatible = "renesas,vin-r8a7793",
> +				     "renesas,rcar-gen2-vin";
> +			reg = <0 0xe6ef0000 0 0x1000>;
> +			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 811>;
> +			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> +			resets = <&cpg 811>;
>  			status = "disabled";
>  		};
>  
> -		ipmmu_rt: mmu at ffc80000 {
> -			compatible = "renesas,ipmmu-r8a7793",
> -				     "renesas,ipmmu-vmsa";
> -			reg = <0 0xffc80000 0 0x1000>;
> -			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
> -			#iommu-cells = <1>;
> +		vin1: video at e6ef1000 {
> +			compatible = "renesas,vin-r8a7793",
> +				     "renesas,rcar-gen2-vin";
> +			reg = <0 0xe6ef1000 0 0x1000>;
> +			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 810>;
> +			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> +			resets = <&cpg 810>;
>  			status = "disabled";
>  		};
>  
> -		ipmmu_gp: mmu at e62a0000 {
> -			compatible = "renesas,ipmmu-r8a7793",
> -				     "renesas,ipmmu-vmsa";
> -			reg = <0 0xe62a0000 0 0x1000>;
> -			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>;
> -			#iommu-cells = <1>;
> +		vin2: video at e6ef2000 {
> +			compatible = "renesas,vin-r8a7793",
> +				     "renesas,rcar-gen2-vin";
> +			reg = <0 0xe6ef2000 0 0x1000>;
> +			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 809>;
> +			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> +			resets = <&cpg 809>;
>  			status = "disabled";
>  		};
>  
> @@ -1153,14 +942,14 @@
>  				 <&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>,
>  				 <&cpg CPG_CORE R8A7793_CLK_M2>;
>  			clock-names = "ssi-all",
> -					"ssi.9", "ssi.8", "ssi.7", "ssi.6",
> -					"ssi.5", "ssi.4", "ssi.3", "ssi.2",
> -					"ssi.1", "ssi.0",
> -					"src.9", "src.8", "src.7", "src.6",
> -					"src.5", "src.4", "src.3", "src.2",
> -					"src.1", "src.0",
> -					"dvc.0", "dvc.1",
> -					"clk_a", "clk_b", "clk_c", "clk_i";
> +				      "ssi.9", "ssi.8", "ssi.7", "ssi.6",
> +				      "ssi.5", "ssi.4", "ssi.3", "ssi.2",
> +				      "ssi.1", "ssi.0",
> +				      "src.9", "src.8", "src.7", "src.6",
> +				      "src.5", "src.4", "src.3", "src.2",
> +				      "src.1", "src.0",
> +				      "dvc.0", "dvc.1",
> +				      "clk_a", "clk_b", "clk_c", "clk_i";
>  			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
>  			resets = <&cpg 1005>,
>  				 <&cpg 1006>, <&cpg 1007>,
> @@ -1303,15 +1092,226 @@
>  			};
>  		};
>  
> -		/* Special CPG clocks */
> -		cpg: clock-controller at e6150000 {
> -			compatible = "renesas,r8a7793-cpg-mssr";
> -			reg = <0 0xe6150000 0 0x1000>;
> -			clocks = <&extal_clk>, <&usb_extal_clk>;
> -			clock-names = "extal", "usb_extal";
> -			#clock-cells = <2>;
> -			#power-domain-cells = <0>;
> -			#reset-cells = <1>;
> +		audma0: dma-controller at ec700000 {
> +			compatible = "renesas,dmac-r8a7793",
> +				     "renesas,rcar-dmac";
> +			reg = <0 0xec700000 0 0x10000>;
> +			interrupts = <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "error",
> +					  "ch0", "ch1", "ch2", "ch3",
> +					  "ch4", "ch5", "ch6", "ch7",
> +					  "ch8", "ch9", "ch10", "ch11",
> +					  "ch12";
> +			clocks = <&cpg CPG_MOD 502>;
> +			clock-names = "fck";
> +			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> +			resets = <&cpg 502>;
> +			#dma-cells = <1>;
> +			dma-channels = <13>;
> +		};
> +
> +		audma1: dma-controller at ec720000 {
> +			compatible = "renesas,dmac-r8a7793",
> +				     "renesas,rcar-dmac";
> +			reg = <0 0xec720000 0 0x10000>;
> +			interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH
> +				      GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "error",
> +					  "ch0", "ch1", "ch2", "ch3",
> +					  "ch4", "ch5", "ch6", "ch7",
> +					  "ch8", "ch9", "ch10", "ch11",
> +					  "ch12";
> +			clocks = <&cpg CPG_MOD 501>;
> +			clock-names = "fck";
> +			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> +			resets = <&cpg 501>;
> +			#dma-cells = <1>;
> +			dma-channels = <13>;
> +		};
> +
> +		sdhi0: sd at ee100000 {
> +			compatible = "renesas,sdhi-r8a7793",
> +				     "renesas,rcar-gen2-sdhi";
> +			reg = <0 0xee100000 0 0x328>;
> +			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 314>;
> +			dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
> +			       <&dmac1 0xcd>, <&dmac1 0xce>;
> +			dma-names = "tx", "rx", "tx", "rx";
> +			max-frequency = <195000000>;
> +			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> +			resets = <&cpg 314>;
> +			status = "disabled";
> +		};
> +
> +		sdhi1: sd at ee140000 {
> +			compatible = "renesas,sdhi-r8a7793",
> +				     "renesas,rcar-gen2-sdhi";
> +			reg = <0 0xee140000 0 0x100>;
> +			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 312>;
> +			dmas = <&dmac0 0xc1>, <&dmac0 0xc2>,
> +			       <&dmac1 0xc1>, <&dmac1 0xc2>;
> +			dma-names = "tx", "rx", "tx", "rx";
> +			max-frequency = <97500000>;
> +			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> +			resets = <&cpg 312>;
> +			status = "disabled";
> +		};
> +
> +		sdhi2: sd at ee160000 {
> +			compatible = "renesas,sdhi-r8a7793",
> +				     "renesas,rcar-gen2-sdhi";
> +			reg = <0 0xee160000 0 0x100>;
> +			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 311>;
> +			dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
> +			       <&dmac1 0xd3>, <&dmac1 0xd4>;
> +			dma-names = "tx", "rx", "tx", "rx";
> +			max-frequency = <97500000>;
> +			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> +			resets = <&cpg 311>;
> +			status = "disabled";
> +		};
> +
> +		mmcif0: mmc at ee200000 {
> +			compatible = "renesas,mmcif-r8a7793",
> +				     "renesas,sh-mmcif";
> +			reg = <0 0xee200000 0 0x80>;
> +			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 315>;
> +			dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
> +			       <&dmac1 0xd1>, <&dmac1 0xd2>;
> +			dma-names = "tx", "rx", "tx", "rx";
> +			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> +			resets = <&cpg 315>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +			max-frequency = <97500000>;
> +		};
> +
> +		ether: ethernet at ee700000 {
> +			compatible = "renesas,ether-r8a7793",
> +				     "renesas,rcar-gen2-ether";
> +			reg = <0 0xee700000 0 0x400>;
> +			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 813>;
> +			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> +			resets = <&cpg 813>;
> +			phy-mode = "rmii";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		gic: interrupt-controller at f1001000 {
> +			compatible = "arm,gic-400";
> +			#interrupt-cells = <3>;
> +			#address-cells = <0>;
> +			interrupt-controller;
> +			reg = <0 0xf1001000 0 0x1000>,
> +				<0 0xf1002000 0 0x2000>,
> +				<0 0xf1004000 0 0x2000>,
> +				<0 0xf1006000 0 0x2000>;
> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
> +			clocks = <&cpg CPG_MOD 408>;
> +			clock-names = "clk";
> +			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> +			resets = <&cpg 408>;
> +		};
> +
> +		du: display at feb00000 {
> +			compatible = "renesas,du-r8a7793";
> +			reg = <0 0xfeb00000 0 0x40000>,
> +			      <0 0xfeb90000 0 0x1c>;
> +			reg-names = "du", "lvds.0";
> +			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 724>,
> +				 <&cpg CPG_MOD 723>,
> +				 <&cpg CPG_MOD 726>;
> +			clock-names = "du.0", "du.1", "lvds.0";
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port at 0 {
> +					reg = <0>;
> +					du_out_rgb: endpoint {
> +					};
> +				};
> +				port at 1 {
> +					reg = <1>;
> +					du_out_lvds0: endpoint {
> +					};
> +				};
> +			};
> +		};
> +
> +		prr: chipid at ff000044 {
> +			compatible = "renesas,prr";
> +			reg = <0 0xff000044 0 4>;
> +		};
> +
> +		cmt0: timer at ffca0000 {
> +			compatible = "renesas,r8a7793-cmt0",
> +				     "renesas,rcar-gen2-cmt0";
> +			reg = <0 0xffca0000 0 0x1004>;
> +			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 124>;
> +			clock-names = "fck";
> +			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> +			resets = <&cpg 124>;
> +
> +			status = "disabled";
> +		};
> +
> +		cmt1: timer at e6130000 {
> +			compatible = "renesas,r8a7793-cmt1",
> +				     "renesas,rcar-gen2-cmt1";
> +			reg = <0 0xe6130000 0 0x1004>;
> +			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 329>;
> +			clock-names = "fck";
> +			power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
> +			resets = <&cpg 329>;
> +
> +			status = "disabled";
>  		};
>  	};
>  
> -- 
> 2.11.0
> 

-- 
Regards,
Niklas S?derlund
