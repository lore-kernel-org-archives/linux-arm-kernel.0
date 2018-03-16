From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:52:40 +0100
Subject: [PATCH 21/52] ARM: dts: r8a7794: add soc node
In-Reply-To: <cover.1521208546.git.horms+renesas@verge.net.au>
References: <cover.1521208546.git.horms+renesas@verge.net.au>
Message-ID: <0f2901d74a99e2e6c0aea2ef9b1820c7d0ed88e1.1521208546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add soc node to represent the bus and move all nodes with a base address
into this node. This is consistent with handling of R-Car Gen3, RZ/G1, and
R-Car V2H (R8A77920) SoCs upstream. It is intended to migrate other R-Car
Gen2 SoCs to this scheme.

The ordering is derived from simply moving each node with an address up to
before any nodes without a base address that occur before the soc node.  To
improve maintainability follow-up patches will sort subnodes of both the
new soc node and the root node.

This patch should not introduce any functional change.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi | 2358 ++++++++++++++++++++--------------------
 1 file changed, 1205 insertions(+), 1153 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 79263377ded3..0d65069b1a89 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -16,7 +16,6 @@
 
 / {
 	compatible = "renesas,r8a7794";
-	interrupt-parent = <&gic>;
 	#address-cells = <2>;
 	#size-cells = <2>;
 
@@ -67,985 +66,1293 @@
 		};
 	};
 
-	apmu at e6151000 {
-		compatible = "renesas,r8a7794-apmu", "renesas,apmu";
-		reg = <0 0xe6151000 0 0x188>;
-		cpus = <&cpu0 &cpu1>;
-	};
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
 
-	gic: interrupt-controller at f1001000 {
-		compatible = "arm,gic-400";
-		#interrupt-cells = <3>;
-		#address-cells = <0>;
-		interrupt-controller;
-		reg = <0 0xf1001000 0 0x1000>,
-			<0 0xf1002000 0 0x2000>,
-			<0 0xf1004000 0 0x2000>,
-			<0 0xf1006000 0 0x2000>;
-		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
-		clocks = <&cpg CPG_MOD 408>;
-		clock-names = "clk";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 408>;
-	};
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
 
-	gpio0: gpio at e6050000 {
-		compatible = "renesas,gpio-r8a7794", "renesas,rcar-gen2-gpio";
-		reg = <0 0xe6050000 0 0x50>;
-		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		gpio-ranges = <&pfc 0 0 32>;
-		#interrupt-cells = <2>;
-		interrupt-controller;
-		clocks = <&cpg CPG_MOD 912>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 912>;
-	};
+		apmu at e6151000 {
+			compatible = "renesas,r8a7794-apmu", "renesas,apmu";
+			reg = <0 0xe6151000 0 0x188>;
+			cpus = <&cpu0 &cpu1>;
+		};
 
-	gpio1: gpio at e6051000 {
-		compatible = "renesas,gpio-r8a7794", "renesas,rcar-gen2-gpio";
-		reg = <0 0xe6051000 0 0x50>;
-		interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		gpio-ranges = <&pfc 0 32 26>;
-		#interrupt-cells = <2>;
-		interrupt-controller;
-		clocks = <&cpg CPG_MOD 911>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 911>;
-	};
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
 
-	gpio2: gpio at e6052000 {
-		compatible = "renesas,gpio-r8a7794", "renesas,rcar-gen2-gpio";
-		reg = <0 0xe6052000 0 0x50>;
-		interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		gpio-ranges = <&pfc 0 64 32>;
-		#interrupt-cells = <2>;
-		interrupt-controller;
-		clocks = <&cpg CPG_MOD 910>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 910>;
-	};
+		gpio0: gpio at e6050000 {
+			compatible = "renesas,gpio-r8a7794",
+				     "renesas,rcar-gen2-gpio";
+			reg = <0 0xe6050000 0 0x50>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 0 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 912>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 912>;
+		};
 
-	gpio3: gpio at e6053000 {
-		compatible = "renesas,gpio-r8a7794", "renesas,rcar-gen2-gpio";
-		reg = <0 0xe6053000 0 0x50>;
-		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		gpio-ranges = <&pfc 0 96 32>;
-		#interrupt-cells = <2>;
-		interrupt-controller;
-		clocks = <&cpg CPG_MOD 909>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 909>;
-	};
+		gpio1: gpio at e6051000 {
+			compatible = "renesas,gpio-r8a7794",
+				     "renesas,rcar-gen2-gpio";
+			reg = <0 0xe6051000 0 0x50>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 32 26>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 911>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 911>;
+		};
 
-	gpio4: gpio at e6054000 {
-		compatible = "renesas,gpio-r8a7794", "renesas,rcar-gen2-gpio";
-		reg = <0 0xe6054000 0 0x50>;
-		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		gpio-ranges = <&pfc 0 128 32>;
-		#interrupt-cells = <2>;
-		interrupt-controller;
-		clocks = <&cpg CPG_MOD 908>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 908>;
-	};
+		gpio2: gpio at e6052000 {
+			compatible = "renesas,gpio-r8a7794",
+				     "renesas,rcar-gen2-gpio";
+			reg = <0 0xe6052000 0 0x50>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 64 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 910>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 910>;
+		};
 
-	gpio5: gpio at e6055000 {
-		compatible = "renesas,gpio-r8a7794", "renesas,rcar-gen2-gpio";
-		reg = <0 0xe6055000 0 0x50>;
-		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		gpio-ranges = <&pfc 0 160 28>;
-		#interrupt-cells = <2>;
-		interrupt-controller;
-		clocks = <&cpg CPG_MOD 907>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 907>;
-	};
+		gpio3: gpio at e6053000 {
+			compatible = "renesas,gpio-r8a7794",
+				     "renesas,rcar-gen2-gpio";
+			reg = <0 0xe6053000 0 0x50>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 96 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 909>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 909>;
+		};
 
-	gpio6: gpio at e6055400 {
-		compatible = "renesas,gpio-r8a7794", "renesas,rcar-gen2-gpio";
-		reg = <0 0xe6055400 0 0x50>;
-		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		gpio-ranges = <&pfc 0 192 26>;
-		#interrupt-cells = <2>;
-		interrupt-controller;
-		clocks = <&cpg CPG_MOD 905>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 905>;
-	};
+		gpio4: gpio at e6054000 {
+			compatible = "renesas,gpio-r8a7794",
+				     "renesas,rcar-gen2-gpio";
+			reg = <0 0xe6054000 0 0x50>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 128 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 908>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 908>;
+		};
 
-	cmt0: timer at ffca0000 {
-		compatible = "renesas,r8a7794-cmt0", "renesas,rcar-gen2-cmt0";
-		reg = <0 0xffca0000 0 0x1004>;
-		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 124>;
-		clock-names = "fck";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 124>;
-
-		status = "disabled";
-	};
+		gpio5: gpio at e6055000 {
+			compatible = "renesas,gpio-r8a7794",
+				     "renesas,rcar-gen2-gpio";
+			reg = <0 0xe6055000 0 0x50>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 160 28>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 907>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 907>;
+		};
 
-	cmt1: timer at e6130000 {
-		compatible = "renesas,r8a7794-cmt1", "renesas,rcar-gen2-cmt1";
-		reg = <0 0xe6130000 0 0x1004>;
-		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 329>;
-		clock-names = "fck";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 329>;
-
-		status = "disabled";
-	};
+		gpio6: gpio at e6055400 {
+			compatible = "renesas,gpio-r8a7794",
+				     "renesas,rcar-gen2-gpio";
+			reg = <0 0xe6055400 0 0x50>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 192 26>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 905>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 905>;
+		};
 
-	timer {
-		compatible = "arm,armv7-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
-	};
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
 
-	irqc0: interrupt-controller at e61c0000 {
-		compatible = "renesas,irqc-r8a7794", "renesas,irqc";
-		#interrupt-cells = <2>;
-		interrupt-controller;
-		reg = <0 0xe61c0000 0 0x200>;
-		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 407>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 407>;
-	};
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
 
-	pfc: pin-controller at e6060000 {
-		compatible = "renesas,pfc-r8a7794";
-		reg = <0 0xe6060000 0 0x11c>;
-	};
+		irqc0: interrupt-controller at e61c0000 {
+			compatible = "renesas,irqc-r8a7794", "renesas,irqc";
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			reg = <0 0xe61c0000 0 0x200>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 407>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 407>;
+		};
 
-	dmac0: dma-controller at e6700000 {
-		compatible = "renesas,dmac-r8a7794", "renesas,rcar-dmac";
-		reg = <0 0xe6700000 0 0x20000>;
-		interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "error",
-				"ch0", "ch1", "ch2", "ch3",
-				"ch4", "ch5", "ch6", "ch7",
-				"ch8", "ch9", "ch10", "ch11",
-				"ch12", "ch13", "ch14";
-		clocks = <&cpg CPG_MOD 219>;
-		clock-names = "fck";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 219>;
-		#dma-cells = <1>;
-		dma-channels = <15>;
-	};
+		pfc: pin-controller at e6060000 {
+			compatible = "renesas,pfc-r8a7794";
+			reg = <0 0xe6060000 0 0x11c>;
+		};
 
-	dmac1: dma-controller at e6720000 {
-		compatible = "renesas,dmac-r8a7794", "renesas,rcar-dmac";
-		reg = <0 0xe6720000 0 0x20000>;
-		interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "error",
-				"ch0", "ch1", "ch2", "ch3",
-				"ch4", "ch5", "ch6", "ch7",
-				"ch8", "ch9", "ch10", "ch11",
-				"ch12", "ch13", "ch14";
-		clocks = <&cpg CPG_MOD 218>;
-		clock-names = "fck";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 218>;
-		#dma-cells = <1>;
-		dma-channels = <15>;
-	};
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
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 219>;
+			#dma-cells = <1>;
+			dma-channels = <15>;
+		};
 
-	audma0: dma-controller at ec700000 {
-		compatible = "renesas,dmac-r8a7794", "renesas,rcar-dmac";
-		reg = <0 0xec700000 0 0x10000>;
-		interrupts = <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "error",
-				  "ch0", "ch1", "ch2", "ch3", "ch4", "ch5",
-				  "ch6", "ch7", "ch8", "ch9", "ch10", "ch11",
-				  "ch12";
-		clocks = <&cpg CPG_MOD 502>;
-		clock-names = "fck";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 502>;
-		#dma-cells = <1>;
-		dma-channels = <13>;
-	};
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
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 218>;
+			#dma-cells = <1>;
+			dma-channels = <15>;
+		};
 
-	scifa0: serial at e6c40000 {
-		compatible = "renesas,scifa-r8a7794",
-			     "renesas,rcar-gen2-scifa", "renesas,scifa";
-		reg = <0 0xe6c40000 0 64>;
-		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 204>;
-		clock-names = "fck";
-		dmas = <&dmac0 0x21>, <&dmac0 0x22>,
-		       <&dmac1 0x21>, <&dmac1 0x22>;
-		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 204>;
-		status = "disabled";
-	};
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
 
-	scifa1: serial at e6c50000 {
-		compatible = "renesas,scifa-r8a7794",
-			     "renesas,rcar-gen2-scifa", "renesas,scifa";
-		reg = <0 0xe6c50000 0 64>;
-		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 203>;
-		clock-names = "fck";
-		dmas = <&dmac0 0x25>, <&dmac0 0x26>,
-		       <&dmac1 0x25>, <&dmac1 0x26>;
-		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 203>;
-		status = "disabled";
-	};
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
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 204>;
+			status = "disabled";
+		};
 
-	scifa2: serial at e6c60000 {
-		compatible = "renesas,scifa-r8a7794",
-			     "renesas,rcar-gen2-scifa", "renesas,scifa";
-		reg = <0 0xe6c60000 0 64>;
-		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 202>;
-		clock-names = "fck";
-		dmas = <&dmac0 0x27>, <&dmac0 0x28>,
-		       <&dmac1 0x27>, <&dmac1 0x28>;
-		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 202>;
-		status = "disabled";
-	};
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
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 203>;
+			status = "disabled";
+		};
 
-	scifa3: serial at e6c70000 {
-		compatible = "renesas,scifa-r8a7794",
-			     "renesas,rcar-gen2-scifa", "renesas,scifa";
-		reg = <0 0xe6c70000 0 64>;
-		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 1106>;
-		clock-names = "fck";
-		dmas = <&dmac0 0x1b>, <&dmac0 0x1c>,
-		       <&dmac1 0x1b>, <&dmac1 0x1c>;
-		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 1106>;
-		status = "disabled";
-	};
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
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 202>;
+			status = "disabled";
+		};
 
-	scifa4: serial at e6c78000 {
-		compatible = "renesas,scifa-r8a7794",
-			     "renesas,rcar-gen2-scifa", "renesas,scifa";
-		reg = <0 0xe6c78000 0 64>;
-		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 1107>;
-		clock-names = "fck";
-		dmas = <&dmac0 0x1f>, <&dmac0 0x20>,
-		       <&dmac1 0x1f>, <&dmac1 0x20>;
-		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 1107>;
-		status = "disabled";
-	};
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
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 1106>;
+			status = "disabled";
+		};
 
-	scifa5: serial at e6c80000 {
-		compatible = "renesas,scifa-r8a7794",
-			     "renesas,rcar-gen2-scifa", "renesas,scifa";
-		reg = <0 0xe6c80000 0 64>;
-		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 1108>;
-		clock-names = "fck";
-		dmas = <&dmac0 0x23>, <&dmac0 0x24>,
-		       <&dmac1 0x23>, <&dmac1 0x24>;
-		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 1108>;
-		status = "disabled";
-	};
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
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 1107>;
+			status = "disabled";
+		};
 
-	scifb0: serial at e6c20000 {
-		compatible = "renesas,scifb-r8a7794",
-			     "renesas,rcar-gen2-scifb", "renesas,scifb";
-		reg = <0 0xe6c20000 0 0x100>;
-		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 206>;
-		clock-names = "fck";
-		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>,
-		       <&dmac1 0x3d>, <&dmac1 0x3e>;
-		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 206>;
-		status = "disabled";
-	};
+		scifa5: serial at e6c80000 {
+			compatible = "renesas,scifa-r8a7794",
+				     "renesas,rcar-gen2-scifa", "renesas,scifa";
+			reg = <0 0xe6c80000 0 64>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 1108>;
+			clock-names = "fck";
+			dmas = <&dmac0 0x23>, <&dmac0 0x24>,
+			       <&dmac1 0x23>, <&dmac1 0x24>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 1108>;
+			status = "disabled";
+		};
 
-	scifb1: serial at e6c30000 {
-		compatible = "renesas,scifb-r8a7794",
-			     "renesas,rcar-gen2-scifb", "renesas,scifb";
-		reg = <0 0xe6c30000 0 0x100>;
-		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 207>;
-		clock-names = "fck";
-		dmas = <&dmac0 0x19>, <&dmac0 0x1a>,
-		       <&dmac1 0x19>, <&dmac1 0x1a>;
-		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 207>;
-		status = "disabled";
-	};
+		scifb0: serial at e6c20000 {
+			compatible = "renesas,scifb-r8a7794",
+				     "renesas,rcar-gen2-scifb", "renesas,scifb";
+			reg = <0 0xe6c20000 0 0x100>;
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 206>;
+			clock-names = "fck";
+			dmas = <&dmac0 0x3d>, <&dmac0 0x3e>,
+			       <&dmac1 0x3d>, <&dmac1 0x3e>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 206>;
+			status = "disabled";
+		};
 
-	scifb2: serial at e6ce0000 {
-		compatible = "renesas,scifb-r8a7794",
-			     "renesas,rcar-gen2-scifb", "renesas,scifb";
-		reg = <0 0xe6ce0000 0 0x100>;
-		interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 216>;
-		clock-names = "fck";
-		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>,
-		       <&dmac1 0x1d>, <&dmac1 0x1e>;
-		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 216>;
-		status = "disabled";
-	};
+		scifb1: serial at e6c30000 {
+			compatible = "renesas,scifb-r8a7794",
+				     "renesas,rcar-gen2-scifb", "renesas,scifb";
+			reg = <0 0xe6c30000 0 0x100>;
+			interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 207>;
+			clock-names = "fck";
+			dmas = <&dmac0 0x19>, <&dmac0 0x1a>,
+			       <&dmac1 0x19>, <&dmac1 0x1a>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 207>;
+			status = "disabled";
+		};
 
-	scif0: serial at e6e60000 {
-		compatible = "renesas,scif-r8a7794", "renesas,rcar-gen2-scif",
-			     "renesas,scif";
-		reg = <0 0xe6e60000 0 64>;
-		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 721>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
-			 <&scif_clk>;
-		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x29>, <&dmac0 0x2a>,
-		       <&dmac1 0x29>, <&dmac1 0x2a>;
-		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 721>;
-		status = "disabled";
-	};
+		scifb2: serial at e6ce0000 {
+			compatible = "renesas,scifb-r8a7794",
+				     "renesas,rcar-gen2-scifb", "renesas,scifb";
+			reg = <0 0xe6ce0000 0 0x100>;
+			interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 216>;
+			clock-names = "fck";
+			dmas = <&dmac0 0x1d>, <&dmac0 0x1e>,
+			       <&dmac1 0x1d>, <&dmac1 0x1e>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 216>;
+			status = "disabled";
+		};
 
-	scif1: serial at e6e68000 {
-		compatible = "renesas,scif-r8a7794", "renesas,rcar-gen2-scif",
-			     "renesas,scif";
-		reg = <0 0xe6e68000 0 64>;
-		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 720>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
-			 <&scif_clk>;
-		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>,
-		       <&dmac1 0x2d>, <&dmac1 0x2e>;
-		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 720>;
-		status = "disabled";
-	};
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
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 721>;
+			status = "disabled";
+		};
 
-	scif2: serial at e6e58000 {
-		compatible = "renesas,scif-r8a7794", "renesas,rcar-gen2-scif",
-			     "renesas,scif";
-		reg = <0 0xe6e58000 0 64>;
-		interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 719>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
-			 <&scif_clk>;
-		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>,
-		       <&dmac1 0x2b>, <&dmac1 0x2c>;
-		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 719>;
-		status = "disabled";
-	};
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
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 720>;
+			status = "disabled";
+		};
 
-	scif3: serial at e6ea8000 {
-		compatible = "renesas,scif-r8a7794", "renesas,rcar-gen2-scif",
-			     "renesas,scif";
-		reg = <0 0xe6ea8000 0 64>;
-		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 718>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
-			 <&scif_clk>;
-		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x2f>, <&dmac0 0x30>,
-		       <&dmac1 0x2f>, <&dmac1 0x30>;
-		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 718>;
-		status = "disabled";
-	};
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
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 719>;
+			status = "disabled";
+		};
 
-	scif4: serial at e6ee0000 {
-		compatible = "renesas,scif-r8a7794", "renesas,rcar-gen2-scif",
-			     "renesas,scif";
-		reg = <0 0xe6ee0000 0 64>;
-		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 715>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
-			 <&scif_clk>;
-		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>,
-		       <&dmac1 0xfb>, <&dmac1 0xfc>;
-		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 715>;
-		status = "disabled";
-	};
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
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 718>;
+			status = "disabled";
+		};
 
-	scif5: serial at e6ee8000 {
-		compatible = "renesas,scif-r8a7794", "renesas,rcar-gen2-scif",
-			     "renesas,scif";
-		reg = <0 0xe6ee8000 0 64>;
-		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 714>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
-			 <&scif_clk>;
-		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>,
-		       <&dmac1 0xfd>, <&dmac1 0xfe>;
-		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 714>;
-		status = "disabled";
-	};
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
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 715>;
+			status = "disabled";
+		};
 
-	hscif0: serial at e62c0000 {
-		compatible = "renesas,hscif-r8a7794",
-			     "renesas,rcar-gen2-hscif", "renesas,hscif";
-		reg = <0 0xe62c0000 0 96>;
-		interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 717>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
-			 <&scif_clk>;
-		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x39>, <&dmac0 0x3a>,
-		       <&dmac1 0x39>, <&dmac1 0x3a>;
-		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 717>;
-		status = "disabled";
-	};
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
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 714>;
+			status = "disabled";
+		};
 
-	hscif1: serial at e62c8000 {
-		compatible = "renesas,hscif-r8a7794",
-			     "renesas,rcar-gen2-hscif", "renesas,hscif";
-		reg = <0 0xe62c8000 0 96>;
-		interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 716>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
-			 <&scif_clk>;
-		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>,
-		       <&dmac1 0x4d>, <&dmac1 0x4e>;
-		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 716>;
-		status = "disabled";
-	};
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
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 717>;
+			status = "disabled";
+		};
 
-	hscif2: serial at e62d0000 {
-		compatible = "renesas,hscif-r8a7794",
-			     "renesas,rcar-gen2-hscif", "renesas,hscif";
-		reg = <0 0xe62d0000 0 96>;
-		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 713>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
-			 <&scif_clk>;
-		clock-names = "fck", "brg_int", "scif_clk";
-		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>,
-		       <&dmac1 0x3b>, <&dmac1 0x3c>;
-		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 713>;
-		status = "disabled";
-	};
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
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 716>;
+			status = "disabled";
+		};
 
-	icram0:	sram at e63a0000 {
-		compatible = "mmio-sram";
-		reg = <0 0xe63a0000 0 0x12000>;
-	};
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
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 713>;
+			status = "disabled";
+		};
 
-	icram1:	sram at e63c0000 {
-		compatible = "mmio-sram";
-		reg = <0 0xe63c0000 0 0x1000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0 0xe63c0000 0x1000>;
+		icram0:	sram at e63a0000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe63a0000 0 0x12000>;
+		};
 
-		smp-sram at 0 {
-			compatible = "renesas,smp-sram";
-			reg = <0 0x10>;
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
-	};
 
-	ether: ethernet at ee700000 {
-		compatible = "renesas,ether-r8a7794",
-			     "renesas,rcar-gen2-ether";
-		reg = <0 0xee700000 0 0x400>;
-		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 813>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 813>;
-		phy-mode = "rmii";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
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
 
-	avb: ethernet at e6800000 {
-		compatible = "renesas,etheravb-r8a7794",
-			     "renesas,etheravb-rcar-gen2";
-		reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
-		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 812>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 812>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
+		avb: ethernet at e6800000 {
+			compatible = "renesas,etheravb-r8a7794",
+				     "renesas,etheravb-rcar-gen2";
+			reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 812>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 812>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 
-	/* The memory map in the User's Manual maps the cores to bus numbers */
-	i2c0: i2c at e6508000 {
-		compatible = "renesas,i2c-r8a7794", "renesas,rcar-gen2-i2c";
-		reg = <0 0xe6508000 0 0x40>;
-		interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 931>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 931>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		i2c-scl-internal-delay-ns = <6>;
-		status = "disabled";
-	};
+		/* The memory map in the User's Manual maps the cores to
+		 * bus numbers
+		 */
+		i2c0: i2c at e6508000 {
+			compatible = "renesas,i2c-r8a7794",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6508000 0 0x40>;
+			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 931>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 931>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			i2c-scl-internal-delay-ns = <6>;
+			status = "disabled";
+		};
 
-	i2c1: i2c at e6518000 {
-		compatible = "renesas,i2c-r8a7794", "renesas,rcar-gen2-i2c";
-		reg = <0 0xe6518000 0 0x40>;
-		interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 930>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 930>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		i2c-scl-internal-delay-ns = <6>;
-		status = "disabled";
-	};
+		i2c1: i2c at e6518000 {
+			compatible = "renesas,i2c-r8a7794",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6518000 0 0x40>;
+			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 930>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 930>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			i2c-scl-internal-delay-ns = <6>;
+			status = "disabled";
+		};
 
-	i2c2: i2c at e6530000 {
-		compatible = "renesas,i2c-r8a7794", "renesas,rcar-gen2-i2c";
-		reg = <0 0xe6530000 0 0x40>;
-		interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 929>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 929>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		i2c-scl-internal-delay-ns = <6>;
-		status = "disabled";
-	};
+		i2c2: i2c at e6530000 {
+			compatible = "renesas,i2c-r8a7794",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6530000 0 0x40>;
+			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 929>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 929>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			i2c-scl-internal-delay-ns = <6>;
+			status = "disabled";
+		};
 
-	i2c3: i2c at e6540000 {
-		compatible = "renesas,i2c-r8a7794", "renesas,rcar-gen2-i2c";
-		reg = <0 0xe6540000 0 0x40>;
-		interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 928>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 928>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		i2c-scl-internal-delay-ns = <6>;
-		status = "disabled";
-	};
+		i2c3: i2c at e6540000 {
+			compatible = "renesas,i2c-r8a7794",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6540000 0 0x40>;
+			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 928>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 928>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			i2c-scl-internal-delay-ns = <6>;
+			status = "disabled";
+		};
 
-	i2c4: i2c at e6520000 {
-		compatible = "renesas,i2c-r8a7794", "renesas,rcar-gen2-i2c";
-		reg = <0 0xe6520000 0 0x40>;
-		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 927>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 927>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		i2c-scl-internal-delay-ns = <6>;
-		status = "disabled";
-	};
+		i2c4: i2c at e6520000 {
+			compatible = "renesas,i2c-r8a7794",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6520000 0 0x40>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 927>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 927>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			i2c-scl-internal-delay-ns = <6>;
+			status = "disabled";
+		};
 
-	i2c5: i2c at e6528000 {
-		compatible = "renesas,i2c-r8a7794", "renesas,rcar-gen2-i2c";
-		reg = <0 0xe6528000 0 0x40>;
-		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 925>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 925>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		i2c-scl-internal-delay-ns = <6>;
-		status = "disabled";
-	};
+		i2c5: i2c at e6528000 {
+			compatible = "renesas,i2c-r8a7794",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6528000 0 0x40>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 925>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 925>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			i2c-scl-internal-delay-ns = <6>;
+			status = "disabled";
+		};
 
-	i2c6: i2c at e6500000 {
-		compatible = "renesas,iic-r8a7794", "renesas,rcar-gen2-iic",
-			     "renesas,rmobile-iic";
-		reg = <0 0xe6500000 0 0x425>;
-		interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 318>;
-		dmas = <&dmac0 0x61>, <&dmac0 0x62>,
-		       <&dmac1 0x61>, <&dmac1 0x62>;
-		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 318>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
+		i2c6: i2c at e6500000 {
+			compatible = "renesas,iic-r8a7794",
+				     "renesas,rcar-gen2-iic",
+				     "renesas,rmobile-iic";
+			reg = <0 0xe6500000 0 0x425>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 318>;
+			dmas = <&dmac0 0x61>, <&dmac0 0x62>,
+			       <&dmac1 0x61>, <&dmac1 0x62>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 318>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 
-	i2c7: i2c at e6510000 {
-		compatible = "renesas,iic-r8a7794", "renesas,rcar-gen2-iic",
-			     "renesas,rmobile-iic";
-		reg = <0 0xe6510000 0 0x425>;
-		interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 323>;
-		dmas = <&dmac0 0x65>, <&dmac0 0x66>,
-		       <&dmac1 0x65>, <&dmac1 0x66>;
-		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 323>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
+		i2c7: i2c at e6510000 {
+			compatible = "renesas,iic-r8a7794",
+				     "renesas,rcar-gen2-iic",
+				     "renesas,rmobile-iic";
+			reg = <0 0xe6510000 0 0x425>;
+			interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 323>;
+			dmas = <&dmac0 0x65>, <&dmac0 0x66>,
+			       <&dmac1 0x65>, <&dmac1 0x66>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 323>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 
-	mmcif0: mmc at ee200000 {
-		compatible = "renesas,mmcif-r8a7794", "renesas,sh-mmcif";
-		reg = <0 0xee200000 0 0x80>;
-		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 315>;
-		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
-		       <&dmac1 0xd1>, <&dmac1 0xd2>;
-		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 315>;
-		reg-io-width = <4>;
-		status = "disabled";
-	};
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
 
-	sdhi0: sd at ee100000 {
-		compatible = "renesas,sdhi-r8a7794",
-			     "renesas,rcar-gen2-sdhi";
-		reg = <0 0xee100000 0 0x328>;
-		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 314>;
-		dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
-		       <&dmac1 0xcd>, <&dmac1 0xce>;
-		dma-names = "tx", "rx", "tx", "rx";
-		max-frequency = <195000000>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 314>;
-		status = "disabled";
-	};
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
 
-	sdhi1: sd at ee140000 {
-		compatible = "renesas,sdhi-r8a7794",
-			     "renesas,rcar-gen2-sdhi";
-		reg = <0 0xee140000 0 0x100>;
-		interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 312>;
-		dmas = <&dmac0 0xc1>, <&dmac0 0xc2>,
-		       <&dmac1 0xc1>, <&dmac1 0xc2>;
-		dma-names = "tx", "rx", "tx", "rx";
-		max-frequency = <97500000>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 312>;
-		status = "disabled";
-	};
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
 
-	sdhi2: sd at ee160000 {
-		compatible = "renesas,sdhi-r8a7794",
-			     "renesas,rcar-gen2-sdhi";
-		reg = <0 0xee160000 0 0x100>;
-		interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 311>;
-		dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
-		       <&dmac1 0xd3>, <&dmac1 0xd4>;
-		dma-names = "tx", "rx", "tx", "rx";
-		max-frequency = <97500000>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 311>;
-		status = "disabled";
-	};
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
 
-	qspi: spi at e6b10000 {
-		compatible = "renesas,qspi-r8a7794", "renesas,qspi";
-		reg = <0 0xe6b10000 0 0x2c>;
-		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 917>;
-		dmas = <&dmac0 0x17>, <&dmac0 0x18>,
-		       <&dmac1 0x17>, <&dmac1 0x18>;
-		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 917>;
-		num-cs = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
+		qspi: spi at e6b10000 {
+			compatible = "renesas,qspi-r8a7794", "renesas,qspi";
+			reg = <0 0xe6b10000 0 0x2c>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 917>;
+			dmas = <&dmac0 0x17>, <&dmac0 0x18>,
+			       <&dmac1 0x17>, <&dmac1 0x18>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 917>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 
-	vin0: video at e6ef0000 {
-		compatible = "renesas,vin-r8a7794", "renesas,rcar-gen2-vin";
-		reg = <0 0xe6ef0000 0 0x1000>;
-		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 811>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 811>;
-		status = "disabled";
-	};
+		vin0: video at e6ef0000 {
+			compatible = "renesas,vin-r8a7794",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef0000 0 0x1000>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 811>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 811>;
+			status = "disabled";
+		};
 
-	vin1: video at e6ef1000 {
-		compatible = "renesas,vin-r8a7794", "renesas,rcar-gen2-vin";
-		reg = <0 0xe6ef1000 0 0x1000>;
-		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 810>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 810>;
-		status = "disabled";
-	};
+		vin1: video at e6ef1000 {
+			compatible = "renesas,vin-r8a7794",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef1000 0 0x1000>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 810>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 810>;
+			status = "disabled";
+		};
 
-	pci0: pci at ee090000 {
-		compatible = "renesas,pci-r8a7794", "renesas,pci-rcar-gen2";
-		device_type = "pci";
-		reg = <0 0xee090000 0 0xc00>,
-		      <0 0xee080000 0 0x1100>;
-		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 703>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 703>;
-		status = "disabled";
-
-		bus-range = <0 0>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		#interrupt-cells = <1>;
-		ranges = <0x02000000 0 0xee080000 0 0xee080000 0 0x00010000>;
-		interrupt-map-mask = <0xff00 0 0 0x7>;
-		interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
-				 0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
-				 0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-
-		usb at 1,0 {
-			reg = <0x800 0 0 0 0>;
-			phys = <&usb0 0>;
-			phy-names = "usb";
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
 		};
 
-		usb at 2,0 {
-			reg = <0x1000 0 0 0 0>;
-			phys = <&usb0 0>;
-			phy-names = "usb";
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
 		};
-	};
 
-	pci1: pci at ee0d0000 {
-		compatible = "renesas,pci-r8a7794", "renesas,pci-rcar-gen2";
-		device_type = "pci";
-		reg = <0 0xee0d0000 0 0xc00>,
-		      <0 0xee0c0000 0 0x1100>;
-		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 703>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 703>;
-		status = "disabled";
-
-		bus-range = <1 1>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		#interrupt-cells = <1>;
-		ranges = <0x02000000 0 0xee0c0000 0 0xee0c0000 0 0x00010000>;
-		interrupt-map-mask = <0xff00 0 0 0x7>;
-		interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
-				 0x0800 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
-				 0x1000 0 0 2 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
-
-		usb at 1,0 {
-			reg = <0x10800 0 0 0 0>;
-			phys = <&usb2 0>;
+		hsusb: usb at e6590000 {
+			compatible = "renesas,usbhs-r8a7794",
+				     "renesas,rcar-gen2-usbhs";
+			reg = <0 0xe6590000 0 0x100>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 704>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 704>;
+			renesas,buswait = <4>;
+			phys = <&usb0 1>;
 			phy-names = "usb";
+			status = "disabled";
 		};
 
-		usb at 2,0 {
-			reg = <0x11000 0 0 0 0>;
-			phys = <&usb2 0>;
-			phy-names = "usb";
+		usbphy: usb-phy at e6590100 {
+			compatible = "renesas,usb-phy-r8a7794",
+				     "renesas,rcar-gen2-usb-phy";
+			reg = <0 0xe6590100 0 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cpg CPG_MOD 704>;
+			clock-names = "usbhs";
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 704>;
+			status = "disabled";
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
-	};
 
-	hsusb: usb at e6590000 {
-		compatible = "renesas,usbhs-r8a7794", "renesas,rcar-gen2-usbhs";
-		reg = <0 0xe6590000 0 0x100>;
-		interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 704>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 704>;
-		renesas,buswait = <4>;
-		phys = <&usb0 1>;
-		phy-names = "usb";
-		status = "disabled";
-	};
+		vsp at fe928000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe928000 0 0x8000>;
+			interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 131>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 131>;
+		};
 
-	usbphy: usb-phy at e6590100 {
-		compatible = "renesas,usb-phy-r8a7794",
-			     "renesas,rcar-gen2-usb-phy";
-		reg = <0 0xe6590100 0 0x100>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&cpg CPG_MOD 704>;
-		clock-names = "usbhs";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 704>;
-		status = "disabled";
+		vsp at fe930000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe930000 0 0x8000>;
+			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 128>;
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 128>;
+		};
 
-		usb0: usb-channel at 0 {
-			reg = <0>;
-			#phy-cells = <1>;
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
 		};
-		usb2: usb-channel at 2 {
-			reg = <2>;
-			#phy-cells = <1>;
+
+		can0: can at e6e80000 {
+			compatible = "renesas,can-r8a7794",
+				     "renesas,rcar-gen2-can";
+			reg = <0 0xe6e80000 0 0x1000>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 916>, <&cpg CPG_CORE R8A7794_CLK_RCAN>,
+				 <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 916>;
+			status = "disabled";
 		};
-	};
 
-	vsp at fe928000 {
-		compatible = "renesas,vsp1";
-		reg = <0 0xfe928000 0 0x8000>;
-		interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 131>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 131>;
-	};
+		can1: can at e6e88000 {
+			compatible = "renesas,can-r8a7794",
+				     "renesas,rcar-gen2-can";
+			reg = <0 0xe6e88000 0 0x1000>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 915>, <&cpg CPG_CORE R8A7794_CLK_RCAN>,
+				 <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 915>;
+			status = "disabled";
+		};
 
-	vsp at fe930000 {
-		compatible = "renesas,vsp1";
-		reg = <0 0xfe930000 0 0x8000>;
-		interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 128>;
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 128>;
-	};
+		cpg: clock-controller at e6150000 {
+			compatible = "renesas,r8a7794-cpg-mssr";
+			reg = <0 0xe6150000 0 0x1000>;
+			clocks = <&extal_clk>, <&usb_extal_clk>;
+			clock-names = "extal", "usb_extal";
+			#clock-cells = <2>;
+			#power-domain-cells = <0>;
+			#reset-cells = <1>;
+		};
 
-	du: display at feb00000 {
-		compatible = "renesas,du-r8a7794";
-		reg = <0 0xfeb00000 0 0x40000>;
-		reg-names = "du";
-		interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 724>, <&cpg CPG_MOD 723>;
-		clock-names = "du.0", "du.1";
-		status = "disabled";
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
+		rst: reset-controller at e6160000 {
+			compatible = "renesas,r8a7794-rst";
+			reg = <0 0xe6160000 0 0x0100>;
+		};
 
-			port at 0 {
-				reg = <0>;
-				du_out_rgb0: endpoint {
+		prr: chipid at ff000044 {
+			compatible = "renesas,prr";
+			reg = <0 0xff000044 0 4>;
+		};
+
+		sysc: system-controller at e6180000 {
+			compatible = "renesas,r8a7794-sysc";
+			reg = <0 0xe6180000 0 0x0200>;
+			#power-domain-cells = <1>;
+		};
+
+		ipmmu_sy0: mmu at e6280000 {
+			compatible = "renesas,ipmmu-r8a7794",
+				     "renesas,ipmmu-vmsa";
+			reg = <0 0xe6280000 0 0x1000>;
+			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_sy1: mmu at e6290000 {
+			compatible = "renesas,ipmmu-r8a7794",
+				     "renesas,ipmmu-vmsa";
+			reg = <0 0xe6290000 0 0x1000>;
+			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_ds: mmu at e6740000 {
+			compatible = "renesas,ipmmu-r8a7794",
+				     "renesas,ipmmu-vmsa";
+			reg = <0 0xe6740000 0 0x1000>;
+			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_mp: mmu at ec680000 {
+			compatible = "renesas,ipmmu-r8a7794",
+				     "renesas,ipmmu-vmsa";
+			reg = <0 0xec680000 0 0x1000>;
+			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_mx: mmu at fe951000 {
+			compatible = "renesas,ipmmu-r8a7794",
+				     "renesas,ipmmu-vmsa";
+			reg = <0 0xfe951000 0 0x1000>;
+			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_gp: mmu at e62a0000 {
+			compatible = "renesas,ipmmu-r8a7794",
+				     "renesas,ipmmu-vmsa";
+			reg = <0 0xe62a0000 0 0x1000>;
+			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		rcar_sound: sound at ec500000 {
+			/*
+			 * #sound-dai-cells is required
+			 *
+			 * Single DAI : #sound-dai-cells = <0>;         <&rcar_sound>;
+			 * Multi  DAI : #sound-dai-cells = <1>;         <&rcar_sound N>;
+			 */
+			compatible = "renesas,rcar_sound-r8a7794",
+				     "renesas,rcar_sound-gen2";
+			reg = <0 0xec500000 0 0x1000>, /* SCU */
+			      <0 0xec5a0000 0 0x100>,  /* ADG */
+			      <0 0xec540000 0 0x1000>, /* SSIU */
+			      <0 0xec541000 0 0x280>,  /* SSI */
+			      <0 0xec740000 0 0x200>;  /* Audio DMAC peri peri */
+			reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
+
+			clocks = <&cpg CPG_MOD 1005>,
+				 <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
+				 <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
+				 <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
+				 <&cpg CPG_MOD 1012>, <&cpg CPG_MOD 1013>,
+				 <&cpg CPG_MOD 1014>, <&cpg CPG_MOD 1015>,
+				 <&cpg CPG_MOD 1025>, <&cpg CPG_MOD 1026>,
+				 <&cpg CPG_MOD 1027>, <&cpg CPG_MOD 1028>,
+				 <&cpg CPG_MOD 1029>, <&cpg CPG_MOD 1030>,
+				 <&cpg CPG_MOD 1021>, <&cpg CPG_MOD 1020>,
+				 <&cpg CPG_MOD 1021>, <&cpg CPG_MOD 1020>,
+				 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
+				 <&audio_clka>, <&audio_clkb>, <&audio_clkc>,
+				 <&cpg CPG_CORE R8A7794_CLK_M2>;
+			clock-names = "ssi-all",
+				      "ssi.9", "ssi.8", "ssi.7", "ssi.6",
+				      "ssi.5", "ssi.4", "ssi.3", "ssi.2",
+				      "ssi.1", "ssi.0",
+				      "src.6", "src.5", "src.4", "src.3",
+				      "src.2", "src.1",
+				      "ctu.0", "ctu.1",
+				      "mix.0", "mix.1",
+				      "dvc.0", "dvc.1",
+				      "clk_a", "clk_b", "clk_c", "clk_i";
+			power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+			resets = <&cpg 1005>,
+				 <&cpg 1006>, <&cpg 1007>,
+				 <&cpg 1008>, <&cpg 1009>,
+				 <&cpg 1010>, <&cpg 1011>,
+				 <&cpg 1012>, <&cpg 1013>,
+				 <&cpg 1014>, <&cpg 1015>;
+			reset-names = "ssi-all",
+				      "ssi.9", "ssi.8", "ssi.7", "ssi.6",
+				      "ssi.5", "ssi.4", "ssi.3", "ssi.2",
+				      "ssi.1", "ssi.0";
+
+			status = "disabled";
+
+			rcar_sound,dvc {
+				dvc0: dvc-0 {
+					dmas = <&audma0 0xbc>;
+					dma-names = "tx";
+				};
+				dvc1: dvc-1 {
+					dmas = <&audma0 0xbe>;
+					dma-names = "tx";
 				};
 			};
-			port at 1 {
-				reg = <1>;
-				du_out_rgb1: endpoint {
+
+			rcar_sound,mix {
+				mix0: mix-0 { };
+				mix1: mix-1 { };
+			};
+
+			rcar_sound,ctu {
+				ctu00: ctu-0 { };
+				ctu01: ctu-1 { };
+				ctu02: ctu-2 { };
+				ctu03: ctu-3 { };
+				ctu10: ctu-4 { };
+				ctu11: ctu-5 { };
+				ctu12: ctu-6 { };
+				ctu13: ctu-7 { };
+			};
+
+			rcar_sound,src {
+				src-0 {
+					status = "disabled";
+				};
+				src1: src-1 {
+					interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x87>, <&audma0 0x9c>;
+					dma-names = "rx", "tx";
+				};
+				src2: src-2 {
+					interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x89>, <&audma0 0x9e>;
+					dma-names = "rx", "tx";
+				};
+				src3: src-3 {
+					interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x8b>, <&audma0 0xa0>;
+					dma-names = "rx", "tx";
+				};
+				src4: src-4 {
+					interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x8d>, <&audma0 0xb0>;
+					dma-names = "rx", "tx";
+				};
+				src5: src-5 {
+					interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x8f>, <&audma0 0xb2>;
+					dma-names = "rx", "tx";
+				};
+				src6: src-6 {
+					interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x91>, <&audma0 0xb4>;
+					dma-names = "rx", "tx";
+				};
+			};
+
+			rcar_sound,ssi {
+				ssi0: ssi-0 {
+					interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x01>, <&audma0 0x02>,
+					       <&audma0 0x15>, <&audma0 0x16>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi1: ssi-1 {
+					interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x03>, <&audma0 0x04>,
+					       <&audma0 0x49>, <&audma0 0x4a>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi2: ssi-2 {
+					interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x05>, <&audma0 0x06>,
+					       <&audma0 0x63>, <&audma0 0x64>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi3: ssi-3 {
+					interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x07>, <&audma0 0x08>,
+					       <&audma0 0x6f>, <&audma0 0x70>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi4: ssi-4 {
+					interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x09>, <&audma0 0x0a>,
+					       <&audma0 0x71>, <&audma0 0x72>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi5: ssi-5 {
+					interrupts = <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x0b>, <&audma0 0x0c>,
+					       <&audma0 0x73>, <&audma0 0x74>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi6: ssi-6 {
+					interrupts = <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x0d>, <&audma0 0x0e>,
+					       <&audma0 0x75>, <&audma0 0x76>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi7: ssi-7 {
+					interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x0f>, <&audma0 0x10>,
+					       <&audma0 0x79>, <&audma0 0x7a>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi8: ssi-8 {
+					interrupts = <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x11>, <&audma0 0x12>,
+					       <&audma0 0x7b>, <&audma0 0x7c>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi9: ssi-9 {
+					interrupts = <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x13>, <&audma0 0x14>,
+					       <&audma0 0x7d>, <&audma0 0x7e>;
+					dma-names = "rx", "tx", "rxu", "txu";
 				};
 			};
 		};
 	};
 
-	can0: can at e6e80000 {
-		compatible = "renesas,can-r8a7794", "renesas,rcar-gen2-can";
-		reg = <0 0xe6e80000 0 0x1000>;
-		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 916>, <&cpg CPG_CORE R8A7794_CLK_RCAN>,
-			 <&can_clk>;
-		clock-names = "clkp1", "clkp2", "can_clk";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 916>;
-		status = "disabled";
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
-	can1: can at e6e88000 {
-		compatible = "renesas,can-r8a7794", "renesas,rcar-gen2-can";
-		reg = <0 0xe6e88000 0 0x1000>;
-		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg CPG_MOD 915>, <&cpg CPG_CORE R8A7794_CLK_RCAN>,
-			 <&can_clk>;
-		clock-names = "clkp1", "clkp2", "can_clk";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 915>;
-		status = "disabled";
-	};
 
 	/* External root clock */
 	extal_clk: extal {
@@ -1098,259 +1405,4 @@
 		#clock-cells = <0>;
 		clock-frequency = <0>;
 	};
-
-	cpg: clock-controller at e6150000 {
-		compatible = "renesas,r8a7794-cpg-mssr";
-		reg = <0 0xe6150000 0 0x1000>;
-		clocks = <&extal_clk>, <&usb_extal_clk>;
-		clock-names = "extal", "usb_extal";
-		#clock-cells = <2>;
-		#power-domain-cells = <0>;
-		#reset-cells = <1>;
-	};
-
-	rst: reset-controller at e6160000 {
-		compatible = "renesas,r8a7794-rst";
-		reg = <0 0xe6160000 0 0x0100>;
-	};
-
-	prr: chipid at ff000044 {
-		compatible = "renesas,prr";
-		reg = <0 0xff000044 0 4>;
-	};
-
-	sysc: system-controller at e6180000 {
-		compatible = "renesas,r8a7794-sysc";
-		reg = <0 0xe6180000 0 0x0200>;
-		#power-domain-cells = <1>;
-	};
-
-	ipmmu_sy0: mmu at e6280000 {
-		compatible = "renesas,ipmmu-r8a7794", "renesas,ipmmu-vmsa";
-		reg = <0 0xe6280000 0 0x1000>;
-		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
-		#iommu-cells = <1>;
-		status = "disabled";
-	};
-
-	ipmmu_sy1: mmu at e6290000 {
-		compatible = "renesas,ipmmu-r8a7794", "renesas,ipmmu-vmsa";
-		reg = <0 0xe6290000 0 0x1000>;
-		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
-		#iommu-cells = <1>;
-		status = "disabled";
-	};
-
-	ipmmu_ds: mmu at e6740000 {
-		compatible = "renesas,ipmmu-r8a7794", "renesas,ipmmu-vmsa";
-		reg = <0 0xe6740000 0 0x1000>;
-		interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
-		#iommu-cells = <1>;
-		status = "disabled";
-	};
-
-	ipmmu_mp: mmu at ec680000 {
-		compatible = "renesas,ipmmu-r8a7794", "renesas,ipmmu-vmsa";
-		reg = <0 0xec680000 0 0x1000>;
-		interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
-		#iommu-cells = <1>;
-		status = "disabled";
-	};
-
-	ipmmu_mx: mmu at fe951000 {
-		compatible = "renesas,ipmmu-r8a7794", "renesas,ipmmu-vmsa";
-		reg = <0 0xfe951000 0 0x1000>;
-		interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
-		#iommu-cells = <1>;
-		status = "disabled";
-	};
-
-	ipmmu_gp: mmu at e62a0000 {
-		compatible = "renesas,ipmmu-r8a7794", "renesas,ipmmu-vmsa";
-		reg = <0 0xe62a0000 0 0x1000>;
-		interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>;
-		#iommu-cells = <1>;
-		status = "disabled";
-	};
-
-	rcar_sound: sound at ec500000 {
-		/*
-		 * #sound-dai-cells is required
-		 *
-		 * Single DAI : #sound-dai-cells = <0>;         <&rcar_sound>;
-		 * Multi  DAI : #sound-dai-cells = <1>;         <&rcar_sound N>;
-		 */
-		compatible = "renesas,rcar_sound-r8a7794",
-			     "renesas,rcar_sound-gen2";
-		reg = <0 0xec500000 0 0x1000>, /* SCU */
-		      <0 0xec5a0000 0 0x100>,  /* ADG */
-		      <0 0xec540000 0 0x1000>, /* SSIU */
-		      <0 0xec541000 0 0x280>,  /* SSI */
-		      <0 0xec740000 0 0x200>;  /* Audio DMAC peri peri */
-		reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
-
-		clocks = <&cpg CPG_MOD 1005>,
-			 <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
-			 <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
-			 <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
-			 <&cpg CPG_MOD 1012>, <&cpg CPG_MOD 1013>,
-			 <&cpg CPG_MOD 1014>, <&cpg CPG_MOD 1015>,
-			 <&cpg CPG_MOD 1025>, <&cpg CPG_MOD 1026>,
-			 <&cpg CPG_MOD 1027>, <&cpg CPG_MOD 1028>,
-			 <&cpg CPG_MOD 1029>, <&cpg CPG_MOD 1030>,
-			 <&cpg CPG_MOD 1021>, <&cpg CPG_MOD 1020>,
-			 <&cpg CPG_MOD 1021>, <&cpg CPG_MOD 1020>,
-			 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
-			 <&audio_clka>, <&audio_clkb>, <&audio_clkc>,
-			 <&cpg CPG_CORE R8A7794_CLK_M2>;
-		clock-names = "ssi-all",
-			      "ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
-			      "ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0",
-			      "src.6", "src.5", "src.4", "src.3", "src.2",
-			      "src.1",
-			      "ctu.0", "ctu.1",
-			      "mix.0", "mix.1",
-			      "dvc.0", "dvc.1",
-			      "clk_a", "clk_b", "clk_c", "clk_i";
-		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
-		resets = <&cpg 1005>,
-			 <&cpg 1006>, <&cpg 1007>, <&cpg 1008>, <&cpg 1009>,
-			 <&cpg 1010>, <&cpg 1011>, <&cpg 1012>, <&cpg 1013>,
-			 <&cpg 1014>, <&cpg 1015>;
-		reset-names = "ssi-all",
-			      "ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
-			      "ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0";
-
-		status = "disabled";
-
-		rcar_sound,dvc {
-			dvc0: dvc-0 {
-				dmas = <&audma0 0xbc>;
-				dma-names = "tx";
-			};
-			dvc1: dvc-1 {
-				dmas = <&audma0 0xbe>;
-				dma-names = "tx";
-			};
-		};
-
-		rcar_sound,mix {
-			mix0: mix-0 { };
-			mix1: mix-1 { };
-		};
-
-		rcar_sound,ctu {
-			ctu00: ctu-0 { };
-			ctu01: ctu-1 { };
-			ctu02: ctu-2 { };
-			ctu03: ctu-3 { };
-			ctu10: ctu-4 { };
-			ctu11: ctu-5 { };
-			ctu12: ctu-6 { };
-			ctu13: ctu-7 { };
-		};
-
-		rcar_sound,src {
-			src-0 {
-				status = "disabled";
-			};
-			src1: src-1 {
-				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
-				dmas = <&audma0 0x87>, <&audma0 0x9c>;
-				dma-names = "rx", "tx";
-			};
-			src2: src-2 {
-				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
-				dmas = <&audma0 0x89>, <&audma0 0x9e>;
-				dma-names = "rx", "tx";
-			};
-			src3: src-3 {
-				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
-				dmas = <&audma0 0x8b>, <&audma0 0xa0>;
-				dma-names = "rx", "tx";
-			};
-			src4: src-4 {
-				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
-				dmas = <&audma0 0x8d>, <&audma0 0xb0>;
-				dma-names = "rx", "tx";
-			};
-			src5: src-5 {
-				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
-				dmas = <&audma0 0x8f>, <&audma0 0xb2>;
-				dma-names = "rx", "tx";
-			};
-			src6: src-6 {
-				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
-				dmas = <&audma0 0x91>, <&audma0 0xb4>;
-				dma-names = "rx", "tx";
-			};
-		};
-
-		rcar_sound,ssi {
-			ssi0: ssi-0 {
-				interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
-				dmas = <&audma0 0x01>, <&audma0 0x02>,
-				       <&audma0 0x15>, <&audma0 0x16>;
-				dma-names = "rx", "tx", "rxu", "txu";
-			};
-			ssi1: ssi-1 {
-				interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
-				dmas = <&audma0 0x03>, <&audma0 0x04>,
-				       <&audma0 0x49>, <&audma0 0x4a>;
-				dma-names = "rx", "tx", "rxu", "txu";
-			};
-			ssi2: ssi-2 {
-				interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>;
-				dmas = <&audma0 0x05>, <&audma0 0x06>,
-				       <&audma0 0x63>, <&audma0 0x64>;
-				dma-names = "rx", "tx", "rxu", "txu";
-			};
-			ssi3: ssi-3 {
-				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
-				dmas = <&audma0 0x07>, <&audma0 0x08>,
-				       <&audma0 0x6f>, <&audma0 0x70>;
-				dma-names = "rx", "tx", "rxu", "txu";
-			};
-			ssi4: ssi-4 {
-				interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>;
-				dmas = <&audma0 0x09>, <&audma0 0x0a>,
-				       <&audma0 0x71>, <&audma0 0x72>;
-				dma-names = "rx", "tx", "rxu", "txu";
-			};
-			ssi5: ssi-5 {
-				interrupts = <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
-				dmas = <&audma0 0x0b>, <&audma0 0x0c>,
-				       <&audma0 0x73>, <&audma0 0x74>;
-				dma-names = "rx", "tx", "rxu", "txu";
-			};
-			ssi6: ssi-6 {
-				interrupts = <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>;
-				dmas = <&audma0 0x0d>, <&audma0 0x0e>,
-				       <&audma0 0x75>, <&audma0 0x76>;
-				dma-names = "rx", "tx", "rxu", "txu";
-			};
-			ssi7: ssi-7 {
-				interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>;
-				dmas = <&audma0 0x0f>, <&audma0 0x10>,
-				       <&audma0 0x79>, <&audma0 0x7a>;
-				dma-names = "rx", "tx", "rxu", "txu";
-			};
-			ssi8: ssi-8 {
-				interrupts = <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>;
-				dmas = <&audma0 0x11>, <&audma0 0x12>,
-				       <&audma0 0x7b>, <&audma0 0x7c>;
-				dma-names = "rx", "tx", "rxu", "txu";
-			};
-			ssi9: ssi-9 {
-				interrupts = <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
-				dmas = <&audma0 0x13>, <&audma0 0x14>,
-				       <&audma0 0x7d>, <&audma0 0x7e>;
-				dma-names = "rx", "tx", "rxu", "txu";
-			};
-		};
-	};
 };
-- 
2.11.0
