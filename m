From: vijaykhemka@fb.com (Vijay Khemka)
Date: Thu, 13 Sep 2018 12:57:51 -0700
Subject: [PATCH] ARM: dts: aspeed: Adding Facebook TioagaPass BMC
Message-ID: <20180913195751.1833227-1-vijaykhemka@fb.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial introduction of Facebook TioagaPass family equipped with
Aspeed 2500 BMC SoC. Neptune is a x86 server development kit
with a ASPEED ast2500 BMC manufactured by Facebook.
Specifically, This adds the tiogapass platform device tree file
including the flash layout used by the tiogapass BMC machines.

This also adds an entry of tiogapass device tree file in Makefile
as well an entry of Facebook in Documentation for vendor prefix

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/aspeed-bmc-facebook-tiogapass.dts     | 152 ++++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 2c3fc512e746..733b2d523642 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -127,6 +127,7 @@ everspin	Everspin Technologies, Inc.
 exar	Exar Corporation
 excito	Excito
 ezchip	EZchip Semiconductor
+facebook  Facebook
 fairphone	Fairphone B.V.
 faraday	Faraday Technology Corporation
 fastrax	Fastrax Oy
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b5bd3de87c33..9c82c1681c38 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1206,4 +1206,5 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-opp-witherspoon.dtb \
 	aspeed-bmc-opp-zaius.dtb \
 	aspeed-bmc-portwell-neptune.dtb \
+	aspeed-bmc-facebook-tiogapass.dtb \
 	aspeed-bmc-quanta-q71l.dtb
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
new file mode 100644
index 000000000000..859a00581e34
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017 Facebook Inc.
+/dts-v1/;
+
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "Facebook TiogaPass BMC";
+	compatible = "facebook,tiogapass-bmc", "aspeed,ast2500";
+	aliases {
+		serial0 = &uart1;
+		serial4 = &uart5;
+	};
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,115200 earlyprintk";
+	};
+
+	memory {
+		reg = <0x80000000 0x20000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		postcode0 {
+			label="BMC_UP";
+			gpios = <&gpio ASPEED_GPIO(H, 0) GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+		postcode1 {
+			label="BMC_HB";
+			gpios = <&gpio ASPEED_GPIO(H, 1) GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+		postcode2 {
+			label="FAULT";
+			gpios = <&gpio ASPEED_GPIO(H, 2) GPIO_ACTIVE_HIGH>;
+		};
+		// postcode3-7 are GPIOH3-H7
+	};
+};
+
+&fmc {
+	status = "okay";
+	flash at 0 {
+		status = "okay";
+		m25p,fast-read;
+#include "openbmc-flash-layout.dtsi"
+	};
+};
+
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	flash at 0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "pnor";
+	};
+};
+
+&uart1 {
+	// Host Console
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd1_default
+		     &pinctrl_rxd1_default>;
+};
+
+&uart5 {
+	// BMC Console
+	status = "okay";
+};
+
+&mac0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii1_default>;
+	use-ncsi;
+};
+
+&i2c1 {
+	status = "okay";
+	// To PCIe slot SMBUS
+};
+
+&i2c2 {
+	status = "okay";
+	// To LAN I210
+};
+
+&i2c3 {
+	status = "okay";
+	// SMBus to COMe AB
+};
+
+&i2c4 {
+	status = "okay";
+	// I2C to COMe AB
+};
+
+&i2c5 {
+	status = "okay";
+  //USB Debug card
+	pca9555 at 27 {
+		compatible = "nxp,pca9555";
+		reg = <0x27>;
+	};
+};
+
+&i2c6 {
+	status = "okay";
+	tpm at 20 {
+		compatible = "infineon,slb9645tt";
+		reg = <0x20>;
+	};
+	tmp421 at 4e {
+		compatible = "ti,tmp421";
+		reg = <0x4e>;
+	};
+	tmp421 at 4f {
+		compatible = "ti,tmp421";
+		reg = <0x4f>;
+	};
+};
+
+&i2c8 {
+	status = "okay";
+	eeprom at 51 {
+		compatible = "atmel,24c128";
+		reg = <0x51>;
+		pagesize = <32>;
+	};
+};
+
+&pwm_tacho {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default &pinctrl_pwm1_default>;
+	fan at 0 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
+	};
+
+	fan at 1 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x01>;
+	};
+};
-- 
2.17.1
