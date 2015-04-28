From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 28 Apr 2015 16:17:38 +0200
Subject: [PATCH 1/2] Regulator: mc34708: Add DT binding documentation
In-Reply-To: <20150428141736.16243.57292.stgit@localhost>
References: <20150428141736.16243.57292.stgit@localhost>
Message-ID: <20150428141738.16243.18377.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 .../bindings/regulator/mc34708-regulator.txt       |  198 ++++++++++++++++++++
 1 file changed, 198 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mc34708-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/mc34708-regulator.txt b/Documentation/devicetree/bindings/regulator/mc34708-regulator.txt
new file mode 100644
index 0000000..35efae0
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mc34708-regulator.txt
@@ -0,0 +1,198 @@
+Regulators included in the Freescale MC34708 PMIC
+
+Required properties:
+- compatible: "fsl,mc34708"
+- reg: I2C slave address
+
+
+Regulators subnode:
+-------------------
+This node contains children following the standard regulator binding format
+described in Documentation/devicetree/bindings/regulator/regulator.txt
+
+The allowed node names are:
+	Switchers:
+		sw1, sw2, sw3, sw4a, sw4b, sw5, swbst
+	LDOs:
+		vpll, vrefddr, vusb, vusb2, vdac, vgen1, vgen2
+
+The mode values are:
+	Switchers:
+		1 : Pulse Frequency Modulation (PFM) [for low loads]
+		2 : Auto
+		3 : Pulse Width Modulation (PWM) [for high loads]
+	LDOs:
+		1 : Low power
+		2 : Normal
+
+Optional properties:
+The input supply of regulators are the optional properties on the
+regulator node.
+
+- vinsw1-supply : phandle to input supply for sw1 regulator
+- vinsw2-supply : phandle to input supply for sw2 regulator
+- vinsw3-supply : phandle to input supply for sw3 regulator
+- vinsw4a-supply : phandle to input supply for sw4a regulator
+- vinsw4b-supply : phandle to input supply for sw4b regulator
+- vinsw5-supply : phandle to input supply for sw5 regulator
+- vinswbst-supply : phandle to input supply for swbst regulator
+- vinrefddr-supply : phandle to input supply for vrefddr regulator (/2)
+
+
+Example:
+&i2c3 {
+	pmic: mc34708 at 08 {
+		compatible = "fsl,mc34708";
+		reg = <0x08>;
+		regulators {
+#define PMIC_REGMODE_SW_PFM	1
+#define PMIC_REGMODE_SW_AUTO	2
+#define PMIC_REGMODE_SW_PWM	3
+#define PMIC_REGMODE_LDO_LP	1
+#define PMIC_REGMODE_LDO_NORMAL	2
+
+			vinrefddr-supply = <&pmic_sw4a_reg>;
+			pmic_sw1_reg: sw1 {
+				/* CPU Core */
+				regulator-name = "SW1";
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <1437500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-initial-mode = <PMIC_REGMODE_SW_PWM>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <850000>;
+					regulator-mode = <PMIC_REGMODE_SW_PFM>;
+				};
+			};
+
+			pmic_sw2_reg: sw2 {
+				/* SOC Periperals */
+				regulator-name = "SW2";
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <1437500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-initial-mode = <PMIC_REGMODE_SW_PWM>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <950000>;
+					regulator-mode = <PMIC_REGMODE_SW_PFM>;
+				};
+			};
+
+			pmic_sw3_reg: sw3 {
+				regulator-name = "SW3";
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <1425000>;
+			};
+
+			pmic_sw4a_reg: sw4a {
+				/* DDR Ram */
+				regulator-name = "SW4A";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-initial-mode = <PMIC_REGMODE_SW_PWM>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-mode = <PMIC_REGMODE_SW_PFM>;
+				};
+			};
+
+			pmic_sw5_reg: sw5 {
+				/* 1v8 power */
+				regulator-name = "SW5";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-initial-mode = <PMIC_REGMODE_SW_PWM>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-mode = <PMIC_REGMODE_SW_PFM>;
+				};
+			};
+
+			pmic_swbst_reg: swbst {
+				regulator-name = "SWBST";
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-initial-mode = <PMIC_REGMODE_SW_AUTO>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			pmic_vpll_reg: vpll {
+				regulator-name = "VPLL";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			pmic_vrefddr_reg: vrefddr {
+				regulator-name = "VREFDDR";
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			pmic_vusb_reg: vusb {
+				regulator-name = "VUSB";
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			pmic_vusb2_reg: vusb2 {
+				regulator-name = "VUSB2";
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			pmic_vdac_reg: vdac {
+				regulator-name = "VDAC";
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2775000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-initial-mode = <PMIC_REGMODE_LDO_NORMAL>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-mode = <PMIC_REGMODE_LDO_LP>;
+				};
+			};
+
+			pmic_vgen1_reg: vgen1 {
+				regulator-name = "VGEN1";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1550000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			pmic_vgen2_reg: vgen2 {
+				regulator-name = "VGEN2";
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-initial-mode = <PMIC_REGMODE_LDO_NORMAL>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-mode = <PMIC_REGMODE_LDO_LP>;
+				};
+			};
+		};
+	};
+};
