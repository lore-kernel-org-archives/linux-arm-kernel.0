From: andrey.gusakov@cogentembedded.com (Andrey Gusakov)
Date: Thu, 21 Jun 2018 20:44:59 +0300
Subject: [PATCH 2/3] ARM: dts: imx: add ZII SCU2 ESB board
In-Reply-To: <1529603100-31958-1-git-send-email-andrey.gusakov@cogentembedded.com>
References: <1529603100-31958-1-git-send-email-andrey.gusakov@cogentembedded.com>
Message-ID: <1529603100-31958-3-git-send-email-andrey.gusakov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the Zodiac Inflight Innovations SCU2 Ethernet
Switch Board, which is based on the i.MX51.

Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
---
 arch/arm/boot/dts/Makefile               |   3 +-
 arch/arm/boot/dts/imx51-zii-scu2-esb.dts | 178 +++++++++++++++++++++++++++++++
 2 files changed, 180 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx51-zii-scu2-esb.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 37a3de7..d8900f4 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -358,7 +358,8 @@ dtb-$(CONFIG_SOC_IMX51) += \
 	imx51-digi-connectcore-jsk.dtb \
 	imx51-eukrea-mbimxsd51-baseboard.dtb \
 	imx51-ts4800.dtb \
-	imx51-zii-rdu1.dtb
+	imx51-zii-rdu1.dtb \
+	imx51-zii-scu2-esb.dtb
 dtb-$(CONFIG_SOC_IMX53) += \
 	imx53-ard.dtb \
 	imx53-cx9020.dtb \
diff --git a/arch/arm/boot/dts/imx51-zii-scu2-esb.dts b/arch/arm/boot/dts/imx51-zii-scu2-esb.dts
new file mode 100644
index 0000000..e052133
--- /dev/null
+++ b/arch/arm/boot/dts/imx51-zii-scu2-esb.dts
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// Copyright (C) 2018 Zodiac Inflight Innovations
+
+/dts-v1/;
+#include "imx51-zii-common.dtsi"
+
+/ {
+	model = "ZII SCU2 ESB board";
+	compatible = "zii,imx51-scu2-esb", "fsl,imx51";
+};
+
+&esdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc1_4bit &pinctrl_esdhc1_8bit>;
+	bus-width = <8>;
+};
+
+&fec {
+	phy-reset-gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
+
+	fixed-link {
+		speed = <100>;
+		full-duplex;
+	};
+
+	fec_mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+
+		switch at 0 {
+			compatible = "marvell,mv88e6085";
+			reg = <0>;
+			dsa,member = <0 0>;
+			eeprom-length = <512>;
+			interrupt-parent = <&gpio4>;
+			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					label = "port1";
+				};
+
+				port at 1 {
+					reg = <1>;
+					label = "port2";
+				};
+
+				port at 2 {
+					reg = <2>;
+					label = "port3";
+				};
+
+				port at 3 {
+					reg = <3>;
+					label = "scu2scu";
+				};
+
+				port at 4 {
+					reg = <4>;
+					label = "esb2host";
+				};
+				port at 5 {
+					reg = <5>;
+					label = "esb2mezz";
+					phy-mode = "sgmii";
+
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+					};
+				};
+				port at 6 {
+					reg = <6>;
+					label = "cpu";
+					phy-mode = "mii";
+					ethernet = <&fec>;
+
+					fixed-link {
+						speed = <100>;
+						full-duplex;
+					};
+				};
+			};
+		};
+	};
+};
+
+&i2c2 {
+	lm75 at 48 {
+		compatible = "national,lm75";
+		reg = <0x48>;
+	};
+};
+
+&i2c_gpio {
+	gpios = <&gpio3 1 GPIO_ACTIVE_HIGH>, /* sda */
+		<&gpio3 0 GPIO_ACTIVE_HIGH>; /* scl */
+};
+
+&ipu {
+	status = "disabled";
+};
+
+&usb_vbus {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_mmc_reset>;
+	gpio = <&gpio4 19 GPIO_ACTIVE_LOW>;
+	startup-delay-us = <150000>;
+};
+
+&iomuxc {
+	pinctrl_fec: fecgrp {
+		fsl,pins = <
+			MX51_PAD_DISP2_DAT15__FEC_TDATA0	0x2004
+			MX51_PAD_DISP2_DAT6__FEC_TDATA1		0x2004
+			MX51_PAD_DISP2_DAT7__FEC_TDATA2		0x2004
+			MX51_PAD_DISP2_DAT8__FEC_TDATA3		0x2004
+			MX51_PAD_DISP2_DAT9__FEC_TX_EN		0x2004
+			MX51_PAD_DISP2_DAT10__FEC_COL		0x0180
+			MX51_PAD_DISP2_DAT11__FEC_RX_CLK	0x0180
+			MX51_PAD_DISP2_DAT12__FEC_RX_DV		0x20a4
+			MX51_PAD_DISP2_DAT13__FEC_TX_CLK	0x2180
+			MX51_PAD_DISP2_DAT14__FEC_RDATA0	0x2180
+			MX51_PAD_DI2_DISP_CLK__FEC_RDATA1	0x0085
+			MX51_PAD_DI_GP4__FEC_RDATA2		0x0085
+			MX51_PAD_DISP2_DAT0__FEC_RDATA3		0x0085
+			MX51_PAD_DI2_PIN2__FEC_MDC		0x2004
+			MX51_PAD_DI2_PIN3__FEC_MDIO		0x01f5
+			MX51_PAD_DI2_PIN4__FEC_CRS		0x0180
+			MX51_PAD_AUD3_BB_FS__GPIO4_21		0x0000
+		>;
+	};
+
+	pinctrl_swi2c: swi2cgrp {
+		fsl,pins = <
+			MX51_PAD_DI1_PIN11__GPIO3_0		0x100
+			MX51_PAD_DI1_PIN12__GPIO3_1		0x100
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX51_PAD_UART1_RXD__UART1_RXD		0x1c5
+			MX51_PAD_UART1_TXD__UART1_TXD		0x1c5
+			MX51_PAD_UART1_RTS__UART1_RTS		0x1c5
+			MX51_PAD_UART1_CTS__UART1_CTS		0x1c5
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX51_PAD_UART2_RXD__UART2_RXD		0x1c5
+			MX51_PAD_UART2_TXD__UART2_TXD		0x1c5
+			MX51_PAD_USBH1_DATA0__UART2_CTS		0x1c5
+			MX51_PAD_USBH1_DATA3__UART2_RTS		0x1c5
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX51_PAD_UART3_RXD__UART3_RXD		0x1c5
+			MX51_PAD_UART3_TXD__UART3_TXD		0x1c5
+		>;
+	};
+
+	pinctrl_usb_mmc_reset: usbmmcgrp {
+		fsl,pins = <
+			MX51_PAD_AUD3_BB_RXD__GPIO4_19		0x100
+		>;
+	};
+};
-- 
1.9.1
