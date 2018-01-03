From: jagan@amarulasolutions.com (Jagan Teki)
Date: Wed,  3 Jan 2018 13:30:47 +0530
Subject: [PATCH] ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual OpenFrame Cap
 7 initial support
Message-ID: <1514966447-30068-1-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.CoreM6 Quad/Dual OpenFrame modules are "system on modules plus
openframe display carriers" which are good solution for develop user
friendly graphic user interface.

ofcap 7 general features:
CPU           NXP Freescale i.MX6Q rev1.5 at 792 MHz
RAM           1GB, 32, 64 bit, DDR3-800/1066
NAND          SLC, 512MB
LVDS Display  TFT 7" industrial, 800x480 resolution
Touchscreen   EP0700M06 EDT Polytouch capacitive touch screen
Backlight     LED backlight, brightness 300 Cd/m2
Power supply  15 to 30 Vdc

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/Makefile               |   1 +
 arch/arm/boot/dts/imx6q-icore-ofcap7.dts | 100 +++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-icore-ofcap7.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0bb8db3..11d0544 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -451,6 +451,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-icore.dtb \
 	imx6q-icore-ofcap10.dtb \
 	imx6q-icore-ofcap12.dtb \
+	imx6q-icore-ofcap7.dtb \
 	imx6q-icore-rqs.dtb \
 	imx6q-marsboard.dtb \
 	imx6q-mccmon6.dtb \
diff --git a/arch/arm/boot/dts/imx6q-icore-ofcap7.dts b/arch/arm/boot/dts/imx6q-icore-ofcap7.dts
new file mode 100644
index 0000000..f0be682
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-icore-ofcap7.dts
@@ -0,0 +1,100 @@
+/*
+ * Copyright (C) 2016 Amarula Solutions B.V.
+ * Copyright (C) 2016 Engicam S.r.l.
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License
+ *     version 2 as published by the Free Software Foundation.
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
+/dts-v1/;
+
+#include "imx6q.dtsi"
+#include "imx6qdl-icore.dtsi"
+
+/ {
+	model = "Engicam i.CoreM6 Quad/Dual OpenFrame Capacitive touch 7 Kit";
+	compatible = "engicam,imx6-icore", "fsl,imx6q";
+
+	panel {
+		compatible = "ampire,am-800480aytzqw-00h";
+		backlight = <&backlight_lvds>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lvds0_out>;
+			};
+		};
+	};
+};
+
+&i2c3 {
+	ep0700m06: touchscreen at 38 {
+		compatible = "edt,edt-ft5406";
+		reg = <0x38>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_edt_ft5x06>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <30 IRQ_TYPE_NONE>;
+		reset-gpios = <&gpio6 0 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&ldb {
+	status = "okay";
+
+	lvds-channel at 0 {
+		reg = <0>;
+		status = "okay";
+
+		port at 4 {
+			reg = <4>;
+
+			lvds0_out: endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl_edt_ft5x06:  edt-ft5x06grp  {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT12__GPIO5_IO30 0x1b0b0 /*interrupt*/
+			MX6QDL_PAD_CSI0_DAT14__GPIO6_IO00 0x1b0b0 /*reset edt*/
+		>;
+	};
+};
-- 
2.7.4
