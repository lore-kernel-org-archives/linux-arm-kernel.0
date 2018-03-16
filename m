From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:53:02 +0100
Subject: [PATCH 43/52] ARM: dts: r7s72100: add soc node
In-Reply-To: <cover.1521208546.git.horms+renesas@verge.net.au>
References: <cover.1521208546.git.horms+renesas@verge.net.au>
Message-ID: <85d4985a37ac170a927f7a43a95d310b3ca99e61.1521208546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add soc node to represent the bus and move all nodes with a base address
into this node. This is consistent with handling of R-Car Gen3 and Gen2
SoCs in mainline. It is intended to migrate other Renesas ARM-based
SoCs to this scheme.

The ordering is derived from simply moving each node with an address up to
before any nodes without a base address that occur before the soc node.  To
improve maintainability follow-up patches will sort subnodes of both the
new soc node and the root node.

This patch should not introduce any functional change.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r7s72100.dtsi | 910 ++++++++++++++++++++--------------------
 1 file changed, 459 insertions(+), 451 deletions(-)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index bd6366d1800b..0aa74355e24f 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -15,7 +15,6 @@
 
 / {
 	compatible = "renesas,r7s72100";
-	interrupt-parent = <&gic>;
 	#address-cells = <1>;
 	#size-cells = <1>;
 
@@ -87,6 +86,29 @@
 			clock-mult = <1>;
 			clock-div = <12>;
 		};
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+			clock-frequency = <400000000>;
+			clocks = <&cpg_clocks R7S72100_CLK_I>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
 
 		/* Special CPG clocks */
 		cpg_clocks: cpg_clocks at fcfe0000 {
@@ -192,499 +214,485 @@
 			>;
 			clock-output-names = "sdhi00", "sdhi01", "sdhi10", "sdhi11";
 		};
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
 
-		cpu at 0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a9";
-			reg = <0>;
-			clock-frequency = <400000000>;
-			clocks = <&cpg_clocks R7S72100_CLK_I>;
-			next-level-cache = <&L2>;
+		pinctrl: pin-controller at fcfe3000 {
+			compatible = "renesas,r7s72100-ports";
+
+			reg = <0xfcfe3000 0x4230>;
+
+			port0: gpio-0 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 0 6>;
+			};
+
+			port1: gpio-1 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 16 16>;
+			};
+
+			port2: gpio-2 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 32 16>;
+			};
+
+			port3: gpio-3 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 48 16>;
+			};
+
+			port4: gpio-4 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 64 16>;
+			};
+
+			port5: gpio-5 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 80 11>;
+			};
+
+			port6: gpio-6 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 96 16>;
+			};
+
+			port7: gpio-7 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 112 16>;
+			};
+
+			port8: gpio-8 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 128 16>;
+			};
+
+			port9: gpio-9 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 144 8>;
+			};
+
+			port10: gpio-10 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 160 16>;
+			};
+
+			port11: gpio-11 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 176 16>;
+			};
 		};
-	};
 
-	pinctrl: pin-controller at fcfe3000 {
-		compatible = "renesas,r7s72100-ports";
-
-		reg = <0xfcfe3000 0x4230>;
-
-		port0: gpio-0 {
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-ranges = <&pinctrl 0 0 6>;
+		scif0: serial at e8007000 {
+			compatible = "renesas,scif-r7s72100", "renesas,scif";
+			reg = <0xe8007000 64>;
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp4_clks R7S72100_CLK_SCIF0>;
+			clock-names = "fck";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
 		};
 
-		port1: gpio-1 {
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-ranges = <&pinctrl 0 16 16>;
+		scif1: serial at e8007800 {
+			compatible = "renesas,scif-r7s72100", "renesas,scif";
+			reg = <0xe8007800 64>;
+			interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp4_clks R7S72100_CLK_SCIF1>;
+			clock-names = "fck";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
 		};
 
-		port2: gpio-2 {
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-ranges = <&pinctrl 0 32 16>;
+		scif2: serial at e8008000 {
+			compatible = "renesas,scif-r7s72100", "renesas,scif";
+			reg = <0xe8008000 64>;
+			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp4_clks R7S72100_CLK_SCIF2>;
+			clock-names = "fck";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
 		};
 
-		port3: gpio-3 {
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-ranges = <&pinctrl 0 48 16>;
+		scif3: serial at e8008800 {
+			compatible = "renesas,scif-r7s72100", "renesas,scif";
+			reg = <0xe8008800 64>;
+			interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp4_clks R7S72100_CLK_SCIF3>;
+			clock-names = "fck";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
 		};
 
-		port4: gpio-4 {
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-ranges = <&pinctrl 0 64 16>;
+		scif4: serial at e8009000 {
+			compatible = "renesas,scif-r7s72100", "renesas,scif";
+			reg = <0xe8009000 64>;
+			interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp4_clks R7S72100_CLK_SCIF4>;
+			clock-names = "fck";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
 		};
 
-		port5: gpio-5 {
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-ranges = <&pinctrl 0 80 11>;
+		scif5: serial at e8009800 {
+			compatible = "renesas,scif-r7s72100", "renesas,scif";
+			reg = <0xe8009800 64>;
+			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp4_clks R7S72100_CLK_SCIF5>;
+			clock-names = "fck";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
 		};
 
-		port6: gpio-6 {
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-ranges = <&pinctrl 0 96 16>;
+		scif6: serial at e800a000 {
+			compatible = "renesas,scif-r7s72100", "renesas,scif";
+			reg = <0xe800a000 64>;
+			interrupts = <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp4_clks R7S72100_CLK_SCIF6>;
+			clock-names = "fck";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
 		};
 
-		port7: gpio-7 {
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-ranges = <&pinctrl 0 112 16>;
+		scif7: serial at e800a800 {
+			compatible = "renesas,scif-r7s72100", "renesas,scif";
+			reg = <0xe800a800 64>;
+			interrupts = <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp4_clks R7S72100_CLK_SCIF7>;
+			clock-names = "fck";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
 		};
 
-		port8: gpio-8 {
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-ranges = <&pinctrl 0 128 16>;
+		spi0: spi at e800c800 {
+			compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
+			reg = <0xe800c800 0x24>;
+			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error", "rx", "tx";
+			clocks = <&mstp10_clks R7S72100_CLK_SPI0>;
+			power-domains = <&cpg_clocks>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
 		};
 
-		port9: gpio-9 {
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-ranges = <&pinctrl 0 144 8>;
+		spi1: spi at e800d000 {
+			compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
+			reg = <0xe800d000 0x24>;
+			interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error", "rx", "tx";
+			clocks = <&mstp10_clks R7S72100_CLK_SPI1>;
+			power-domains = <&cpg_clocks>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
 		};
 
-		port10: gpio-10 {
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-ranges = <&pinctrl 0 160 16>;
+		spi2: spi at e800d800 {
+			compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
+			reg = <0xe800d800 0x24>;
+			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error", "rx", "tx";
+			clocks = <&mstp10_clks R7S72100_CLK_SPI2>;
+			power-domains = <&cpg_clocks>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
 		};
 
-		port11: gpio-11 {
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-ranges = <&pinctrl 0 176 16>;
+		spi3: spi at e800e000 {
+			compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
+			reg = <0xe800e000 0x24>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error", "rx", "tx";
+			clocks = <&mstp10_clks R7S72100_CLK_SPI3>;
+			power-domains = <&cpg_clocks>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
 		};
-	};
-
-	scif0: serial at e8007000 {
-		compatible = "renesas,scif-r7s72100", "renesas,scif";
-		reg = <0xe8007000 64>;
-		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp4_clks R7S72100_CLK_SCIF0>;
-		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
-		status = "disabled";
-	};
-
-	scif1: serial at e8007800 {
-		compatible = "renesas,scif-r7s72100", "renesas,scif";
-		reg = <0xe8007800 64>;
-		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp4_clks R7S72100_CLK_SCIF1>;
-		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
-		status = "disabled";
-	};
-
-	scif2: serial at e8008000 {
-		compatible = "renesas,scif-r7s72100", "renesas,scif";
-		reg = <0xe8008000 64>;
-		interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp4_clks R7S72100_CLK_SCIF2>;
-		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
-		status = "disabled";
-	};
-
-	scif3: serial at e8008800 {
-		compatible = "renesas,scif-r7s72100", "renesas,scif";
-		reg = <0xe8008800 64>;
-		interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp4_clks R7S72100_CLK_SCIF3>;
-		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
-		status = "disabled";
-	};
-
-	scif4: serial at e8009000 {
-		compatible = "renesas,scif-r7s72100", "renesas,scif";
-		reg = <0xe8009000 64>;
-		interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp4_clks R7S72100_CLK_SCIF4>;
-		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
-		status = "disabled";
-	};
-
-	scif5: serial at e8009800 {
-		compatible = "renesas,scif-r7s72100", "renesas,scif";
-		reg = <0xe8009800 64>;
-		interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp4_clks R7S72100_CLK_SCIF5>;
-		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
-		status = "disabled";
-	};
-
-	scif6: serial at e800a000 {
-		compatible = "renesas,scif-r7s72100", "renesas,scif";
-		reg = <0xe800a000 64>;
-		interrupts = <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp4_clks R7S72100_CLK_SCIF6>;
-		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
-		status = "disabled";
-	};
-
-	scif7: serial at e800a800 {
-		compatible = "renesas,scif-r7s72100", "renesas,scif";
-		reg = <0xe800a800 64>;
-		interrupts = <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp4_clks R7S72100_CLK_SCIF7>;
-		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
-		status = "disabled";
-	};
-
-	spi0: spi at e800c800 {
-		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
-		reg = <0xe800c800 0x24>;
-		interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "error", "rx", "tx";
-		clocks = <&mstp10_clks R7S72100_CLK_SPI0>;
-		power-domains = <&cpg_clocks>;
-		num-cs = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
-
-	spi1: spi at e800d000 {
-		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
-		reg = <0xe800d000 0x24>;
-		interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "error", "rx", "tx";
-		clocks = <&mstp10_clks R7S72100_CLK_SPI1>;
-		power-domains = <&cpg_clocks>;
-		num-cs = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
-
-	spi2: spi at e800d800 {
-		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
-		reg = <0xe800d800 0x24>;
-		interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "error", "rx", "tx";
-		clocks = <&mstp10_clks R7S72100_CLK_SPI2>;
-		power-domains = <&cpg_clocks>;
-		num-cs = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
 
-	spi3: spi at e800e000 {
-		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
-		reg = <0xe800e000 0x24>;
-		interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "error", "rx", "tx";
-		clocks = <&mstp10_clks R7S72100_CLK_SPI3>;
-		power-domains = <&cpg_clocks>;
-		num-cs = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
-
-	spi4: spi at e800e800 {
-		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
-		reg = <0xe800e800 0x24>;
-		interrupts = <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "error", "rx", "tx";
-		clocks = <&mstp10_clks R7S72100_CLK_SPI4>;
-		power-domains = <&cpg_clocks>;
-		num-cs = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
+		spi4: spi at e800e800 {
+			compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
+			reg = <0xe800e800 0x24>;
+			interrupts = <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error", "rx", "tx";
+			clocks = <&mstp10_clks R7S72100_CLK_SPI4>;
+			power-domains = <&cpg_clocks>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 
-	gic: interrupt-controller at e8201000 {
-		compatible = "arm,pl390";
-		#interrupt-cells = <3>;
-		#address-cells = <0>;
-		interrupt-controller;
-		reg = <0xe8201000 0x1000>,
-			<0xe8202000 0x1000>;
-	};
+		gic: interrupt-controller at e8201000 {
+			compatible = "arm,pl390";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0xe8201000 0x1000>,
+				<0xe8202000 0x1000>;
+		};
 
-	L2: cache-controller at 3ffff000 {
-		compatible = "arm,pl310-cache";
-		reg = <0x3ffff000 0x1000>;
-		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-		arm,early-bresp-disable;
-		arm,full-line-zero-disable;
-		cache-unified;
-		cache-level = <2>;
-	};
+		L2: cache-controller at 3ffff000 {
+			compatible = "arm,pl310-cache";
+			reg = <0x3ffff000 0x1000>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			arm,early-bresp-disable;
+			arm,full-line-zero-disable;
+			cache-unified;
+			cache-level = <2>;
+		};
 
-	wdt: watchdog at fcfe0000 {
-		compatible = "renesas,r7s72100-wdt", "renesas,rza-wdt";
-		reg = <0xfcfe0000 0x6>;
-		interrupts = <GIC_SPI 106 IRQ_TYPE_EDGE_RISING>;
-		clocks = <&p0_clk>;
-	};
+		wdt: watchdog at fcfe0000 {
+			compatible = "renesas,r7s72100-wdt", "renesas,rza-wdt";
+			reg = <0xfcfe0000 0x6>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&p0_clk>;
+		};
 
-	i2c0: i2c at fcfee000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
-		reg = <0xfcfee000 0x44>;
-		interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 158 IRQ_TYPE_EDGE_RISING>,
-			     <GIC_SPI 159 IRQ_TYPE_EDGE_RISING>,
-			     <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R7S72100_CLK_I2C0>;
-		clock-frequency = <100000>;
-		power-domains = <&cpg_clocks>;
-		status = "disabled";
-	};
+		i2c0: i2c at fcfee000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
+			reg = <0xfcfee000 0x44>;
+			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 158 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 159 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R7S72100_CLK_I2C0>;
+			clock-frequency = <100000>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
 
-	i2c1: i2c at fcfee400 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
-		reg = <0xfcfee400 0x44>;
-		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 166 IRQ_TYPE_EDGE_RISING>,
-			     <GIC_SPI 167 IRQ_TYPE_EDGE_RISING>,
-			     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R7S72100_CLK_I2C1>;
-		clock-frequency = <100000>;
-		power-domains = <&cpg_clocks>;
-		status = "disabled";
-	};
+		i2c1: i2c at fcfee400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
+			reg = <0xfcfee400 0x44>;
+			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 166 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 167 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R7S72100_CLK_I2C1>;
+			clock-frequency = <100000>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
 
-	i2c2: i2c at fcfee800 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
-		reg = <0xfcfee800 0x44>;
-		interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 174 IRQ_TYPE_EDGE_RISING>,
-			     <GIC_SPI 175 IRQ_TYPE_EDGE_RISING>,
-			     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R7S72100_CLK_I2C2>;
-		clock-frequency = <100000>;
-		power-domains = <&cpg_clocks>;
-		status = "disabled";
-	};
+		i2c2: i2c at fcfee800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
+			reg = <0xfcfee800 0x44>;
+			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 174 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 175 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R7S72100_CLK_I2C2>;
+			clock-frequency = <100000>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
 
-	i2c3: i2c at fcfeec00 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
-		reg = <0xfcfeec00 0x44>;
-		interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 182 IRQ_TYPE_EDGE_RISING>,
-			     <GIC_SPI 183 IRQ_TYPE_EDGE_RISING>,
-			     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R7S72100_CLK_I2C3>;
-		clock-frequency = <100000>;
-		power-domains = <&cpg_clocks>;
-		status = "disabled";
-	};
+		i2c3: i2c at fcfeec00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
+			reg = <0xfcfeec00 0x44>;
+			interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 182 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 183 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R7S72100_CLK_I2C3>;
+			clock-frequency = <100000>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
 
-	mtu2: timer at fcff0000 {
-		compatible = "renesas,mtu2-r7s72100", "renesas,mtu2";
-		reg = <0xfcff0000 0x400>;
-		interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "tgi0a";
-		clocks = <&mstp3_clks R7S72100_CLK_MTU2>;
-		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
-		status = "disabled";
-	};
+		mtu2: timer at fcff0000 {
+			compatible = "renesas,mtu2-r7s72100", "renesas,mtu2";
+			reg = <0xfcff0000 0x400>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tgi0a";
+			clocks = <&mstp3_clks R7S72100_CLK_MTU2>;
+			clock-names = "fck";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
 
-	ether: ethernet at e8203000 {
-		compatible = "renesas,ether-r7s72100";
-		reg = <0xe8203000 0x800>,
-		      <0xe8204800 0x200>;
-		interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R7S72100_CLK_ETHER>;
-		power-domains = <&cpg_clocks>;
-		phy-mode = "mii";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "disabled";
-	};
+		ether: ethernet at e8203000 {
+			compatible = "renesas,ether-r7s72100";
+			reg = <0xe8203000 0x800>,
+			      <0xe8204800 0x200>;
+			interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R7S72100_CLK_ETHER>;
+			power-domains = <&cpg_clocks>;
+			phy-mode = "mii";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 
-	mmcif: mmc at e804c800 {
-		compatible = "renesas,mmcif-r7s72100", "renesas,sh-mmcif";
-		reg = <0xe804c800 0x80>;
-		interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp8_clks R7S72100_CLK_MMCIF>;
-		power-domains = <&cpg_clocks>;
-		reg-io-width = <4>;
-		bus-width = <8>;
-		status = "disabled";
-	};
+		mmcif: mmc at e804c800 {
+			compatible = "renesas,mmcif-r7s72100", "renesas,sh-mmcif";
+			reg = <0xe804c800 0x80>;
+			interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R7S72100_CLK_MMCIF>;
+			power-domains = <&cpg_clocks>;
+			reg-io-width = <4>;
+			bus-width = <8>;
+			status = "disabled";
+		};
 
-	sdhi0: sd at e804e000 {
-		compatible = "renesas,sdhi-r7s72100";
-		reg = <0xe804e000 0x100>;
-		interrupts = <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
-
-		clocks = <&mstp12_clks R7S72100_CLK_SDHI00>,
-			 <&mstp12_clks R7S72100_CLK_SDHI01>;
-		clock-names = "core", "cd";
-		power-domains = <&cpg_clocks>;
-		cap-sd-highspeed;
-		cap-sdio-irq;
-		status = "disabled";
-	};
+		sdhi0: sd at e804e000 {
+			compatible = "renesas,sdhi-r7s72100";
+			reg = <0xe804e000 0x100>;
+			interrupts = <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&mstp12_clks R7S72100_CLK_SDHI00>,
+				 <&mstp12_clks R7S72100_CLK_SDHI01>;
+			clock-names = "core", "cd";
+			power-domains = <&cpg_clocks>;
+			cap-sd-highspeed;
+			cap-sdio-irq;
+			status = "disabled";
+		};
 
-	sdhi1: sd at e804e800 {
-		compatible = "renesas,sdhi-r7s72100";
-		reg = <0xe804e800 0x100>;
-		interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>;
-
-		clocks = <&mstp12_clks R7S72100_CLK_SDHI10>,
-			 <&mstp12_clks R7S72100_CLK_SDHI11>;
-		clock-names = "core", "cd";
-		power-domains = <&cpg_clocks>;
-		cap-sd-highspeed;
-		cap-sdio-irq;
-		status = "disabled";
-	};
+		sdhi1: sd at e804e800 {
+			compatible = "renesas,sdhi-r7s72100";
+			reg = <0xe804e800 0x100>;
+			interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&mstp12_clks R7S72100_CLK_SDHI10>,
+				 <&mstp12_clks R7S72100_CLK_SDHI11>;
+			clock-names = "core", "cd";
+			power-domains = <&cpg_clocks>;
+			cap-sd-highspeed;
+			cap-sdio-irq;
+			status = "disabled";
+		};
 
-	ostm0: timer at fcfec000 {
-		compatible = "renesas,r7s72100-ostm", "renesas,ostm";
-		reg = <0xfcfec000 0x30>;
-		interrupts = <GIC_SPI 102 IRQ_TYPE_EDGE_RISING>;
-		clocks = <&mstp5_clks R7S72100_CLK_OSTM0>;
-		power-domains = <&cpg_clocks>;
-		status = "disabled";
-	};
+		ostm0: timer at fcfec000 {
+			compatible = "renesas,r7s72100-ostm", "renesas,ostm";
+			reg = <0xfcfec000 0x30>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&mstp5_clks R7S72100_CLK_OSTM0>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
 
-	ostm1: timer at fcfec400 {
-		compatible = "renesas,r7s72100-ostm", "renesas,ostm";
-		reg = <0xfcfec400 0x30>;
-		interrupts = <GIC_SPI 103 IRQ_TYPE_EDGE_RISING>;
-		clocks = <&mstp5_clks R7S72100_CLK_OSTM1>;
-		power-domains = <&cpg_clocks>;
-		status = "disabled";
-	};
+		ostm1: timer at fcfec400 {
+			compatible = "renesas,r7s72100-ostm", "renesas,ostm";
+			reg = <0xfcfec400 0x30>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&mstp5_clks R7S72100_CLK_OSTM1>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
 
-	rtc: rtc at fcff1000 {
-		compatible = "renesas,r7s72100-rtc", "renesas,sh-rtc";
-		reg = <0xfcff1000 0x2e>;
-		interrupts = <GIC_SPI 276 IRQ_TYPE_EDGE_RISING
-			      GIC_SPI 277 IRQ_TYPE_EDGE_RISING
-			      GIC_SPI 278 IRQ_TYPE_EDGE_RISING>;
-		interrupt-names = "alarm", "period", "carry";
-		clocks = <&mstp6_clks R7S72100_CLK_RTC>, <&rtc_x1_clk>,
-			 <&rtc_x3_clk>, <&extal_clk>;
-		clock-names = "fck", "rtc_x1", "rtc_x3", "extal";
-		power-domains = <&cpg_clocks>;
-		status = "disabled";
-	};
+		rtc: rtc at fcff1000 {
+			compatible = "renesas,r7s72100-rtc", "renesas,sh-rtc";
+			reg = <0xfcff1000 0x2e>;
+			interrupts = <GIC_SPI 276 IRQ_TYPE_EDGE_RISING
+				      GIC_SPI 277 IRQ_TYPE_EDGE_RISING
+				      GIC_SPI 278 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "alarm", "period", "carry";
+			clocks = <&mstp6_clks R7S72100_CLK_RTC>, <&rtc_x1_clk>,
+				 <&rtc_x3_clk>, <&extal_clk>;
+			clock-names = "fck", "rtc_x1", "rtc_x3", "extal";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
 
-	usbhs0: usb at e8010000 {
-		compatible = "renesas,usbhs-r7s72100", "renesas,rza1-usbhs";
-		reg = <0xe8010000 0x1a0>;
-		interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R7S72100_CLK_USB0>;
-		renesas,buswait = <4>;
-		power-domains = <&cpg_clocks>;
-		status = "disabled";
-	};
+		usbhs0: usb at e8010000 {
+			compatible = "renesas,usbhs-r7s72100", "renesas,rza1-usbhs";
+			reg = <0xe8010000 0x1a0>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R7S72100_CLK_USB0>;
+			renesas,buswait = <4>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
 
-	usbhs1: usb at e8207000 {
-		compatible = "renesas,usbhs-r7s72100", "renesas,rza1-usbhs";
-		reg = <0xe8207000 0x1a0>;
-		interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R7S72100_CLK_USB1>;
-		renesas,buswait = <4>;
-		power-domains = <&cpg_clocks>;
-		status = "disabled";
+		usbhs1: usb at e8207000 {
+			compatible = "renesas,usbhs-r7s72100", "renesas,rza1-usbhs";
+			reg = <0xe8207000 0x1a0>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R7S72100_CLK_USB1>;
+			renesas,buswait = <4>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.11.0
