From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue,  9 Sep 2014 13:26:02 +0200
Subject: [PATCH 3/4] ARM: dts: imx28-tx28: add spi-gpio as alternative for
 spi-mxs
In-Reply-To: <1410261963-27956-1-git-send-email-LW@KARO-electronics.de>
References: <1410261963-27956-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1410261963-27956-4-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spi-mxs driver does not allow full duplex SPI transfers. The
spi-gpio driver may be used as an alternative if this is required.

Make the choice between those drivers easier for the end user by
providing settings for both drivers.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx28-tx28.dts |   54 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index cfe6b31..81d4eb4 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -27,6 +27,8 @@
 		lcdif = &lcdif;
 		lcdif_23bit_pins = &tx28_lcdif_23bit_pins;
 		lcdif_24bit_pins = &lcdif_24bit_pins_a;
+		spi_gpio = &spi_gpio;
+		spi_mxs = &ssp3;
 		stk5led = &user_led;
 		usbotg = &usb0;
 	};
@@ -203,6 +205,44 @@
 		col-scan-delay-us = <5000>;
 		linux,no-autorepeat;
 	};
+
+	spi_gpio: spi-gpio {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tx28_spi_gpio_pins>;
+
+		gpio-sck = <&gpio2 24 GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio2 25 GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio2 26 GPIO_ACTIVE_HIGH>;
+		num-chipselects = <3>;
+		cs-gpios = <
+			&gpio2 27 GPIO_ACTIVE_LOW
+			&gpio3 8 GPIO_ACTIVE_LOW
+			&gpio3 9 GPIO_ACTIVE_LOW
+		>;
+		/* enable this and disable ssp3 below, if you need full duplex SPI transfer */
+		status = "disabled";
+
+		spi at 0 {
+			compatible = "spidev";
+			reg = <0>;
+			spi-max-frequency = <57600000>;
+		};
+
+		spi at 1 {
+			compatible = "spidev";
+			reg = <1>;
+			spi-max-frequency = <57600000>;
+		};
+
+		spi at 2 {
+			compatible = "spidev";
+			reg = <2>;
+			spi-max-frequency = <57600000>;
+		};
+	};
 };
 
 /* 2nd TX-Std UART - (A)UART1  */
@@ -558,6 +598,20 @@
 		fsl,pull-up = <MXS_PULL_DISABLE>;
 	};
 
+	tx28_spi_gpio_pins: spi-gpiogrp {
+		fsl,pinmux-ids = <
+			MX28_PAD_AUART2_RX__GPIO_3_8
+			MX28_PAD_AUART2_TX__GPIO_3_9
+			MX28_PAD_SSP3_SCK__GPIO_2_24
+			MX28_PAD_SSP3_MOSI__GPIO_2_25
+			MX28_PAD_SSP3_MISO__GPIO_2_26
+			MX28_PAD_SSP3_SS0__GPIO_2_27
+		>;
+		fsl,drive-strength = <MXS_DRIVE_8mA>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_DISABLE>;
+	};
+
 	tx28_tsc2007_pins: tx28-tsc2007-pins {
 		fsl,pinmux-ids = <
 			MX28_PAD_SAIF0_MCLK__GPIO_3_20 /* TSC2007 IRQ */
-- 
1.7.10.4
