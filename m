From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  1 Mar 2014 20:26:21 +0100
Subject: [PATCH 02/19] ARM: sun4i: dt: Add ahci / sata support
In-Reply-To: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
References: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1393701998-3553-3-git-send-email-hdegoede@redhat.com>
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
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts | 10 ++++++++++
 arch/arm/boot/dts/sun4i-a10.dtsi           |  8 ++++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index cbd2e13..d6ec839 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -35,6 +35,10 @@
 			};
 		};
 
+		ahci: sata at 01c18000 {
+			status = "okay";
+		};
+
 		pinctrl at 01c20800 {
 			emac_power_pin_a1000: emac_power_pin at 0 {
 				allwinner,pins = "PH15";
diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index b139ee6..20407ac 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -12,6 +12,7 @@
 
 /dts-v1/;
 /include/ "sun4i-a10.dtsi"
+/include/ "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Cubietech Cubieboard";
@@ -33,6 +34,11 @@
 			};
 		};
 
+		ahci: sata at 01c18000 {
+			target-supply = <&reg_ahci_5v>;
+			status = "okay";
+		};
+
 		pinctrl at 01c20800 {
 			led_pins_cubieboard: led_pins at 0 {
 				allwinner,pins = "PH20", "PH21";
@@ -77,4 +83,8 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	reg_ahci_5v: ahci-5v {
+		status = "okay";
+	};
 };
diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index a850482c..e073c41 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -388,6 +388,14 @@
 			#size-cells = <0>;
 		};
 
+		ahci: sata at 01c18000 {
+			compatible = "allwinner,sun4i-a10-ahci";
+			reg = <0x01c18000 0x1000>;
+			interrupts = <56>;
+			clocks = <&pll6 0>, <&ahb_gates 25>;
+			status = "disabled";
+		};
+
 		spi3: spi at 01c1f000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c1f000 0x1000>;
-- 
1.9.0
