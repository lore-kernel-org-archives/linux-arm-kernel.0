From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 23 Oct 2018 11:49:29 +0000
Subject: [PATCH V2 7/8] dts: fsl: add imx7ulp evk support
In-Reply-To: <1540295058-26090-1-git-send-email-aisheng.dong@nxp.com>
References: <1540295058-26090-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1540295058-26090-8-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NXP i.MX 7ULP Evaluation Kit (EVK) provides a platform for rapid
evaluation of the i.MX 7ULP, which features NXP's advanced implementation
of the Arm? Cortex?-A7 core, the Arm Cortex-M4 core, as well as a 3D and
2D Graphics Processing Units (GPUs).

The EVK enables HDMI output for simple out-of-the-box to bring up but
allows reconfiguration for MIPI displays. The EVK is designed as a
System-On-Module(SOM) board that connects to an associated baseboard.
The SOM provides 1 GB LPDDR3, 8 MB Quad SPI flash, Micro SD 3.0 card
socket, WiFi/ Bluetooth capability, USB 2.0 OTG with Type C connector
and an NXP PF1550 power management IC (PMIC). The baseboard provides
additional capabilities including a full SD/MMC 3.0 card socket, audio
codec, multiple sensors, an HDMI connector, and an alternate MIPI display
connector. Additionally, the EVK facilitates software development with the
ultimate goal of faster time to market through the support of both
Linux? OS and AndroidTM rich operating systems, as well as FreeRTOS.

This patch aims to support the preliminary booting up features
as follows:
GPIO
LPUART
FEC
SD/MMC

See more board details:
https://www.nxp.com/products/processors-and-microcontrollers/
arm-based-processors-and-mcus/i.mx-applications-processors/
i.mx-7-processors/evaluation-kit-for-the-i.mx-7ulp-applications
-processor:MCIMX7ULP-EVK

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: devicetree at vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v1->v2:
 * switch to SPDX license
 * pad name update
 * fix Character '_' not recommended in node name
 * separate from soc.dtsi file
---
 arch/arm/boot/dts/Makefile        |  2 +
 arch/arm/boot/dts/imx7ulp-evk.dts | 94 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx7ulp-evk.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d7268ae..39eac9c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -573,6 +573,8 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-sdb-sht11.dtb \
 	imx7s-colibri-eval-v3.dtb \
 	imx7s-warp.dtb
+dtb-$(CONFIG_SOC_IMX7ULP) += \
+	imx7ulp-evk.dtb
 dtb-$(CONFIG_SOC_LS1021A) += \
 	ls1021a-moxa-uc-8410a.dtb \
 	ls1021a-qds.dtb \
diff --git a/arch/arm/boot/dts/imx7ulp-evk.dts b/arch/arm/boot/dts/imx7ulp-evk.dts
new file mode 100644
index 0000000..d876cb3
--- /dev/null
+++ b/arch/arm/boot/dts/imx7ulp-evk.dts
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017-2018 NXP
+ *   Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+/dts-v1/;
+
+#include "imx7ulp.dtsi"
+
+/ {
+	model = "NXP i.MX7ULP EVK";
+	compatible = "fsl,imx7ulp-evk", "fsl,imx7ulp", "Generic DT based system";
+
+	chosen {
+		stdout-path = &lpuart4;
+	};
+
+	memory at 60000000 {
+		reg = <0x60000000 0x40000000>;
+	};
+
+	reg_vsd_3v3: regulator-vsd-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usdhc0_rst>;
+		gpio = <&gpio_ptd 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&lpuart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart4>;
+	status = "okay";
+};
+
+&usdhc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc0_cmd_data>, <&pinctrl_usdhc0_clk>,
+		    <&pinctrl_usdhc0_cd>;
+	cd-gpios = <&gpio_ptc 10 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_vsd_3v3>;
+	status = "okay";
+};
+
+&iomuxc1 {
+	pinctrl_lpuart4: lpuart4grp {
+		pinmux = <
+			IMX7ULP_PAD_PTC3__LPUART4_RX
+			IMX7ULP_PAD_PTC2__LPUART4_TX
+		>;
+		bias-pull-up;
+	};
+
+	pinctrl_usdhc0_cmd_data: usdhc0-cmd-data-grp {
+		pinmux = <
+			IMX7ULP_PAD_PTD1__SDHC0_CMD
+			IMX7ULP_PAD_PTD2__SDHC0_CLK
+			IMX7ULP_PAD_PTD7__SDHC0_D3
+			IMX7ULP_PAD_PTD8__SDHC0_D2
+			IMX7ULP_PAD_PTD9__SDHC0_D1
+			IMX7ULP_PAD_PTD10__SDHC0_D0
+		>;
+		drive-strength = <1>;
+		bias-pull-up;
+	};
+
+	pinctrl_usdhc0_clk: usdhc0-clk-grp {
+		pinmux = <
+			IMX7ULP_PAD_PTD2__SDHC0_CLK
+		>;
+		drive-strength = <1>;
+		bias-pull-down;
+	};
+
+	pinctrl_usdhc0_cd: usdhc0-gpio-cd-grp {
+		pinmux = <
+			IMX7ULP_PAD_PTC10__PTC10	/* USDHC0 CD */
+		>;
+		bias-pull-up;
+	};
+
+	pinctrl_usdhc0_rst: usdhc0-gpio-rst-grp {
+		pinmux = <
+			IMX7ULP_PAD_PTD0__PTD0		/* USDHC0 RST */
+		>;
+		bias-pull-up;
+	};
+};
-- 
2.7.4
