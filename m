From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 22 Mar 2015 00:29:59 +0000
Subject: [PATCH 3/7] DT: add binding for MXS regulator
In-Reply-To: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1426984203-9133-4-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the device tree bindings for the Freescale MXS on-chip
regulators.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../bindings/regulator/mxs-regulator.txt           |   70 ++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mxs-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/mxs-regulator.txt b/Documentation/devicetree/bindings/regulator/mxs-regulator.txt
new file mode 100644
index 0000000..88452d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mxs-regulator.txt
@@ -0,0 +1,70 @@
+Regulators for Freescale i.MX23/i.MX28
+
+Required properties:
+For imx23 regulators
+- compatible:
+  - "fsl,imx23-dcdc" for DC-DC converter
+  - "fsl,imx23-vddd" for VDDD linear regulator
+  - "fsl,imx23-vdda" for VDDA linear regulator
+  - "fsl,imx23-vddio" for VDDIO linear regulator
+For imx28 regulators
+- compatible:
+  - "fsl,imx28-dcdc" for DC-DC converter
+  - "fsl,imx28-vddd" for VDDD linear regulator
+  - "fsl,imx28-vdda" for VDDA linear regulator
+  - "fsl,imx28-vddio" for VDDIO linear regulator
+- reg: Address and length of the register set for the device. It contains
+  the information of registers in the same order as described by reg-names
+- reg-names: Should contain the reg names
+  - "base-address"	- contains base address of regulator
+  - "status-address"	- contains status address of regulator
+  - "v5ctrl-address"	- contains 5V control address of DC-DC converter
+			  (required only for linear regulators)
+  - "misc-address"      - contains misc control address of DC-DC converter
+			  (required only for DC-DC converter)
+
+Optional properties:
+- switching-frequency: switching frequency of the DC-DC converter in Hz.
+  Possible values are <19200000>, <22000000> or <24000000> (default).
+
+Any regulator property defined as part of the core regulator
+binding, defined in regulator.txt, can also be used.
+
+Example for i.MX28:
+
+	power: power at 80044000 {
+		compatible = "fsl,imx28-power";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x80044000 0x2000>;
+		interrupts = <6>;
+		ranges;
+
+		dcdc: regulator at 80044010 {
+			reg = <0x80044010 0x10>,
+			      <0x80044090 0x10>,
+			      <0x800440c0 0x10>;
+			reg-names = "base-address",
+				    "misc-address",
+				    "status-address";
+			compatible = "fsl,imx28-dcdc";
+			regulator-name = "dcdc";
+			regulator-boot-on;
+			regulator-always-on;
+			switching-frequency = <24000000>;
+		};
+
+		reg_vddd: regulator at 80044040 {
+			reg = <0x80044040 0x10>,
+			      <0x80044010 0x10>,
+			      <0x800440c0 0x10>;
+			reg-names = "base-address",
+				    "v5ctrl-address",
+				    "status-address";
+			compatible = "fsl,imx28-vddd";
+			regulator-name = "vddd";
+			regulator-min-microvolt = <1350000>;
+			regulator-max-microvolt = <1550000>;
+		};
+	};
+
-- 
1.7.9.5
