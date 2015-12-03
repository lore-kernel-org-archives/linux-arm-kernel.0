From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Thu,  3 Dec 2015 16:10:36 -0500
Subject: [PATCH v5 7/7] ARM: dts: imx: Add support for Advantech/GE B850v3
In-Reply-To: <1449177036-13317-1-git-send-email-akshay.bhat@timesys.com>
References: <1449177036-13317-1-git-send-email-akshay.bhat@timesys.com>
Message-ID: <1449177036-13317-8-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Advantech/GE B850v3 board.

Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---
 arch/arm/boot/dts/Makefile         |   1 +
 arch/arm/boot/dts/imx6q-b850v3.dts | 127 +++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-b850v3.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9cdff66..37d5b09 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -312,6 +312,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-arm2.dtb \
 	imx6q-b450v3.dtb \
 	imx6q-b650v3.dtb \
+	imx6q-b850v3.dtb \
 	imx6q-cm-fx6.dtb \
 	imx6q-cubox-i.dtb \
 	imx6q-dfi-fs700-m60.dtb \
diff --git a/arch/arm/boot/dts/imx6q-b850v3.dts b/arch/arm/boot/dts/imx6q-b850v3.dts
new file mode 100644
index 0000000..652f237
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-b850v3.dts
@@ -0,0 +1,127 @@
+/*
+ * Copyright 2015 Timesys Corporation.
+ * Copyright 2015 General Electric Company
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
+
+#include "imx6q-bx50v3.dtsi"
+
+/ {
+	model = "General Electric B850v3";
+	compatible = "ge,imx6q-b850v3", "advantech,imx6q-ba16", "fsl,imx6q";
+
+	chosen {
+		stdout-path = &uart3;
+	};
+
+	panel_lvds0 {
+		compatible = "auo,b133htn01";
+		backlight = <&backlight_lvds>;
+		ddc-i2c-bus = <&mux_i2c12>;
+
+		port {
+			panel_in_lvds0: endpoint {
+				remote-endpoint = <&lvds0_out>;
+			};
+		};
+	};
+};
+
+&ldb {
+	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
+			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
+	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
+				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
+	fsl,dual-channel;
+	status = "okay";
+
+	lvds0: lvds-channel at 0 {
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <24>;
+		status = "okay";
+
+		port at 4 {
+			reg = <4>;
+
+			lvds0_out: endpoint {
+				remote-endpoint = <&panel_in_lvds0>;
+			};
+		};
+	};
+};
+
+&i2c2 {
+	pca9547_ddc: mux at 70 {
+		compatible = "nxp,pca9547";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mux_i2c11: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0>;
+		};
+
+		mux_i2c12: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x1>;
+		};
+
+		mux_i2c13: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2>;
+		};
+
+		mux_i2c14: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x3>;
+		};
+
+		mux_i2c15: i2c at 4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x4>;
+		};
+
+		mux_i2c16: i2c at 5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x5>;
+		};
+
+		mux_i2c17: i2c at 6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x6>;
+		};
+
+		mux_i2c18: i2c at 7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x7>;
+		};
+	};
+};
+
+&hdmi {
+	ddc-i2c-bus = <&mux_i2c11>;
+};
+
+&mux_i2c3 {
+	ads7830_2: ads7830 at 4a {
+		compatible = "ti,ads7830";
+		reg = <0x4a>;
+	};
+};
-- 
2.6.3
