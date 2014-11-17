From: flora.fu@mediatek.com (Flora Fu)
Date: Mon, 17 Nov 2014 15:40:24 +0800
Subject: [PATCH 4/7] dt-bindings: Add document for MT6397 MFD
In-Reply-To: <1416210027-5562-1-git-send-email-flora.fu@mediatek.com>
References: <1416210027-5562-1-git-send-email-flora.fu@mediatek.com>
Message-ID: <1416210027-5562-5-git-send-email-flora.fu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Flora Fu <flora.fu@mediatek.com>
---
 Documentation/devicetree/bindings/mfd/mt6397.txt | 87 ++++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mt6397.txt

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
new file mode 100644
index 0000000..0783368
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -0,0 +1,87 @@
+MediaTek MT6397 multifunction device
+
+MT6397 is a multifunction device with the following sub modules:
+- PMIC
+- Regulator
+- RTC
+- Audio codec
+- GPIO
+- Clock
+
+It is interfaced to host controller using SPI interface by a proprietary hardware
+called pmic wrapper or pwrap. This document describes the binding for mfd device
+and PMIC sub module.
+
+Required properties in pwrap device node.
+- compatible:"mediatek,mt8135-pwrap";
+- interrupts : This pmic wrapper device has an IRQ line connected to the main SoC.
+- reg: Specifies the address of pwrap in AP.
+- resets: reset bit for pwrap
+- clock: clock frequency selection in SPI bus.
+- pmic: Mediatek PMIC used pwrap as its communication protocol.
+
+Example:
+	pwrap: pwrap at 1000f000 {
+		compatible = "mediatek,mt8135-pwrap";
+		reg = <0 0x1000f000 0 0x1000>,
+			<0 0x11017000 0 0x1000>;
+		reg-names = "pwrap-base", "pwrap-bridge-base";
+		interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+		resets = <&infrarst MT8135_INFRA_PMIC_WRAP_RST>,
+				<&perirst MT8135_PERI_PWRAP_BRIDGE_SW_RST>;
+		reset-names = "infra-pwrap-rst",
+				"peri-pwrap-bridge-rst";
+		clocks = <&pmicspi_sel>, <&clk26m> ;
+		clock-names = "pmicspi-sel", "pmicspi-parent";
+
+		pmic {
+			compatible = "mediatek,mt6397";
+	}
+
+MT6397 MFD device should in pwrap device node.
+Optional properties:
+- codec: Audio Codec
+- pinctrl: GPIO in mt6397
+- rtc: RTC
+- clock: clocks in mt6397
+- regulators : The regulators of mt6397
+	regulators {
+		regulator constratints.
+		refer Documentation/devicetree/bindings/regulator/regulator.txt
+	};
+
+Example:
+	pwrap: pwrap at 1000f000 {
+		[...]
+		pmic {
+			compatible = "mediatek,mt6397";
+
+			codec: mt6397codec {
+				compatible = "mediatek,mt6397-codec";
+			};
+
+			pinctrl at 0x0000C000 {
+				compatible = "mediatek,mt6397-pinctrl";
+				reg = <0 0x0000C000 0 0x0108>;
+				gpio-controller;
+			};
+
+			regulators {
+				mt6397_vpca15_reg: buck_vpca15 {
+					regulator-name = "vpca15";
+					regulator-min-microvolt = < 700000>;
+					regulator-max-microvolt = <1493750>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				mt6397_vpca7_reg: buck_vpca7 {
+					regulator-name = "vpca7";
+					regulator-min-microvolt = < 700000>;
+					regulator-max-microvolt = <1493750>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+			}
+		}
+	}
\ No newline at end of file
-- 
1.8.1.1.dirty
