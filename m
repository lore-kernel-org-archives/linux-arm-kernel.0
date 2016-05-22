From: christopher.spinrath@rwth-aachen.de (christopher.spinrath at rwth-aachen.de)
Date: Mon, 23 May 2016 00:47:38 +0200
Subject: [PATCH 2/2] ARM: dts: imx6q: add support for the Utilite Pro
In-Reply-To: <1463957258-4893-1-git-send-email-christopher.spinrath@rwth-aachen.de>
References: <1463957258-4893-1-git-send-email-christopher.spinrath@rwth-aachen.de>
Message-ID: <c4ab0387041f42ada68296141befe332@rwthex-s1-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>

The CompuLab Utilite Pro is a miniature fanless desktop pc based on
the i.MX6 Quad powered cm-fx6 module. It features two serial ports,
USB OTG, 4x USB, analog audio and S/PDIF, 2x Gb Ethernet, HDMI and
DVI ports, an on-board 32GB SSD, a mmc slot, and on-board wifi/bt.

Add initial support for it including USB, Ethernet (both ports), sata
and HDMI support.

Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
---
 arch/arm/boot/dts/Makefile              |   1 +
 arch/arm/boot/dts/imx6q-utilite-pro.dts | 128 ++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-utilite-pro.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 515a428..287044c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -369,6 +369,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-tx6q-1110.dtb \
 	imx6q-tx6q-11x0-mb7.dtb \
 	imx6q-udoo.dtb \
+	imx6q-utilite-pro.dtb \
 	imx6q-wandboard.dtb \
 	imx6q-wandboard-revb1.dtb \
 	imx6qp-nitrogen6_max.dtb \
diff --git a/arch/arm/boot/dts/imx6q-utilite-pro.dts b/arch/arm/boot/dts/imx6q-utilite-pro.dts
new file mode 100644
index 0000000..bcd8e0d
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-utilite-pro.dts
@@ -0,0 +1,128 @@
+/*
+ * Copyright 2016 Christopher Spinrath
+ * Copyright 2013 CompuLab Ltd.
+ *
+ * Based on the GPLv2 licensed devicetree distributed with the vendor
+ * kernel for the Utilite Pro:
+ *	Copyright 2013 CompuLab Ltd.
+ *	Author: Valentin Raevsky <valentin@compulab.co.il>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include "imx6q-cm-fx6.dts"
+
+/ {
+	model = "CompuLab Utilite Pro";
+	compatible = "compulab,utilite-pro", "compulab,cm-fx6", "fsl,imx6q";
+
+	aliases {
+		ethernet1 = &eth1;
+		rtc0 = &em3027;
+		rtc1 = &snvs_rtc;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		power {
+			label = "Power Button";
+			gpios = <&gpio1 29 1>;
+			linux,code = <116>; /* KEY_POWER */
+			gpio-key,wakeup;
+		};
+	};
+};
+
+&hdmi {
+	ddc-i2c-bus = <&i2c2>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	eeprom at 50 {
+		compatible = "at24,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+
+	em3027: rtc at 56 {
+		compatible = "emmicro,em3027";
+		reg = <0x56>;
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	hog {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				/* power button */
+				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x80000000
+			>;
+		};
+	};
+
+	imx6q-utilite-pro {
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D21__I2C1_SCL 0x4001b8b1
+				MX6QDL_PAD_EIM_D28__I2C1_SDA 0x4001b8b1
+			>;
+		};
+
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
+				MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
+			>;
+		};
+
+		pinctrl_uart2: uart2grp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_7__UART2_TX_DATA 0x1b0b1
+				MX6QDL_PAD_GPIO_8__UART2_RX_DATA 0x1b0b1
+				MX6QDL_PAD_SD4_DAT5__UART2_RTS_B 0x1b0b1
+				MX6QDL_PAD_SD4_DAT6__UART2_CTS_B 0x1b0b1
+			>;
+		};
+	};
+};
+
+&pcie {
+	pcie at 0,0 {
+		reg = <0x000000 0 0 0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		/* non-removable i211 ethernet card */
+		eth1: intel,i211 at pcie0,0 {
+			reg = <0x010000 0 0 0 0>;
+		};
+	};
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	fsl,uart-has-rtscts;
+	dma-names = "rx", "tx";
+	dmas = <&sdma 27 4 0>, <&sdma 28 4 0>;
+	status = "okay";
+};
-- 
2.8.2
