From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 31 Aug 2014 15:54:15 +0400
Subject: [PATCH 2/2] ARM: dts: Add support for the i.MX1 Armadeus APF9328 board
In-Reply-To: <1409486055-21541-1-git-send-email-shc_work@mail.ru>
References: <1409486055-21541-1-git-send-email-shc_work@mail.ru>
Message-ID: <1409486055-21541-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the i.MX1 APF9328 from Armadeus.
This change is intended to further remove non-DT support for this board.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/Makefile         |   1 +
 arch/arm/boot/dts/imx1-apf9328.dts | 129 +++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx1-apf9328.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b022972..b51d485 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -162,6 +162,7 @@ dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
 dtb-$(CONFIG_ARCH_MOXART) += moxart-uc7112lx.dtb
 dtb-$(CONFIG_ARCH_MXC) += \
 	imx1-ads.dtb \
+	imx1-apf9328.dtb \
 	imx25-eukrea-mbimxsd25-baseboard.dtb \
 	imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb \
 	imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dtb \
diff --git a/arch/arm/boot/dts/imx1-apf9328.dts b/arch/arm/boot/dts/imx1-apf9328.dts
new file mode 100644
index 0000000..07d92fb
--- /dev/null
+++ b/arch/arm/boot/dts/imx1-apf9328.dts
@@ -0,0 +1,129 @@
+/*
+ * Copyright (C) 2014 Alexander Shiyan <shc_work@mail.ru>
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
+#include "imx1.dtsi"
+
+/ {
+	model = "Armadeus APF9328";
+	compatible = "armadeus,imx1-apf9328", "fsl,imx1";
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	memory {
+		reg = <0x08000000 0x00800000>;
+	};
+};
+
+&i2c {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&weim {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_weim>;
+	status = "okay";
+
+	nor: nor at 0,0 {
+		compatible = "cfi-flash";
+		reg = <0 0x00000000 0x02000000>;
+		bank-width = <2>;
+		fsl,weim-cs-timing = <0x00330e04 0x00000d01>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+
+	eth: eth at 4,c00000 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_eth>;
+		compatible = "davicom,dm9000";
+		reg = <
+			4 0x00c00000 0x2
+			4 0x00c00002 0x2
+		>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+		fsl,weim-cs-timing = <0x0000c700 0x19190d01>;
+	};
+};
+
+&iomuxc {
+	imx1-apf9328 {
+		pinctrl_eth: ethgrp {
+			fsl,pins = <
+				MX1_PAD_SIM_SVEN__GPIO2_14	0x0
+			>;
+		};
+
+		pinctrl_i2c: i2cgrp {
+			fsl,pins = <
+				MX1_PAD_I2C_SCL__I2C_SCL	0x0
+				MX1_PAD_I2C_SDA__I2C_SDA	0x0
+			>;
+		};
+
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <
+				MX1_PAD_UART1_TXD__UART1_TXD	0x0
+				MX1_PAD_UART1_RXD__UART1_RXD	0x0
+				MX1_PAD_UART1_CTS__UART1_CTS	0x0
+				MX1_PAD_UART1_RTS__UART1_RTS	0x0
+			>;
+		};
+
+		pinctrl_uart2: uart2grp {
+			fsl,pins = <
+				MX1_PAD_UART2_TXD__UART2_TXD	0x0
+				MX1_PAD_UART2_RXD__UART2_RXD	0x0
+				MX1_PAD_UART2_CTS__UART2_CTS	0x0
+				MX1_PAD_UART2_RTS__UART2_RTS	0x0
+			>;
+		};
+
+		pinctrl_weim: weimgrp {
+			fsl,pins = <
+				MX1_PAD_A0__A0			0x0
+				MX1_PAD_A16__A16		0x0
+				MX1_PAD_A17__A17		0x0
+				MX1_PAD_A18__A18		0x0
+				MX1_PAD_A19__A19		0x0
+				MX1_PAD_A20__A20		0x0
+				MX1_PAD_A21__A21		0x0
+				MX1_PAD_A22__A22		0x0
+				MX1_PAD_A23__A23		0x0
+				MX1_PAD_A24__A24		0x0
+				MX1_PAD_BCLK__BCLK		0x0
+				MX1_PAD_CS4__CS4		0x0
+				MX1_PAD_DTACK__DTACK		0x0
+				MX1_PAD_ECB__ECB		0x0
+				MX1_PAD_LBA__LBA		0x0
+			>;
+		};
+	};
+};
-- 
1.8.5.5
