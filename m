From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Wed,  7 Mar 2018 17:43:36 +0100
Subject: [PATCH] arm: dts: nes: add Nintendo NES Classic Edition support
Message-ID: <20180307164336.32359-1-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Nintendo NES Classic features an R16 already well supported in
mainline.

The console over UART0 may be wired on two ports of the R16, both
available on the NES Classic PCB.

USB host can be used after a bit of soldering to wire a 5V power supply
directly on the PCB, in order to free the micro-USB port from that task
and allow the plug of any USB device.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               | 18 ++++++
 .../dts/sun8i-r16-nintendo-nes-classic-edition.dts | 71 ++++++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-r16-nintendo-nes-classic-edition.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ade7a38543dc..eed4e1222897 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -990,6 +990,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-h3-orangepi-plus.dtb \
 	sun8i-h3-orangepi-plus2e.dtb \
 	sun8i-r16-bananapi-m2m.dtb \
+	sun8i-r16-nintendo-nes-classic-edition.dtb \
 	sun8i-r16-parrot.dtb \
 	sun8i-r40-bananapi-m2-ultra.dtb \
 	sun8i-v3s-licheepi-zero.dtb \
diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 971f9be699a7..1ad7291581be 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -315,6 +315,24 @@
 				bias-pull-up;
 			};
 
+			nand_pins_a: nand-base0 at 0 {
+				pins = "PC0", "PC1", "PC2",
+				       "PC5", "PC8", "PC9", "PC10",
+				       "PC11", "PC12", "PC13", "PC14",
+				       "PC15";
+				function = "nand0";
+			};
+
+			nand_cs0_pins_a: nand-cs at 0 {
+				pins = "PC4";
+				function = "nand0";
+			};
+
+			nand_rb0_pins_a: nand-rb at 0 {
+				pins = "PC6";
+				function = "nand0";
+			};
+
 			pwm0_pins: pwm0 {
 				pins = "PH0";
 				function = "pwm0";
diff --git a/arch/arm/boot/dts/sun8i-r16-nintendo-nes-classic-edition.dts b/arch/arm/boot/dts/sun8i-r16-nintendo-nes-classic-edition.dts
new file mode 100644
index 000000000000..63c289f1f46d
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-r16-nintendo-nes-classic-edition.dts
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0 OR X11
+/* Copyright (c) 2016 FUKAUMI Naoki <naobsd@gmail.com> */
+
+/dts-v1/;
+#include "sun8i-a33.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+/ {
+	model = "Nintendo NES Classic Edition";
+	compatible = "nintendo,nes-classic-edition", "allwinner,sun8i-a33";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	/*
+	 * UART0 is available on two ports, both accessible on the NES Classic
+	 * PCB. One can use the <&uart0_pins_b> handle instead.
+	 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&nfc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&nand_pins_a &nand_cs0_pins_a &nand_rb0_pins_a>;
+	status = "okay";
+
+	/* 2Gb Macronix MX30LF2G18AC (3V) */
+	nand at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0>;
+		allwinner,rb = <0>;
+		nand-ecc-mode = "hw";
+		nand-ecc-strength = <16>;
+		nand-ecc-step-size = <1024>;
+	};
+};
+
+/*
+ * The NES is powered by the USB port. However it is possible to solder a wire
+ * from the internal side of the connector on VBUS pin to supply the required 5V
+ * without the need of a cable plugged in the micro USB port. This way it is
+ * easy to use any USB device.
+ */
+&usb_otg {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbphy {
+	/* VBUS is always on because it is wired to the power supply */
+	usb1_vbus-supply = <&reg_vcc5v0>;
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
-- 
2.14.1
