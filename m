From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 19 Jan 2014 00:48:54 +0100
Subject: [RFC v3 12/13] ARM: sun4i: dts: Add ahci / sata support
In-Reply-To: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1390088935-7193-13-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oliver Schinagl <oliver@schinagl.nl>

This patch adds sunxi sata support to A10 boards that have such a connector.
Some boards also feature a regulator via a GPIO and support for this is also
added.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-a1000.dts      |  4 ++++
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts |  6 +++++
 arch/arm/boot/dts/sun4i-a10.dtsi           |  8 +++++++
 arch/arm/boot/dts/sunxi-ahci-reg.dtsi      | 38 ++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+)
 create mode 100644 arch/arm/boot/dts/sunxi-ahci-reg.dtsi

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index aef8207..fd6d512 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -48,6 +48,10 @@
 			status = "okay";
 		};
 
+		sata: ahci at 01c18000 {
+			status = "okay";
+		};
+
 		pinctrl at 01c20800 {
 			mmc0_cd_pin_a1000: mmc0_cd_pin at 0 {
 				allwinner,pins = "PH1";
diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index f50fb2b..d23aaa8 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -12,6 +12,7 @@
 
 /dts-v1/;
 /include/ "sun4i-a10.dtsi"
+/include/ "sunxi-ahci-reg.dtsi"
 
 / {
 	model = "Cubietech Cubieboard";
@@ -51,6 +52,11 @@
 			status = "okay";
 		};
 
+		sata: ahci at 01c18000 {
+			target-supply = <&reg_ahci_5v>;
+			status = "okay";
+		};
+
 		pinctrl at 01c20800 {
 			mmc0_cd_pin_cubieboard: mmc0_cd_pin at 0 {
 				allwinner,pins = "PH1";
diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 4736dd2..09517c3 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -331,6 +331,14 @@
 			status = "disabled";
 		};
 
+		sata: ahci at 01c18000 {
+			compatible = "allwinner,sun4i-a10-ahci";
+			reg = <0x01c18000 0x1000>;
+			interrupts = <56>;
+			clocks = <&pll6 0>, <&ahb_gates 25>;
+			status = "disabled";
+		};
+
 		intc: interrupt-controller at 01c20400 {
 			compatible = "allwinner,sun4i-ic";
 			reg = <0x01c20400 0x400>;
diff --git a/arch/arm/boot/dts/sunxi-ahci-reg.dtsi b/arch/arm/boot/dts/sunxi-ahci-reg.dtsi
new file mode 100644
index 0000000..955b197
--- /dev/null
+++ b/arch/arm/boot/dts/sunxi-ahci-reg.dtsi
@@ -0,0 +1,38 @@
+/*
+ * sunxi boards sata target power supply common code
+ *
+ * Copyright 2014 - Hans de Goede <hdegoede@redhat.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/ {
+	soc at 01c00000 {
+		ahci_pwr_pin_a: ahci_pwr_pin at 0 {
+			allwinner,pins = "PB8";
+			allwinner,function = "gpio_out";
+			allwinner,drive = <0>;
+			allwinner,pull = <0>;
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		pinctrl-names = "default";
+
+		reg_ahci_5v: ahci-5v {
+			compatible = "regulator-fixed";
+			regulator-name = "ahci-5v";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			pinctrl-0 = <&ahci_pwr_pin_a>;
+			gpio = <&pio 1 8 0>;
+			enable-active-high;
+		};
+	};
+};
-- 
1.8.4.2
