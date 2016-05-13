From: shc_work@mail.ru (Alexander Shiyan)
Date: Fri, 13 May 2016 14:26:28 +0300
Subject: [PATCH 3/3] ARM: dts: clps711x: Add basic Cirrus Logic CDB89712
 Development board
In-Reply-To: <1463138788-5390-1-git-send-email-shc_work@mail.ru>
References: <1463138788-5390-1-git-send-email-shc_work@mail.ru>
Message-ID: <1463138788-5390-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the Cirrus Logic CLPS711X DT template and support for
CDB89712 Development board.
http://www.cirrus.com/en/pubs/manual/cdb89712-2.pdf

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/Makefile              |   2 +
 arch/arm/boot/dts/clps711x-cdb89712.dts |  56 +++++++++
 arch/arm/boot/dts/clps711x.dtsi         | 201 ++++++++++++++++++++++++++++++++
 3 files changed, 259 insertions(+)
 create mode 100644 arch/arm/boot/dts/clps711x-cdb89712.dts
 create mode 100644 arch/arm/boot/dts/clps711x.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 95c1923..69de1d5 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -104,6 +104,8 @@ dtb-$(CONFIG_ARCH_BERLIN) += \
 	berlin2q-marvell-dmp.dtb
 dtb-$(CONFIG_ARCH_BRCMSTB) += \
 	bcm7445-bcm97445svmb.dtb
+dtb-$(CONFIG_ARCH_CLPS711X) += \
+	clps711x-cdb89712.dtb
 dtb-$(CONFIG_ARCH_DAVINCI) += \
 	da850-enbw-cmc.dtb \
 	da850-evm.dtb
diff --git a/arch/arm/boot/dts/clps711x-cdb89712.dts b/arch/arm/boot/dts/clps711x-cdb89712.dts
new file mode 100644
index 0000000..eaffd7c
--- /dev/null
+++ b/arch/arm/boot/dts/clps711x-cdb89712.dts
@@ -0,0 +1,56 @@
+/*
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ */
+
+#include "clps711x.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Cirrus Logic CS89712 Development Board";
+	compatible = "cirrus,cdb89712", "cirrus,cs89712", "cirrus,clps711x";
+
+	memory {
+		reg = <0xc0000000 0x01000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		pd0 {
+			label = "diagnostic";
+			gpios = <&portd 0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&bus {
+	flash: root at 00000000 {
+		compatible = "cfi-flash";
+		reg = <0 0x00000000 0x01000000>;
+		bank-width = <2>;
+		linux,mtd-name = "physmap-flash.0";
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+
+	boot: boot at 0x70000000 {
+		compatible = "cfi-flash";
+		reg = <7 0x00000000 0x00000080>;
+		bank-width = <2>;
+		linux,mtd-name = "physmap-flash.1";
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
+
+&uart1 {
+	cts-gpios = <&mctrl 0 GPIO_ACTIVE_LOW>;
+	dsr-gpios = <&mctrl 1 GPIO_ACTIVE_LOW>;
+	dcd-gpios = <&mctrl 2 GPIO_ACTIVE_LOW>;
+	rts-gpios = <&portb 1 GPIO_ACTIVE_LOW>;
+	rng-gpios = <&portb 2 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm/boot/dts/clps711x.dtsi b/arch/arm/boot/dts/clps711x.dtsi
new file mode 100644
index 0000000..791eeee
--- /dev/null
+++ b/arch/arm/boot/dts/clps711x.dtsi
@@ -0,0 +1,201 @@
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
+	model = "Cirrus Logic CLPS711X";
+	compatible = "cirrus,clps711x";
+
+	aliases {
+		gpio0 = &porta;
+		gpio1 = &portb;
+		gpio2 = &portc;
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
+			compatible = "cirrus,clps711x-clk";
+			reg = <0x80000000 0xc000>;
+			startup-frequency = <73728000>;
+		};
+
+		intc: intc at 80000000 {
+			compatible = "cirrus,clps711x-intc";
+			reg = <0x80000000 0x4000>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		porta: gpio at 80000000 {
+			compatible = "cirrus,clps711x-gpio";
+			reg = <0x80000000 0x1 0x80000040 0x1>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		portb: gpio at 80000001 {
+			compatible = "cirrus,clps711x-gpio";
+			reg = <0x80000001 0x1 0x80000041 0x1>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		portc: gpio at 80000002 {
+			compatible = "cirrus,clps711x-gpio";
+			reg = <0x80000002 0x1 0x80000042 0x1>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			status = "disabled";
+		};
+
+		portd: gpio at 80000003 {
+			compatible = "cirrus,clps711x-gpio";
+			reg = <0x80000003 0x1 0x80000043 0x1>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		porte: gpio at 80000083 {
+			compatible = "cirrus,clps711x-gpio";
+			reg = <0x80000083 0x1 0x800000c3 0x1>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		syscon1: syscon at 80000100 {
+			compatible = "cirrus,clps711x-syscon1", "syscon";
+			reg = <0x80000100 0x80>;
+		};
+
+		bus: bus at 80000180 {
+			#address-cells = <2>;
+			#size-cells = <1>;
+			compatible = "cirrus,clps711x-bus", "simple-bus";
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
+			compatible = "cirrus,clps711x-fb";
+			reg = <0x800002c0 0xd44>, <0x60000000 0xc000>;
+			clocks = <&clks CLPS711X_CLK_BUS>;
+			status = "disabled";
+		};
+
+		timer1: timer at 80000300 {
+			compatible = "cirrus,clps711x-timer";
+			reg = <0x80000300 0x4>;
+			clocks = <&clks CLPS711X_CLK_TIMER1>;
+			interrupts = <8>;
+		};
+
+		timer2: timer at 80000340 {
+			compatible = "cirrus,clps711x-timer";
+			reg = <0x80000340 0x4>;
+			clocks = <&clks CLPS711X_CLK_TIMER2>;
+			interrupts = <9>;
+		};
+
+		pwm: pwm at 80000400 {
+			compatible = "cirrus,clps711x-pwm";
+			reg = <0x80000400 0x4>;
+			clocks = <&clks CLPS711X_CLK_PWM>;
+			#pwm-cells = <1>;
+		};
+
+		uart1: uart at 80000480 {
+			compatible = "cirrus,clps711x-uart";
+			reg = <0x80000480 0x80>;
+			interrupts = <12 13>;
+			clocks = <&clks CLPS711X_CLK_UART>;
+			syscon = <&syscon1>;
+		};
+
+		spi: spi at 80000500 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "cirrus,clps711x-spi";
+			reg = <0x80000500 0x4>;
+			interrupts = <15>;
+			clocks = <&clks CLPS711X_CLK_SPI>;
+			status = "disabled";
+		};
+
+		syscon2: syscon at 80001100 {
+			compatible = "cirrus,clps711x-syscon2", "syscon";
+			reg = <0x80001100 0x80>;
+		};
+
+		uart2: uart at 80001480 {
+			compatible = "cirrus,clps711x-uart";
+			reg = <0x80001480 0x80>;
+			interrupts = <28 29>;
+			clocks = <&clks CLPS711X_CLK_UART>;
+			syscon = <&syscon2>;
+		};
+
+		dai: dai at 80002000 {
+			#sound-dai-cells = <0>;
+			compatible = "cirrus,clps711x-dai";
+			reg = <0x80002000 0x604>;
+			clocks = <&clks CLPS711X_CLK_PLL>;
+			clock-names = "pll";
+			interrupts = <32>;
+			status = "disabled";
+		};
+
+		syscon3: syscon at 80002200 {
+			compatible = "cirrus,clps711x-syscon3", "syscon";
+			reg = <0x80002200 0x40>;
+		};
+	};
+
+	mctrl: mctrl {
+		compatible = "cirrus,clps711x-mctrl-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+};
-- 
2.4.9
