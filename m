From: mdf@kernel.org (Moritz Fischer)
Date: Mon, 11 Sep 2017 16:22:22 -0700
Subject: [PATCH 1/2] arm: dts: Add support for National Instruments Project
 Sulfur SDRs
Message-ID: <20170911232223.91894-1-mdf@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the National Instruments Project Sulfur SDR
motherboards Rev 2,3 and 4.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 arch/arm/boot/dts/Makefile                |   3 +
 arch/arm/boot/dts/zynq-ni-sulfur-rev2.dts |  84 +++++++++++++++++++
 arch/arm/boot/dts/zynq-ni-sulfur-rev3.dts | 118 ++++++++++++++++++++++++++
 arch/arm/boot/dts/zynq-ni-sulfur-rev4.dts |  26 ++++++
 arch/arm/boot/dts/zynq-ni-sulfur.dtsi     | 133 ++++++++++++++++++++++++++++++
 5 files changed, 364 insertions(+)
 create mode 100644 arch/arm/boot/dts/zynq-ni-sulfur-rev2.dts
 create mode 100644 arch/arm/boot/dts/zynq-ni-sulfur-rev3.dts
 create mode 100644 arch/arm/boot/dts/zynq-ni-sulfur-rev4.dts
 create mode 100644 arch/arm/boot/dts/zynq-ni-sulfur.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4b17f35dc9a7..9c3317c00aee 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -991,6 +991,9 @@ dtb-$(CONFIG_ARCH_VT8500) += \
 dtb-$(CONFIG_ARCH_ZYNQ) += \
 	zynq-microzed.dtb \
 	zynq-parallella.dtb \
+	zynq-ni-sulfur-rev2.dtb \
+	zynq-ni-sulfur-rev3.dtb \
+	zynq-ni-sulfur-rev4.dtb \
 	zynq-zc702.dtb \
 	zynq-zc706.dtb \
 	zynq-zed.dtb \
diff --git a/arch/arm/boot/dts/zynq-ni-sulfur-rev2.dts b/arch/arm/boot/dts/zynq-ni-sulfur-rev2.dts
new file mode 100644
index 000000000000..8b7c54fe9c59
--- /dev/null
+++ b/arch/arm/boot/dts/zynq-ni-sulfur-rev2.dts
@@ -0,0 +1,84 @@
+/*
+ * Copyright (c) 2016,2017 National Instruments Corp.
+ *
+ * SPDX-License-Identifier: (GPL-2.0 OR X11)
+ */
+
+/dts-v1/;
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "zynq-ni-sulfur.dtsi"
+
+/ {
+	model = "NI/Ettus Research Project Sulfur SDR Rev2";
+	compatible = "ettus,zynq-sulfur-rev2", "xlnx,zynq-7000";
+
+	gpio-poweroff {
+		compatible = "gpio-poweroff";
+		gpios = <&gpio0 4 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&i2c_switch0 {
+	reset-gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
+
+	i2c at 4 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <4>;
+
+		tpm: tpm at 20 {
+			compatible = "infineon,slb9645tt";
+			reg = <0x20>;
+
+			interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-parent = <&gpio0>;
+
+			reset-gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+};
+
+&spi1 {
+	status = "okay";
+
+	cros_ec: ec at 0 {
+		compatible = "google,cros-ec-spi";
+		reg = <0>;
+		google,cros-ec-spi-msg-delay = <200>;
+		google,cros-ec-spi-pre-delay = <60>;
+		google,has-vbc-nvram;
+		spi-max-frequency = <3000000>;
+
+		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio0>;
+
+		tun: i2c-tunnel {
+			compatible = "google,cros-ec-i2c-tunnel";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			google,remote-bus = <1>;
+			clock-frequency = <50000>;
+
+			nvmem0: eeprom at 50 {
+				compatible = "atmel,24c256";
+				reg = <0x50>;
+			};
+
+			rtc0: rtc at 68 {
+				compatible = "dallas,ds1374";
+				reg = <0x68>;
+			};
+		};
+	};
+};
+
+&ethernet_phy0 {
+	reset-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
+};
+
+&usb_phy0 {
+	reset-gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm/boot/dts/zynq-ni-sulfur-rev3.dts b/arch/arm/boot/dts/zynq-ni-sulfur-rev3.dts
new file mode 100644
index 000000000000..fff3a40b507b
--- /dev/null
+++ b/arch/arm/boot/dts/zynq-ni-sulfur-rev3.dts
@@ -0,0 +1,118 @@
+/*
+ * Copyright (c) 2016,2017 National Instruments Corp.
+ *
+ * SPDX-License-Identifier: (GPL-2.0 OR X11)
+ */
+
+/dts-v1/;
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "zynq-ni-sulfur.dtsi"
+
+/ {
+	model = "NI/Ettus Research Project Sulfur SDR Rev3";
+	compatible = "ettus,zynq-sulfur-rev3", "xlnx,zynq-7000";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		power-button {
+			label = "Power Button";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	gpio-poweroff {
+		compatible = "gpio-poweroff";
+		gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
+	};
+
+	leds {
+		led0 {
+			label = "sulfur:ledn";
+			gpios = <&gpio0 4 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&i2c_switch0 {
+	reset-gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
+
+	i2c at 3 {
+		reg = <3>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio1: gpio at 22 {
+			compatible = "ti,tca6424";
+			reg = <0x22>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+	};
+
+	i2c at 5 {
+		reg = <5>;
+		status = "okay";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rtc0: rtc at 68 {
+			compatible = "dallas,ds1374";
+			reg = <0x68>;
+		};
+	};
+
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	embedded-controller at 1e {
+		reg = <0x1e>;
+		compatible = "google,cros-ec-i2c";
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio0>;
+		google,has-vbc-nvram;
+
+		wakeup-source;
+
+		tun: i2c-tunnel {
+			compatible = "google,cros-ec-i2c-tunnel";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			google,remote-bus = <0>;
+			clock-frequency = <50000>;
+
+			nvmem0: eeprom at 50 {
+				compatible = "atmel,24c02";
+				reg = <0x50>;
+			};
+		};
+	};
+};
+
+&gpio0 {
+	ledp {
+		gpio-hog;
+		gpios = <5 GPIO_ACTIVE_HIGH>;
+		output-high;
+	};
+};
+
+&ethernet_phy0 {
+	reset-gpios = <&gpio0 50 GPIO_ACTIVE_LOW>;
+};
+
+&usb_phy0 {
+	reset-gpios = <&gpio0 51 GPIO_ACTIVE_LOW>;
+};
+
+&clkc {
+	ps-clk-frequency = <33333333>;
+};
diff --git a/arch/arm/boot/dts/zynq-ni-sulfur-rev4.dts b/arch/arm/boot/dts/zynq-ni-sulfur-rev4.dts
new file mode 100644
index 000000000000..2a5b21549e68
--- /dev/null
+++ b/arch/arm/boot/dts/zynq-ni-sulfur-rev4.dts
@@ -0,0 +1,26 @@
+/*
+ * Copyright (c) 2016,2017 National Instruments Corp.
+ *
+ * SPDX-License-Identifier: (GPL-2.0 OR X11)
+ */
+
+/dts-v1/;
+#include "zynq-ni-sulfur-rev3.dts"
+
+/ {
+	model = "NI/Ettus Research Project Sulfur SDR Rev4";
+	compatible = "ettus,zynq-sulfur-rev4", "xlnx,zynq-7000";
+};
+
+&i2c_switch0 {
+	i2c at 4 {
+		reg = <4>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		tpm: tpm at 29 {
+			compatible = "atmel,at97sc3204t";
+			reg = <0x29>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/zynq-ni-sulfur.dtsi b/arch/arm/boot/dts/zynq-ni-sulfur.dtsi
new file mode 100644
index 000000000000..4bf63f09c81a
--- /dev/null
+++ b/arch/arm/boot/dts/zynq-ni-sulfur.dtsi
@@ -0,0 +1,133 @@
+/*
+ * Copyright (c) 2016,2017 National Instruments Corp.
+ *
+ * SPDX-License-Identifier: (GPL-2.0 OR X11)
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "zynq-7000.dtsi"
+
+/ {
+	aliases {
+		ethernet0 = &gem0;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		spi0 = &spi0;
+		spi1 = &spi1;
+		gpio0 = &gpio0;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c20 = &tun;
+		i2c706 = &usrpio_i2c0;
+		i2c707 = &usrpio_i2c1;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x40000000>;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	usb_phy0: phy0 {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+	};
+};
+
+&cpu0 {
+	operating-points = <800000 1000000>;
+};
+
+&clkc {
+	ps-clk-frequency = <33333333>;
+};
+
+&sdhci0 {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+/* we use the ARM global timer */
+&ttc0 {
+	status = "disabled";
+};
+
+/* we use the ARM global timer */
+&ttc1 {
+	status = "disabled";
+};
+
+&i2c0 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	i2c_switch0: i2cswitch at 70 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+
+		usrpio_i2c0: i2c at 6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+
+			nvmem2: eeprom at 50 {
+				compatible = "atmel,24c256";
+				reg = <0x50>;
+			};
+
+		};
+
+		usrpio_i2c1: i2c at 7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+
+			nvmem3: eeprom at 50 {
+				compatible = "atmel,24c256";
+				reg = <0x50>;
+			};
+		};
+
+	};
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gem0 {
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethernet_phy0>;
+	status = "okay";
+
+	ethernet_phy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
+};
+
+&usb0 {
+	usb-phy = <&usb_phy0>;
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&amba {
+	ocm: sram at fffc0000 {
+		compatible = "mmio-sram";
+		reg = <0xfffc0000 0x10000>;
+	};
+};
-- 
2.14.1
