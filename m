From: tony@atomide.com (Tony Lindgren)
Date: Mon, 25 Nov 2013 12:11:42 -0800
Subject: [PATCH] ARM: dts: Fix omap serial wake-up when booted with device tree
Message-ID: <20131125201142.GT10023@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We've had deeper idle states working on omaps for few years now,
but only in the legacy mode. When booted with device tree, the
wake-up events did not have a chance to work until commit
3e6cee1786a1 (pinctrl: single: Add support for wake-up interrupts)
that recently got merged. In addition to that we also needed commit
79d9701559a9 (of/irq: create interrupts-extended property) that's
now also merged.

So let's fix the wake-up events for some selected omaps so devices
booted in device tree mode won't just hang if deeper power states
are enabled, and so systems can wake up from suspend to the serial
port event.

Note that there's no longer need to specify the wake-up bit in
the pinctrl settings, the request_irq on the wake-up pin takes
care of that.

Cc: devicetree at vger.kernel.org
Cc: "Beno?t Cousson" <bcousson@baylibre.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

---

FYI, this depends on the device resource populating patch posted in
thread "[PATCH] of/platform: Fix no irq domain found errors when
populating interrupts" to avoid intoducing nasty warnings.

--- a/arch/arm/boot/dts/omap3-evm-37xx.dts
+++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
@@ -89,7 +89,16 @@
 	status = "disabled";
 };
 
+&uart1 {
+	interrupts-extended = <&intc 72 &omap3_pmx_core OMAP3_UART1_RX>;
+};
+
+&uart2 {
+	interrupts-extended = <&intc 73 &omap3_pmx_core OMAP3_UART2_RX>;
+};
+
 &uart3 {
+	interrupts-extended = <&intc 74 &omap3_pmx_core OMAP3_UART3_RX>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins>;
 };
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -495,11 +495,13 @@
 };
 
 &uart2 {
+	interrupts-extended = <&intc 73 &omap3_pmx_core OMAP3_UART2_RX>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart2_pins>;
 };
 
 &uart3 {
+	interrupts-extended = <&intc 74 &omap3_pmx_core OMAP3_UART3_RX>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins>;
 };
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -207,7 +207,7 @@
 		uart1: serial at 4806a000 {
 			compatible = "ti,omap3-uart";
 			reg = <0x4806a000 0x2000>;
-			interrupts = <72>;
+			interrupts-extended = <&intc 72>;
 			dmas = <&sdma 49 &sdma 50>;
 			dma-names = "tx", "rx";
 			ti,hwmods = "uart1";
@@ -217,7 +217,7 @@
 		uart2: serial at 4806c000 {
 			compatible = "ti,omap3-uart";
 			reg = <0x4806c000 0x400>;
-			interrupts = <73>;
+			interrupts-extended = <&intc 73>;
 			dmas = <&sdma 51 &sdma 52>;
 			dma-names = "tx", "rx";
 			ti,hwmods = "uart2";
@@ -227,7 +227,7 @@
 		uart3: serial at 49020000 {
 			compatible = "ti,omap3-uart";
 			reg = <0x49020000 0x400>;
-			interrupts = <74>;
+			interrupts-extended = <&intc 74>;
 			dmas = <&sdma 53 &sdma 54>;
 			dma-names = "tx", "rx";
 			ti,hwmods = "uart3";
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -396,6 +396,21 @@
 	usb-supply = <&vusb>;
 };
 
+&uart2 {
+	interrupts-extended = <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH
+			       &omap4_pmx_core OMAP4_UART2_RX>;
+};
+
+&uart3 {
+	interrupts-extended = <&gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH
+			       &omap4_pmx_core OMAP4_UART3_RX>;
+};
+
+&uart4 {
+	interrupts-extended = <&gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH
+			       &omap4_pmx_core OMAP4_UART4_RX>;
+};
+
 &usb_otg_hs {
 	interface-type = <1>;
 	mode = <3>;
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -523,16 +523,22 @@
 };
 
 &uart2 {
+	interrupts-extended = <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH
+			       &omap4_pmx_core OMAP4_UART2_RX>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart2_pins>;
 };
 
 &uart3 {
+	interrupts-extended = <&gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH
+			       &omap4_pmx_core OMAP4_UART3_RX>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins>;
 };
 
 &uart4 {
+	interrupts-extended = <&gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH
+			       &omap4_pmx_core OMAP4_UART4_RX>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart4_pins>;
 };
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -236,7 +236,7 @@
 		uart2: serial at 4806c000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x4806c000 0x100>;
-			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
 		};
@@ -244,7 +244,7 @@
 		uart3: serial at 48020000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x48020000 0x100>;
-			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
 		};
@@ -252,7 +252,7 @@
 		uart4: serial at 4806e000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x4806e000 0x100>;
-			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
 		};
--- a/include/dt-bindings/pinctrl/omap.h
+++ b/include/dt-bindings/pinctrl/omap.h
@@ -49,5 +49,17 @@
 #define PIN_OFF_INPUT_PULLDOWN	(OFF_EN | OFF_PULL_EN)
 #define PIN_OFF_WAKEUPENABLE	WAKEUP_EN
 
+/*
+ * Define some commonly used pins configured by the boards.
+ * Note that some boards use alternative pins, so check
+ * the schematics before using these.
+ */
+#define OMAP3_UART1_RX		0x152
+#define OMAP3_UART2_RX		0x14a
+#define OMAP3_UART3_RX		0x16e
+#define OMAP4_UART2_RX		0xdc
+#define OMAP4_UART3_RX		0x104
+#define OMAP4_UART4_RX		0x11c
+
 #endif
 
