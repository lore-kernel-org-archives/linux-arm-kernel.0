From: stefan@agner.ch (Stefan Agner)
Date: Wed,  6 Dec 2017 16:30:05 +0100
Subject: [PATCH 9/9] ARM: dts: imx7: add Toradex Colibri iMX7D 1GB (eMMC)
 support
In-Reply-To: <20171206153005.6144-1-stefan@agner.ch>
References: <20171206153005.6144-1-stefan@agner.ch>
Message-ID: <20171206153005.6144-9-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Computer on Module Colibri iMX7D 1GB along
with the Colibri Evaluation Board device trees. Follow the usual
hierarchic include model, maintaining shared configuration in
imx7-colibri.dtsi and imx7-colibri-eval-v3.dtsi respectively.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/Makefile                       |  1 +
 arch/arm/boot/dts/imx7-colibri.dtsi              | 64 +++++++++++++++++++++++-
 arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts | 55 ++++++++++++++++++++
 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi        | 57 +++++++++++++++++++++
 arch/arm/boot/dts/imx7d-colibri.dtsi             |  4 ++
 5 files changed, 180 insertions(+), 1 deletion(-)
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
index e1c6da0a65e4..4ea654a206e4 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -122,7 +122,6 @@
 	fsl,use-minimum-ecc;
 	nand-on-flash-bbt;
 	nand-ecc-mode = "hw";
-	status = "okay";
 };
 
 &i2c1 {
@@ -312,6 +311,21 @@
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
@@ -599,6 +613,54 @@
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
index 000000000000..5d5bb4c2843f
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts
@@ -0,0 +1,55 @@
+/*
+ * Copyright 2017 Toradex AG
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license,@your option. Note that this dual
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
index 000000000000..fce826895abb
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
@@ -0,0 +1,57 @@
+/*
+ * Copyright 2017 Toradex AG
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
