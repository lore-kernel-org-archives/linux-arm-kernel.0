From: denis@eukrea.com (Denis Carikli)
Date: Mon, 15 Jul 2013 16:57:07 +0200
Subject: =?UTF-8?q?=5BPATCH=2022/22=5D=20arm/dts=3A=20Add=20support=20for=20the=20cpuimx35=20board=20from=20Eukrea=20and=20its=20baseboard=2E?=
In-Reply-To: <1373900227-341-1-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
Message-ID: <1373900227-341-23-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only the following devices were added:
 * Main UART
 * Memory node
 * NAND
 * i2c and its pcf8563
 * Ethernet

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt     |    4 ++
 arch/arm/boot/dts/eukrea_cpuimx35.dts             |   45 +++++++++++++++++++++
 arch/arm/boot/dts/eukrea_mbimxsd35-baseboard.dtsi |   19 +++++++++
 3 files changed, 68 insertions(+)
 create mode 100644 arch/arm/boot/dts/eukrea_cpuimx35.dts
 create mode 100644 arch/arm/boot/dts/eukrea_mbimxsd35-baseboard.dtsi

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 4001d91..40d5d22 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -21,6 +21,10 @@ i.MX28 Evaluation Kit
 Required root node properties:
     - compatible = "fsl,imx28-evk", "fsl,imx28";
 
+i.MX35 Eukrea CPUIMX35 Board
+Required root node properties:
+    - compatible = "fsl,eukrea_cpuimx35", "fsl,imx35";
+
 i.MX51 Babbage Board
 Required root node properties:
     - compatible = "fsl,imx51-babbage", "fsl,imx51";
diff --git a/arch/arm/boot/dts/eukrea_cpuimx35.dts b/arch/arm/boot/dts/eukrea_cpuimx35.dts
new file mode 100644
index 0000000..162df18c
--- /dev/null
+++ b/arch/arm/boot/dts/eukrea_cpuimx35.dts
@@ -0,0 +1,45 @@
+/*
+ * Copyright 2013 Eukr?a Electromatique <denis@eukrea.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+#include "imx35.dtsi"
+#include "eukrea_mbimxsd35-baseboard.dtsi"
+/ {
+	model = "Eukrea CPUIMX35";
+	compatible = "fsl,eukrea_cpuimx35", "fsl,imx35";
+
+	memory {
+		reg = <0x80000000 0x8000000>; /* 128M */
+	};
+};
+
+&nand {
+	nand-bus-width = <8>;
+	nand-ecc-mode = "hw";
+	nand-on-flash-bbt;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1_1>;
+	status = "okay";
+	pcf8563 at 51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec_1>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/eukrea_mbimxsd35-baseboard.dtsi b/arch/arm/boot/dts/eukrea_mbimxsd35-baseboard.dtsi
new file mode 100644
index 0000000..7ac5572
--- /dev/null
+++ b/arch/arm/boot/dts/eukrea_mbimxsd35-baseboard.dtsi
@@ -0,0 +1,19 @@
+/*
+ * Copyright 2013 Eukr?a Electromatique <denis@eukrea.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include "skeleton.dtsi"
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_1>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
-- 
1.7.9.5
