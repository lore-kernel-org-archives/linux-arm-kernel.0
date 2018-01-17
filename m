From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 17 Jan 2018 17:17:16 +0100
Subject: [PATCH v2 15/16] ARM: dts: r8a7794: sort subnodes of soc node
In-Reply-To: <20180117161717.14589-1-horms+renesas@verge.net.au>
References: <20180117161717.14589-1-horms+renesas@verge.net.au>
Message-ID: <20180117161717.14589-16-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort the subnodes of the soc node to improve maintainability.
The sort key is the address on the bus with instances of the same
IP block grouped together.

This patch should not introduce any functional change.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v2
* New patch
---
 arch/arm/boot/dts/r8a7794.dtsi | 1525 ++++++++++++++++++++--------------------
 1 file changed, 762 insertions(+), 763 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 0d65069b1a89..9e5f886f53c5 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -74,28 +74,6 @@
 		#size-cells = <2>;
 		ranges;
 
-		apmu at e6151000 {
-			compatible = "renesas,r8a7794-apmu", "renesas,apmu";
-			reg = <0 0xe6151000 0 0x188>;
-			cpus = <&cpu0 &cpu1>;
-		};
-
-		gic: interrupt-controller at f1001000 {
-			compatible = "arm,gic-400";
-			#interrupt-cells = <3>;
-			#address-cells = <0>;
-			interrupt-controller;
-			reg = <0 0xf1001000 0 0x1000>,
-			      <0 0xf1002000 0 0x2000>,
-			      <0 0xf1004000 0 0x2000>,
-			      <0 0xf1006000 0 0x2000>;
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
-			clocks = <&cpg CPG_MOD 408>;
-			clock-names = "clk";
-			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 408>;
-		};
-
 		gpio0: gpio at e6050000 {
 			compatible = "renesas,gpio-r8a7794",
 				     "renesas,rcar-gen2-gpio";
@@ -201,38 +179,36 @@
 			resets = <&cpg 905>;
 		};
 
-		cmt0: timer at ffca0000 {
-			compatible = "renesas,r8a7794-cmt0",
-				     "renesas,rcar-gen2-cmt0";
-			reg = <0 0xffca0000 0 0x1004>;
-			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 124>;
-			clock-names = "fck";
-			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 124>;
+		pfc: pin-controller at e6060000 {
+			compatible = "renesas,pfc-r8a7794";
+			reg = <0 0xe6060000 0 0x11c>;
+		};
 
-			status = "disabled";
+		cpg: clock-controller at e6150000 {
+			compatible = "renesas,r8a7794-cpg-mssr";
+			reg = <0 0xe6150000 0 0x1000>;
+			clocks = <&extal_clk>, <&usb_extal_clk>;
+			clock-names = "extal", "usb_extal";
+			#clock-cells = <2>;
+			#power-domain-cells = <0>;
+			#reset-cells = <1>;
 		};
 
-		cmt1: timer at e6130000 {
-			compatible = "renesas,r8a7794-cmt1",
-				     "renesas,rcar-gen2-cmt1";
-			reg = <0 0xe6130000 0 0x1004>;
-			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 329>;
-			clock-names = "fck";
-			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 329>;
+		apmu at e6151000 {
+			compatible = "renesas,r8a7794-apmu", "renesas,apmu";
+			reg = <0 0xe6151000 0 0x188>;
+			cpus = <&cpu0 &cpu1>;
+		};
 
-			status = "disabled";
+		rst: reset-controller at e6160000 {
+			compatible = "renesas,r8a7794-rst";
+			reg = <0 0xe6160000 0 0x0100>;
+		};
+
+		sysc: system-controller at e6180000 {
+			compatible = "renesas,r8a7794-sysc";
+			reg = <0 0xe6180000 0 0x0200>;
+			#power-domain-cells = <1>;
 		};
 
 		irqc0: interrupt-controller at e61c0000 {
@@ -255,419 +231,303 @@
 			resets = <&cpg 407>;
 		};
 
-		pfc: pin-controller at e6060000 {
-			compatible = "renesas,pfc-r8a7794";
-			reg = <0 0xe6060000 0 0x11c>;
+		ipmmu_sy0: mmu at e6280000 {
+			compatible = "renesas,ipmmu-r8a7794",
+				     "renesas,ipmmu-vmsa";
+			reg = <0 0xe6280000 0 0x1000>;
+			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
 		};
 
-		dmac0: dma-controller at e6700000 {
-			compatible = "renesas,dmac-r8a7794",
-				     "renesas,rcar-dmac";
-			reg = <0 0xe6700000 0 0x20000>;
-			interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "error",
-					  "ch0", "ch1", "ch2", "ch3",
-					  "ch4", "ch5", "ch6", "ch7",
-					  "ch8", "ch9", "ch10", "ch11",
-					  "ch12", "ch13", "ch14";
-			clocks = <&cpg CPG_MOD 219>;
-			clock-names = "fck";
-			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 219>;
-			#dma-cells = <1>;
-			dma-channels = <15>;
+		ipmmu_sy1: mmu at e6290000 {
+			compatible = "renesas,ipmmu-r8a7794",
+				     "renesas,ipmmu-vmsa";
+			reg = <0 0xe6290000 0 0x1000>;
+			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
 		};
 
-		dmac1: dma-controller at e6720000 {
-			compatible = "renesas,dmac-r8a7794",
-				     "renesas,rcar-dmac";
-			reg = <0 0xe6720000 0 0x20000>;
-			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "error",
-					  "ch0", "ch1", "ch2", "ch3",
-					  "ch4", "ch5", "ch6", "ch7",
-					  "ch8", "ch9", "ch10", "ch11",
-					  "ch12", "ch13", "ch14";
-			clocks = <&cpg CPG_MOD 218>;
-			clock-names = "fck";
-			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 218>;
-			#dma-cells = <1>;
-			dma-channels = <15>;
+		ipmmu_ds: mmu at e6740000 {
+			compatible = "renesas,ipmmu-r8a7794",
+				     "renesas,ipmmu-vmsa";
+			reg = <0 0xe6740000 0 0x1000>;
+			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
 		};
 
-		audma0: dma-controller at ec700000 {
-			compatible = "renesas,dmac-r8a7794",
-				     "renesas,rcar-dmac";
-			reg = <0 0xec700000 0 0x10000>;
-			interrupts = <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "error",
-					  "ch0", "ch1", "ch2", "ch3", "ch4",
-					  "ch5", "ch6", "ch7", "ch8", "ch9",
-					  "ch10", "ch11",
-					  "ch12";
-			clocks = <&cpg CPG_MOD 502>;
-			clock-names = "fck";
-			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 502>;
-			#dma-cells = <1>;
-			dma-channels = <13>;
+		ipmmu_mp: mmu at ec680000 {
+			compatible = "renesas,ipmmu-r8a7794",
+				     "renesas,ipmmu-vmsa";
+			reg = <0 0xec680000 0 0x1000>;
+			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
 		};
 
-		scifa0: serial at e6c40000 {
-			compatible = "renesas,scifa-r8a7794",
-				     "renesas,rcar-gen2-scifa", "renesas,scifa";
-			reg = <0 0xe6c40000 0 64>;
-			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 204>;
-			clock-names = "fck";
-			dmas = <&dmac0 0x21>, <&dmac0 0x22>,
-			       <&dmac1 0x21>, <&dmac1 0x22>;
-			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 204>;
+		ipmmu_mx: mmu at fe951000 {
+			compatible = "renesas,ipmmu-r8a7794",
+				     "renesas,ipmmu-vmsa";
+			reg = <0 0xfe951000 0 0x1000>;
+			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
 			status = "disabled";
 		};
 
-		scifa1: serial at e6c50000 {
-			compatible = "renesas,scifa-r8a7794",
-				     "renesas,rcar-gen2-scifa", "renesas,scifa";
-			reg = <0 0xe6c50000 0 64>;
-			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 203>;
-			clock-names = "fck";
-			dmas = <&dmac0 0x25>, <&dmac0 0x26>,
-			       <&dmac1 0x25>, <&dmac1 0x26>;
-			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 203>;
+		ipmmu_gp: mmu at e62a0000 {
+			compatible = "renesas,ipmmu-r8a7794",
+				     "renesas,ipmmu-vmsa";
+			reg = <0 0xe62a0000 0 0x1000>;
+			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
 			status = "disabled";
 		};
 
-		scifa2: serial at e6c60000 {
-			compatible = "renesas,scifa-r8a7794",
-				     "renesas,rcar-gen2-scifa", "renesas,scifa";
-			reg = <0 0xe6c60000 0 64>;
-			interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 202>;
-			clock-names = "fck";
-			dmas = <&dmac0 0x27>, <&dmac0 0x28>,
-			       <&dmac1 0x27>, <&dmac1 0x28>;
-			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 202>;
-			status = "disabled";
+		icram0:	sram at e63a0000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe63a0000 0 0x12000>;
 		};
 
-		scifa3: serial at e6c70000 {
-			compatible = "renesas,scifa-r8a7794",
-				     "renesas,rcar-gen2-scifa", "renesas,scifa";
-			reg = <0 0xe6c70000 0 64>;
-			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 1106>;
-			clock-names = "fck";
-			dmas = <&dmac0 0x1b>, <&dmac0 0x1c>,
-			       <&dmac1 0x1b>, <&dmac1 0x1c>;
-			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 1106>;
-			status = "disabled";
+		icram1:	sram at e63c0000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe63c0000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0xe63c0000 0x1000>;
+
+			smp-sram at 0 {
+				compatible = "renesas,smp-sram";
+				reg = <0 0x10>;
+			};
 		};
 
-		scifa4: serial at e6c78000 {
-			compatible = "renesas,scifa-r8a7794",
-				     "renesas,rcar-gen2-scifa", "renesas,scifa";
-			reg = <0 0xe6c78000 0 64>;
-			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 1107>;
-			clock-names = "fck";
-			dmas = <&dmac0 0x1f>, <&dmac0 0x20>,
-			       <&dmac1 0x1f>, <&dmac1 0x20>;
-			dma-names = "tx", "rx", "tx", "rx";
+		/* The memory map in the User's Manual maps the cores to
+		 * bus numbers
+		 */
+		i2c0: i2c at e6508000 {
+			compatible = "renesas,i2c-r8a7794",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6508000 0 0x40>;
+			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 931>;
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 1107>;
+			resets = <&cpg 931>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
 
-		scifa5: serial at e6c80000 {
-			compatible = "renesas,scifa-r8a7794",
-				     "renesas,rcar-gen2-scifa", "renesas,scifa";
-			reg = <0 0xe6c80000 0 64>;
-			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 1108>;
-			clock-names = "fck";
-			dmas = <&dmac0 0x23>, <&dmac0 0x24>,
-			       <&dmac1 0x23>, <&dmac1 0x24>;
-			dma-names = "tx", "rx", "tx", "rx";
+		i2c1: i2c at e6518000 {
+			compatible = "renesas,i2c-r8a7794",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6518000 0 0x40>;
+			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 930>;
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 1108>;
+			resets = <&cpg 930>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
 
-		scifb0: serial at e6c20000 {
-			compatible = "renesas,scifb-r8a7794",
-				     "renesas,rcar-gen2-scifb", "renesas,scifb";
-			reg = <0 0xe6c20000 0 0x100>;
-			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 206>;
-			clock-names = "fck";
-			dmas = <&dmac0 0x3d>, <&dmac0 0x3e>,
-			       <&dmac1 0x3d>, <&dmac1 0x3e>;
-			dma-names = "tx", "rx", "tx", "rx";
+		i2c2: i2c at e6530000 {
+			compatible = "renesas,i2c-r8a7794",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6530000 0 0x40>;
+			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 929>;
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 206>;
+			resets = <&cpg 929>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
 
-		scifb1: serial at e6c30000 {
-			compatible = "renesas,scifb-r8a7794",
-				     "renesas,rcar-gen2-scifb", "renesas,scifb";
-			reg = <0 0xe6c30000 0 0x100>;
-			interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 207>;
-			clock-names = "fck";
-			dmas = <&dmac0 0x19>, <&dmac0 0x1a>,
-			       <&dmac1 0x19>, <&dmac1 0x1a>;
-			dma-names = "tx", "rx", "tx", "rx";
+		i2c3: i2c at e6540000 {
+			compatible = "renesas,i2c-r8a7794",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6540000 0 0x40>;
+			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 928>;
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 207>;
+			resets = <&cpg 928>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
 
-		scifb2: serial at e6ce0000 {
-			compatible = "renesas,scifb-r8a7794",
-				     "renesas,rcar-gen2-scifb", "renesas,scifb";
-			reg = <0 0xe6ce0000 0 0x100>;
-			interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 216>;
-			clock-names = "fck";
-			dmas = <&dmac0 0x1d>, <&dmac0 0x1e>,
-			       <&dmac1 0x1d>, <&dmac1 0x1e>;
-			dma-names = "tx", "rx", "tx", "rx";
+		i2c4: i2c at e6520000 {
+			compatible = "renesas,i2c-r8a7794",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6520000 0 0x40>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 927>;
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 216>;
+			resets = <&cpg 927>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
 
-		scif0: serial at e6e60000 {
-			compatible = "renesas,scif-r8a7794",
-				     "renesas,rcar-gen2-scif",
-				     "renesas,scif";
-			reg = <0 0xe6e60000 0 64>;
-			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 721>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
-				 <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac0 0x29>, <&dmac0 0x2a>,
-			       <&dmac1 0x29>, <&dmac1 0x2a>;
-			dma-names = "tx", "rx", "tx", "rx";
+		i2c5: i2c at e6528000 {
+			compatible = "renesas,i2c-r8a7794",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6528000 0 0x40>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 925>;
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 721>;
+			resets = <&cpg 925>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
 
-		scif1: serial at e6e68000 {
-			compatible = "renesas,scif-r8a7794",
-				     "renesas,rcar-gen2-scif",
-				     "renesas,scif";
-			reg = <0 0xe6e68000 0 64>;
-			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 720>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
-				 <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac0 0x2d>, <&dmac0 0x2e>,
-			       <&dmac1 0x2d>, <&dmac1 0x2e>;
+		i2c6: i2c at e6500000 {
+			compatible = "renesas,iic-r8a7794",
+				     "renesas,rcar-gen2-iic",
+				     "renesas,rmobile-iic";
+			reg = <0 0xe6500000 0 0x425>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 318>;
+			dmas = <&dmac0 0x61>, <&dmac0 0x62>,
+			       <&dmac1 0x61>, <&dmac1 0x62>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 720>;
+			resets = <&cpg 318>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			status = "disabled";
 		};
 
-		scif2: serial at e6e58000 {
-			compatible = "renesas,scif-r8a7794",
-				     "renesas,rcar-gen2-scif", "renesas,scif";
-			reg = <0 0xe6e58000 0 64>;
-			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 719>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
-				 <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac0 0x2b>, <&dmac0 0x2c>,
-			       <&dmac1 0x2b>, <&dmac1 0x2c>;
+		i2c7: i2c at e6510000 {
+			compatible = "renesas,iic-r8a7794",
+				     "renesas,rcar-gen2-iic",
+				     "renesas,rmobile-iic";
+			reg = <0 0xe6510000 0 0x425>;
+			interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 323>;
+			dmas = <&dmac0 0x65>, <&dmac0 0x66>,
+			       <&dmac1 0x65>, <&dmac1 0x66>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 719>;
+			resets = <&cpg 323>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			status = "disabled";
 		};
 
-		scif3: serial at e6ea8000 {
-			compatible = "renesas,scif-r8a7794",
-				     "renesas,rcar-gen2-scif", "renesas,scif";
-			reg = <0 0xe6ea8000 0 64>;
-			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 718>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
-				 <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac0 0x2f>, <&dmac0 0x30>,
-			       <&dmac1 0x2f>, <&dmac1 0x30>;
-			dma-names = "tx", "rx", "tx", "rx";
+		hsusb: usb at e6590000 {
+			compatible = "renesas,usbhs-r8a7794",
+				     "renesas,rcar-gen2-usbhs";
+			reg = <0 0xe6590000 0 0x100>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 704>;
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 718>;
+			resets = <&cpg 704>;
+			renesas,buswait = <4>;
+			phys = <&usb0 1>;
+			phy-names = "usb";
 			status = "disabled";
 		};
 
-		scif4: serial at e6ee0000 {
-			compatible = "renesas,scif-r8a7794",
-				     "renesas,rcar-gen2-scif", "renesas,scif";
-			reg = <0 0xe6ee0000 0 64>;
-			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 715>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
-				 <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac0 0xfb>, <&dmac0 0xfc>,
-			       <&dmac1 0xfb>, <&dmac1 0xfc>;
-			dma-names = "tx", "rx", "tx", "rx";
+		usbphy: usb-phy at e6590100 {
+			compatible = "renesas,usb-phy-r8a7794",
+				     "renesas,rcar-gen2-usb-phy";
+			reg = <0 0xe6590100 0 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cpg CPG_MOD 704>;
+			clock-names = "usbhs";
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 715>;
+			resets = <&cpg 704>;
 			status = "disabled";
+
+			usb0: usb-channel at 0 {
+				reg = <0>;
+				#phy-cells = <1>;
+			};
+			usb2: usb-channel at 2 {
+				reg = <2>;
+				#phy-cells = <1>;
+			};
 		};
 
-		scif5: serial at e6ee8000 {
-			compatible = "renesas,scif-r8a7794",
-				     "renesas,rcar-gen2-scif", "renesas,scif";
-			reg = <0 0xe6ee8000 0 64>;
-			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 714>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
-				 <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac0 0xfd>, <&dmac0 0xfe>,
-			       <&dmac1 0xfd>, <&dmac1 0xfe>;
-			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 714>;
-			status = "disabled";
-		};
-
-		hscif0: serial at e62c0000 {
-			compatible = "renesas,hscif-r8a7794",
-				     "renesas,rcar-gen2-hscif", "renesas,hscif";
-			reg = <0 0xe62c0000 0 96>;
-			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 717>,
-				 <&cpg CPG_CORE R8A7794_CLK_ZS>, <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac0 0x39>, <&dmac0 0x3a>,
-			       <&dmac1 0x39>, <&dmac1 0x3a>;
-			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 717>;
-			status = "disabled";
-		};
-
-		hscif1: serial at e62c8000 {
-			compatible = "renesas,hscif-r8a7794",
-				     "renesas,rcar-gen2-hscif", "renesas,hscif";
-			reg = <0 0xe62c8000 0 96>;
-			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 716>,
-				 <&cpg CPG_CORE R8A7794_CLK_ZS>, <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac0 0x4d>, <&dmac0 0x4e>,
-			       <&dmac1 0x4d>, <&dmac1 0x4e>;
-			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 716>;
-			status = "disabled";
-		};
-
-		hscif2: serial at e62d0000 {
-			compatible = "renesas,hscif-r8a7794",
-				     "renesas,rcar-gen2-hscif", "renesas,hscif";
-			reg = <0 0xe62d0000 0 96>;
-			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 713>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
-				 <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac0 0x3b>, <&dmac0 0x3c>,
-			       <&dmac1 0x3b>, <&dmac1 0x3c>;
-			dma-names = "tx", "rx", "tx", "rx";
+		dmac0: dma-controller at e6700000 {
+			compatible = "renesas,dmac-r8a7794",
+				     "renesas,rcar-dmac";
+			reg = <0 0xe6700000 0 0x20000>;
+			interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14";
+			clocks = <&cpg CPG_MOD 219>;
+			clock-names = "fck";
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 713>;
-			status = "disabled";
-		};
-
-		icram0:	sram at e63a0000 {
-			compatible = "mmio-sram";
-			reg = <0 0xe63a0000 0 0x12000>;
-		};
-
-		icram1:	sram at e63c0000 {
-			compatible = "mmio-sram";
-			reg = <0 0xe63c0000 0 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0 0xe63c0000 0x1000>;
-
-			smp-sram at 0 {
-				compatible = "renesas,smp-sram";
-				reg = <0 0x10>;
-			};
+			resets = <&cpg 219>;
+			#dma-cells = <1>;
+			dma-channels = <15>;
 		};
 
-		ether: ethernet at ee700000 {
-			compatible = "renesas,ether-r8a7794",
-				     "renesas,rcar-gen2-ether";
-			reg = <0 0xee700000 0 0x400>;
-			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 813>;
+		dmac1: dma-controller at e6720000 {
+			compatible = "renesas,dmac-r8a7794",
+				     "renesas,rcar-dmac";
+			reg = <0 0xe6720000 0 0x20000>;
+			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14";
+			clocks = <&cpg CPG_MOD 218>;
+			clock-names = "fck";
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 813>;
-			phy-mode = "rmii";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
+			resets = <&cpg 218>;
+			#dma-cells = <1>;
+			dma-channels = <15>;
 		};
 
 		avb: ethernet at e6800000 {
@@ -683,374 +543,301 @@
 			status = "disabled";
 		};
 
-		/* The memory map in the User's Manual maps the cores to
-		 * bus numbers
-		 */
-		i2c0: i2c at e6508000 {
-			compatible = "renesas,i2c-r8a7794",
-				     "renesas,rcar-gen2-i2c";
-			reg = <0 0xe6508000 0 0x40>;
-			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 931>;
+		qspi: spi at e6b10000 {
+			compatible = "renesas,qspi-r8a7794", "renesas,qspi";
+			reg = <0 0xe6b10000 0 0x2c>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 917>;
+			dmas = <&dmac0 0x17>, <&dmac0 0x18>,
+			       <&dmac1 0x17>, <&dmac1 0x18>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 931>;
+			resets = <&cpg 917>;
+			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
 
-		i2c1: i2c at e6518000 {
-			compatible = "renesas,i2c-r8a7794",
-				     "renesas,rcar-gen2-i2c";
-			reg = <0 0xe6518000 0 0x40>;
-			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 930>;
+		scifa0: serial at e6c40000 {
+			compatible = "renesas,scifa-r8a7794",
+				     "renesas,rcar-gen2-scifa", "renesas,scifa";
+			reg = <0 0xe6c40000 0 64>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 204>;
+			clock-names = "fck";
+			dmas = <&dmac0 0x21>, <&dmac0 0x22>,
+			       <&dmac1 0x21>, <&dmac1 0x22>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 930>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			i2c-scl-internal-delay-ns = <6>;
+			resets = <&cpg 204>;
 			status = "disabled";
 		};
 
-		i2c2: i2c at e6530000 {
-			compatible = "renesas,i2c-r8a7794",
-				     "renesas,rcar-gen2-i2c";
-			reg = <0 0xe6530000 0 0x40>;
-			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 929>;
+		scifa1: serial at e6c50000 {
+			compatible = "renesas,scifa-r8a7794",
+				     "renesas,rcar-gen2-scifa", "renesas,scifa";
+			reg = <0 0xe6c50000 0 64>;
+			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 203>;
+			clock-names = "fck";
+			dmas = <&dmac0 0x25>, <&dmac0 0x26>,
+			       <&dmac1 0x25>, <&dmac1 0x26>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 929>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			i2c-scl-internal-delay-ns = <6>;
+			resets = <&cpg 203>;
 			status = "disabled";
 		};
 
-		i2c3: i2c at e6540000 {
-			compatible = "renesas,i2c-r8a7794",
-				     "renesas,rcar-gen2-i2c";
-			reg = <0 0xe6540000 0 0x40>;
-			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 928>;
+		scifa2: serial at e6c60000 {
+			compatible = "renesas,scifa-r8a7794",
+				     "renesas,rcar-gen2-scifa", "renesas,scifa";
+			reg = <0 0xe6c60000 0 64>;
+			interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 202>;
+			clock-names = "fck";
+			dmas = <&dmac0 0x27>, <&dmac0 0x28>,
+			       <&dmac1 0x27>, <&dmac1 0x28>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 928>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			i2c-scl-internal-delay-ns = <6>;
+			resets = <&cpg 202>;
 			status = "disabled";
 		};
 
-		i2c4: i2c at e6520000 {
-			compatible = "renesas,i2c-r8a7794",
-				     "renesas,rcar-gen2-i2c";
-			reg = <0 0xe6520000 0 0x40>;
-			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 927>;
+		scifa3: serial at e6c70000 {
+			compatible = "renesas,scifa-r8a7794",
+				     "renesas,rcar-gen2-scifa", "renesas,scifa";
+			reg = <0 0xe6c70000 0 64>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 1106>;
+			clock-names = "fck";
+			dmas = <&dmac0 0x1b>, <&dmac0 0x1c>,
+			       <&dmac1 0x1b>, <&dmac1 0x1c>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 927>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			i2c-scl-internal-delay-ns = <6>;
+			resets = <&cpg 1106>;
 			status = "disabled";
 		};
 
-		i2c5: i2c at e6528000 {
-			compatible = "renesas,i2c-r8a7794",
-				     "renesas,rcar-gen2-i2c";
-			reg = <0 0xe6528000 0 0x40>;
-			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 925>;
+		scifa4: serial at e6c78000 {
+			compatible = "renesas,scifa-r8a7794",
+				     "renesas,rcar-gen2-scifa", "renesas,scifa";
+			reg = <0 0xe6c78000 0 64>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 1107>;
+			clock-names = "fck";
+			dmas = <&dmac0 0x1f>, <&dmac0 0x20>,
+			       <&dmac1 0x1f>, <&dmac1 0x20>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 925>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			i2c-scl-internal-delay-ns = <6>;
+			resets = <&cpg 1107>;
 			status = "disabled";
 		};
 
-		i2c6: i2c at e6500000 {
-			compatible = "renesas,iic-r8a7794",
-				     "renesas,rcar-gen2-iic",
-				     "renesas,rmobile-iic";
-			reg = <0 0xe6500000 0 0x425>;
-			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 318>;
-			dmas = <&dmac0 0x61>, <&dmac0 0x62>,
-			       <&dmac1 0x61>, <&dmac1 0x62>;
+		scifa5: serial at e6c80000 {
+			compatible = "renesas,scifa-r8a7794",
+				     "renesas,rcar-gen2-scifa", "renesas,scifa";
+			reg = <0 0xe6c80000 0 64>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 1108>;
+			clock-names = "fck";
+			dmas = <&dmac0 0x23>, <&dmac0 0x24>,
+			       <&dmac1 0x23>, <&dmac1 0x24>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 318>;
-			#address-cells = <1>;
-			#size-cells = <0>;
+			resets = <&cpg 1108>;
 			status = "disabled";
 		};
 
-		i2c7: i2c at e6510000 {
-			compatible = "renesas,iic-r8a7794",
-				     "renesas,rcar-gen2-iic",
-				     "renesas,rmobile-iic";
-			reg = <0 0xe6510000 0 0x425>;
-			interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 323>;
-			dmas = <&dmac0 0x65>, <&dmac0 0x66>,
-			       <&dmac1 0x65>, <&dmac1 0x66>;
+		scifb0: serial at e6c20000 {
+			compatible = "renesas,scifb-r8a7794",
+				     "renesas,rcar-gen2-scifb", "renesas,scifb";
+			reg = <0 0xe6c20000 0 0x100>;
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 206>;
+			clock-names = "fck";
+			dmas = <&dmac0 0x3d>, <&dmac0 0x3e>,
+			       <&dmac1 0x3d>, <&dmac1 0x3e>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 323>;
-			#address-cells = <1>;
-			#size-cells = <0>;
+			resets = <&cpg 206>;
 			status = "disabled";
 		};
 
-		mmcif0: mmc at ee200000 {
-			compatible = "renesas,mmcif-r8a7794",
-				     "renesas,sh-mmcif";
-			reg = <0 0xee200000 0 0x80>;
-			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 315>;
-			dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
-			       <&dmac1 0xd1>, <&dmac1 0xd2>;
+		scifb1: serial at e6c30000 {
+			compatible = "renesas,scifb-r8a7794",
+				     "renesas,rcar-gen2-scifb", "renesas,scifb";
+			reg = <0 0xe6c30000 0 0x100>;
+			interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 207>;
+			clock-names = "fck";
+			dmas = <&dmac0 0x19>, <&dmac0 0x1a>,
+			       <&dmac1 0x19>, <&dmac1 0x1a>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 315>;
-			reg-io-width = <4>;
+			resets = <&cpg 207>;
 			status = "disabled";
 		};
 
-		sdhi0: sd at ee100000 {
-			compatible = "renesas,sdhi-r8a7794",
-				     "renesas,rcar-gen2-sdhi";
-			reg = <0 0xee100000 0 0x328>;
-			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 314>;
-			dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
-			       <&dmac1 0xcd>, <&dmac1 0xce>;
+		scifb2: serial at e6ce0000 {
+			compatible = "renesas,scifb-r8a7794",
+				     "renesas,rcar-gen2-scifb", "renesas,scifb";
+			reg = <0 0xe6ce0000 0 0x100>;
+			interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 216>;
+			clock-names = "fck";
+			dmas = <&dmac0 0x1d>, <&dmac0 0x1e>,
+			       <&dmac1 0x1d>, <&dmac1 0x1e>;
 			dma-names = "tx", "rx", "tx", "rx";
-			max-frequency = <195000000>;
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 314>;
+			resets = <&cpg 216>;
 			status = "disabled";
 		};
 
-		sdhi1: sd at ee140000 {
-			compatible = "renesas,sdhi-r8a7794",
-				     "renesas,rcar-gen2-sdhi";
-			reg = <0 0xee140000 0 0x100>;
-			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 312>;
-			dmas = <&dmac0 0xc1>, <&dmac0 0xc2>,
-			       <&dmac1 0xc1>, <&dmac1 0xc2>;
+		scif0: serial at e6e60000 {
+			compatible = "renesas,scif-r8a7794",
+				     "renesas,rcar-gen2-scif",
+				     "renesas,scif";
+			reg = <0 0xe6e60000 0 64>;
+			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 721>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x29>, <&dmac0 0x2a>,
+			       <&dmac1 0x29>, <&dmac1 0x2a>;
 			dma-names = "tx", "rx", "tx", "rx";
-			max-frequency = <97500000>;
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 312>;
+			resets = <&cpg 721>;
 			status = "disabled";
 		};
 
-		sdhi2: sd at ee160000 {
-			compatible = "renesas,sdhi-r8a7794",
-				     "renesas,rcar-gen2-sdhi";
-			reg = <0 0xee160000 0 0x100>;
-			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 311>;
-			dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
-			       <&dmac1 0xd3>, <&dmac1 0xd4>;
+		scif1: serial at e6e68000 {
+			compatible = "renesas,scif-r8a7794",
+				     "renesas,rcar-gen2-scif",
+				     "renesas,scif";
+			reg = <0 0xe6e68000 0 64>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 720>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x2d>, <&dmac0 0x2e>,
+			       <&dmac1 0x2d>, <&dmac1 0x2e>;
 			dma-names = "tx", "rx", "tx", "rx";
-			max-frequency = <97500000>;
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 311>;
+			resets = <&cpg 720>;
 			status = "disabled";
 		};
 
-		qspi: spi at e6b10000 {
-			compatible = "renesas,qspi-r8a7794", "renesas,qspi";
-			reg = <0 0xe6b10000 0 0x2c>;
-			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 917>;
-			dmas = <&dmac0 0x17>, <&dmac0 0x18>,
-			       <&dmac1 0x17>, <&dmac1 0x18>;
+		scif2: serial at e6e58000 {
+			compatible = "renesas,scif-r8a7794",
+				     "renesas,rcar-gen2-scif", "renesas,scif";
+			reg = <0 0xe6e58000 0 64>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 719>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x2b>, <&dmac0 0x2c>,
+			       <&dmac1 0x2b>, <&dmac1 0x2c>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 917>;
-			num-cs = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
+			resets = <&cpg 719>;
 			status = "disabled";
 		};
 
-		vin0: video at e6ef0000 {
-			compatible = "renesas,vin-r8a7794",
-				     "renesas,rcar-gen2-vin";
-			reg = <0 0xe6ef0000 0 0x1000>;
-			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 811>;
+		scif3: serial at e6ea8000 {
+			compatible = "renesas,scif-r8a7794",
+				     "renesas,rcar-gen2-scif", "renesas,scif";
+			reg = <0 0xe6ea8000 0 64>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 718>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x2f>, <&dmac0 0x30>,
+			       <&dmac1 0x2f>, <&dmac1 0x30>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 811>;
+			resets = <&cpg 718>;
 			status = "disabled";
 		};
 
-		vin1: video at e6ef1000 {
-			compatible = "renesas,vin-r8a7794",
-				     "renesas,rcar-gen2-vin";
-			reg = <0 0xe6ef1000 0 0x1000>;
-			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 810>;
+		scif4: serial at e6ee0000 {
+			compatible = "renesas,scif-r8a7794",
+				     "renesas,rcar-gen2-scif", "renesas,scif";
+			reg = <0 0xe6ee0000 0 64>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 715>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0xfb>, <&dmac0 0xfc>,
+			       <&dmac1 0xfb>, <&dmac1 0xfc>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 810>;
+			resets = <&cpg 715>;
 			status = "disabled";
 		};
 
-		pci0: pci at ee090000 {
-			compatible = "renesas,pci-r8a7794",
-				     "renesas,pci-rcar-gen2";
-			device_type = "pci";
-			reg = <0 0xee090000 0 0xc00>,
-			      <0 0xee080000 0 0x1100>;
-			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
+		scif5: serial at e6ee8000 {
+			compatible = "renesas,scif-r8a7794",
+				     "renesas,rcar-gen2-scif", "renesas,scif";
+			reg = <0 0xe6ee8000 0 64>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 714>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0xfd>, <&dmac0 0xfe>,
+			       <&dmac1 0xfd>, <&dmac1 0xfe>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
+			resets = <&cpg 714>;
 			status = "disabled";
-
-			bus-range = <0 0>;
-			#address-cells = <3>;
-			#size-cells = <2>;
-			#interrupt-cells = <1>;
-			ranges = <0x02000000 0 0xee080000 0 0xee080000 0 0x00010000>;
-			interrupt-map-mask = <0xff00 0 0 0x7>;
-			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
-					 0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
-					 0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-
-			usb at 1,0 {
-				reg = <0x800 0 0 0 0>;
-				phys = <&usb0 0>;
-				phy-names = "usb";
-			};
-
-			usb at 2,0 {
-				reg = <0x1000 0 0 0 0>;
-				phys = <&usb0 0>;
-				phy-names = "usb";
-			};
 		};
 
-		pci1: pci at ee0d0000 {
-			compatible = "renesas,pci-r8a7794",
-				     "renesas,pci-rcar-gen2";
-			device_type = "pci";
-			reg = <0 0xee0d0000 0 0xc00>,
-			      <0 0xee0c0000 0 0x1100>;
-			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
-			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
-			status = "disabled";
-
-			bus-range = <1 1>;
-			#address-cells = <3>;
-			#size-cells = <2>;
-			#interrupt-cells = <1>;
-			ranges = <0x02000000 0 0xee0c0000 0 0xee0c0000 0 0x00010000>;
-			interrupt-map-mask = <0xff00 0 0 0x7>;
-			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
-					 0x0800 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
-					 0x1000 0 0 2 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
-
-			usb at 1,0 {
-				reg = <0x10800 0 0 0 0>;
-				phys = <&usb2 0>;
-				phy-names = "usb";
-			};
-
-			usb at 2,0 {
-				reg = <0x11000 0 0 0 0>;
-				phys = <&usb2 0>;
-				phy-names = "usb";
-			};
-		};
-
-		hsusb: usb at e6590000 {
-			compatible = "renesas,usbhs-r8a7794",
-				     "renesas,rcar-gen2-usbhs";
-			reg = <0 0xe6590000 0 0x100>;
-			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 704>;
+		hscif0: serial at e62c0000 {
+			compatible = "renesas,hscif-r8a7794",
+				     "renesas,rcar-gen2-hscif", "renesas,hscif";
+			reg = <0 0xe62c0000 0 96>;
+			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 717>,
+				 <&cpg CPG_CORE R8A7794_CLK_ZS>, <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x39>, <&dmac0 0x3a>,
+			       <&dmac1 0x39>, <&dmac1 0x3a>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 704>;
-			renesas,buswait = <4>;
-			phys = <&usb0 1>;
-			phy-names = "usb";
+			resets = <&cpg 717>;
 			status = "disabled";
 		};
 
-		usbphy: usb-phy at e6590100 {
-			compatible = "renesas,usb-phy-r8a7794",
-				     "renesas,rcar-gen2-usb-phy";
-			reg = <0 0xe6590100 0 0x100>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			clocks = <&cpg CPG_MOD 704>;
-			clock-names = "usbhs";
+		hscif1: serial at e62c8000 {
+			compatible = "renesas,hscif-r8a7794",
+				     "renesas,rcar-gen2-hscif", "renesas,hscif";
+			reg = <0 0xe62c8000 0 96>;
+			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 716>,
+				 <&cpg CPG_CORE R8A7794_CLK_ZS>, <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x4d>, <&dmac0 0x4e>,
+			       <&dmac1 0x4d>, <&dmac1 0x4e>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 704>;
+			resets = <&cpg 716>;
 			status = "disabled";
-
-			usb0: usb-channel at 0 {
-				reg = <0>;
-				#phy-cells = <1>;
-			};
-			usb2: usb-channel at 2 {
-				reg = <2>;
-				#phy-cells = <1>;
-			};
-		};
-
-		vsp at fe928000 {
-			compatible = "renesas,vsp1";
-			reg = <0 0xfe928000 0 0x8000>;
-			interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 131>;
-			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 131>;
 		};
 
-		vsp at fe930000 {
-			compatible = "renesas,vsp1";
-			reg = <0 0xfe930000 0 0x8000>;
-			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 128>;
+		hscif2: serial at e62d0000 {
+			compatible = "renesas,hscif-r8a7794",
+				     "renesas,rcar-gen2-hscif", "renesas,hscif";
+			reg = <0 0xe62d0000 0 96>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 713>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x3b>, <&dmac0 0x3c>,
+			       <&dmac1 0x3b>, <&dmac1 0x3c>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-			resets = <&cpg 128>;
-		};
-
-		du: display at feb00000 {
-			compatible = "renesas,du-r8a7794";
-			reg = <0 0xfeb00000 0 0x40000>;
-			reg-names = "du";
-			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 724>, <&cpg CPG_MOD 723>;
-			clock-names = "du.0", "du.1";
+			resets = <&cpg 713>;
 			status = "disabled";
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port at 0 {
-					reg = <0>;
-					du_out_rgb0: endpoint {
-					};
-				};
-				port at 1 {
-					reg = <1>;
-					du_out_rgb1: endpoint {
-					};
-				};
-			};
 		};
 
 		can0: can at e6e80000 {
@@ -1079,87 +866,25 @@
 			status = "disabled";
 		};
 
-		cpg: clock-controller at e6150000 {
-			compatible = "renesas,r8a7794-cpg-mssr";
-			reg = <0 0xe6150000 0 0x1000>;
-			clocks = <&extal_clk>, <&usb_extal_clk>;
-			clock-names = "extal", "usb_extal";
-			#clock-cells = <2>;
-			#power-domain-cells = <0>;
-			#reset-cells = <1>;
-		};
-
-		rst: reset-controller at e6160000 {
-			compatible = "renesas,r8a7794-rst";
-			reg = <0 0xe6160000 0 0x0100>;
-		};
-
-		prr: chipid at ff000044 {
-			compatible = "renesas,prr";
-			reg = <0 0xff000044 0 4>;
-		};
-
-		sysc: system-controller at e6180000 {
-			compatible = "renesas,r8a7794-sysc";
-			reg = <0 0xe6180000 0 0x0200>;
-			#power-domain-cells = <1>;
-		};
-
-		ipmmu_sy0: mmu at e6280000 {
-			compatible = "renesas,ipmmu-r8a7794",
-				     "renesas,ipmmu-vmsa";
-			reg = <0 0xe6280000 0 0x1000>;
-			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
-			#iommu-cells = <1>;
-			status = "disabled";
-		};
-
-		ipmmu_sy1: mmu at e6290000 {
-			compatible = "renesas,ipmmu-r8a7794",
-				     "renesas,ipmmu-vmsa";
-			reg = <0 0xe6290000 0 0x1000>;
-			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
-			#iommu-cells = <1>;
-			status = "disabled";
-		};
-
-		ipmmu_ds: mmu at e6740000 {
-			compatible = "renesas,ipmmu-r8a7794",
-				     "renesas,ipmmu-vmsa";
-			reg = <0 0xe6740000 0 0x1000>;
-			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
-			#iommu-cells = <1>;
-			status = "disabled";
-		};
-
-		ipmmu_mp: mmu at ec680000 {
-			compatible = "renesas,ipmmu-r8a7794",
-				     "renesas,ipmmu-vmsa";
-			reg = <0 0xec680000 0 0x1000>;
-			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
-			#iommu-cells = <1>;
-			status = "disabled";
-		};
-
-		ipmmu_mx: mmu at fe951000 {
-			compatible = "renesas,ipmmu-r8a7794",
-				     "renesas,ipmmu-vmsa";
-			reg = <0 0xfe951000 0 0x1000>;
-			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
-			#iommu-cells = <1>;
+		vin0: video at e6ef0000 {
+			compatible = "renesas,vin-r8a7794",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef0000 0 0x1000>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 811>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 811>;
 			status = "disabled";
 		};
 
-		ipmmu_gp: mmu at e62a0000 {
-			compatible = "renesas,ipmmu-r8a7794",
-				     "renesas,ipmmu-vmsa";
-			reg = <0 0xe62a0000 0 0x1000>;
-			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>;
-			#iommu-cells = <1>;
+		vin1: video at e6ef1000 {
+			compatible = "renesas,vin-r8a7794",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef1000 0 0x1000>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 810>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 810>;
 			status = "disabled";
 		};
 
@@ -1343,6 +1068,281 @@
 				};
 			};
 		};
+
+		audma0: dma-controller at ec700000 {
+			compatible = "renesas,dmac-r8a7794",
+				     "renesas,rcar-dmac";
+			reg = <0 0xec700000 0 0x10000>;
+			interrupts = <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					  "ch0", "ch1", "ch2", "ch3", "ch4",
+					  "ch5", "ch6", "ch7", "ch8", "ch9",
+					  "ch10", "ch11",
+					  "ch12";
+			clocks = <&cpg CPG_MOD 502>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 502>;
+			#dma-cells = <1>;
+			dma-channels = <13>;
+		};
+
+		pci0: pci at ee090000 {
+			compatible = "renesas,pci-r8a7794",
+				     "renesas,pci-rcar-gen2";
+			device_type = "pci";
+			reg = <0 0xee090000 0 0xc00>,
+			      <0 0xee080000 0 0x1100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 703>;
+			status = "disabled";
+
+			bus-range = <0 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges = <0x02000000 0 0xee080000 0 0xee080000 0 0x00010000>;
+			interrupt-map-mask = <0xff00 0 0 0x7>;
+			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
+					 0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
+					 0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+
+			usb at 1,0 {
+				reg = <0x800 0 0 0 0>;
+				phys = <&usb0 0>;
+				phy-names = "usb";
+			};
+
+			usb at 2,0 {
+				reg = <0x1000 0 0 0 0>;
+				phys = <&usb0 0>;
+				phy-names = "usb";
+			};
+		};
+
+		pci1: pci at ee0d0000 {
+			compatible = "renesas,pci-r8a7794",
+				     "renesas,pci-rcar-gen2";
+			device_type = "pci";
+			reg = <0 0xee0d0000 0 0xc00>,
+			      <0 0xee0c0000 0 0x1100>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 703>;
+			status = "disabled";
+
+			bus-range = <1 1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges = <0x02000000 0 0xee0c0000 0 0xee0c0000 0 0x00010000>;
+			interrupt-map-mask = <0xff00 0 0 0x7>;
+			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
+					 0x0800 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
+					 0x1000 0 0 2 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+
+			usb at 1,0 {
+				reg = <0x10800 0 0 0 0>;
+				phys = <&usb2 0>;
+				phy-names = "usb";
+			};
+
+			usb at 2,0 {
+				reg = <0x11000 0 0 0 0>;
+				phys = <&usb2 0>;
+				phy-names = "usb";
+			};
+		};
+
+		sdhi0: sd at ee100000 {
+			compatible = "renesas,sdhi-r8a7794",
+				     "renesas,rcar-gen2-sdhi";
+			reg = <0 0xee100000 0 0x328>;
+			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 314>;
+			dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
+			       <&dmac1 0xcd>, <&dmac1 0xce>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <195000000>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 314>;
+			status = "disabled";
+		};
+
+		sdhi1: sd at ee140000 {
+			compatible = "renesas,sdhi-r8a7794",
+				     "renesas,rcar-gen2-sdhi";
+			reg = <0 0xee140000 0 0x100>;
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 312>;
+			dmas = <&dmac0 0xc1>, <&dmac0 0xc2>,
+			       <&dmac1 0xc1>, <&dmac1 0xc2>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <97500000>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 312>;
+			status = "disabled";
+		};
+
+		sdhi2: sd at ee160000 {
+			compatible = "renesas,sdhi-r8a7794",
+				     "renesas,rcar-gen2-sdhi";
+			reg = <0 0xee160000 0 0x100>;
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 311>;
+			dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
+			       <&dmac1 0xd3>, <&dmac1 0xd4>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <97500000>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 311>;
+			status = "disabled";
+		};
+
+		mmcif0: mmc at ee200000 {
+			compatible = "renesas,mmcif-r8a7794",
+				     "renesas,sh-mmcif";
+			reg = <0 0xee200000 0 0x80>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 315>;
+			dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
+			       <&dmac1 0xd1>, <&dmac1 0xd2>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 315>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		ether: ethernet at ee700000 {
+			compatible = "renesas,ether-r8a7794",
+				     "renesas,rcar-gen2-ether";
+			reg = <0 0xee700000 0 0x400>;
+			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 813>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 813>;
+			phy-mode = "rmii";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller at f1001000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0 0xf1001000 0 0x1000>,
+			      <0 0xf1002000 0 0x2000>,
+			      <0 0xf1004000 0 0x2000>,
+			      <0 0xf1006000 0 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&cpg CPG_MOD 408>;
+			clock-names = "clk";
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 408>;
+		};
+
+		vsp at fe928000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe928000 0 0x8000>;
+			interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 131>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 131>;
+		};
+
+		vsp at fe930000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe930000 0 0x8000>;
+			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 128>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 128>;
+		};
+
+		du: display at feb00000 {
+			compatible = "renesas,du-r8a7794";
+			reg = <0 0xfeb00000 0 0x40000>;
+			reg-names = "du";
+			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 724>, <&cpg CPG_MOD 723>;
+			clock-names = "du.0", "du.1";
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					du_out_rgb0: endpoint {
+					};
+				};
+				port at 1 {
+					reg = <1>;
+					du_out_rgb1: endpoint {
+					};
+				};
+			};
+		};
+
+		prr: chipid at ff000044 {
+			compatible = "renesas,prr";
+			reg = <0 0xff000044 0 4>;
+		};
+
+		cmt0: timer at ffca0000 {
+			compatible = "renesas,r8a7794-cmt0",
+				     "renesas,rcar-gen2-cmt0";
+			reg = <0 0xffca0000 0 0x1004>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 124>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 124>;
+
+			status = "disabled";
+		};
+
+		cmt1: timer at e6130000 {
+			compatible = "renesas,r8a7794-cmt1",
+				     "renesas,rcar-gen2-cmt1";
+			reg = <0 0xe6130000 0 0x1004>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 329>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 329>;
+
+			status = "disabled";
+		};
 	};
 
 	timer {
@@ -1353,7 +1353,6 @@
 				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
-
 	/* External root clock */
 	extal_clk: extal {
 		compatible = "fixed-clock";
-- 
2.11.0
