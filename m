From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  6 Jan 2015 16:45:10 +0100
Subject: [PATCH 4/4] ARM: mvebu: armada-385-ap: Enable USB3 port
In-Reply-To: <1420559110-8043-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1420559110-8043-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1420559110-8043-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 385 AP board has a USB3 port exposed that uses a GPIO to drive the
VBUS line. Enable the needed drivers to support this.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/armada-385-ap.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/armada-385-ap.dts b/arch/arm/boot/dts/armada-385-ap.dts
index ab88dc4be636..a9dea82ef34b 100644
--- a/arch/arm/boot/dts/armada-385-ap.dts
+++ b/arch/arm/boot/dts/armada-385-ap.dts
@@ -88,6 +88,13 @@
 				status = "okay";
 			};
 
+			pinctrl at 18000 {
+				xhci0_vbus_pins: xhci0-vbus-pins {
+					marvell,pins = "mpp44";
+					marvell,function = "gpio";
+				};
+			};
+
 			ethernet at 30000 {
 				status = "okay";
 				phy = <&phy1>;
@@ -112,6 +119,11 @@
 				phy = <&phy0>;
 				phy-mode = "rgmii-id";
 			};
+
+			usb3 at f0000 {
+				status = "okay";
+				usb-phy = <&usb3_phy>;
+			};
 		};
 
 		pcie-controller {
@@ -137,4 +149,20 @@
 			};
 		};
 	};
+
+	usb3_phy: usb3_phy {
+		compatible = "usb-nop-xceiv";
+		vcc-supply = <&reg_xhci0_vbus>;
+	};
+
+	reg_xhci0_vbus: xhci0-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&xhci0_vbus_pins>;
+		regulator-name = "xhci0-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+	};
 };
-- 
2.2.1
