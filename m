From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 21 Jan 2015 09:34:54 +0800
Subject: [PATCH v2 2/2] ARM: imx6sx-sdb: add revb board and make it default
In-Reply-To: <1421804094-26379-1-git-send-email-peter.chen@freescale.com>
References: <1421804094-26379-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1421804094-26379-3-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since imx6sx-sdb reva board is experimental and will not be used
formally (eg, no software release based on it), we set revb board
as the formal imx6sx-sdb board.

The imx6sx-sdb uses pfuse200 as pmic which has only one power supply
for both VDDARM_IN and VDDSOC_IN, so VDDARM_IN and VDDSOC_IN have to
use the same (higher one in the same frequency) one as its power supply,
that's the reason we override the OPP setting in board dts file.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/boot/dts/Makefile       |   3 +-
 arch/arm/boot/dts/imx6sx-sdb.dts | 145 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx6sx-sdb.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 50eff7b..71bfdf7 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -303,7 +303,8 @@ dtb-$(CONFIG_SOC_IMX6SL) += \
 	imx6sl-evk.dtb
 dtb-$(CONFIG_SOC_IMX6SX) += \
 	imx6sx-sabreauto.dtb \
-	imx6sx-sdb-reva.dtb
+	imx6sx-sdb-reva.dtb \
+	imx6sx-sdb.dtb
 dtb-$(CONFIG_SOC_LS1021A) += \
 	ls1021a-qds.dtb \
 	ls1021a-twr.dtb
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
new file mode 100644
index 0000000..0bfc4e7
--- /dev/null
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -0,0 +1,145 @@
+/*
+ * Copyright (C) 2015 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "imx6sx-sdb.dtsi"
+
+/ {
+	model = "Freescale i.MX6 SoloX SDB RevB Board";
+};
+
+&cpu0 {
+	operating-points = <
+		/* kHz    uV */
+		996000  1250000
+		792000  1175000
+		396000  1175000
+		>;
+	fsl,soc-operating-points = <
+		/* ARM kHz      SOC uV */
+		996000	1250000
+		792000	1175000
+		396000	1175000
+	>;
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pmic: pfuze100 at 08 {
+		compatible = "fsl,pfuze200";
+		reg = <0x08>;
+
+		regulators {
+			sw1a_reg: sw1ab {
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw2_reg: sw2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3a_reg: sw3a {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3b_reg: sw3b {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1975000>;
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
+			vgen1_reg: vgen1 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+				regulator-always-on;
+			};
+
+			vgen2_reg: vgen2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+			};
+
+			vgen3_reg: vgen3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen4_reg: vgen4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen5_reg: vgen5 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen6_reg: vgen6 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&qspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi2>;
+	status = "okay";
+
+	flash0: n25q256a at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "micron,n25q256a";
+		spi-max-frequency = <29000000>;
+		reg = <0>;
+	};
+
+	flash1: n25q256a at 1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "micron,n25q256a";
+		spi-max-frequency = <29000000>;
+		reg = <1>;
+	};
+};
-- 
1.9.1
