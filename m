From: Andrei.Stefanescu@microchip.com (Andrei.Stefanescu at microchip.com)
Date: Tue, 13 Nov 2018 11:29:24 +0000
Subject: [PATCH 1/3] regulator: dt-bindings: add MCP16502 regulator bindings
In-Reply-To: <1542108563-10108-1-git-send-email-andrei.stefanescu@microchip.com>
References: <1542108563-10108-1-git-send-email-andrei.stefanescu@microchip.com>
Message-ID: <1542108563-10108-2-git-send-email-andrei.stefanescu@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch describes the compatible and the device tree
bindings necessary for the MCP16502 PMIC.

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
---
 .../bindings/regulator/mcp16502-regulator.txt      | 107 +++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt b/Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
new file mode 100644
index 0000000..bb3d787
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
@@ -0,0 +1,107 @@
+MCP16502 PMIC
+
+Required properties:
+- compatible: "microchip,mcp16502"
+- reg: I2C slave address
+- lpm-gpio: GPIO for LPM pin. Note that this GPIO *must* remain high during
+	     suspend-to-ram, keeping the PMIC into HIBERNATE mode.
+- regulators: A node that houses a sub-node for each regulator within
+              the device. Each sub-node is identified using the node's
+              name. The content of each sub-node is defined by the
+              standard binding for regulators; see regulator.txt.
+
+Regulator modes:
+2 - FPWM: higher precision, higher consumption
+4 - AutoPFM: lower precision, lower consumption
+
+Each regulator is defined using the standard binding for regulators.
+
+Example:
+
+mcp16502 at 5b {
+	compatible = "microchip,mcp16502";
+	reg = <0x5b>;
+	status = "okay";
+	lpm-gpios = <&pioBU 7 GPIO_ACTIVE_HIGH>;
+
+	regulators {
+		VDD_IO {
+			regulator-name = "VDD_IO";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3700000>;
+			regulator-initial-mode = <2>;
+			regulator-allowed-modes = <2>, <4>;
+			regulator-always-on;
+
+			regulator-state-mem {
+				regulator-off-in-suspend;
+				regulator-mode = <4>;
+			};
+		};
+
+		VDD_DDR {
+			regulator-name = "VDD_DDR";
+			regulator-min-microvolt = <600000>;
+			regulator-max-microvolt = <1850000>;
+			regulator-initial-mode = <2>;
+			regulator-allowed-modes = <2>, <4>;
+			regulator-always-on;
+
+			regulator-state-mem {
+				regulator-on-in-suspend;
+				regulator-mode = <4>;
+			};
+		};
+
+		VDD_CORE {
+			regulator-name = "VDD_CORE";
+			regulator-min-microvolt = <600000>;
+			regulator-max-microvolt = <1850000>;
+			regulator-initial-mode = <2>;
+			regulator-allowed-modes = <2>, <4>;
+			regulator-always-on;
+
+			regulator-state-mem {
+				regulator-off-in-suspend;
+				regulator-mode = <4>;
+			};
+		};
+
+		VDD_OTHER {
+			regulator-name = "VDD_OTHER";
+			regulator-min-microvolt = <600000>;
+			regulator-max-microvolt = <1850000>;
+			regulator-initial-mode = <2>;
+			regulator-allowed-modes = <2>, <4>;
+			regulator-always-on;
+
+			regulator-state-mem {
+				regulator-off-in-suspend;
+				regulator-mode = <4>;
+			};
+		};
+
+		LDO1 {
+			regulator-name = "LDO1";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3700000>;
+			regulator-always-on;
+
+			regulator-state-mem {
+				regulator-off-in-suspend;
+			};
+		};
+
+		LDO2 {
+			regulator-name = "LDO2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3700000>;
+			regulator-always-on;
+
+			regulator-state-mem {
+				regulator-off-in-suspend;
+			};
+		};
+
+	};
+};
-- 
2.7.4
