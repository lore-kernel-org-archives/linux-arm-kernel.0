From: jagan@amarulasolutions.com (Jagan Teki)
Date: Thu,  4 Jan 2018 11:42:24 +0530
Subject: [PATCH v2 6/7] ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual
 OpenFrame Cap 7 initial support
In-Reply-To: <1515046345-15881-1-git-send-email-jagan@amarulasolutions.com>
References: <1515046345-15881-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <1515046345-15881-7-git-send-email-jagan@amarulasolutions.com>
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
Changes for v2:
- Updated licence text - remove big notes, add SPDX and author

 arch/arm/boot/dts/Makefile               |  1 +
 arch/arm/boot/dts/imx6q-icore-ofcap7.dts | 65 ++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)
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
index 0000000..6ff7a0a
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-icore-ofcap7.dts
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2017 Engicam S.r.l.
+ * Copyright (C) 2017 Amarula Solutions B.V.
+ * Author: Jagan Teki <jagan@amarulasolutions.com>
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
