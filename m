From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 17:38:24 +0100
Subject: [PATCH 27/47] ARM: dts: r8a7743: sort subnodes of soc node
In-Reply-To: <cover.1521218085.git.horms+renesas@verge.net.au>
References: <cover.1521218085.git.horms+renesas@verge.net.au>
Message-ID: <8eccafe92d100d836dfee541c3337b42d818533c.1521218085.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort the subnodes of the soc node to improve maintainability.
The sort key is the address on the bus with instances of the same
IP block grouped together and sorted alphabetically.

Minor whitespace and line-wrapping changes are also made
to match the formatting of R-Car Gen2 SoCs.

This patch should not introduce any functional change.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7743.dtsi | 1327 ++++++++++++++++++++--------------------
 1 file changed, 662 insertions(+), 665 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 0b74c6c7d21d..1933aaccb874 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -141,29 +141,6 @@
 		#size-cells = <2>;
 		ranges;
 
-		apmu at e6152000 {
-			compatible = "renesas,r8a7743-apmu", "renesas,apmu";
-			reg = <0 0xe6152000 0 0x188>;
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
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) |
-						 IRQ_TYPE_LEVEL_HIGH)>;
-			clocks = <&cpg CPG_MOD 408>;
-			clock-names = "clk";
-			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 408>;
-		};
-
 		gpio0: gpio at e6050000 {
 			compatible = "renesas,gpio-r8a7743",
 				     "renesas,rcar-gen2-gpio";
@@ -284,6 +261,48 @@
 			resets = <&cpg 904>;
 		};
 
+		pfc: pin-controller at e6060000 {
+			compatible = "renesas,pfc-r8a7743";
+			reg = <0 0xe6060000 0 0x250>;
+		};
+
+		tpu: pwm at e60f0000 {
+			compatible = "renesas,tpu-r8a7743", "renesas,tpu";
+			reg = <0 0xe60f0000 0 0x148>;
+			clocks = <&cpg CPG_MOD 304>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 304>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		cpg: clock-controller at e6150000 {
+			compatible = "renesas,r8a7743-cpg-mssr";
+			reg = <0 0xe6150000 0 0x1000>;
+			clocks = <&extal_clk>, <&usb_extal_clk>;
+			clock-names = "extal", "usb_extal";
+			#clock-cells = <2>;
+			#power-domain-cells = <0>;
+			#reset-cells = <1>;
+		};
+
+		apmu at e6152000 {
+			compatible = "renesas,r8a7743-apmu", "renesas,apmu";
+			reg = <0 0xe6152000 0 0x188>;
+			cpus = <&cpu0 &cpu1>;
+		};
+
+		rst: reset-controller at e6160000 {
+			compatible = "renesas,r8a7743-rst";
+			reg = <0 0xe6160000 0 0x100>;
+		};
+
+		sysc: system-controller at e6180000 {
+			compatible = "renesas,r8a7743-sysc";
+			reg = <0 0xe6180000 0 0x200>;
+			#power-domain-cells = <1>;
+		};
+
 		irqc: interrupt-controller at e61c0000 {
 			compatible = "renesas,irqc-r8a7743", "renesas,irqc";
 			#interrupt-cells = <2>;
@@ -316,195 +335,206 @@
 			#thermal-sensor-cells = <0>;
 		};
 
-		cmt0: timer at ffca0000 {
-			compatible = "renesas,r8a7743-cmt0",
-				     "renesas,rcar-gen2-cmt0";
-			reg = <0 0xffca0000 0 0x1004>;
-			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 124>;
-			clock-names = "fck";
+		icram0:	sram at e63a0000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe63a0000 0 0x12000>;
+		};
+
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
+		};
+
+		icram2:	sram at e6300000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe6300000 0 0x40000>;
+		};
+
+		/* The memory map in the User's Manual maps the cores to
+		 * bus numbers
+		 */
+		i2c0: i2c at e6508000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7743",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6508000 0 0x40>;
+			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 931>;
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 124>;
+			resets = <&cpg 931>;
+			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
 
-		cmt1: timer at e6130000 {
-			compatible = "renesas,r8a7743-cmt1",
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
+		i2c1: i2c at e6518000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7743",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6518000 0 0x40>;
+			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 930>;
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 329>;
+			resets = <&cpg 930>;
+			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
 
-		cpg: clock-controller at e6150000 {
-			compatible = "renesas,r8a7743-cpg-mssr";
-			reg = <0 0xe6150000 0 0x1000>;
-			clocks = <&extal_clk>, <&usb_extal_clk>;
-			clock-names = "extal", "usb_extal";
-			#clock-cells = <2>;
-			#power-domain-cells = <0>;
-			#reset-cells = <1>;
+		i2c2: i2c at e6530000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7743",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6530000 0 0x40>;
+			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 929>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 929>;
+			i2c-scl-internal-delay-ns = <6>;
+			status = "disabled";
 		};
 
-		prr: chipid at ff000044 {
-			compatible = "renesas,prr";
-			reg = <0 0xff000044 0 4>;
+		i2c3: i2c at e6540000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7743",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6540000 0 0x40>;
+			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 928>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 928>;
+			i2c-scl-internal-delay-ns = <6>;
+			status = "disabled";
 		};
 
-		rst: reset-controller at e6160000 {
-			compatible = "renesas,r8a7743-rst";
-			reg = <0 0xe6160000 0 0x100>;
+		i2c4: i2c at e6520000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7743",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6520000 0 0x40>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 927>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 927>;
+			i2c-scl-internal-delay-ns = <6>;
+			status = "disabled";
 		};
 
-		sysc: system-controller at e6180000 {
-			compatible = "renesas,r8a7743-sysc";
-			reg = <0 0xe6180000 0 0x200>;
-			#power-domain-cells = <1>;
+		i2c5: i2c at e6528000 {
+			/* doesn't need pinmux */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7743",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6528000 0 0x40>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 925>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 925>;
+			i2c-scl-internal-delay-ns = <110>;
+			status = "disabled";
 		};
 
-		pfc: pin-controller at e6060000 {
-			compatible = "renesas,pfc-r8a7743";
-			reg = <0 0xe6060000 0 0x250>;
+		iic0: i2c at e6500000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,iic-r8a7743",
+				     "renesas,rcar-gen2-iic",
+				     "renesas,rmobile-iic";
+			reg = <0 0xe6500000 0 0x425>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 318>;
+			dmas = <&dmac0 0x61>, <&dmac0 0x62>,
+			       <&dmac1 0x61>, <&dmac1 0x62>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 318>;
+			status = "disabled";
 		};
 
-		dmac0: dma-controller at e6700000 {
-			compatible = "renesas,dmac-r8a7743",
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
-					"ch0", "ch1", "ch2", "ch3",
-					"ch4", "ch5", "ch6", "ch7",
-					"ch8", "ch9", "ch10", "ch11",
-					"ch12", "ch13", "ch14";
-			clocks = <&cpg CPG_MOD 219>;
-			clock-names = "fck";
+		iic1: i2c at e6510000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,iic-r8a7743",
+				     "renesas,rcar-gen2-iic",
+				     "renesas,rmobile-iic";
+			reg = <0 0xe6510000 0 0x425>;
+			interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 323>;
+			dmas = <&dmac0 0x65>, <&dmac0 0x66>,
+			       <&dmac1 0x65>, <&dmac1 0x66>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 219>;
-			#dma-cells = <1>;
-			dma-channels = <15>;
+			resets = <&cpg 323>;
+			status = "disabled";
 		};
 
-		dmac1: dma-controller at e6720000 {
-			compatible = "renesas,dmac-r8a7743",
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
-					"ch0", "ch1", "ch2", "ch3",
-					"ch4", "ch5", "ch6", "ch7",
-					"ch8", "ch9", "ch10", "ch11",
-					"ch12", "ch13", "ch14";
-			clocks = <&cpg CPG_MOD 218>;
-			clock-names = "fck";
+		iic3: i2c at e60b0000 {
+			/* doesn't need pinmux */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,iic-r8a7743",
+				     "renesas,rcar-gen2-iic",
+				     "renesas,rmobile-iic";
+			reg = <0 0xe60b0000 0 0x425>;
+			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 926>;
+			dmas = <&dmac0 0x77>, <&dmac0 0x78>,
+			       <&dmac1 0x77>, <&dmac1 0x78>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 218>;
-			#dma-cells = <1>;
-			dma-channels = <15>;
+			resets = <&cpg 926>;
+			status = "disabled";
 		};
 
-		audma0: dma-controller at ec700000 {
-			compatible = "renesas,dmac-r8a7743",
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
-					  "ch0", "ch1", "ch2", "ch3",
-					  "ch4", "ch5", "ch6", "ch7",
-					  "ch8", "ch9", "ch10", "ch11",
-					  "ch12";
-			clocks = <&cpg CPG_MOD 502>;
-			clock-names = "fck";
+		hsusb: usb at e6590000 {
+			compatible = "renesas,usbhs-r8a7743",
+				     "renesas,rcar-gen2-usbhs";
+			reg = <0 0xe6590000 0 0x100>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 704>;
+			dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
+			       <&usb_dmac1 0>, <&usb_dmac1 1>;
+			dma-names = "ch0", "ch1", "ch2", "ch3";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 502>;
-			#dma-cells = <1>;
-			dma-channels = <13>;
+			resets = <&cpg 704>;
+			renesas,buswait = <4>;
+			phys = <&usb0 1>;
+			phy-names = "usb";
+			status = "disabled";
 		};
 
-		audma1: dma-controller at ec720000 {
-			compatible = "renesas,dmac-r8a7743",
-				     "renesas,rcar-dmac";
-			reg = <0 0xec720000 0 0x10000>;
-			interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "error",
-					  "ch0", "ch1", "ch2", "ch3",
-					  "ch4", "ch5", "ch6", "ch7",
-					  "ch8", "ch9", "ch10", "ch11",
-					  "ch12";
-			clocks = <&cpg CPG_MOD 501>;
-			clock-names = "fck";
+		usbphy: usb-phy at e6590100 {
+			compatible = "renesas,usb-phy-r8a7743",
+				     "renesas,rcar-gen2-usb-phy";
+			reg = <0 0xe6590100 0 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cpg CPG_MOD 704>;
+			clock-names = "usbhs";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 501>;
-			#dma-cells = <1>;
-			dma-channels = <13>;
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
 
 		usb_dmac0: dma-controller at e65a0000 {
@@ -535,143 +565,98 @@
 			dma-channels = <2>;
 		};
 
-		/* The memory map in the User's Manual maps the cores to bus
-		 *  numbers
-		 */
-		i2c0: i2c at e6508000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "renesas,i2c-r8a7743",
-				     "renesas,rcar-gen2-i2c";
-			reg = <0 0xe6508000 0 0x40>;
-			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 931>;
+		dmac0: dma-controller at e6700000 {
+			compatible = "renesas,dmac-r8a7743",
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
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 931>;
-			i2c-scl-internal-delay-ns = <6>;
-			status = "disabled";
+			resets = <&cpg 219>;
+			#dma-cells = <1>;
+			dma-channels = <15>;
 		};
 
-		i2c1: i2c at e6518000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "renesas,i2c-r8a7743",
-				     "renesas,rcar-gen2-i2c";
-			reg = <0 0xe6518000 0 0x40>;
-			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 930>;
+		dmac1: dma-controller at e6720000 {
+			compatible = "renesas,dmac-r8a7743",
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
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 930>;
-			i2c-scl-internal-delay-ns = <6>;
-			status = "disabled";
+			resets = <&cpg 218>;
+			#dma-cells = <1>;
+			dma-channels = <15>;
 		};
 
-		i2c2: i2c at e6530000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "renesas,i2c-r8a7743",
-				     "renesas,rcar-gen2-i2c";
-			reg = <0 0xe6530000 0 0x40>;
-			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 929>;
+		avb: ethernet at e6800000 {
+			compatible = "renesas,etheravb-r8a7743",
+				     "renesas,etheravb-rcar-gen2";
+			reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 812>;
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 929>;
-			i2c-scl-internal-delay-ns = <6>;
-			status = "disabled";
-		};
-
-		i2c3: i2c at e6540000 {
+			resets = <&cpg 812>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "renesas,i2c-r8a7743",
-				     "renesas,rcar-gen2-i2c";
-			reg = <0 0xe6540000 0 0x40>;
-			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 928>;
-			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 928>;
-			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
 
-		i2c4: i2c at e6520000 {
+		qspi: spi at e6b10000 {
+			compatible = "renesas,qspi-r8a7743", "renesas,qspi";
+			reg = <0 0xe6b10000 0 0x2c>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 917>;
+			dmas = <&dmac0 0x17>, <&dmac0 0x18>,
+			       <&dmac1 0x17>, <&dmac1 0x18>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "renesas,i2c-r8a7743",
-				     "renesas,rcar-gen2-i2c";
-			reg = <0 0xe6520000 0 0x40>;
-			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 927>;
-			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 927>;
-			i2c-scl-internal-delay-ns = <6>;
-			status = "disabled";
-		};
-
-		i2c5: i2c at e6528000 {
-			/* doesn't need pinmux */
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "renesas,i2c-r8a7743",
-				     "renesas,rcar-gen2-i2c";
-			reg = <0 0xe6528000 0 0x40>;
-			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 925>;
-			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 925>;
-			i2c-scl-internal-delay-ns = <110>;
-			status = "disabled";
-		};
-
-		iic0: i2c at e6500000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "renesas,iic-r8a7743",
-				     "renesas,rcar-gen2-iic",
-				     "renesas,rmobile-iic";
-			reg = <0 0xe6500000 0 0x425>;
-			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 318>;
-			dmas = <&dmac0 0x61>, <&dmac0 0x62>,
-			       <&dmac1 0x61>, <&dmac1 0x62>;
-			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 318>;
-			status = "disabled";
-		};
-
-		iic1: i2c at e6510000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "renesas,iic-r8a7743",
-				     "renesas,rcar-gen2-iic",
-				     "renesas,rmobile-iic";
-			reg = <0 0xe6510000 0 0x425>;
-			interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 323>;
-			dmas = <&dmac0 0x65>, <&dmac0 0x66>,
-			       <&dmac1 0x65>, <&dmac1 0x66>;
-			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 323>;
-			status = "disabled";
-		};
-
-		iic3: i2c at e60b0000 {
-			/* doesn't need pinmux */
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "renesas,iic-r8a7743",
-				     "renesas,rcar-gen2-iic",
-				     "renesas,rmobile-iic";
-			reg = <0 0xe60b0000 0 0x425>;
-			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 926>;
-			dmas = <&dmac0 0x77>, <&dmac0 0x78>,
-			       <&dmac1 0x77>, <&dmac1 0x78>;
-			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 926>;
+			resets = <&cpg 917>;
 			status = "disabled";
 		};
 
@@ -954,88 +939,6 @@
 			status = "disabled";
 		};
 
-		icram2:	sram at e6300000 {
-			compatible = "mmio-sram";
-			reg = <0 0xe6300000 0 0x40000>;
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
-		};
-
-		ether: ethernet at ee700000 {
-			compatible = "renesas,ether-r8a7743",
-				     "renesas,rcar-gen2-ether";
-			reg = <0 0xee700000 0 0x400>;
-			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 813>;
-			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 813>;
-			phy-mode = "rmii";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		avb: ethernet at e6800000 {
-			compatible = "renesas,etheravb-r8a7743",
-				     "renesas,etheravb-rcar-gen2";
-			reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
-			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 812>;
-			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 812>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		mmcif0: mmc at ee200000 {
-			compatible = "renesas,mmcif-r8a7743",
-				     "renesas,sh-mmcif";
-			reg = <0 0xee200000 0 0x80>;
-			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 315>;
-			dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
-			       <&dmac1 0xd1>, <&dmac1 0xd2>;
-			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 315>;
-			reg-io-width = <4>;
-			max-frequency = <97500000>;
-			status = "disabled";
-		};
-
-		qspi: spi at e6b10000 {
-			compatible = "renesas,qspi-r8a7743", "renesas,qspi";
-			reg = <0 0xe6b10000 0 0x2c>;
-			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 917>;
-			dmas = <&dmac0 0x17>, <&dmac0 0x18>,
-			       <&dmac1 0x17>, <&dmac1 0x18>;
-			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			num-cs = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			resets = <&cpg 917>;
-			status = "disabled";
-		};
-
 		msiof0: spi at e6e20000 {
 			compatible = "renesas,msiof-r8a7743",
 				     "renesas,rcar-gen2-msiof";
@@ -1084,26 +987,6 @@
 			status = "disabled";
 		};
 
-		/*
-		 * pci1 and xhci share the same phy, therefore only one of them
-		 * can be active at any one time. If both of them are enabled,
-		 * a race condition will determine who'll control the phy.
-		 * A firmware file is needed by the xhci driver in order for
-		 * USB 3.0 to work properly.
-		 */
-		xhci: usb at ee000000 {
-			compatible = "renesas,xhci-r8a7743",
-				     "renesas,rcar-gen2-xhci";
-			reg = <0 0xee000000 0 0xc00>;
-			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 328>;
-			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 328>;
-			phys = <&usb2 1>;
-			phy-names = "usb";
-			status = "disabled";
-		};
-
 		pwm0: pwm at e6e30000 {
 			compatible = "renesas,pwm-r8a7743", "renesas,pwm-rcar";
 			reg = <0 0xe6e30000 0 0x8>;
@@ -1174,119 +1057,53 @@
 			status = "disabled";
 		};
 
-		tpu: pwm at e60f0000 {
-			compatible = "renesas,tpu-r8a7743", "renesas,tpu";
-			reg = <0 0xe60f0000 0 0x148>;
-			clocks = <&cpg CPG_MOD 304>;
+		can0: can at e6e80000 {
+			compatible = "renesas,can-r8a7743",
+				     "renesas,rcar-gen2-can";
+			reg = <0 0xe6e80000 0 0x1000>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 916>,
+				 <&cpg CPG_CORE R8A7743_CLK_RCAN>,
+				 <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 304>;
-			#pwm-cells = <3>;
+			resets = <&cpg 916>;
 			status = "disabled";
 		};
 
-		sdhi0: sd at ee100000 {
-			compatible = "renesas,sdhi-r8a7743",
-				     "renesas,rcar-gen2-sdhi";
-			reg = <0 0xee100000 0 0x328>;
-			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 314>;
-			dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
-			       <&dmac1 0xcd>, <&dmac1 0xce>;
-			dma-names = "tx", "rx", "tx", "rx";
-			max-frequency = <195000000>;
+		can1: can at e6e88000 {
+			compatible = "renesas,can-r8a7743",
+				     "renesas,rcar-gen2-can";
+			reg = <0 0xe6e88000 0 0x1000>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 915>,
+				 <&cpg CPG_CORE R8A7743_CLK_RCAN>,
+				 <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 314>;
+			resets = <&cpg 915>;
 			status = "disabled";
 		};
 
-		sdhi1: sd at ee140000 {
-			compatible = "renesas,sdhi-r8a7743",
-				     "renesas,rcar-gen2-sdhi";
-			reg = <0 0xee140000 0 0x100>;
-			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 312>;
-			dmas = <&dmac0 0xc1>, <&dmac0 0xc2>,
-			       <&dmac1 0xc1>, <&dmac1 0xc2>;
-			dma-names = "tx", "rx", "tx", "rx";
-			max-frequency = <97500000>;
+		vin0: video at e6ef0000 {
+			compatible = "renesas,vin-r8a7743",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef0000 0 0x1000>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 811>;
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 312>;
+			resets = <&cpg 811>;
 			status = "disabled";
 		};
 
-		sdhi2: sd at ee160000 {
-			compatible = "renesas,sdhi-r8a7743",
-				     "renesas,rcar-gen2-sdhi";
-			reg = <0 0xee160000 0 0x100>;
-			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 311>;
-			dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
-			       <&dmac1 0xd3>, <&dmac1 0xd4>;
-			dma-names = "tx", "rx", "tx", "rx";
-			max-frequency = <97500000>;
+		vin1: video at e6ef1000 {
+			compatible = "renesas,vin-r8a7743",
+				     "renesas,rcar-gen2-vin";
+			reg = <0 0xe6ef1000 0 0x1000>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 810>;
 			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 311>;
-			status = "disabled";
-		};
-
-		hsusb: usb at e6590000 {
-			compatible = "renesas,usbhs-r8a7743",
-				     "renesas,rcar-gen2-usbhs";
-			reg = <0 0xe6590000 0 0x100>;
-			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 704>;
-			dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
-			       <&usb_dmac1 0>, <&usb_dmac1 1>;
-			dma-names = "ch0", "ch1", "ch2", "ch3";
-			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 704>;
-			renesas,buswait = <4>;
-			phys = <&usb0 1>;
-			phy-names = "usb";
-			status = "disabled";
-		};
-
-		usbphy: usb-phy at e6590100 {
-			compatible = "renesas,usb-phy-r8a7743",
-				     "renesas,rcar-gen2-usb-phy";
-			reg = <0 0xe6590100 0 0x100>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			clocks = <&cpg CPG_MOD 704>;
-			clock-names = "usbhs";
-			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 704>;
-			status = "disabled";
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
-		vin0: video at e6ef0000 {
-			compatible = "renesas,vin-r8a7743",
-				     "renesas,rcar-gen2-vin";
-			reg = <0 0xe6ef0000 0 0x1000>;
-			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 811>;
-			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 811>;
-			status = "disabled";
-		};
-
-		vin1: video at e6ef1000 {
-			compatible = "renesas,vin-r8a7743",
-				     "renesas,rcar-gen2-vin";
-			reg = <0 0xe6ef1000 0 0x1000>;
-			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 810>;
-			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 810>;
+			resets = <&cpg 810>;
 			status = "disabled";
 		};
 
@@ -1301,162 +1118,6 @@
 			status = "disabled";
 		};
 
-		du: display at feb00000 {
-			compatible = "renesas,du-r8a7743";
-			reg = <0 0xfeb00000 0 0x40000>,
-			      <0 0xfeb90000 0 0x1c>;
-			reg-names = "du", "lvds.0";
-			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 724>,
-				 <&cpg CPG_MOD 723>,
-				 <&cpg CPG_MOD 726>;
-			clock-names = "du.0", "du.1", "lvds.0";
-			status = "disabled";
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port at 0 {
-					reg = <0>;
-					du_out_rgb: endpoint {
-					};
-				};
-				port at 1 {
-					reg = <1>;
-					du_out_lvds0: endpoint {
-					};
-				};
-			};
-		};
-
-		can0: can at e6e80000 {
-			compatible = "renesas,can-r8a7743",
-				     "renesas,rcar-gen2-can";
-			reg = <0 0xe6e80000 0 0x1000>;
-			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 916>,
-				 <&cpg CPG_CORE R8A7743_CLK_RCAN>,
-				 <&can_clk>;
-			clock-names = "clkp1", "clkp2", "can_clk";
-			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 916>;
-			status = "disabled";
-		};
-
-		can1: can at e6e88000 {
-			compatible = "renesas,can-r8a7743",
-				     "renesas,rcar-gen2-can";
-			reg = <0 0xe6e88000 0 0x1000>;
-			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 915>,
-				 <&cpg CPG_CORE R8A7743_CLK_RCAN>,
-				 <&can_clk>;
-			clock-names = "clkp1", "clkp2", "can_clk";
-			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 915>;
-			status = "disabled";
-		};
-
-		pci0: pci at ee090000 {
-			compatible = "renesas,pci-r8a7743",
-				     "renesas,pci-rcar-gen2";
-			device_type = "pci";
-			reg = <0 0xee090000 0 0xc00>,
-			      <0 0xee080000 0 0x1100>;
-			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
-			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
-			status = "disabled";
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
-		};
-
-		pci1: pci at ee0d0000 {
-			compatible = "renesas,pci-r8a7743",
-				     "renesas,pci-rcar-gen2";
-			device_type = "pci";
-			reg = <0 0xee0d0000 0 0xc00>,
-			      <0 0xee0c0000 0 0x1100>;
-			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
-			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
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
-		pciec: pcie at fe000000 {
-			compatible = "renesas,pcie-r8a7743",
-				     "renesas,pcie-rcar-gen2";
-			reg = <0 0xfe000000 0 0x80000>;
-			#address-cells = <3>;
-			#size-cells = <2>;
-			bus-range = <0x00 0xff>;
-			device_type = "pci";
-			ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000
-				  0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000
-				  0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
-				  0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
-			/* Map all possible DDR as inbound ranges */
-			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000
-				      0x43000000 2 0x00000000 2 0x00000000 1 0x00000000>;
-			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
-			#interrupt-cells = <1>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &gic GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 319>, <&pcie_bus_clk>;
-			clock-names = "pcie", "pcie_bus";
-			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 319>;
-			status = "disabled";
-		};
-
 		rcar_sound: sound at ec500000 {
 			/*
 			 * #sound-dai-cells is required
@@ -1641,6 +1302,342 @@
 				};
 			};
 		};
+
+		audma0: dma-controller at ec700000 {
+			compatible = "renesas,dmac-r8a7743",
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
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12";
+			clocks = <&cpg CPG_MOD 502>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 502>;
+			#dma-cells = <1>;
+			dma-channels = <13>;
+		};
+
+		audma1: dma-controller at ec720000 {
+			compatible = "renesas,dmac-r8a7743",
+				     "renesas,rcar-dmac";
+			reg = <0 0xec720000 0 0x10000>;
+			interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12";
+			clocks = <&cpg CPG_MOD 501>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 501>;
+			#dma-cells = <1>;
+			dma-channels = <13>;
+		};
+
+		/*
+		 * pci1 and xhci share the same phy, therefore only one of them
+		 * can be active at any one time. If both of them are enabled,
+		 * a race condition will determine who'll control the phy.
+		 * A firmware file is needed by the xhci driver in order for
+		 * USB 3.0 to work properly.
+		 */
+		xhci: usb at ee000000 {
+			compatible = "renesas,xhci-r8a7743",
+				     "renesas,rcar-gen2-xhci";
+			reg = <0 0xee000000 0 0xc00>;
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 328>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 328>;
+			phys = <&usb2 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		pci0: pci at ee090000 {
+			compatible = "renesas,pci-r8a7743",
+				     "renesas,pci-rcar-gen2";
+			device_type = "pci";
+			reg = <0 0xee090000 0 0xc00>,
+			      <0 0xee080000 0 0x1100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
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
+			compatible = "renesas,pci-r8a7743",
+				     "renesas,pci-rcar-gen2";
+			device_type = "pci";
+			reg = <0 0xee0d0000 0 0xc00>,
+			      <0 0xee0c0000 0 0x1100>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
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
+			compatible = "renesas,sdhi-r8a7743",
+				     "renesas,rcar-gen2-sdhi";
+			reg = <0 0xee100000 0 0x328>;
+			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 314>;
+			dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
+			       <&dmac1 0xcd>, <&dmac1 0xce>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <195000000>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 314>;
+			status = "disabled";
+		};
+
+		sdhi1: sd at ee140000 {
+			compatible = "renesas,sdhi-r8a7743",
+				     "renesas,rcar-gen2-sdhi";
+			reg = <0 0xee140000 0 0x100>;
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 312>;
+			dmas = <&dmac0 0xc1>, <&dmac0 0xc2>,
+			       <&dmac1 0xc1>, <&dmac1 0xc2>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <97500000>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 312>;
+			status = "disabled";
+		};
+
+		sdhi2: sd at ee160000 {
+			compatible = "renesas,sdhi-r8a7743",
+				     "renesas,rcar-gen2-sdhi";
+			reg = <0 0xee160000 0 0x100>;
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 311>;
+			dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
+			       <&dmac1 0xd3>, <&dmac1 0xd4>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <97500000>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 311>;
+			status = "disabled";
+		};
+
+		mmcif0: mmc at ee200000 {
+			compatible = "renesas,mmcif-r8a7743",
+				     "renesas,sh-mmcif";
+			reg = <0 0xee200000 0 0x80>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 315>;
+			dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
+			       <&dmac1 0xd1>, <&dmac1 0xd2>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 315>;
+			reg-io-width = <4>;
+			max-frequency = <97500000>;
+			status = "disabled";
+		};
+
+		ether: ethernet at ee700000 {
+			compatible = "renesas,ether-r8a7743",
+				     "renesas,rcar-gen2-ether";
+			reg = <0 0xee700000 0 0x400>;
+			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 813>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
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
+			reg = <0 0xf1001000 0 0x1000>, <0 0xf1002000 0 0x2000>,
+			      <0 0xf1004000 0 0x2000>, <0 0xf1006000 0 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&cpg CPG_MOD 408>;
+			clock-names = "clk";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 408>;
+		};
+
+		pciec: pcie at fe000000 {
+			compatible = "renesas,pcie-r8a7743",
+				     "renesas,pcie-rcar-gen2";
+			reg = <0 0xfe000000 0 0x80000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x00 0xff>;
+			device_type = "pci";
+			ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000
+				  0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000
+				  0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
+				  0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
+			/* Map all possible DDR as inbound ranges */
+			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000
+				      0x43000000 2 0x00000000 2 0x00000000 1 0x00000000>;
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 319>, <&pcie_bus_clk>;
+			clock-names = "pcie", "pcie_bus";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 319>;
+			status = "disabled";
+		};
+
+		du: display at feb00000 {
+			compatible = "renesas,du-r8a7743";
+			reg = <0 0xfeb00000 0 0x40000>,
+			      <0 0xfeb90000 0 0x1c>;
+			reg-names = "du", "lvds.0";
+			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 724>,
+				 <&cpg CPG_MOD 723>,
+				 <&cpg CPG_MOD 726>;
+			clock-names = "du.0", "du.1", "lvds.0";
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					du_out_rgb: endpoint {
+					};
+				};
+				port at 1 {
+					reg = <1>;
+					du_out_lvds0: endpoint {
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
+			compatible = "renesas,r8a7743-cmt0",
+				     "renesas,rcar-gen2-cmt0";
+			reg = <0 0xffca0000 0 0x1004>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 124>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 124>;
+			status = "disabled";
+		};
+
+		cmt1: timer at e6130000 {
+			compatible = "renesas,r8a7743-cmt1",
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
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 329>;
+			status = "disabled";
+		};
 	};
 
 	thermal-zones {
-- 
2.11.0
