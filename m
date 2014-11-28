From: flora.fu@mediatek.com (Flora Fu)
Date: Fri, 28 Nov 2014 11:54:30 +0800
Subject: [PATCH v2 4/8] dt-bindings:: Add document for MT8135 PMIC Wrapper
In-Reply-To: <1417146874-5232-1-git-send-email-flora.fu@mediatek.com>
References: <1417146874-5232-1-git-send-email-flora.fu@mediatek.com>
Message-ID: <1417146874-5232-5-git-send-email-flora.fu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Signed-off-by: Flora Fu <flora.fu@mediatek.com>
---
 .../soc/mediatek/mediatek,mt8135-pwrap.txt         | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8135-pwrap.txt

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8135-pwrap.txt b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8135-pwrap.txt
new file mode 100644
index 0000000..46e9b2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8135-pwrap.txt
@@ -0,0 +1,79 @@
+MediaTek MT8135 PMIC Wrapper Driver
+
+MediaTek PMIC MFD is interfaced to host controller using SPI interface
+by a proprietary hardware called PMIC wrapper or pwrap.
+
++-----------------+           +---------------+
+|                 |           |               |
+| Mediatek AP SoC |           |               |
+| (ex. MT8135)    |           |    MT6397     |
+|                 |           |               |
+|      +--------+ | (SPI bus) | +--------+    |
+|      |        | |-----------| |        |    |
+|      |  PMIC  | |-----------| |  PMIC  |    |
+|      | Wrapper| |-----------| | Wrapper|    |
+|      |        | |-----------| |        |    |
+|      +--------+ |           | +--------+    |
+|                 |           |               |
++-----------------+           +---------------+
+
+This document describes the binding for MT8135 PMIC wrapper.
+
+Required properties in pwrap device node.
+- compatible:"mediatek,mt8135-pwrap"
+- interrupts: IRQ for pwrap in SOC
+- reg: address range for pwrap registers
+- resets: reset bit for pwrap
+- clock: clock frequency selection in SPI bus
+- pmic: Mediatek PMIC MFD is the child device of pwrap
+
+Properties for children:
+See the following for child node definitions:
+Documentation/devicetree/bindings/mfd/mt6397.txt
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
+		clocks = <&pmicspi_sel>, <&clk26m>;
+		clock-names = "pmicspi-sel", "pmicspi-parent";
+
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
-- 
1.8.1.1.dirty
