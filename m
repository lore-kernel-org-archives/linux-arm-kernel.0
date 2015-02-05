From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  5 Feb 2015 16:25:37 +0100
Subject: [PATCH 7/8] mfd: dt-bindings: Add bindings for the MediaTek MT6397
 PMIC
In-Reply-To: <1423149938-14471-1-git-send-email-s.hauer@pengutronix.de>
References: <1423149938-14471-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1423149938-14471-8-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 Documentation/devicetree/bindings/mfd/mt6397.txt | 70 ++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mt6397.txt

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
new file mode 100644
index 0000000..15043e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -0,0 +1,70 @@
+MediaTek MT6397 Multifunction Device Driver
+
+MT6397 is a multifunction device with the following sub modules:
+- Regulator
+- RTC
+- Audio codec
+- GPIO
+- Clock
+
+It is interfaced to host controller using SPI interface by a proprietary hardware
+called PMIC wrapper or pwrap. MT6397 MFD is a child device of pwrap.
+See the following for pwarp node definitions:
+Documentation/devicetree/bindings/soc/pwrap.txt
+
+This document describes the binding for MFD device and its sub module.
+
+Required properties:
+compatible: "mediatek,mt6397"
+
+Optional subnodes:
+
+- rtc
+	Required properties:
+		- compatible: "mediatek,mt6397-rtc"
+- regulators
+	Required properties:
+		- compatible: "mediatek,mt6397-regulator"
+	see Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
+- codec
+	Required properties:
+		- compatible: "mediatek,mt6397-codec"
+- clk
+	Required properties:
+		- compatible: "mediatek,mt6397-clk"
+
+Example:
+	pwrap: pwrap at 1000f000 {
+		compatible = "mediatek,mt8135-pwrap";
+
+		...
+
+		pmic {
+			compatible = "mediatek,mt6397";
+
+			codec: mt6397codec {
+				compatible = "mediatek,mt6397-codec";
+			};
+
+			regulators {
+				compatible = "mediatek,mt6397-regulator";
+
+				mt6397_vpca15_reg: buck_vpca15 {
+					regulator-compatible = "buck_vpca15";
+					regulator-name = "vpca15";
+					regulator-min-microvolt = <850000>;
+					regulator-max-microvolt = <1400000>;
+					regulator-ramp-delay = <12500>;
+					regulator-always-on;
+				};
+
+				mt6397_vgp4_reg: ldo_vgp4 {
+					regulator-compatible = "ldo_vgp4";
+					regulator-name = "vgp4";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-enable-ramp-delay = <218>;
+				};
+			};
+		};
+	};
-- 
2.1.4
