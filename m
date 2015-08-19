From: mathieu@codeaurora.org (Mathieu Olivari)
Date: Wed, 19 Aug 2015 10:53:21 -0700
Subject: [PATCH 1/2] ARM: qcom: add mdio bus on IPQ806x/AP148
Message-ID: <1440006802-2415-1-git-send-email-mathieu@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ethernet switch on AP148 is connected through MDIO using GPIO 0 and 1.
We'll add the new node using the bitbang driver on these two pins.

Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064-ap148.dts | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064-ap148.dts b/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
index 6886d09..d73df24 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
+++ b/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
@@ -19,8 +19,9 @@
 		};
 	};
 
-	alias {
+	aliases {
 		serial0 = &uart4;
+		mdio-gpio0 = &mdio0;
 	};
 
 	chosen {
@@ -84,6 +85,15 @@
 					};
 				};
 			};
+
+			mdio0_pins: mdio0_pins {
+				mux {
+					pins = "gpio0", "gpio1";
+					function = "gpio";
+					drive-strength = <8>;
+					bias-disable;
+				};
+			};
 		};
 
 		sata-phy at 1b400000 {
@@ -93,5 +103,24 @@
 		sata at 29000000 {
 			status = "ok";
 		};
+
+		mdio0: mdio {
+			compatible = "virtual,mdio-gpio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			gpios = <&qcom_pinmux 1 0 &qcom_pinmux 0 0>;
+			pinctrl-0 = <&mdio0_pins>;
+			pinctrl-names = "default";
+
+			phy0: ethernet-phy at 0 {
+				device_type = "ethernet-phy";
+				reg = <0>;
+			};
+
+			phy4: ethernet-phy at 4 {
+				device_type = "ethernet-phy";
+				reg = <4>;
+			};
+		};
 	};
 };
-- 
2.1.4
