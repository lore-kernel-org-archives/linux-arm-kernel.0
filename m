From: ping.bai@nxp.com (Bai Ping)
Date: Tue, 2 Feb 2016 18:01:35 +0800
Subject: [PATCH V3 2/5] ARM: dts: imx: Add basic dts support for imx6qp SOC
In-Reply-To: <1454407298-15545-1-git-send-email-ping.bai@nxp.com>
References: <1454407298-15545-1-git-send-email-ping.bai@nxp.com>
Message-ID: <1454407298-15545-2-git-send-email-ping.bai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX6Quad Plus processor is an high performance SOC of i.MX6 family.
It has enhanced graphics performance and increased overall memory bandwidth
compared to i.MX6Q. Most of the design are same as i.MX6Quad/Dual, so code
for i.MX6Quad can be resued by this chip. The revision number is identied as
i.MX6Q Rev2.0, but actually it is a new chip, as we did many change to the
overall architecture.

This patch adds basic dtsi file support for the new i.MX6Quad Plus processor.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
---

change for V3:
--remove some device node that the driver is not ready or stable in upstream
-- update the copyright header


 arch/arm/boot/dts/imx6q.dtsi           |  2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi |  1 +
 arch/arm/boot/dts/imx6qp.dtsi          | 86 ++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx6qp.dtsi

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 0d93c0e..ddcb37b 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -22,7 +22,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			reg = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index a6d445c..f65f57b 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -238,6 +238,7 @@
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
+				regulator-ramp-delay = <6250>;
 			};
 
 			sw3a_reg: sw3a {
diff --git a/arch/arm/boot/dts/imx6qp.dtsi b/arch/arm/boot/dts/imx6qp.dtsi
new file mode 100644
index 0000000..1ada714
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qp.dtsi
@@ -0,0 +1,86 @@
+/*
+ * Copyright 2016 Freescale Semiconductor, Inc.
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "imx6q.dtsi"
+
+/ {
+	soc {
+		ocram2: sram at 00940000 {
+			compatible = "mmio-sram";
+			reg = <0x00940000 0x20000>;
+			clocks = <&clks IMX6QDL_CLK_OCRAM>;
+		};
+
+		ocram3: sram at 00960000 {
+			compatible = "mmio-sram";
+			reg = <0x00960000 0x20000>;
+			clocks = <&clks IMX6QDL_CLK_OCRAM>;
+		};
+
+		ipu1: ipu at 02400000 {
+			compatible = "fsl,imx6qp-ipu", "fsl,imx6q-ipu";
+			clocks = <&clks IMX6QDL_CLK_IPU1>,
+				 <&clks IMX6QDL_CLK_IPU1_DI0>, <&clks IMX6QDL_CLK_IPU1_DI1>,
+				 <&clks IMX6QDL_CLK_IPU1_DI0_SEL>, <&clks IMX6QDL_CLK_IPU1_DI1_SEL>,
+				 <&clks IMX6QDL_CLK_LDB_DI0_PODF>, <&clks IMX6QDL_CLK_LDB_DI1_PODF>,
+				 <&clks IMX6QDL_CLK_PRG0_APB>;
+			clock-names = "bus",
+				      "di0", "di1",
+				      "di0_sel", "di1_sel",
+				      "ldb_di0", "ldb_di1", "prg";
+		};
+
+		ipu2: ipu at 02800000 {
+			compatible = "fsl,imx6qp-ipu", "fsl,imx6q-ipu";
+			clocks = <&clks IMX6QDL_CLK_IPU2>,
+				 <&clks IMX6QDL_CLK_IPU2_DI0>, <&clks IMX6QDL_CLK_IPU2_DI1>,
+				 <&clks IMX6QDL_CLK_IPU2_DI0_SEL>, <&clks IMX6QDL_CLK_IPU2_DI1_SEL>,
+				 <&clks IMX6QDL_CLK_LDB_DI0_PODF>, <&clks IMX6QDL_CLK_LDB_DI1_PODF>,
+				 <&clks IMX6QDL_CLK_PRG1_APB>;
+			clock-names = "bus",
+				      "di0", "di1",
+				      "di0_sel", "di1_sel",
+				      "ldb_di0", "ldb_di1", "prg";
+		};
+
+	};
+};
-- 
1.9.1
