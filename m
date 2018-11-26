From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2018 13:54:44 +0100
Subject: [PATCH 18/40] arm64: dts: renesas: r8a7799{0|5}: add/enable USB2.0
 peripheral
In-Reply-To: <cover.1543229515.git.horms+renesas@verge.net.au>
References: <cover.1543229515.git.horms+renesas@verge.net.au>
Message-ID: <5c6479d9b25b40001e814003f62a93485f9ff82f.1543229515.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds/enables USB2.0 peripheral for R-Car [DE]3 boards.

R-Car E3 Ebisu board connects the ID pin to the SoC, so this adds
a group "usb0_id" into usb0_pins node. Also, to use SW15 pin 3 side,
this patch adds vbus0_usb2 node on r8a77990-ebisu.dts.

R-Car D3 Draak board doesn't connect the ID pin, so this adds
"renesas,no-otg-pins" property into usb2_phy0 node.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts | 21 +++++++++++-
 arch/arm64/boot/dts/renesas/r8a77990.dtsi      | 45 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts |  8 +++++
 arch/arm64/boot/dts/renesas/r8a77995.dtsi      | 45 ++++++++++++++++++++++++++
 4 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
index ff428a64341c..038664e0cdcb 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
@@ -128,6 +128,17 @@
 		regulator-always-on;
 	};
 
+	vbus0_usb2: regulator-vbus0-usb2 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "USB20_VBUS_CN";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+
+		gpio = <&gpio6 4 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	x13_clk: x13 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -188,6 +199,7 @@
 };
 
 &ehci0 {
+	dr_mode = "otg";
 	status = "okay";
 };
 
@@ -195,6 +207,11 @@
 	clock-frequency = <48000000>;
 };
 
+&hsusb {
+	dr_mode = "otg";
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -295,6 +312,7 @@
 };
 
 &ohci0 {
+	dr_mode = "otg";
 	status = "okay";
 };
 
@@ -322,7 +340,7 @@
 	};
 
 	usb0_pins: usb {
-		groups = "usb0_b";
+		groups = "usb0_b", "usb0_id";
 		function = "usb0";
 	};
 
@@ -359,6 +377,7 @@
 	pinctrl-0 = <&usb0_pins>;
 	pinctrl-names = "default";
 
+	vbus-supply = <&vbus0_usb2>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index a945db3c4644..8c9d7faa9e65 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -357,6 +357,51 @@
 			resets = <&cpg 407>;
 		};
 
+		hsusb: usb at e6590000 {
+			compatible = "renesas,usbhs-r8a77990",
+				     "renesas,rcar-gen3-usbhs";
+			reg = <0 0xe6590000 0 0x200>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 704>, <&cpg CPG_MOD 703>;
+			dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
+			       <&usb_dmac1 0>, <&usb_dmac1 1>;
+			dma-names = "ch0", "ch1", "ch2", "ch3";
+			renesas,buswait = <11>;
+			phys = <&usb2_phy0>;
+			phy-names = "usb";
+			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+			resets = <&cpg 704>, <&cpg 703>;
+			status = "disabled";
+		};
+
+		usb_dmac0: dma-controller at e65a0000 {
+			compatible = "renesas,r8a77990-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65a0000 0 0x100>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&cpg CPG_MOD 330>;
+			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+			resets = <&cpg 330>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
+		usb_dmac1: dma-controller at e65b0000 {
+			compatible = "renesas,r8a77990-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65b0000 0 0x100>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&cpg CPG_MOD 331>;
+			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+			resets = <&cpg 331>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
 		dmac0: dma-controller at e6700000 {
 			compatible = "renesas,dmac-r8a77990",
 				     "renesas,rcar-dmac";
diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
index 2405eaad0296..48bb1d77744f 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
@@ -179,6 +179,7 @@
 };
 
 &ehci0 {
+	dr_mode = "host";
 	status = "okay";
 };
 
@@ -186,6 +187,11 @@
 	clock-frequency = <48000000>;
 };
 
+&hsusb {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-0 = <&i2c0_pins>;
 	pinctrl-names = "default";
@@ -337,6 +343,7 @@
 };
 
 &ohci0 {
+	dr_mode = "host";
 	status = "okay";
 };
 
@@ -445,6 +452,7 @@
 	pinctrl-0 = <&usb0_pins>;
 	pinctrl-names = "default";
 
+	renesas,no-otg-pins;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index 214f4954b321..8530d9fc1371 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -344,6 +344,51 @@
 			status = "disabled";
 		};
 
+		hsusb: usb at e6590000 {
+			compatible = "renesas,usbhs-r8a77995",
+				     "renesas,rcar-gen3-usbhs";
+			reg = <0 0xe6590000 0 0x200>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 704>, <&cpg CPG_MOD 703>;
+			dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
+			       <&usb_dmac1 0>, <&usb_dmac1 1>;
+			dma-names = "ch0", "ch1", "ch2", "ch3";
+			renesas,buswait = <11>;
+			phys = <&usb2_phy0>;
+			phy-names = "usb";
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 704>, <&cpg 703>;
+			status = "disabled";
+		};
+
+		usb_dmac0: dma-controller at e65a0000 {
+			compatible = "renesas,r8a77995-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65a0000 0 0x100>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&cpg CPG_MOD 330>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 330>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
+		usb_dmac1: dma-controller at e65b0000 {
+			compatible = "renesas,r8a77995-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65b0000 0 0x100>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&cpg CPG_MOD 331>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 331>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
 		canfd: can at e66c0000 {
 			compatible = "renesas,r8a77995-canfd",
 				     "renesas,rcar-gen3-canfd";
-- 
2.11.0
