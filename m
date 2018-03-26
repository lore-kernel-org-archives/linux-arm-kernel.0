From: jagan@amarulasolutions.com (Jagan Teki)
Date: Mon, 26 Mar 2018 13:35:54 +0530
Subject: [PATCH v4] ARM: dts: imx6q: Add Engicam i.CoreM6 1.5 Quad/Dual MIPI
 starter kit support
In-Reply-To: <20180326080554.11559-1-jagan@amarulasolutions.com>
References: <20180326080554.11559-1-jagan@amarulasolutions.com>
Message-ID: <20180326080554.11559-2-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.CoreM6 1.5 is an another i.CoreM6 QDL cpu modules which can be connected
to EDIMM starter kit design with eMMC and MIPI-CSI interfaces suitable for
Android and video capture application.

notable features:
CPU			NXP i.MX6 S/DL/D/Q, Up to 4 x Cortex-A9 at 800MHz
Memory  		Up to 2 GB DDR3-1066
Video Interfaces	Up to 1 Parallel Up to 2 LVDS HDMI 1.4
			port 8 bit CSI INPUT MIPI-CSI INPUT
1 x 10/100 Ethernet interface, 2 x USB, 1 x PCIe, 1 x I2S etc

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4:
- Send as seprate patch from previous series
  https://patchwork.kernel.org/patch/10199429/
Changes for v3:
- none
Changes for v2:
- new patch  

 arch/arm/boot/dts/Makefile             |  1 +
 arch/arm/boot/dts/imx6q-icore-mipi.dts | 25 +++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-icore.dtsi   | 23 +++++++++++++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-icore-mipi.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 3b4cc1b64a1e..ac188ecee1a1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -463,6 +463,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-hummingboard2-emmc-som-v15.dtb \
 	imx6q-hummingboard2-som-v15.dtb \
 	imx6q-icore.dtb \
+	imx6q-icore-mipi.dtb \
 	imx6q-icore-ofcap10.dtb \
 	imx6q-icore-ofcap12.dtb \
 	imx6q-icore-rqs.dtb \
diff --git a/arch/arm/boot/dts/imx6q-icore-mipi.dts b/arch/arm/boot/dts/imx6q-icore-mipi.dts
new file mode 100644
index 000000000000..acd3d33476d4
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-icore-mipi.dts
@@ -0,0 +1,25 @@
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
+	model = "Engicam i.CoreM6 Quad/Dual MIPI Starter Kit";
+	compatible = "engicam,imx6-icore", "fsl,imx6q";
+};
+
+&hdmi {
+	ddc-i2c-bus = <&i2c2>;
+	status = "okay";
+};
+
+&usdhc3 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index 1bce85c3376b..0a1574998fc6 100644
--- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -265,6 +265,14 @@
 	status = "okay";
 };
 
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	no-1-8-v;
+	non-removable;
+	status = "disabled";
+};
+
 &iomuxc {
 	pinctrl_audmux: audmux {
 		fsl,pins = <
@@ -378,4 +386,19 @@
 			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17070
 		>;
 	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_CMD__SD3_CMD    0x17059
+			MX6QDL_PAD_SD3_CLK__SD3_CLK    0x10059
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x17059
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x17059
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x17059
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x17059
+			MX6QDL_PAD_SD3_DAT4__SD3_DATA4 0x17059
+			MX6QDL_PAD_SD3_DAT5__SD3_DATA5 0x17059
+			MX6QDL_PAD_SD3_DAT6__SD3_DATA6 0x17059
+			MX6QDL_PAD_SD3_DAT7__SD3_DATA7 0x17059
+		>;
+	};
 };
-- 
2.14.3
