From: lsartre@adeneo-embedded.com (SARTRE Leo)
Date: Thu, 23 May 2013 17:07:29 +0200
Subject: [PATCH] Add congatec conga-QEVAL minimal board support
Message-ID: <3465D313FDFB824F9A9C8CD24FA4F6BC0108CD11@frontmail.adetel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Conga-QEVAL is a Qseven Evaluation Carrier board, manufactured by
Congatec, it can be used with conga-QMX6 modules based on Freescale's
i.MX6 ARM processors.
More details can be found on the manufacturer's web site:
for the board:
http://www.congatec.com/en/products/accessories/dView/conga-qeval.html
for the module:
http://www.congatec.com/en/products/qseven/dView/conga-qmx6.html

imx6q-congatec.dts: Add minimal congatec device tree (usb, fec, spi
andusdhc)
mach-imx6q.c      : Add fixup function for micrel KSZ9031RNX

Signed-off-by: Leo Sartre <lsartre@adeneo-embedded.com>
---
 arch/arm/boot/dts/imx6q-congatec.dts |   92 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/mach-imx6q.c       |   41 +++++++++++++++
 2 files changed, 133 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-congatec.dts

diff --git a/arch/arm/boot/dts/imx6q-congatec.dts b/arch/arm/boot/dts/imx6q-congatec.dts
new file mode 100644
index 0000000..d54d31a
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-congatec.dts
@@ -0,0 +1,92 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ * Copyright 2013 Adeneo Embedded
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
+#include "imx6q.dtsi"
+
+/ {
+	model = "Congatec i.MX6 Quad QSEVEN eval Board";
+	compatible = "cgt,imx6q-qmx6", "fsl,imx6q";
+
+	memory {
+		reg = <0x10000000 0x40000000>;
+	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		reg_3p3v: 3p3v {
+			compatible = "regulator-fixed";
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+	};
+
+};
+
+&ecspi1 {
+	fsl,spi-num-chipselects = <1>;
+	cs-gpios = <&gpio3 19 0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1_1>;
+	status = "okay";
+
+	flash: m25p80 at 0 {
+		compatible = "sst,sst25vf032b";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	hog {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				MX6Q_PAD_NANDF_D6__GPIO2_IO06 0x80000000
+				MX6Q_PAD_NANDF_D7__GPIO2_IO07 0x80000000
+				MX6Q_PAD_EIM_D23__GPIO3_IO23  0x80000000
+				MX6Q_PAD_EIM_D19__GPIO3_IO19  0x80000000
+			>;
+		};
+	};
+};
+
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet_1>;
+	phy-mode = "rgmii";
+	phy-reset-gpios = <&gpio3 23 0>;
+	status = "okay";
+};
+
+&usdhc4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc4_1>;
+	cd-gpios = <&gpio2 6 0>;
+	wp-gpios = <&gpio2 7 0>;
+	vmmc-supply = <&reg_3p3v>;
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2_1>;
+};
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 5536fd8..7de4208 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -96,6 +96,36 @@ soft:
 	soft_restart(0);
 }
 
+/* For congatec qmx6 board, fixup micrel KSZ9031RNX */
+static int ksz9031rnx_phy_fixup(struct phy_device *phydev)
+{
+	if (IS_BUILTIN(CONFIG_PHYLIB)) {
+		/* adjust KSZ9031 ethernet phy */
+		phy_write(phydev, 0x0d, 0x2);
+		phy_write(phydev, 0x0e, 0x4);
+		phy_write(phydev, 0x0d, 0xc002);
+		phy_write(phydev, 0x0e, 0x0000);
+
+		phy_write(phydev, 0x0d, 0x2);
+		phy_write(phydev, 0x0e, 0x5);
+		phy_write(phydev, 0x0d, 0xc002);
+		phy_write(phydev, 0x0e, 0x0000);
+
+		phy_write(phydev, 0x0d, 0x2);
+		phy_write(phydev, 0x0e, 0x6);
+		phy_write(phydev, 0x0d, 0xc002);
+		phy_write(phydev, 0x0e, 0xffff);
+
+		phy_write(phydev, 0x0d, 0x2);
+		phy_write(phydev, 0x0e, 0x8);
+		phy_write(phydev, 0x0d, 0xc002);
+		phy_write(phydev, 0x0e, 0x3fff);
+		phy_write(phydev, 0x0d, 0x0);
+	}
+
+	return 0;
+}
+
 /* For imx6q sabrelite board: set KSZ9021RN RGMII pad skew */
 static int ksz9021rn_phy_fixup(struct phy_device *phydev)
 {
@@ -145,6 +175,14 @@ static void __init imx6q_sabrelite_init(void)
 	imx6q_sabrelite_cko1_setup();
 }
 
+static void __init imx6q_cgtqmx6_init(void)
+{
+	if (IS_BUILTIN(CONFIG_PHYLIB))
+		phy_register_fixup_for_uid(PHY_ID_KSZ9031, MICREL_PHY_ID_MASK,
+				ksz9031rnx_phy_fixup);
+	imx6q_sabrelite_cko1_setup();
+}
+
 static void __init imx6q_1588_init(void)
 {
 	struct regmap *gpr;
@@ -166,6 +204,9 @@ static void __init imx6q_init_machine(void)
 	if (of_machine_is_compatible("fsl,imx6q-sabrelite"))
 		imx6q_sabrelite_init();
 
+	if (of_machine_is_compatible("cgt,imx6q-qmx6"))
+		imx6q_cgtqmx6_init();
+
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	imx_anatop_init();
-- 
1.7.10.4
