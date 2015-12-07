From: ilya@compulab.co.il (Ilya Ledvich)
Date: Mon,  7 Dec 2015 09:14:32 +0200
Subject: [PATCH 1/8] ARM: dts: imx7d: cl-som-imx7: add basic module support
In-Reply-To: <1449472479-2521-1-git-send-email-ilya@compulab.co.il>
References: <1449472479-2521-1-git-send-email-ilya@compulab.co.il>
Message-ID: <1449472479-2521-2-git-send-email-ilya@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CL-SOM-iMX7 is a miniature System-on-Module (SoM) based on
Freescale i.MX7 System-on-Chip family.

http://www.compulab.co.il/products/computer-on-modules/cl-som-imx7-freescale-i-mx-7-system-on-module/

Add basic DT support for standalone module (without a carrier board):

* Memory configuration
* I2C2 bus
* PMIC
* UART1

Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
 Documentation/devicetree/bindings/arm/fsl.txt |   4 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts       | 150 ++++++++++++++++++++++++++
 3 files changed, 155 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx7d-cl-som-imx7.dts

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 34c88b0..30b0ba1 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -53,6 +53,10 @@ i.MX6 Quad SABRE Automotive Board
 Required root node properties:
     - compatible = "fsl,imx6q-sabreauto", "fsl,imx6q";
 
+i.MX7D CL-SOM-iMX7 Board
+Required root node properties:
+    - compatible = "compulab,cl-som-imx7", "fsl,imx7d";
+
 Generic i.MX boards
 -------------------
 
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 30bbc37..83ed521 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -350,6 +350,7 @@ dtb-$(CONFIG_SOC_IMX6SX) += \
 dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-14x14-evk.dtb
 dtb-$(CONFIG_SOC_IMX7D) += \
+	imx7d-cl-som-imx7.dtb \
 	imx7d-sdb.dtb
 dtb-$(CONFIG_SOC_LS1021A) += \
 	ls1021a-qds.dtb \
diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
new file mode 100644
index 0000000..6fa6580
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -0,0 +1,150 @@
+/*
+ * Support for CompuLab CL-SOM-iMX7 System-on-Module
+ *
+ * Copyright (C) 2015 CompuLab Ltd. - http://www.compulab.co.il/
+ * Author: Ilya Ledvich <ilya@compulab.co.il>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include "imx7d.dtsi"
+
+/ {
+	model = "CompuLab CL-SOM-iMX7";
+	compatible = "compulab,cl-som-imx7", "fsl,imx7d";
+
+	memory {
+		reg = <0x80000000 0x10000000>; /* 256 MB - minimal configuration */
+	};
+};
+
+&cpu0 {
+	arm-supply = <&sw1a_reg>;
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	pmic: pfuze3000 at 08 {
+		compatible = "fsl,pfuze3000";
+		reg = <0x08>;
+
+		regulators {
+			sw1a_reg: sw1a {
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1475000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			/* use sw1c_reg to align with pfuze100/pfuze200 */
+			sw1c_reg: sw1b {
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1475000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw2_reg: sw2 {
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3a_reg: sw3 {
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1650000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			swbst_reg: swbst {
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5150000>;
+			};
+
+			snvs_reg: vsnvs {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vref_reg: vrefddr {
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vgen1_reg: vldo1 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen2_reg: vldo2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+			};
+
+			vgen3_reg: vccsd {
+				regulator-min-microvolt = <2850000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen4_reg: v33 {
+				regulator-min-microvolt = <2850000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen5_reg: vldo3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen6_reg: vldo4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	assigned-clocks = <&clks IMX7D_UART1_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	status = "okay";
+};
+
+&iomuxc {
+	cl-som-imx7 {
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins = <
+				MX7D_PAD_I2C2_SDA__I2C2_SDA		0x4000007f
+				MX7D_PAD_I2C2_SCL__I2C2_SCL		0x4000007f
+			>;
+		};
+
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <
+				MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
+				MX7D_PAD_UART1_RX_DATA__UART1_DCE_RX	0x79
+			>;
+		};
+	};
+};
-- 
1.9.1
