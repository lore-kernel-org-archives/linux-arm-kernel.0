From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 28 Aug 2017 21:33:07 +0900
Subject: [PATCH] arm64: dts: uniphier: add PXs3 SoC support
Message-ID: <1503923587-1251-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial support for PXs3 SoC and its reference development board.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/Makefile             |   3 +-
 .../arm64/boot/dts/socionext/uniphier-pxs3-ref.dts |  62 ++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   | 367 +++++++++++++++++++++
 3 files changed, 431 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi

diff --git a/arch/arm64/boot/dts/socionext/Makefile b/arch/arm64/boot/dts/socionext/Makefile
index 4a13a3a97101..4bc091b365fd 100644
--- a/arch/arm64/boot/dts/socionext/Makefile
+++ b/arch/arm64/boot/dts/socionext/Makefile
@@ -2,7 +2,8 @@ dtb-$(CONFIG_ARCH_UNIPHIER) += \
 	uniphier-ld11-global.dtb \
 	uniphier-ld11-ref.dtb \
 	uniphier-ld20-global.dtb \
-	uniphier-ld20-ref.dtb
+	uniphier-ld20-ref.dtb \
+	uniphier-pxs3-ref.dtb
 
 always		:= $(dtb-y)
 clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
new file mode 100644
index 000000000000..d65f746a3f9d
--- /dev/null
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
@@ -0,0 +1,62 @@
+/*
+ * Device Tree Source for UniPhier PXs3 Reference Board
+ *
+ * Copyright (C) 2017 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/dts-v1/;
+#include "uniphier-pxs3.dtsi"
+#include "uniphier-support-card.dtsi"
+
+/ {
+	model = "UniPhier PXs3 Reference Board";
+	compatible = "socionext,uniphier-pxs3-ref", "socionext,uniphier-pxs3";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		serial2 = &serial2;
+		serial3 = &serial3;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c6 = &i2c6;
+	};
+
+	memory at 80000000 {
+		device_type = "memory";
+		reg = <0 0x80000000 0 0xa0000000>;
+	};
+};
+
+&ethsc {
+	interrupts = <0 52 4>;
+};
+
+&serial0 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
new file mode 100644
index 000000000000..384729fa740f
--- /dev/null
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -0,0 +1,367 @@
+/*
+ * Device Tree Source for UniPhier PXs3 SoC
+ *
+ * Copyright (C) 2017 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/memreserve/ 0x80000000 0x02000000;
+
+/ {
+	compatible = "socionext,uniphier-pxs3";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+				core2 {
+					cpu = <&cpu2>;
+				};
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+		};
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0 0x000>;
+			clocks = <&sys_clk 33>;
+			enable-method = "psci";
+			operating-points-v2 = <&cluster0_opp>;
+		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0 0x001>;
+			clocks = <&sys_clk 33>;
+			enable-method = "psci";
+			operating-points-v2 = <&cluster0_opp>;
+		};
+
+		cpu2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0 0x002>;
+			clocks = <&sys_clk 33>;
+			enable-method = "psci";
+			operating-points-v2 = <&cluster0_opp>;
+		};
+
+		cpu3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0 0x003>;
+			clocks = <&sys_clk 33>;
+			enable-method = "psci";
+			operating-points-v2 = <&cluster0_opp>;
+		};
+	};
+
+	cluster0_opp: opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-250000000 {
+			opp-hz = /bits/ 64 <250000000>;
+			clock-latency-ns = <300>;
+		};
+		opp-325000000 {
+			opp-hz = /bits/ 64 <325000000>;
+			clock-latency-ns = <300>;
+		};
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			clock-latency-ns = <300>;
+		};
+		opp-650000000 {
+			opp-hz = /bits/ 64 <650000000>;
+			clock-latency-ns = <300>;
+		};
+		opp-666667000 {
+			opp-hz = /bits/ 64 <666667000>;
+			clock-latency-ns = <300>;
+		};
+		opp-866667000 {
+			opp-hz = /bits/ 64 <866667000>;
+			clock-latency-ns = <300>;
+		};
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			clock-latency-ns = <300>;
+		};
+		opp-1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			clock-latency-ns = <300>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	clocks {
+		refclk: ref {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <25000000>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <1 13 4>,
+			     <1 14 4>,
+			     <1 11 4>,
+			     <1 10 4>;
+	};
+
+	soc at 0 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0xffffffff>;
+
+		serial0: serial at 54006800 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006800 0x40>;
+			interrupts = <0 33 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart0>;
+			clocks = <&peri_clk 0>;
+		};
+
+		serial1: serial at 54006900 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006900 0x40>;
+			interrupts = <0 35 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart1>;
+			clocks = <&peri_clk 1>;
+		};
+
+		serial2: serial at 54006a00 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006a00 0x40>;
+			interrupts = <0 37 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart2>;
+			clocks = <&peri_clk 2>;
+		};
+
+		serial3: serial at 54006b00 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006b00 0x40>;
+			interrupts = <0 177 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart3>;
+			clocks = <&peri_clk 3>;
+		};
+
+		i2c0: i2c at 58780000 {
+			compatible = "socionext,uniphier-fi2c";
+			status = "disabled";
+			reg = <0x58780000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0 41 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c0>;
+			clocks = <&peri_clk 4>;
+			clock-frequency = <100000>;
+		};
+
+		i2c1: i2c at 58781000 {
+			compatible = "socionext,uniphier-fi2c";
+			status = "disabled";
+			reg = <0x58781000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0 42 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c1>;
+			clocks = <&peri_clk 5>;
+			clock-frequency = <100000>;
+		};
+
+		i2c2: i2c at 58782000 {
+			compatible = "socionext,uniphier-fi2c";
+			status = "disabled";
+			reg = <0x58782000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0 43 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c2>;
+			clocks = <&peri_clk 6>;
+			clock-frequency = <100000>;
+		};
+
+		i2c3: i2c at 58783000 {
+			compatible = "socionext,uniphier-fi2c";
+			status = "disabled";
+			reg = <0x58783000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0 44 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c3>;
+			clocks = <&peri_clk 7>;
+			clock-frequency = <100000>;
+		};
+
+		/* chip-internal connection for HDMI */
+		i2c6: i2c at 58786000 {
+			compatible = "socionext,uniphier-fi2c";
+			reg = <0x58786000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0 26 4>;
+			clocks = <&peri_clk 10>;
+			clock-frequency = <400000>;
+		};
+
+		system_bus: system-bus at 58c00000 {
+			compatible = "socionext,uniphier-system-bus";
+			status = "disabled";
+			reg = <0x58c00000 0x400>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_system_bus>;
+		};
+
+		smpctrl at 59801000 {
+			compatible = "socionext,uniphier-smpctrl";
+			reg = <0x59801000 0x400>;
+		};
+
+		sdctrl at 59810000 {
+			compatible = "socionext,uniphier-pxs3-sdctrl",
+				     "simple-mfd", "syscon";
+			reg = <0x59810000 0x400>;
+
+			sd_clk: clock {
+				compatible = "socionext,uniphier-pxs3-sd-clock";
+				#clock-cells = <1>;
+			};
+
+			sd_rst: reset {
+				compatible = "socionext,uniphier-pxs3-sd-reset";
+				#reset-cells = <1>;
+			};
+		};
+
+		perictrl at 59820000 {
+			compatible = "socionext,uniphier-pxs3-perictrl",
+				     "simple-mfd", "syscon";
+			reg = <0x59820000 0x200>;
+
+			peri_clk: clock {
+				compatible = "socionext,uniphier-pxs3-peri-clock";
+				#clock-cells = <1>;
+			};
+
+			peri_rst: reset {
+				compatible = "socionext,uniphier-pxs3-peri-reset";
+				#reset-cells = <1>;
+			};
+		};
+
+		emmc: sdhc at 5a000000 {
+			compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
+			reg = <0x5a000000 0x400>;
+			interrupts = <0 78 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_emmc>;
+			clocks = <&sys_clk 4>;
+			bus-width = <8>;
+			mmc-ddr-1_8v;
+			mmc-hs200-1_8v;
+			cdns,phy-input-delay-legacy = <4>;
+			cdns,phy-input-delay-mmc-highspeed = <2>;
+			cdns,phy-input-delay-mmc-ddr = <3>;
+			cdns,phy-dll-delay-sdclk = <21>;
+			cdns,phy-dll-delay-sdclk-hsmmc = <21>;
+		};
+
+		soc-glue at 5f800000 {
+			compatible = "socionext,uniphier-pxs3-soc-glue",
+				     "simple-mfd", "syscon";
+			reg = <0x5f800000 0x2000>;
+
+			pinctrl: pinctrl {
+				compatible = "socionext,uniphier-pxs3-pinctrl";
+			};
+		};
+
+		aidet: aidet at 5fc20000 {
+			compatible = "socionext,uniphier-pxs3-aidet";
+			reg = <0x5fc20000 0x200>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gic: interrupt-controller at 5fe00000 {
+			compatible = "arm,gic-v3";
+			reg = <0x5fe00000 0x10000>,	/* GICD */
+			      <0x5fe80000 0x80000>;	/* GICR */
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			interrupts = <1 9 4>;
+		};
+
+		sysctrl at 61840000 {
+			compatible = "socionext,uniphier-pxs3-sysctrl",
+				     "simple-mfd", "syscon";
+			reg = <0x61840000 0x10000>;
+
+			sys_clk: clock {
+				compatible = "socionext,uniphier-pxs3-clock";
+				#clock-cells = <1>;
+			};
+
+			sys_rst: reset {
+				compatible = "socionext,uniphier-pxs3-reset";
+				#reset-cells = <1>;
+			};
+
+			watchdog {
+				compatible = "socionext,uniphier-wdt";
+			};
+		};
+
+		nand: nand at 68000000 {
+			compatible = "socionext,uniphier-denali-nand-v5b";
+			status = "disabled";
+			reg-names = "nand_data", "denali_reg";
+			reg = <0x68000000 0x20>, <0x68100000 0x1000>;
+			interrupts = <0 65 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_nand>;
+			clocks = <&sys_clk 2>;
+		};
+	};
+};
+
+#include "uniphier-pinctrl.dtsi"
-- 
2.7.4
