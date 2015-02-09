From: dt.tangr@gmail.com (Daniel Tang)
Date: Mon,  9 Feb 2015 19:41:57 +1100
Subject: [PATCH] devicetree: Add TI-NSPIRE USB OTG support to device tree
Message-ID: <1423471317-38119-1-git-send-email-dt.tangr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Tang <dt.tangr@gmail.com>
---
 arch/arm/boot/dts/nspire-classic.dtsi |  5 +++++
 arch/arm/boot/dts/nspire-cx.dts       |  4 ++++
 arch/arm/boot/dts/nspire.dtsi         | 21 +++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/nspire-classic.dtsi b/arch/arm/boot/dts/nspire-classic.dtsi
index 9565199..4907c50 100644
--- a/arch/arm/boot/dts/nspire-classic.dtsi
+++ b/arch/arm/boot/dts/nspire-classic.dtsi
@@ -51,6 +51,11 @@
 	compatible = "lsi,nspire-classic-ahb-divider";
 };
 
+
+&vbus_reg {
+	gpio = <&gpio 5 0>;
+};
+
 / {
 	memory {
 		device_type = "memory";
diff --git a/arch/arm/boot/dts/nspire-cx.dts b/arch/arm/boot/dts/nspire-cx.dts
index 375b924..08e0b81 100644
--- a/arch/arm/boot/dts/nspire-cx.dts
+++ b/arch/arm/boot/dts/nspire-cx.dts
@@ -69,6 +69,10 @@
 	0x0709001d 	0x070a0033 	>;
 };
 
+&vbus_reg {
+	gpio = <&gpio 2 0>;
+};
+
 / {
 	model = "TI-NSPIRE CX";
 	compatible = "ti,nspire-cx";
diff --git a/arch/arm/boot/dts/nspire.dtsi b/arch/arm/boot/dts/nspire.dtsi
index a22ffe6..390c91a 100644
--- a/arch/arm/boot/dts/nspire.dtsi
+++ b/arch/arm/boot/dts/nspire.dtsi
@@ -54,6 +54,20 @@
 		clocks = <&ahb_clk>;
 	};
 
+	usb_phy: usb_phy {
+		compatible = "usb-nop-xceiv";
+	};
+
+	vbus_reg: vbus_reg {
+		compatible = "regulator-fixed";
+
+		regulator-name = "USB VBUS output";
+		regulator-type = "voltage";
+
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
 	ahb {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -65,8 +79,12 @@
 		};
 
 		usb0: usb at B0000000 {
+			compatible = "lsi,zevio-usb";
 			reg = <0xB0000000 0x1000>;
 			interrupts = <8>;
+
+			usb-phy = <&usb_phy>;
+			vbus-supply = <&vbus_reg>;
 		};
 
 		usb1: usb at B4000000 {
@@ -105,8 +123,11 @@
 			ranges;
 
 			gpio: gpio at 90000000 {
+				compatible = "lsi,zevio-gpio";
 				reg = <0x90000000 0x1000>;
 				interrupts = <7>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
 			fast_timer: timer at 90010000 {
-- 
2.1.3
