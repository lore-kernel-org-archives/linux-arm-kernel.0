From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  1 Mar 2014 20:26:22 +0100
Subject: [PATCH 03/19] ARM: sun7i: dt: Add ahci / sata support
In-Reply-To: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
References: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1393701998-3553-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds sunxi sata support to A20 boards that have such a connector.
Some boards also feature a regulator via a GPIO and support for this is also
added.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 10 ++++++++++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 19 +++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 10 ++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                |  8 ++++++++
 4 files changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 7bf4935..4bed115 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -13,12 +13,18 @@
 
 /dts-v1/;
 /include/ "sun7i-a20.dtsi"
+/include/ "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Cubietech Cubieboard2";
 	compatible = "cubietech,cubieboard2", "allwinner,sun7i-a20";
 
 	soc at 01c00000 {
+		ahci: sata at 01c18000 {
+			target-supply = <&reg_ahci_5v>;
+			status = "okay";
+		};
+
 		pinctrl at 01c20800 {
 			led_pins_cubieboard2: led_pins at 0 {
 				allwinner,pins = "PH20", "PH21";
@@ -74,4 +80,8 @@
 			gpios = <&pio 7 20 0>;
 		};
 	};
+
+	reg_ahci_5v: ahci-5v {
+		status = "okay";
+	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 025ce52..ef5fed8 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -13,13 +13,26 @@
 
 /dts-v1/;
 /include/ "sun7i-a20.dtsi"
+/include/ "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Cubietech Cubietruck";
 	compatible = "cubietech,cubietruck", "allwinner,sun7i-a20";
 
 	soc at 01c00000 {
+		ahci: sata at 01c18000 {
+			target-supply = <&reg_ahci_5v>;
+			status = "okay";
+		};
+
 		pinctrl at 01c20800 {
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
@@ -90,4 +103,10 @@
 			gpios = <&pio 7 7 0>;
 		};
 	};
+
+	reg_ahci_5v: ahci-5v {
+		pinctrl-0 = <&ahci_pwr_pin_cubietruck>;
+		gpio = <&pio 7 12 0>;
+		status = "okay";
+	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 9d98316..c9b0f37 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -13,6 +13,7 @@
 
 /dts-v1/;
 /include/ "sun7i-a20.dtsi"
+/include/ "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Olimex A20-Olinuxino Micro";
@@ -36,6 +37,11 @@
 			status = "okay";
 		};
 
+		ahci: sata at 01c18000 {
+			target-supply = <&reg_ahci_5v>;
+			status = "okay";
+		};
+
 		pinctrl at 01c20800 {
 			led_pins_olinuxino: led_pins at 0 {
 				allwinner,pins = "PH2";
@@ -105,4 +111,8 @@
 			default-state = "on";
 		};
 	};
+
+	reg_ahci_5v: ahci-5v {
+		status = "okay";
+	};
 };
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 52507e4..9952c1e 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -450,6 +450,14 @@
 			#size-cells = <0>;
 		};
 
+		ahci: sata at 01c18000 {
+			compatible = "allwinner,sun4i-a10-ahci";
+			reg = <0x01c18000 0x1000>;
+			interrupts = <0 56 4>;
+			clocks = <&pll6 0>, <&ahb_gates 25>;
+			status = "disabled";
+		};
+
 		spi3: spi at 01c1f000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c1f000 0x1000>;
-- 
1.9.0
