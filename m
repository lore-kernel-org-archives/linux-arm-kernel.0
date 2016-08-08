From: andre.przywara@arm.com (Andre Przywara)
Date: Mon,  8 Aug 2016 18:21:47 +0100
Subject: [PATCH v4 5/7] arm64: dts: add Allwinner A64 SoC .dtsi
In-Reply-To: <20160808172149.30861-1-andre.przywara@arm.com>
References: <20160808172149.30861-1-andre.przywara@arm.com>
Message-ID: <20160808172149.30861-6-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A64 SoC is a low-cost chip with 4 ARM Cortex-A53 cores
and the typical tablet / TV box peripherals.
The SoC is based on the (32-bit) Allwinner H3 chip, sharing most of
the peripherals and the memory map.
Although the cores are proper 64-bit ones, the whole SoC is actually
limited to 4GB (including all the supported DRAM), so we use 32-bit
address and size cells. This has the nice feature of us being able to
reuse the DT for 32-bit kernels as well.
This .dtsi lists the hardware that we support so far.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Hi,

I dropped Rob's previous ACK, as there were quite some changes.

Cheers,
Andre.

 Documentation/devicetree/bindings/arm/sunxi.txt    |   1 +
 .../boot/dts/allwinner/sun50i-a64-clocks.dtsi      | 140 ++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 398 +++++++++++++++++++++
 3 files changed, 539 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-clocks.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi

diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
index 7e79fcc..7e59d8b 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.txt
+++ b/Documentation/devicetree/bindings/arm/sunxi.txt
@@ -14,3 +14,4 @@ using one of the following compatible strings:
   allwinner,sun8i-a83t
   allwinner,sun8i-h3
   allwinner,sun9i-a80
+  allwinner,sun50i-a64
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-clocks.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-clocks.dtsi
new file mode 100644
index 0000000..9bfcd41
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-clocks.dtsi
@@ -0,0 +1,140 @@
+/*
+ * Allwinner A64 clocks
+ *
+ * Copyright (c) 2016 ARM Ltd
+ *
+ * This file is licensed under a dual GPLv2 or BSD license.
+ *
+ */
+
+	osc24M: osc24M_clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "osc24M";
+	};
+
+	osc32k: osc32k_clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		clock-output-names = "osc32k";
+	};
+
+	periph0_2x: periph0_2x_clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <1200000000>;
+		clock-output-names = "periph0_2x";
+	};
+
+	periph0: periph0_clk {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clock-div = <2>;
+		clock-mult = <1>;
+		clocks = <&periph0_2x>;
+		clock-output-names = "periph0";
+	};
+
+	periph1: periph1_clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <600000000>;
+		clock-output-names = "periph1";
+	};
+
+	ahb1: ahb1_clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <200000000>;
+		clock-output-names = "ahb1";
+	};
+
+	ahb2: ahb2_clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <300000000>;
+		clock-output-names = "ahb2";
+	};
+
+	apb1: apb1_clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <100000000>;
+		clock-output-names = "apb1";
+	};
+
+	apb2: apb2_clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "apb2";
+	};
+
+	bus_gates: bus_gates_clk at 1c20060 {
+		#clock-cells = <1>;
+		compatible = "allwinner,sun50i-a64-bus-gates-clk",
+			     "allwinner,sunxi-multi-bus-gates-clk";
+		reg = <0x01c20060 0x14>;
+		ahb1_parent {
+			clocks = <&ahb1>;
+			clock-indices = <1>, <5>,
+					<6>, <8>,
+					<9>, <10>,
+					<13>, <14>,
+					<18>, <19>,
+					<20>, <21>,
+					<23>, <24>,
+					<25>, <28>,
+					<32>, <35>,
+					<36>, <37>,
+					<40>, <43>,
+					<44>, <52>,
+					<53>, <54>,
+					<135>;
+			clock-output-names = "bus_mipidsi", "bus_ce",
+					"bus_dma", "bus_mmc0",
+					"bus_mmc1", "bus_mmc2",
+					"bus_nand", "bus_sdram",
+					"bus_ts", "bus_hstimer",
+					"bus_spi0", "bus_spi1",
+					"bus_otg", "bus_otg_ehci0",
+					"bus_ehci0", "bus_otg_ohci0",
+					"bus_ve", "bus_lcd0",
+					"bus_lcd1", "bus_deint",
+					"bus_csi", "bus_hdmi",
+					"bus_de", "bus_gpu",
+					"bus_msgbox", "bus_spinlock",
+					"bus_dbg";
+		};
+		ahb2_parent {
+			clocks = <&ahb2>;
+			clock-indices = <17>, <29>;
+			clock-output-names = "bus_gmac", "bus_ohci0";
+		};
+		apb1_parent {
+			clocks = <&apb1>;
+			clock-indices = <64>, <65>,
+					<69>, <72>,
+					<76>, <77>,
+					<78>;
+			clock-output-names = "bus_codec", "bus_spdif",
+					"bus_pio", "bus_ths",
+					"bus_i2s0", "bus_i2s1",
+					"bus_i2s2";
+		};
+		abp2_parent {
+			clocks = <&apb2>;
+			clock-indices = <96>, <97>,
+					<98>, <101>,
+					<112>, <113>,
+					<114>, <115>,
+					<116>;
+			clock-output-names = "bus_i2c0", "bus_i2c1",
+					"bus_i2c2", "bus_scr",
+					"bus_uart0", "bus_uart1",
+					"bus_uart2", "bus_uart3",
+					"bus_uart4";
+		};
+	};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
new file mode 100644
index 0000000..70d0382
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -0,0 +1,398 @@
+/*
+ * Copyright (C) 2016 ARM Ltd.
+ * based on the Allwinner H3 dtsi:
+ *    Copyright (C) 2015 Jens Kuske <jenskuske@gmail.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pinctrl/sun4i-a10.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu at 1 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <1>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu at 2 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <2>;
+			enable-method = "psci";
+		};
+
+		cpu3: cpu at 3 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <3>;
+			enable-method = "psci";
+		};
+	};
+
+	pmu {
+			compatible = "arm,cortex-a53-pmu", "arm,armv8-pmuv3";
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-affinity = <&cpu0>,
+					     <&cpu1>,
+					     <&cpu2>,
+					     <&cpu3>;
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x40000000 0>;
+	};
+
+	gic: interrupt-controller at 1c81000 {
+		compatible = "arm,gic-400";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+
+		reg = <0x01c81000 0x1000>,
+		      <0x01c82000 0x2000>,
+		      <0x01c84000 0x2000>,
+		      <0x01c86000 0x2000>;
+		interrupts = <GIC_PPI 9
+		      (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 14
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 11
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 10
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	/include/ "sun50i-a64-clocks.dtsi"
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		pio: pinctrl at 1c20800 {
+			compatible = "allwinner,sun50i-a64-pinctrl";
+			reg = <0x01c20800 0x400>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bus_gates 69>;
+			gpio-controller;
+			#gpio-cells = <3>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			uart0_pins_a: uart0 at 0 {
+				allwinner,pins = "PB8", "PB9";
+				allwinner,function = "uart0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart0_pins_b: uart0 at 1 {
+				allwinner,pins = "PF2", "PF3";
+				allwinner,function = "uart0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart1_2pins: uart1_2 at 0 {
+				allwinner,pins = "PG6", "PG7";
+				allwinner,function = "uart1";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart1_4pins: uart1_4 at 0 {
+				allwinner,pins = "PG6", "PG7", "PG8", "PG9";
+				allwinner,function = "uart1";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart2_2pins: uart2_2 at 0 {
+				allwinner,pins = "PB0", "PB1";
+				allwinner,function = "uart2";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart2_4pins: uart2_4 at 0 {
+				allwinner,pins = "PB0", "PB1", "PB2", "PB3";
+				allwinner,function = "uart2";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart3_pins_a: uart3 at 0 {
+				allwinner,pins = "PD0", "PD1";
+				allwinner,function = "uart3";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart3_2pins_b: uart3_2 at 1 {
+				allwinner,pins = "PH4", "PH5";
+				allwinner,function = "uart3";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart3_4pins_b: uart3_4 at 1 {
+				allwinner,pins = "PH4", "PH5", "PH6", "PH7";
+				allwinner,function = "uart3";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart4_2pins: uart4_2 at 0 {
+				allwinner,pins = "PD2", "PD3";
+				allwinner,function = "uart4";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart4_4pins: uart4_4 at 0 {
+				allwinner,pins = "PD2", "PD3", "PD4", "PD5";
+				allwinner,function = "uart4";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			mmc0_pins: mmc0 at 0 {
+				allwinner,pins = "PF0", "PF1", "PF2", "PF3",
+						 "PF4", "PF5";
+				allwinner,function = "mmc0";
+				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			mmc0_default_cd_pin: mmc0_cd_pin at 0 {
+				allwinner,pins = "PF6";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+			};
+
+			mmc1_pins: mmc1 at 0 {
+				allwinner,pins = "PG0", "PG1", "PG2", "PG3",
+						 "PG4", "PG5";
+				allwinner,function = "mmc1";
+				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			mmc2_pins: mmc2 at 0 {
+				allwinner,pins = "PC1", "PC5", "PC6", "PC8",
+						 "PC9", "PC10", "PC11", "PC12",
+						 "PC13", "PC14", "PC15", "PC16";
+				allwinner,function = "mmc2";
+				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			i2c0_pins: i2c0_pins {
+				allwinner,pins = "PH0", "PH1";
+				allwinner,function = "i2c0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			i2c1_pins: i2c1_pins {
+				allwinner,pins = "PH2", "PH3";
+				allwinner,function = "i2c1";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			i2c2_pins: i2c2_pins {
+				allwinner,pins = "PE14", "PE15";
+				allwinner,function = "i2c2";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+		};
+
+		ahb_rst: reset at 1c202c0 {
+			#reset-cells = <1>;
+			compatible = "allwinner,sun6i-a31-clock-reset";
+			reg = <0x01c202c0 0xc>;
+		};
+
+		apb1_rst: reset at 1c202d0 {
+			#reset-cells = <1>;
+			compatible = "allwinner,sun6i-a31-clock-reset";
+			reg = <0x01c202d0 0x4>;
+		};
+
+		apb2_rst: reset at 1c202d8 {
+			#reset-cells = <1>;
+			compatible = "allwinner,sun6i-a31-clock-reset";
+			reg = <0x01c202d8 0x4>;
+		};
+
+		uart0: serial at 1c28000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28000 0x400>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&bus_gates 112>;
+			resets = <&apb2_rst 16>;
+			status = "disabled";
+		};
+
+		uart1: serial at 1c28400 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28400 0x400>;
+			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&bus_gates 113>;
+			resets = <&apb2_rst 17>;
+			status = "disabled";
+		};
+
+		uart2: serial at 1c28800 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28800 0x400>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&bus_gates 114>;
+			resets = <&apb2_rst 18>;
+			status = "disabled";
+		};
+
+		uart3: serial at 1c28c00 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28c00 0x400>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&bus_gates 115>;
+			resets = <&apb2_rst 19>;
+			status = "disabled";
+		};
+
+		uart4: serial at 1c29000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c29000 0x400>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&bus_gates 116>;
+			resets = <&apb2_rst 20>;
+			status = "disabled";
+		};
+
+		rtc: rtc at 1f00000 {
+			compatible = "allwinner,sun6i-a31-rtc";
+			reg = <0x01f00000 0x54>;
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		i2c0: i2c at 1c2ac00 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2ac00 0x400>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bus_gates 96>;
+			resets = <&apb2_rst 0>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c1: i2c at 1c2b000 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2b000 0x400>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bus_gates 97>;
+			resets = <&apb2_rst 1>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c2: i2c at 1c2b400 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2b400 0x400>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bus_gates 98>;
+			resets = <&apb2_rst 2>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
-- 
2.9.0
