From: stefan@agner.ch (Stefan Agner)
Date: Tue, 19 Dec 2017 19:10:38 +0100
Subject: [PATCH v3 9/9] ARM: dts: imx7: add Toradex Colibri iMX7D 1GB (eMMC)
 support
In-Reply-To: <20171219181038.1369-1-stefan@agner.ch>
References: <20171219181038.1369-1-stefan@agner.ch>
Message-ID: <20171219181038.1369-9-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Computer on Module Colibri iMX7D 1GB along
with the Colibri Evaluation Board device trees. Follow the usual
hierarchic include model, maintaining shared configuration in
imx7-colibri.dtsi and imx7-colibri-eval-v3.dtsi respectively.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v2:
- Fix SPDX header location and use GPL-2.0 only license
Changes since v1:
- Use SPDX-License-Identifier: (GPL-2.0+ OR MIT)

 arch/arm/boot/dts/Makefile                       |  1 +
 arch/arm/boot/dts/imx7-colibri.dtsi              | 64 +++++++++++++++++++++++-
 arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts | 19 +++++++
 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi        | 21 ++++++++
 arch/arm/boot/dts/imx7d-colibri.dtsi             |  4 ++
 5 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b5ba7ad6ae30..9e4b4ecae572 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -519,6 +519,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ull-14x14-evk.dtb
 dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-cl-som-imx7.dtb \
+	imx7d-colibri-emmc-eval-v3.dtb \
 	imx7d-colibri-eval-v3.dtb \
 	imx7d-nitrogen7.dtb \
 	imx7d-pico.dtb \
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index c28a483b786d..895fbde4d433 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -121,7 +121,6 @@
 	fsl,use-minimum-ecc;
 	nand-on-flash-bbt;
 	nand-ecc-mode = "hw";
-	status = "okay";
 };
 
 &i2c1 {
@@ -311,6 +310,21 @@
 	vqmmc-supply = <&reg_LDO2>;
 };
 
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	assigned-clocks = <&clks IMX7D_USDHC3_ROOT_CLK>;
+	assigned-clock-rates = <400000000>;
+	bus-width = <8>;
+	fsl,tuning-step = <2>;
+	max-frequency = <100000000>;
+	vmmc-supply = <&reg_module_3v3>;
+	vqmmc-supply = <&reg_DCDC3>;
+	non-removable;
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpio1 &pinctrl_gpio2 &pinctrl_gpio3 &pinctrl_gpio4>;
@@ -598,6 +612,54 @@
 		>;
 	};
 
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX7D_PAD_SD3_CMD__SD3_CMD		0x59
+			MX7D_PAD_SD3_CLK__SD3_CLK		0x19
+			MX7D_PAD_SD3_DATA0__SD3_DATA0		0x59
+			MX7D_PAD_SD3_DATA1__SD3_DATA1		0x59
+			MX7D_PAD_SD3_DATA2__SD3_DATA2		0x59
+			MX7D_PAD_SD3_DATA3__SD3_DATA3		0x59
+			MX7D_PAD_SD3_DATA4__SD3_DATA4		0x59
+			MX7D_PAD_SD3_DATA5__SD3_DATA5		0x59
+			MX7D_PAD_SD3_DATA6__SD3_DATA6		0x59
+			MX7D_PAD_SD3_DATA7__SD3_DATA7		0x59
+			MX7D_PAD_SD3_STROBE__SD3_STROBE         0x19
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
+		fsl,pins = <
+			MX7D_PAD_SD3_CMD__SD3_CMD		0x5a
+			MX7D_PAD_SD3_CLK__SD3_CLK		0x1a
+			MX7D_PAD_SD3_DATA0__SD3_DATA0		0x5a
+			MX7D_PAD_SD3_DATA1__SD3_DATA1		0x5a
+			MX7D_PAD_SD3_DATA2__SD3_DATA2		0x5a
+			MX7D_PAD_SD3_DATA3__SD3_DATA3		0x5a
+			MX7D_PAD_SD3_DATA4__SD3_DATA4		0x5a
+			MX7D_PAD_SD3_DATA5__SD3_DATA5		0x5a
+			MX7D_PAD_SD3_DATA6__SD3_DATA6		0x5a
+			MX7D_PAD_SD3_DATA7__SD3_DATA7		0x5a
+			MX7D_PAD_SD3_STROBE__SD3_STROBE         0x1a
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3grp_200mhz {
+		fsl,pins = <
+			MX7D_PAD_SD3_CMD__SD3_CMD		0x5b
+			MX7D_PAD_SD3_CLK__SD3_CLK		0x1b
+			MX7D_PAD_SD3_DATA0__SD3_DATA0		0x5b
+			MX7D_PAD_SD3_DATA1__SD3_DATA1		0x5b
+			MX7D_PAD_SD3_DATA2__SD3_DATA2		0x5b
+			MX7D_PAD_SD3_DATA3__SD3_DATA3		0x5b
+			MX7D_PAD_SD3_DATA4__SD3_DATA4		0x5b
+			MX7D_PAD_SD3_DATA5__SD3_DATA5		0x5b
+			MX7D_PAD_SD3_DATA6__SD3_DATA6		0x5b
+			MX7D_PAD_SD3_DATA7__SD3_DATA7		0x5b
+			MX7D_PAD_SD3_STROBE__SD3_STROBE         0x1b
+		>;
+	};
+
 	pinctrl_sai1: sai1-grp {
 		fsl,pins = <
 			MX7D_PAD_ENET1_RX_CLK__SAI1_TX_BCLK     0x1f
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts b/arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts
new file mode 100644
index 000000000000..8ee73c870b12
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2017 Toradex AG
+ */
+
+/dts-v1/;
+#include "imx7d-colibri-emmc.dtsi"
+#include "imx7-colibri-eval-v3.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX7D 1GB (eMMC) on Colibri Evaluation Board V3";
+	compatible = "toradex,colibri-imx7d-emmc-eval-v3",
+		     "toradex,colibri-imx7d-emmc", "fsl,imx7d";
+};
+
+&usbotg2 {
+	vbus-supply = <&reg_usbh_vbus>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
new file mode 100644
index 000000000000..9b63b9c89e4b
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2017 Toradex AG
+ */
+
+#include "imx7d.dtsi"
+#include "imx7-colibri.dtsi"
+
+/ {
+	memory {
+		reg = <0x80000000 0x40000000>;
+	};
+};
+
+&usbotg2 {
+	dr_mode = "host";
+};
+
+&usdhc3 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx7d-colibri.dtsi b/arch/arm/boot/dts/imx7d-colibri.dtsi
index 3c2cb502b388..6f2bb70c1fbd 100644
--- a/arch/arm/boot/dts/imx7d-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7d-colibri.dtsi
@@ -49,6 +49,10 @@
 	};
 };
 
+&gpmi {
+	status = "okay";
+};
+
 &usbotg2 {
 	dr_mode = "host";
 };
-- 
2.15.1
