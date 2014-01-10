From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri, 10 Jan 2014 13:52:59 +0100
Subject: [PATCH 2/2] ARM: i.MX53: dts: add support for MCIMX53-START-R
In-Reply-To: <1389358379-26196-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1389358379-26196-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1389358379-26196-3-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "Start-R QSB" has a different PMIC than the older "Start QSB".
Add a new devicetree for the Start-R.
They both could use the same DT, as both PMICs (the dialog and the mc34708)
have different i2c addresses and could coexist in the same DT without any
errors. But once phandles are used, this will get messy.

The pmic nodes are based on an earlier patch

	[PATCH] arm: imx53-qsb: Add Ripley driver DT nodes

from

	Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>

which apparently got lost/abandoned.

I added phandles/newlines and changed the node name from ripley to mc34708.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/Makefile       |   1 +
 arch/arm/boot/dts/imx53-qsrb.dts | 158 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 159 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx53-qsrb.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 306d1d5..5128da9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -137,6 +137,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx53-m53evk.dtb \
 	imx53-mba53.dtb \
 	imx53-qsb.dtb \
+	imx53-qsrb.dtb \
 	imx53-smd.dtb \
 	imx53-voipac-bsb.dtb \
 	imx6dl-gw51xx.dtb \
diff --git a/arch/arm/boot/dts/imx53-qsrb.dts b/arch/arm/boot/dts/imx53-qsrb.dts
new file mode 100644
index 0000000..f1bbf9a
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-qsrb.dts
@@ -0,0 +1,158 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
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
+#include "imx53-qsb-common.dtsi"
+
+/ {
+	model = "Freescale i.MX53 Quick Start-R Board";
+	compatible = "fsl,imx53-qsrb", "fsl,imx53";
+};
+
+&iomuxc {
+	i2c1 {
+		/* open drain */
+		pinctrl_i2c1_qsrb: i2c1grp-1 {
+			fsl,pins = <
+				MX53_PAD_CSI0_DAT8__I2C1_SDA      0x400001ec
+				MX53_PAD_CSI0_DAT9__I2C1_SCL      0x400001ec
+			>;
+		};
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1_qsrb>;
+	status = "okay";
+
+	pmic: mc34708 at 8 {
+		compatible = "fsl,mc34708";
+		reg = <0x08>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <23 0x8>;
+		regulators {
+			sw1_reg: sw1a {
+				regulator-name = "SW1";
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <1437500>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw1b_reg: sw1b {
+				regulator-name = "SW1B";
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <1437500>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw2_reg: sw2 {
+				regulator-name = "SW2";
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <1437500>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3_reg: sw3 {
+				regulator-name = "SW3";
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <1425000>;
+				regulator-boot-on;
+			};
+
+			sw4a_reg: sw4a {
+				regulator-name = "SW4A";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw4b_reg: sw4b {
+				regulator-name = "SW4B";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw5_reg: sw5 {
+				regulator-name = "SW5";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			swbst_reg: swbst {
+				regulator-name = "SWBST";
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vpll_reg: vpll {
+				regulator-name = "VPLL";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+			};
+
+			vrefddr_reg: vrefddr {
+				regulator-name = "VREFDDR";
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vusb_reg: vusb {
+				regulator-name = "VUSB";
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vusb2_reg: vusb2 {
+				regulator-name = "VUSB2";
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vdac_reg: vdac {
+				regulator-name = "VDAC";
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2775000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vgen1_reg: vgen1 {
+				regulator-name = "VGEN1";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1550000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vgen2_reg: vgen2 {
+				regulator-name = "VGEN2";
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
-- 
1.8.5.2
