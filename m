From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Fri,  6 Jul 2018 19:49:02 -0700
Subject: [PATCH] ARM: dts: imx: Add ZII SCU2 Mezz board
Message-ID: <20180707024902.439-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Zodiac Inflight Innovations SCU2 Mezz
board (i.MX51-based).

Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: cphealy at gmail.com
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Shawn:

This is a spin-off of SCU2 Mezz board support originally found in [v0]
as per out off-list (Fabio, Chris, Nikita, myself) to add support for
ZII hardware fist and worry about factoring out commonalites later.

Original submission was done by Andrey Gusakov, but he is too busy on
other projects, so the honors of submitting this were delegated to me.

NOTE: RAVE SP ("zii,rave-sp-mezz") node is technically supported by
upstream, but it needs some fixes from [rave-sp-fixes] to work
correctly. If you want me to drop that node until [rave-sp-fixes] is
merged, let me know.

Changes since [v0]:

 - Patch converted to be a standalone file not dependent on any
   ZII-specific .dtsi

 - Added RAVE SP node with all the children that are currently
   supported by upstream

 - Droppped ecspi2 node. That node didn't have any child devices in
   [v0] because none of the chips connected to that bus are supported
   upstream. This node can be added later once anything attached to it
   has upstream drivers.

 - Dropped i2c_gpio. That bus was originally added for RAVE SP related
   prototyping and is unused in actual product.

 - Various newline fixes pointed out in [v0]

 - Most of then nodes should be sorted alphabetically (I might have
   missed some)

 - Collected Reviewed-by from Fabio (Fabio, I assumed you won't mind,
   but let me know if you want me to drop it)

[v0] lkml.kernel.org/r/1529603100-31958-4-git-send-email-andrey.gusakov at cogentembedded.com
[rave-sp-fixes] lkml.kernel.org/r/20180707024108.32373-1-andrew.smirnov at gmail.com

 arch/arm/boot/dts/Makefile                |   3 +-
 arch/arm/boot/dts/imx51-zii-scu2-mezz.dts | 448 ++++++++++++++++++++++
 2 files changed, 450 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx51-zii-scu2-mezz.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 37a3de760d40..1d6acbab7062 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -358,7 +358,8 @@ dtb-$(CONFIG_SOC_IMX51) += \
 	imx51-digi-connectcore-jsk.dtb \
 	imx51-eukrea-mbimxsd51-baseboard.dtb \
 	imx51-ts4800.dtb \
-	imx51-zii-rdu1.dtb
+	imx51-zii-rdu1.dtb \
+	imx51-zii-scu2-mezz.dtb
 dtb-$(CONFIG_SOC_IMX53) += \
 	imx53-ard.dtb \
 	imx53-cx9020.dtb \
diff --git a/arch/arm/boot/dts/imx51-zii-scu2-mezz.dts b/arch/arm/boot/dts/imx51-zii-scu2-mezz.dts
new file mode 100644
index 000000000000..26cf08549df4
--- /dev/null
+++ b/arch/arm/boot/dts/imx51-zii-scu2-mezz.dts
@@ -0,0 +1,448 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/*
+ * Copyright (C) 2018 Zodiac Inflight Innovations
+ */
+
+/dts-v1/;
+
+#include "imx51.dtsi"
+
+/ {
+	model = "ZII SCU2 Mezz Board";
+	compatible = "zii,imx51-scu2-mezz", "fsl,imx51";
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	/* Will be filled by the bootloader */
+	memory at 90000000 {
+		reg = <0x90000000 0>;
+	};
+
+	aliases {
+		mdio-gpio0 = &mdio_gpio;
+	};
+
+	usb_vbus: regulator-usb-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb_mmc_reset>;
+		gpio = <&gpio3 13 GPIO_ACTIVE_LOW>;
+		startup-delay-us = <150000>;
+		regulator-name = "usb_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	mdio_gpio: mdio-gpio {
+		compatible = "virtual,mdio-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_swmdio>;
+		gpios = <&gpio2 7 GPIO_ACTIVE_HIGH>, /* mdc */
+			<&gpio2 6 GPIO_ACTIVE_HIGH>; /* mdio */
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		switch at 0 {
+			compatible = "marvell,mv88e6085";
+			reg = <0>;
+			dsa,member = <0 0>;
+			eeprom-length = <512>;
+			interrupt-parent = <&gpio1>;
+			interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					label = "port4";
+				};
+
+				port at 1 {
+					reg = <1>;
+					label = "port5";
+				};
+
+				port at 2 {
+					reg = <2>;
+					label = "port6";
+				};
+
+				port at 3 {
+					reg = <3>;
+					label = "port7";
+				};
+
+				port at 4 {
+					reg = <4>;
+					label = "cpu";
+					ethernet = <&fec>;
+
+					fixed-link {
+						speed = <100>;
+						full-duplex;
+					};
+				};
+
+				port at 5 {
+					reg = <5>;
+					label = "mezz2esb";
+					phy-mode = "sgmii";
+
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+					};
+				};
+			};
+		};
+	};
+};
+
+&cpu {
+	cpu-supply = <&sw1_reg>;
+};
+
+&ecspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	cs-gpios = <&gpio4 24 GPIO_ACTIVE_HIGH>,
+		   <&gpio4 25 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	pmic at 0 {
+		compatible = "fsl,mc13892";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		spi-max-frequency = <6000000>;
+		spi-cs-high;
+		reg = <0>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+		fsl,mc13xxx-uses-adc;
+
+		regulators {
+			sw1_reg: sw1 {
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1375000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw2_reg: sw2 {
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3_reg: sw3 {
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw4_reg: sw4 {
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vpll_reg: vpll {
+				regulator-min-microvolt = <1050000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vdig_reg: vdig {
+				regulator-min-microvolt = <1650000>;
+				regulator-max-microvolt = <1650000>;
+				regulator-boot-on;
+			};
+
+			vsd_reg: vsd {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3150000>;
+				regulator-always-on;
+			};
+
+			vusb_reg: vusb {
+				regulator-always-on;
+			};
+
+			vusb2_reg: vusb2 {
+				regulator-min-microvolt = <2400000>;
+				regulator-max-microvolt = <2775000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vvideo_reg: vvideo {
+				regulator-min-microvolt = <2775000>;
+				regulator-max-microvolt = <2775000>;
+			};
+
+			vaudio_reg: vaudio {
+				regulator-min-microvolt = <2300000>;
+				regulator-max-microvolt = <3000000>;
+			};
+
+			vcam_reg: vcam {
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <3000000>;
+			};
+
+			vgen1_reg: vgen1 {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+			};
+
+			vgen2_reg: vgen2 {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3150000>;
+				regulator-always-on;
+			};
+
+			vgen3_reg: vgen3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <2900000>;
+				regulator-always-on;
+			};
+		};
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			led-control = <0x0 0x0 0x3f83f8 0x0>;
+
+			sysled3: led3 at 3 {
+				reg = <3>;
+				label = "system:red:power";
+				linux,default-trigger = "default-on";
+			};
+
+			sysled4: led4 at 4 {
+				reg = <4>;
+				label = "system:green:act";
+				linux,default-trigger = "heartbeat";
+			};
+		};
+	};
+
+	flash at 1 {
+		compatible = "atmel,at45", "atmel,dataflash";
+		reg = <1>;
+		spi-max-frequency = <25000000>;
+	};
+};
+
+&esdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc1>;
+	bus-width = <8>;
+	non-removable;
+	no-1-8-v;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&esdhc4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc4>;
+	bus-width = <4>;
+	no-1-8-v;
+	no-sdio;
+	cd-gpios = <&gpio4 8 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec>;
+	phy-mode = "mii";
+	status = "okay";
+	phy-reset-gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
+	phy-reset-duration = <1>;
+	phy-supply = <&vgen3_reg>;
+	phy-handle = <&ethphy>;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethernet-phy at 0 {
+			reg = <0>;
+			max-speed = <100>;
+		};
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	eeprom at 50 {
+		compatible = "atmel,24c04";
+		pagesize = <16>;
+		reg = <0x50>;
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+
+	rave-sp {
+		compatible = "zii,rave-sp-mezz";
+		current-speed = <57600>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		watchdog {
+			compatible = "zii,rave-sp-watchdog-legacy";
+		};
+
+		eeprom at a4 {
+			compatible = "zii,rave-sp-eeprom";
+			reg = <0xa4 0x4000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			zii,eeprom-name = "main-eeprom";
+		};
+	};
+};
+
+&usbotg {
+	dr_mode = "host";
+	disable-over-current;
+	phy_type = "utmi_wide";
+	vbus-supply = <&usb_vbus>;
+	status = "okay";
+};
+
+&usbphy0 {
+	vcc-supply = <&vusb2_reg>;
+};
+
+&iomuxc {
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+			MX51_PAD_CSPI1_MISO__ECSPI1_MISO	0x185
+			MX51_PAD_CSPI1_MOSI__ECSPI1_MOSI	0x185
+			MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK	0x185
+			MX51_PAD_CSPI1_SS0__GPIO4_24		0x85
+			MX51_PAD_CSPI1_SS1__GPIO4_25		0x85
+		>;
+	};
+
+	pinctrl_esdhc1: esdhc1grp {
+		fsl,pins = <
+			MX51_PAD_SD1_CMD__SD1_CMD		0x400020d5
+			MX51_PAD_SD1_CLK__SD1_CLK		0x20d5
+			MX51_PAD_SD1_DATA0__SD1_DATA0		0x20d5
+			MX51_PAD_SD1_DATA1__SD1_DATA1		0x20d5
+			MX51_PAD_SD1_DATA2__SD1_DATA2		0x20d5
+			MX51_PAD_SD1_DATA3__SD1_DATA3		0x20d5
+			MX51_PAD_SD2_DATA0__SD1_DAT4		0x20d5
+			MX51_PAD_SD2_DATA1__SD1_DAT5		0x20d5
+			MX51_PAD_SD2_DATA2__SD1_DAT6		0x20d5
+			MX51_PAD_SD2_DATA3__SD1_DAT7		0x20d5
+		>;
+	};
+
+	pinctrl_esdhc4: esdhc4grp {
+		fsl,pins = <
+			MX51_PAD_NANDF_RB1__SD4_CMD		0x400020d5
+			MX51_PAD_NANDF_CS2__SD4_CLK		0x20d5
+			MX51_PAD_NANDF_CS3__SD4_DAT0		0x20d5
+			MX51_PAD_NANDF_CS4__SD4_DAT1		0x20d5
+			MX51_PAD_NANDF_CS5__SD4_DAT2		0x20d5
+			MX51_PAD_NANDF_CS6__SD4_DAT3		0x20d5
+			MX51_PAD_NANDF_D0__GPIO4_8		0x100
+		>;
+	};
+
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
+			MX51_PAD_DISP2_DAT1__FEC_RX_ER		0x20a4
+			MX51_PAD_DISP2_DAT13__FEC_TX_CLK	0x2180
+			MX51_PAD_DI_GP3__FEC_TX_ER		0x2004
+			MX51_PAD_DISP2_DAT14__FEC_RDATA0	0x2180
+			MX51_PAD_DI2_DISP_CLK__FEC_RDATA1	0x0085
+			MX51_PAD_DI_GP4__FEC_RDATA2		0x0085
+			MX51_PAD_DISP2_DAT0__FEC_RDATA3		0x0085
+			MX51_PAD_DI2_PIN2__FEC_MDC		0x2004
+			MX51_PAD_DI2_PIN3__FEC_MDIO		0x01f5
+			MX51_PAD_DI2_PIN4__FEC_CRS		0x0180
+			MX51_PAD_EIM_A20__GPIO2_14		0x0085
+			MX51_PAD_EIM_A21__GPIO2_15		0x00e5
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX51_PAD_KEY_COL4__I2C2_SCL		0x400001ed
+			MX51_PAD_KEY_COL5__I2C2_SDA		0x400001ed
+		>;
+	};
+
+	pinctrl_pmic: pmicgrp {
+		fsl,pins = <
+			MX51_PAD_GPIO1_4__GPIO1_4		0x85
+			MX51_PAD_GPIO1_8__GPIO1_8		0xe5
+		>;
+	};
+
+	pinctrl_swmdio: swmdiogrp {
+		fsl,pins = <
+			MX51_PAD_EIM_D22__GPIO2_6		0x100
+			MX51_PAD_EIM_D23__GPIO2_7		0x100
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX51_PAD_UART1_RXD__UART1_RXD		0x1c5
+			MX51_PAD_UART1_TXD__UART1_TXD		0x1c5
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
+			MX51_PAD_CSI1_D9__GPIO3_13		0x85
+		>;
+	};
+};
-- 
2.17.1
