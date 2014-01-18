From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 19 Jan 2014 00:48:55 +0100
Subject: [RFC v3 13/13] ARM: sun7i: dts: Add ahci / sata support
In-Reply-To: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1390088935-7193-14-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds sunxi sata support to A20 boards that have such a connector.
Some boards also feature a regulator via a GPIO and support for this is also
added.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     |  6 ++++++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 20 ++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts |  6 ++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                |  8 ++++++++
 4 files changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 48777cd..785fac0 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -13,6 +13,7 @@
 
 /dts-v1/;
 /include/ "sun7i-a20.dtsi"
+/include/ "sunxi-ahci-reg.dtsi"
 
 / {
 	model = "Cubietech Cubieboard2";
@@ -28,6 +29,11 @@
 			status = "okay";
 		};
 
+		sata: ahci at 01c18000 {
+			target-supply = <&reg_ahci_5v>;
+			status = "okay";
+		};
+
 		pinctrl at 01c20800 {
 			mmc0_cd_pin_cubieboard2: mmc0_cd_pin at 0 {
 				allwinner,pins = "PH1";
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 2684f27..68e0809 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -13,6 +13,7 @@
 
 /dts-v1/;
 /include/ "sun7i-a20.dtsi"
+/include/ "sunxi-ahci-reg.dtsi"
 
 / {
 	model = "Cubietech Cubietruck";
@@ -28,6 +29,11 @@
 			status = "okay";
 		};
 
+		sata: ahci at 01c18000 {
+			target-supply = <&reg_ahci_5v>;
+			status = "okay";
+		};
+
 		pinctrl at 01c20800 {
 			mmc0_cd_pin_cubietruck: mmc0_cd_pin at 0 {
 				allwinner,pins = "PH1";
@@ -36,6 +42,13 @@
 				allwinner,pull = <0>;
 			};
 
+			ahci_pwr_pin_cubietruck: ahci_pwr_pin at 1 {
+				allwinner,pins = "PH12";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			led_pins_cubietruck: led_pins at 0 {
 				allwinner,pins = "PH7", "PH11", "PH20", "PH21";
 				allwinner,function = "gpio_out";
@@ -84,4 +97,11 @@
 			gpios = <&pio 7 7 0>;
 		};
 	};
+
+	regulators {
+		reg_ahci_5v: ahci-5v {
+			pinctrl-0 = <&ahci_pwr_pin_cubietruck>;
+			gpio = <&pio 7 12 0>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index bf6f6c8..8a289c4 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -13,6 +13,7 @@
 
 /dts-v1/;
 /include/ "sun7i-a20.dtsi"
+/include/ "sunxi-ahci-reg.dtsi"
 
 / {
 	model = "Olimex A20-Olinuxino Micro";
@@ -37,6 +38,11 @@
 			status = "okay";
 		};
 
+		sata: ahci at 01c18000 {
+			target-supply = <&reg_ahci_5v>;
+			status = "okay";
+		};
+
 		pinctrl at 01c20800 {
 			mmc0_cd_pin_olinuxinom: mmc0_cd_pin at 0 {
 				allwinner,pins = "PH1";
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index c9c123a..fc1be33 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -347,6 +347,14 @@
 			status = "disabled";
 		};
 
+		sata: ahci at 01c18000 {
+			compatible = "allwinner,sun4i-a10-ahci";
+			reg = <0x01c18000 0x1000>;
+			interrupts = <0 56 1>;
+			clocks = <&pll6 0>, <&ahb_gates 25>;
+			status = "disabled";
+		};
+
 		pio: pinctrl at 01c20800 {
 			compatible = "allwinner,sun7i-a20-pinctrl";
 			reg = <0x01c20800 0x400>;
-- 
1.8.4.2
