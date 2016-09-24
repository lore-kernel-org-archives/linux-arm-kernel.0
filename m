From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Sun, 25 Sep 2016 08:59:45 +0900
Subject: [PATCH v2] ARM: dts: socfpga: Add Macnica sodia board
Message-ID: <20160924235945.32128-1-iwamatsu@nigauri.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for board based on the Altera Cyclone V SoC.
This board has the following functions:
    - 1 GiB of DRAM
    - 1 Gigabit ethernet
    - 1 SD card slot
    - 1 USB gadget port
    - QSPI NOR Flash
    - I2C EEPROMs and I2C RTC
    - DVI output
    - Audio port

This commit supports without QSPI, DVI and Audio.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 V2: move the PHY of setting to the Ethetnet PHY node level.

 arch/arm/boot/dts/Makefile                   |   1 +
 arch/arm/boot/dts/socfpga_cyclone5_sodia.dts | 123 +++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_sodia.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index befcd26..7c5f0c3 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -696,6 +696,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) += \
 	socfpga_cyclone5_de0_sockit.dtb \
 	socfpga_cyclone5_sockit.dtb \
 	socfpga_cyclone5_socrates.dtb \
+	socfpga_cyclone5_sodia.dtb \
 	socfpga_cyclone5_vining_fpga.dtb \
 	socfpga_vt.dtb
 dtb-$(CONFIG_ARCH_SPEAR13XX) += \
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts b/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
new file mode 100644
index 0000000..9aaf413
--- /dev/null
+++ b/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
@@ -0,0 +1,123 @@
+/*
+ *  Copyright (C) 2016 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "socfpga_cyclone5.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Altera SOCFPGA Cyclone V SoC Macnica Sodia board";
+	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
+
+	chosen {
+		bootargs = "earlyprintk";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		name = "memory";
+		device_type = "memory";
+		reg = <0x0 0x40000000>;
+	};
+
+	aliases {
+		ethernet0 = &gmac1;
+	};
+
+	regulator_3_3v: 3-3-v-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	leds: gpio-leds {
+		compatible = "gpio-leds";
+
+		hps_led0 {
+			label = "hps:green:led0";
+			gpios = <&portb 12 GPIO_ACTIVE_LOW>;
+		};
+
+		hps_led1 {
+			label = "hps:green:led1";
+			gpios = <&portb 13 GPIO_ACTIVE_LOW>;
+		};
+
+		hps_led2 {
+			label = "hps:green:led2";
+			gpios = <&portb 14 GPIO_ACTIVE_LOW>;
+		};
+
+		hps_led3 {
+			label = "hps:green:led3";
+			gpios = <&portb 15 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&gmac1 {
+	status = "okay";
+	phy-mode = "rgmii";
+	phy = <&phy0>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy0: ethernet-phy at 0 {
+			reg = <0>;
+			rxd0-skew-ps = <0>;
+			rxd1-skew-ps = <0>;
+			rxd2-skew-ps = <0>;
+			rxd3-skew-ps = <0>;
+			rxdv-skew-ps = <0>;
+			rxc-skew-ps = <3000>;
+			txen-skew-ps = <0>;
+			txc-skew-ps = <3000>;
+		};
+	};
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	eeprom at 51 {
+		compatible = "atmel,24c32";
+		reg = <0x51>;
+		pagesize = <32>;
+	};
+
+	rtc at 68 {
+		compatible = "dallas,ds1339";
+		reg = <0x68>;
+	};
+};
+
+&mmc0 {
+	cd-gpios = <&portb 18 0>;
+	vmmc-supply = <&regulator_3_3v>;
+	vqmmc-supply = <&regulator_3_3v>;
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
-- 
2.9.3
