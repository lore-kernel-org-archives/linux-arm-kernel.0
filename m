From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 29 Apr 2015 22:32:25 +0000
Subject: [PATCH V2 4/6] DT: add binding for mxs on-chip regulators
In-Reply-To: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1430346747-28728-5-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the device tree bindings for the Freescale MXS on-chip
regulators.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../bindings/regulator/mxs-regulator.txt           |   65 ++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mxs-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/mxs-regulator.txt b/Documentation/devicetree/bindings/regulator/mxs-regulator.txt
new file mode 100644
index 0000000..e7092fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mxs-regulator.txt
@@ -0,0 +1,65 @@
+Regulators on Freescale i.MX23/i.MX28
+
+On-chip linear regulator daisy chain:
+
++------------+     VDD5V  +---------+  VDDIO
+| DC-DC      |   +--------> LINREG  +--------->+
+|            |            | VDDIO   |          |
+|            |            +---------+          |
+| DCDC_VDDIO +->-+-----------------------------+
+|            |   |
+|            |   | VDDIO  +---------+  VDDA
+|            |   +--------> LINREG  +--------->+
+|            |            | VDDA    |          |
+|            |            +---------+          |
+| DCDC_VDDA  +->-+-----------------------------+
+|            |   |
+|            |   | VDDA   +---------+  VDD1P5
+|            |   +--------> LINREG  +--------->
+|            |   |        | VDD1P5  |
+|            |   |        +---------+
+|            |   | VDDA   +---------+  VDDD
+|            |   +--------> LINREG  +--------->+
+|            |            | VDDD    |          |
+|            |            +---------+          |
+| DCDC_VDDD  +->-------------------------------+
++------------+                                 |
+                                               v
+
+Required properties:
+- compatible (imx23 and imx28 supported):
+  - "fsl,<soc>-dcdc" for DC-DC converter
+  - "fsl,<soc>-vddd" for VDDD linear regulator
+  - "fsl,<soc>-vdda" for VDDA linear regulator
+  - "fsl,<soc>-vddio" for VDDIO linear regulator
+
+Optional properties:
+- switching-frequency: switching frequency for the DC-DC converter in Hz.
+  Possible values are <1200000>, <1250000> or <1500000> (default).
+
+Any regulator property defined as part of the core regulator
+binding, defined in regulator.txt, can also be used.
+
+Example for i.MX28:
+
+	power: power at 80044000 {
+		compatible = "fsl,imx28-power", "syscon";
+		reg = <0x80044000 0x2000>;
+		interrupts = <6>;
+
+		dcdc: regulator at 1 {
+			compatible = "fsl,imx28-dcdc";
+			regulator-name = "dcdc";
+			regulator-boot-on;
+			regulator-always-on;
+			switching-frequency = <1250000>;
+		};
+
+		reg_vddd: regulator at 2 {
+			compatible = "fsl,imx28-vddd";
+			regulator-name = "vddd";
+			regulator-min-microvolt = <1350000>;
+			regulator-max-microvolt = <1550000>;
+		};
+	};
+
-- 
1.7.9.5
