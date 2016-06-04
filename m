From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  4 Jun 2016 10:10:04 +0300
Subject: [PATCH 12/22] ARM: dts: clps711x: Add DT Cirrus Logic EDB7211
 Development board
In-Reply-To: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
References: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
Message-ID: <1465024214-22120-13-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the Cirrus Logic EP7209,EP7211 DT templates and support for
EDB7211 Development board.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/Makefile           |   2 +
 arch/arm/boot/dts/ep7209.dtsi        | 191 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/ep7211-edb7211.dts | 100 ++++++++++++++++++
 arch/arm/boot/dts/ep7211.dtsi        |  12 +++
 4 files changed, 305 insertions(+)
 create mode 100644 arch/arm/boot/dts/ep7209.dtsi
 create mode 100644 arch/arm/boot/dts/ep7211-edb7211.dts
 create mode 100644 arch/arm/boot/dts/ep7211.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 06b6c2d..e409890 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -104,6 +104,8 @@ dtb-$(CONFIG_ARCH_BERLIN) += \
 	berlin2q-marvell-dmp.dtb
 dtb-$(CONFIG_ARCH_BRCMSTB) += \
 	bcm7445-bcm97445svmb.dtb
+dtb-$(CONFIG_ARCH_CLPS711X) += \
+	ep7211-edb7211.dtb
 dtb-$(CONFIG_ARCH_DAVINCI) += \
 	da850-enbw-cmc.dtb \
 	da850-evm.dtb
diff --git a/arch/arm/boot/dts/ep7209.dtsi b/arch/arm/boot/dts/ep7209.dtsi
new file mode 100644
index 0000000..aaf1261
--- /dev/null
+++ b/arch/arm/boot/dts/ep7209.dtsi
@@ -0,0 +1,191 @@
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ */
+
+/dts-v1/;
+
+#include "skeleton.dtsi"
+
+#include <dt-bindings/clock/clps711x-clock.h>
+
+/ {
+	model = "Cirrus Logic EP7209";
+	compatible = "cirrus,ep7209";
+
+	aliases {
+		gpio0 = &porta;
+		gpio1 = &portb;
+		gpio3 = &portd;
+		gpio4 = &porte;
+		serial0 = &uart1;
+		serial1 = &uart2;
+		spi0 = &spi;
+		timer0 = &timer1;
+		timer1 = &timer2;
+	};
+
+	cpus {
+		#address-cells = <0>;
+		#size-cells = <0>;
+
+		cpu {
+			device_type = "cpu";
+			compatible = "arm,arm720t";
+		};
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&intc>;
+		ranges;
+
+		clks: clks at 80000000 {
+			#clock-cells = <1>;
+			compatible = "cirrus,ep7209-clk";
+			reg = <0x80000000 0xc000>;
+			startup-frequency = <73728000>;
+		};
+
+		intc: intc at 80000000 {
+			compatible = "cirrus,ep7209-intc";
+			reg = <0x80000000 0x4000>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		porta: gpio at 80000000 {
+			compatible = "cirrus,ep7209-gpio";
+			reg = <0x80000000 0x1 0x80000040 0x1>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		portb: gpio at 80000001 {
+			compatible = "cirrus,ep7209-gpio";
+			reg = <0x80000001 0x1 0x80000041 0x1>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		portd: gpio at 80000003 {
+			compatible = "cirrus,ep7209-gpio";
+			reg = <0x80000003 0x1 0x80000043 0x1>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		porte: gpio at 80000083 {
+			compatible = "cirrus,ep7209-gpio";
+			reg = <0x80000083 0x1 0x800000c3 0x1>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		syscon1: syscon at 80000100 {
+			compatible = "cirrus,ep7209-syscon1", "syscon";
+			reg = <0x80000100 0x80>;
+		};
+
+		bus: bus at 80000180 {
+			#address-cells = <2>;
+			#size-cells = <1>;
+			compatible = "cirrus,ep7209-bus", "simple-bus";
+			clocks = <&clks CLPS711X_CLK_BUS>;
+			reg = <0x80000180 0x80>;
+			ranges = <
+				0 0 0x00000000 0x10000000
+				1 0 0x10000000 0x10000000
+				2 0 0x20000000 0x10000000
+				3 0 0x30000000 0x10000000
+				4 0 0x40000000 0x10000000
+				5 0 0x50000000 0x10000000
+				6 0 0x60000000 0x0000c000
+				7 0 0x70000000 0x00000080
+			>;
+		};
+
+		fb: fb at 800002c0 {
+			compatible = "cirrus,ep7209-fb";
+			reg = <0x800002c0 0xd44>, <0x60000000 0xc000>;
+			clocks = <&clks CLPS711X_CLK_BUS>;
+			status = "disabled";
+		};
+
+		timer1: timer at 80000300 {
+			compatible = "cirrus,ep7209-timer";
+			reg = <0x80000300 0x4>;
+			clocks = <&clks CLPS711X_CLK_TIMER1>;
+			interrupts = <8>;
+		};
+
+		timer2: timer at 80000340 {
+			compatible = "cirrus,ep7209-timer";
+			reg = <0x80000340 0x4>;
+			clocks = <&clks CLPS711X_CLK_TIMER2>;
+			interrupts = <9>;
+		};
+
+		pwm: pwm at 80000400 {
+			compatible = "cirrus,ep7209-pwm";
+			reg = <0x80000400 0x4>;
+			clocks = <&clks CLPS711X_CLK_PWM>;
+			#pwm-cells = <1>;
+		};
+
+		uart1: uart at 80000480 {
+			compatible = "cirrus,ep7209-uart";
+			reg = <0x80000480 0x80>;
+			interrupts = <12 13>;
+			clocks = <&clks CLPS711X_CLK_UART>;
+			syscon = <&syscon1>;
+		};
+
+		spi: spi at 80000500 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "cirrus,ep7209-spi";
+			reg = <0x80000500 0x4>;
+			interrupts = <15>;
+			clocks = <&clks CLPS711X_CLK_SPI>;
+			status = "disabled";
+		};
+
+		syscon2: syscon at 80001100 {
+			compatible = "cirrus,ep7209-syscon2", "syscon";
+			reg = <0x80001100 0x80>;
+		};
+
+		uart2: uart at 80001480 {
+			compatible = "cirrus,ep7209-uart";
+			reg = <0x80001480 0x80>;
+			interrupts = <28 29>;
+			clocks = <&clks CLPS711X_CLK_UART>;
+			syscon = <&syscon2>;
+		};
+
+		dai: dai at 80002000 {
+			#sound-dai-cells = <0>;
+			compatible = "cirrus,ep7209-dai";
+			reg = <0x80002000 0x604>;
+			clocks = <&clks CLPS711X_CLK_PLL>;
+			clock-names = "pll";
+			interrupts = <32>;
+			status = "disabled";
+		};
+
+		syscon3: syscon at 80002200 {
+			compatible = "cirrus,ep7209-syscon3", "syscon";
+			reg = <0x80002200 0x40>;
+		};
+	};
+
+	mctrl: mctrl {
+		compatible = "cirrus,ep7209-mctrl-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
diff --git a/arch/arm/boot/dts/ep7211-edb7211.dts b/arch/arm/boot/dts/ep7211-edb7211.dts
new file mode 100644
index 0000000..9a134ed
--- /dev/null
+++ b/arch/arm/boot/dts/ep7211-edb7211.dts
@@ -0,0 +1,100 @@
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ */
+
+#include "ep7211.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Cirrus Logic EP7211 Development Board";
+	compatible = "cirrus,edb7211", "cirrus,ep7211", "cirrus,ep7209";
+
+	memory {
+		reg = <0xc0000000 0x02000000>;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 0>;
+		brightness-levels = <
+			0x0 0x1 0x2 0x3 0x4 0x5 0x6 0x7
+			0x8 0x9 0xa 0xb 0xc 0xd 0xe 0xf
+		>;
+		default-brightness-level = <0x0>;
+		power-supply = <&blen>;
+	};
+
+	display: display {
+		model = "320x240x4";
+		native-mode = <&timing0>;
+		bits-per-pixel = <4>;
+		ac-prescale = <17>;
+
+		display-timings {
+			timing0: 320x240 {
+				hactive = <320>;
+				hback-porch = <0>;
+				hfront-porch = <0>;
+				hsync-len = <0>;
+				vactive = <240>;
+				vback-porch = <0>;
+				vfront-porch = <0>;
+				vsync-len = <0>;
+				clock-frequency = <6500000>;
+			};
+		};
+	};
+
+	i2c: i2c {
+		compatible = "i2c-gpio";
+		gpios = <&portd 4 GPIO_ACTIVE_HIGH>,
+			<&portd 5 GPIO_ACTIVE_HIGH>;
+		i2c-gpio,delay-us = <2>;
+		i2c-gpio,scl-output-only;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	lcddc: lcddc {
+		compatible = "regulator-fixed";
+		regulator-name = "BACKLIGHT ENABLE";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&portd 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	blen: blen {
+		compatible = "regulator-fixed";
+		regulator-name = "BACKLIGHT ENABLE";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&portd 3 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&bus {
+	flash: nor at 00000000 {
+		compatible = "cfi-flash";
+		reg = <0 0x00000000 0x02000000>;
+		bank-width = <2>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
+
+&fb {
+	display = <&display>;
+	lcd-supply = <&lcddc>;
+	status = "okay";
+};
+
+&portd {
+	lcden {
+		gpio-hog;
+		gpios = <2 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "LCD ENABLE";
+	};
+};
diff --git a/arch/arm/boot/dts/ep7211.dtsi b/arch/arm/boot/dts/ep7211.dtsi
new file mode 100644
index 0000000..e438f6d
--- /dev/null
+++ b/arch/arm/boot/dts/ep7211.dtsi
@@ -0,0 +1,12 @@
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ */
+
+#include "ep7209.dtsi"
+
+/ {
+	model = "Cirrus Logic EP7211";
+	compatible = "cirrus,ep7211", "cirrus,ep7209";
+};
-- 
2.4.9
