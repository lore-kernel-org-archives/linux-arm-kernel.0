From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Mon, 20 Feb 2017 17:14:51 +0800
Subject: [PATCH v2 2/2] arm: dts: hisi: add dts files for Hi3516CV300 demo
 board
In-Reply-To: <1487582091-24695-1-git-send-email-xuejiancheng@hisilicon.com>
References: <1487582091-24695-1-git-send-email-xuejiancheng@hisilicon.com>
Message-ID: <1487582091-24695-3-git-send-email-xuejiancheng@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pan Wen <wenpan@hisilicon.com>

Add dts files for Hi3516CV300 demo board.

Signed-off-by: Pan Wen <wenpan@hisilicon.com>
Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
---
ChangeLog:
1. removed i2c and pwm nodes because the drivers were not merged.
2. removed some unused alias and properties.

 arch/arm/boot/dts/Makefile             |   1 +
 arch/arm/boot/dts/hi3516cv300-demb.dts |  95 +++++++++
 arch/arm/boot/dts/hi3516cv300.dtsi     | 362 +++++++++++++++++++++++++++++++++
 3 files changed, 458 insertions(+)
 create mode 100644 arch/arm/boot/dts/hi3516cv300-demb.dts
 create mode 100644 arch/arm/boot/dts/hi3516cv300.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 01d178a..69497ad 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -178,6 +178,7 @@ dtb-$(CONFIG_ARCH_HIP01) += \
 dtb-$(CONFIG_ARCH_HIP04) += \
 	hip04-d01.dtb
 dtb-$(CONFIG_ARCH_HISI) += \
+	hi3516cv300-demb.dtb \
 	hi3519-demb.dtb
 dtb-$(CONFIG_ARCH_HIX5HD2) += \
 	hisi-x5hd2-dkb.dtb
diff --git a/arch/arm/boot/dts/hi3516cv300-demb.dts b/arch/arm/boot/dts/hi3516cv300-demb.dts
new file mode 100644
index 0000000..b0e980b
--- /dev/null
+++ b/arch/arm/boot/dts/hi3516cv300-demb.dts
@@ -0,0 +1,95 @@
+/*
+ * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+
+/dts-v1/;
+#include "hi3516cv300.dtsi"
+
+/ {
+	model = "Hisilicon Hi3516CV300 DEMO Board";
+	compatible = "hisilicon,hi3516cv300-demb", "hisilicon,hi3516cv300";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>;
+	};
+};
+
+&dual_timer0 {
+	status = "okay";
+};
+
+&watchdog {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&spi_bus1 {
+	status = "okay";
+	num-cs = <2>;
+	cs-gpios = <&gpio_chip5 3 0>, <&gpio_chip5 4 0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pmux>;
+};
+
+&fmc {
+	spi-nor at 0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <160000000>;
+		m25p,fast-read;
+	};
+};
+
+&mdio {
+	phy0: phy at 1 {
+		reg = <1>;
+	};
+};
+
+&hisi_femac {
+	phy-mode = "rmii";
+	phy-handle = <&phy0>;
+	hisilicon,phy-reset-delays-us = <10000 10000 150000>;
+};
+
+&dmac {
+	status = "okay";
+};
+
+&pmux {
+	spi1_pmux: spi1_pmux {
+		pinctrl-single,pins = <
+			0xc4 0x1
+			0xc8 0x1
+			0xcc 0x1
+			0xd0 0x1
+			0xd4 0x1>;
+	};
+};
diff --git a/arch/arm/boot/dts/hi3516cv300.dtsi b/arch/arm/boot/dts/hi3516cv300.dtsi
new file mode 100644
index 0000000..5132cfe
--- /dev/null
+++ b/arch/arm/boot/dts/hi3516cv300.dtsi
@@ -0,0 +1,362 @@
+/*
+ * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <dt-bindings/clock/hi3516cv300-clock.h>
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,arm926ej-s";
+			device_type = "cpu";
+			reg = <0>;
+		};
+	};
+
+	vic: interrupt-controller at 10040000 {
+		compatible = "arm,pl190-vic";
+		reg = <0x10040000 0x1000>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&vic>;
+		ranges;
+
+		clk_3m: clk_3m {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <3000000>;
+		};
+
+		clk_apb: clk_apb {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <50000000>;
+		};
+
+		crg: clock-reset-controller at 12010000 {
+			compatible = "hisilicon,hi3516cv300-crg";
+			reg = <0x12010000 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <2>;
+		};
+
+		sysctrl: system-controller at 12020000 {
+			compatible = "hisilicon,hi3516cv300-sysctrl", "syscon";
+			reg = <0x12020000 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		reboot {
+			compatible = "syscon-reboot";
+			regmap = <&sysctrl>;
+			offset = <0x4>;
+			mask = <0xdeadbeef>;
+		};
+
+		dual_timer0: dual_timer at 12000000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x12000000 0x1000>;
+			interrupts = <3>;
+			clocks = <&clk_3m>, <&clk_3m>, <&clk_apb>;
+			clock-names = "timer0", "timer1", "apb_pclk";
+			status = "disabled";
+		};
+
+		dual_timer1: dual_timer at 12001000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x12001000 0x1000>;
+			interrupts = <4>;
+			clocks = <&clk_3m>, <&clk_3m>, <&clk_apb>;
+			clock-names = "timer0", "timer1", "apb_pclk";
+			status = "disabled";
+		};
+
+		watchdog: watchdog at 12080000 {
+			compatible = "arm,sp805-wdt", "arm,primecell";
+			arm,primecell-periphid = <0x00141805>;
+			reg = <0x12080000 0x1000>;
+			clocks = <&sysctrl HI3516CV300_WDT_CLK>,
+				<&crg HI3516CV300_APB_CLK>;
+			clock-names = "wdog_clk", "apb_pclk";
+			status = "disabled";
+		};
+
+		uart0: uart at 12100000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x12100000 0x1000>;
+			interrupts = <5>;
+			clocks = <&crg HI3516CV300_UART0_CLK>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		uart1: uart at 12101000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x12101000 0x1000>;
+			interrupts = <30>;
+			clocks = <&crg HI3516CV300_UART1_CLK>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		uart2: uart at 12102000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x12102000 0x1000>;
+			interrupts = <25>;
+			clocks = <&crg HI3516CV300_UART2_CLK>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		spi_bus0: spi at 12120000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x12120000 0x1000>;
+			interrupts = <6>;
+			clocks = <&crg HI3516CV300_SPI0_CLK>;
+			clock-names = "apb_pclk";
+			dmas = <&dmac 12 1>, <&dmac 13 2>;
+			dma-names = "rx", "tx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi_bus1: spi at 12121000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x12121000 0x1000>, <0x12030000 0x4>;
+			interrupts = <7>;
+			clocks = <&crg HI3516CV300_SPI1_CLK>;
+			clock-names = "apb_pclk";
+			dmas = <&dmac 14 1>, <&dmac 15 2>;
+			dma-names = "rx", "tx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		fmc: spi-nor-controller at 10000000 {
+			compatible = "hisilicon,fmc-spi-nor";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x10000000 0x1000>, <0x14000000 0x1000000>;
+			reg-names = "control", "memory";
+			clocks = <&crg HI3516CV300_FMC_CLK>;
+			assigned-clocks = <&crg HI3516CV300_FMC_CLK>;
+			assigned-clock-rates = <24000000>;
+		};
+
+		mdio: mdio at 10051100 {
+			compatible = "hisilicon,hisi-femac-mdio";
+			reg = <0x10051100 0x10>;
+			clocks = <&crg HI3516CV300_ETH_CLK>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		hisi_femac: ethernet at 10090000 {
+			compatible = "hisilicon,hi3516cv300-femac",
+				     "hisilicon,hisi-femac-v2";
+			reg = <0x10050000 0x1000>,<0x10051300 0x200>;
+			interrupts = <12>;
+			clocks = <&crg HI3516CV300_ETH_CLK>;
+			resets = <&crg 0xec 0>, <&crg 0xec 3>;
+			reset-names = "mac","phy";
+		};
+
+		dmac: dma-controller at 10030000 {
+			compatible = "arm,pl080", "arm,primecell";
+			reg = <0x10030000 0x1000>;
+			interrupts = <14>;
+			clocks = <&crg HI3516CV300_DMAC_CLK>;
+			clock-names = "apb_pclk";
+			lli-bus-interface-ahb1;
+			lli-bus-interface-ahb2;
+			mem-bus-interface-ahb1;
+			mem-bus-interface-ahb2;
+			memcpy-burst-size = <256>;
+			memcpy-bus-width = <32>;
+			#dma-cells = <2>;
+			status = "disabled";
+		};
+
+		gpio_chip0: gpio at 12140000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x12140000 0x1000>;
+			interrupts = <31>;
+			clocks = <&crg HI3516CV300_APB_CLK>;
+			clock-names = "apb_pclk";
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmux 0 61 2>,
+				      <&pmux 4 11 1>,
+				      <&pmux 5 10 1>,
+				      <&pmux 6 13 2>;
+
+			status = "disabled";
+		};
+
+		gpio_chip1: gpio at 12141000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x12141000 0x1000>;
+			interrupts = <31>;
+			clocks = <&crg HI3516CV300_APB_CLK>;
+			clock-names = "apb_pclk";
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmux 0 16 7>,
+				      <&pmux 7 0 1>;
+			status = "disabled";
+		};
+
+		gpio_chip2: gpio at 12142000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x12142000 0x1000>;
+			interrupts = <31>;
+			clocks = <&crg HI3516CV300_APB_CLK>;
+			clock-names = "apb_pclk";
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmux 0 46 1>,
+				      <&pmux 1 45 1>,
+				      <&pmux 2 44 1>,
+				      <&pmux 3 43 1>,
+				      <&pmux 4 39 1>,
+				      <&pmux 5 38 1>,
+				      <&pmux 6 40 1>,
+				      <&pmux 7 48 1>;
+			status = "disabled";
+		};
+
+		gpio_chip3: gpio at 12143000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x12143000 0x1000>;
+			interrupts = <31>;
+			clocks = <&crg HI3516CV300_APB_CLK>;
+			clock-names = "apb_pclk";
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmux 0 37 1>,
+				      <&pmux 1 36 1>,
+				      <&pmux 2 35 1>,
+				      <&pmux 3 34 1>,
+				      <&pmux 4 23 2>,
+				      <&pmux 6 8 2>;
+			status = "disabled";
+		};
+
+		gpio_chip4: gpio at 12144000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x12144000 0x1000>;
+			interrupts = <31>;
+			clocks = <&crg HI3516CV300_APB_CLK>;
+			clock-names = "apb_pclk";
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmux 0 27 1>,
+				      <&pmux 1 26 1>,
+				      <&pmux 2 31 1>,
+				      <&pmux 3 30 1>,
+				      <&pmux 4 28 2>,
+				      <&pmux 6 33 1>,
+				      <&pmux 7 32 1>;
+			status = "disabled";
+		};
+
+		gpio_chip5: gpio at 12145000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x12145000 0x1000>;
+			interrupts = <31>;
+			clocks = <&crg HI3516CV300_APB_CLK>;
+			clock-names = "apb_pclk";
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmux 0 53 1>,
+				      <&pmux 1 51 2>,
+				      <&pmux 3 50 1>,
+				      <&pmux 4 49 1>,
+				      <&pmux 5 47 1>,
+				      <&pmux 6 40 2>;
+			status = "disabled";
+		};
+
+		gpio_chip6: gpio at 12146000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x12146000 0x1000>;
+			interrupts = <31>;
+			clocks = <&crg HI3516CV300_APB_CLK>;
+			clock-names = "apb_pclk";
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmux 0 7 1>,
+				      <&pmux 1 6 1>,
+				      <&pmux 2 4 1>,
+				      <&pmux 3 5 1>,
+				      <&pmux 4 15 1>,
+				      <&pmux 5 1 3>;
+			status = "disabled";
+		};
+
+		gpio_chip7: gpio at 12147000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x12147000 0x1000>;
+			interrupts = <31>;
+			clocks = <&crg HI3516CV300_APB_CLK>;
+			clock-names = "apb_pclk";
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmux 1 55 6>,
+				      <&pmux 7 25 1>;
+			status = "disabled";
+		};
+
+		gpio_chip8: gpio at 12148000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x12148000 0x1000>;
+			interrupts = <31>;
+			clocks = <&crg HI3516CV300_APB_CLK>;
+			clock-names = "apb_pclk";
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmux 0 63 3>,
+				      <&pmux 3 12 1>;
+			status = "disabled";
+		};
+
+		pmux: pinmux at 12040000 {
+			compatible = "pinctrl-single";
+			reg = <0x12040000 0x108>;
+			#gpio-range-cells = <3>;
+			pinctrl-single,register-width = <32>;
+			pinctrl-single,function-mask = <7>;
+			pinctrl-single,gpio-range = <&range 0 54 0
+						     &range 55 6 1
+						     &range 61 5 0>;
+
+			range: gpio-range {
+				#pinctrl-single,gpio-range-cells = <3>;
+			};
+		};
+
+		pconf: pinconf at 12040800 {
+			compatible = "pinconf-single";
+			reg = <0x12040800 0x130>;
+			pinctrl-single,register-width = <32>;
+		};
+	};
+};
-- 
1.9.1
