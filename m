From: jm@lentin.co.uk (Jamie Lentin)
Date: Fri, 26 Aug 2016 10:21:01 +0100
Subject: [PATCH 5/8] arm: orion5x: Add DT include for mv88f5181
In-Reply-To: <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1472203264-21089-6-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Common definitions for the SoC for board definitions to use.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 .../bindings/arm/marvell/marvell,orion5x.txt       |  1 +
 arch/arm/boot/dts/orion5x-mv88f5181.dtsi           | 49 ++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 arch/arm/boot/dts/orion5x-mv88f5181.dtsi

diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt b/Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt
index a888011..ff3c120 100644
--- a/Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt
@@ -9,6 +9,7 @@ compatible: must contain "marvell,orion5x"
 In addition, the above compatible shall be extended with the specific
 SoC. Currently known SoC compatibles are:
 
+"marvell,orion5x-88f5181"
 "marvell,orion5x-88f5182"
 
 And in addition, the compatible shall be extended with the specific
diff --git a/arch/arm/boot/dts/orion5x-mv88f5181.dtsi b/arch/arm/boot/dts/orion5x-mv88f5181.dtsi
new file mode 100644
index 0000000..f667012
--- /dev/null
+++ b/arch/arm/boot/dts/orion5x-mv88f5181.dtsi
@@ -0,0 +1,49 @@
+/*
+ * Copyright (C) 2016 Jamie Lentin <jm@lentin.co.uk>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include "orion5x.dtsi"
+
+/ {
+	compatible = "marvell,orion5x-88f5181", "marvell,orion5x";
+
+	soc {
+		compatible = "marvell,orion5x-88f5181-mbus", "simple-bus";
+
+		internal-regs {
+			pinctrl: pinctrl at 10000 {
+				compatible = "marvell,88f5181-pinctrl";
+				reg = <0x10000 0x8>, <0x10050 0x4>;
+			};
+
+			core_clk: core-clocks at 10030 {
+				compatible = "marvell,mv88f5181-core-clock";
+				reg = <0x10010 0x4>;
+				#clock-cells = <1>;
+			};
+
+			mbusc: mbus-controller at 20000 {
+				compatible = "marvell,mbus-controller";
+				reg = <0x20000 0x100>, <0x1500 0x20>;
+			};
+		};
+	};
+};
+
+&pinctrl {
+	pmx_ge: pmx-ge {
+		marvell,pins = "mpp8", "mpp9", "mpp10", "mpp11",
+			       "mpp12", "mpp13", "mpp14", "mpp15",
+			       "mpp16", "mpp17", "mpp18", "mpp19";
+		marvell,function = "ge";
+	};
+};
+
+&eth {
+	pinctrl-0 = <&pmx_ge>;
+	pinctrl-names = "default";
+};
-- 
2.8.1
