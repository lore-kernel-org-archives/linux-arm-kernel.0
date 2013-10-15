From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 15 Oct 2013 13:01:02 +0200
Subject: [PATCH 4/5] ARM: rockchip: add support for rk3188 and Radxa Rock board
In-Reply-To: <201310151258.53435.heiko@sntech.de>
References: <201310151258.53435.heiko@sntech.de>
Message-ID: <201310151301.02290.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Basic devicetree files for the rk3188 SoC. Also provided is a board
dts file for the upcoming Radxa Rock board using this SoC.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3188-clocks.dtsi   |  289 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3188-radxarock.dts |   80 +++++++++
 arch/arm/boot/dts/rk3188.dtsi          |  253 ++++++++++++++++++++++++++++
 3 files changed, 622 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3188-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/rk3188-radxarock.dts
 create mode 100644 arch/arm/boot/dts/rk3188.dtsi

diff --git a/arch/arm/boot/dts/rk3188-clocks.dtsi b/arch/arm/boot/dts/rk3188-clocks.dtsi
new file mode 100644
index 0000000..b1b92dc
--- /dev/null
+++ b/arch/arm/boot/dts/rk3188-clocks.dtsi
@@ -0,0 +1,289 @@
+/*
+ * Copyright (c) 2013 MundoReader S.L.
+ * Author: Heiko Stuebner <heiko@sntech.de>
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
+ */
+
+/ {
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		/*
+		 * This is a dummy clock, to be used as placeholder on
+		 * other mux clocks when a specific parent clock is not
+		 * yet implemented. It should be dropped when the driver
+		 * is complete.
+		 */
+		dummy: dummy {
+			compatible = "fixed-clock";
+			clock-frequency = <0>;
+			#clock-cells = <0>;
+		};
+
+		xin24m: xin24m {
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+			#clock-cells = <0>;
+		};
+
+		dummy48m: dummy48m {
+			compatible = "fixed-clock";
+			clock-frequency = <48000000>;
+			#clock-cells = <0>;
+		};
+
+		dummy150m: dummy150m {
+			compatible = "fixed-clock";
+			clock-frequency = <150000000>;
+			#clock-cells = <0>;
+		};
+
+		clk_gates0: gate-clk at 200000d0 {
+			compatible = "rockchip,rk2928-gate-clk";
+			reg = <0x200000d0 0x4>;
+			clocks = <&dummy150m>, <&dummy>,
+				 <&dummy>, <&dummy>,
+				 <&dummy>, <&dummy>,
+				 <&dummy>, <&dummy>,
+				 <&dummy>, <&dummy>,
+				 <&dummy>, <&dummy>,
+				 <&dummy>, <&dummy>,
+				 <&dummy>, <&dummy>;
+
+			clock-output-names =
+				"gate_core_periph", "gate_cpu_gpll",
+				"gate_ddrphy", "gate_aclk_cpu",
+				"gate_hclk_cpu", "gate_pclk_cpu",
+				"gate_atclk_cpu", "gate_aclk_core",
+				"reserved", "gate_i2s0",
+				"gate_i2s0_frac", "reserved",
+				"reserved", "gate_spdif",
+				"gate_spdif_frac", "gate_testclk";
+
+			#clock-cells = <1>;
+		};
+
+		clk_gates1: gate-clk at 200000d4 {
+			compatible = "rockchip,rk2928-gate-clk";
+			reg = <0x200000d4 0x4>;
+			clocks = <&xin24m>, <&xin24m>,
+				 <&xin24m>, <&dummy>,
+				 <&dummy>, <&xin24m>,
+				 <&xin24m>, <&dummy>,
+				 <&xin24m>, <&dummy>,
+				 <&xin24m>, <&dummy>,
+				 <&xin24m>, <&dummy>,
+				 <&xin24m>, <&dummy>;
+
+			clock-output-names =
+				"gate_timer0", "gate_timer1",
+				"gate_timer3", "gate_jtag",
+				"gate_aclk_lcdc1_src", "gate_otgphy0",
+				"gate_otgphy1", "gate_ddr_gpll",
+				"gate_uart0", "gate_frac_uart0",
+				"gate_uart1", "gate_frac_uart1",
+				"gate_uart2", "gate_frac_uart2",
+				"gate_uart3", "gate_frac_uart3";
+
+			#clock-cells = <1>;
+		};
+
+		clk_gates2: gate-clk at 200000d8 {
+			compatible = "rockchip,rk2928-gate-clk";
+			reg = <0x200000d8 0x4>;
+			clocks = <&clk_gates2 1>, <&dummy>,
+				 <&dummy>, <&dummy>,
+				 <&dummy>, <&dummy>,
+				 <&clk_gates2 3>, <&dummy>,
+				 <&dummy>, <&dummy>,
+				 <&dummy>, <&dummy48m>,
+				 <&dummy>, <&dummy48m>,
+				 <&dummy>, <&dummy>;
+
+			clock-output-names =
+				"gate_periph_src", "gate_aclk_periph",
+				"gate_hclk_periph", "gate_pclk_periph",
+				"gate_smc", "gate_mac",
+				"gate_hsadc", "gate_hsadc_frac",
+				"gate_saradc", "gate_spi0",
+				"gate_spi1", "gate_mmc0",
+				"gate_mac_lbtest", "gate_mmc1",
+				"gate_emmc", "reserved";
+
+			#clock-cells = <1>;
+		};
+
+		clk_gates3: gate-clk at 200000dc {
+			compatible = "rockchip,rk2928-gate-clk";
+			reg = <0x200000dc 0x4>;
+			clocks = <&dummy>, <&dummy>,
+				 <&dummy>, <&dummy>,
+				 <&xin24m>, <&xin24m>,
+				 <&dummy>, <&dummy>,
+				 <&xin24m>, <&dummy>,
+				 <&dummy>, <&dummy>,
+				 <&dummy>, <&dummy>,
+				 <&xin24m>, <&dummy>;
+
+			clock-output-names =
+				"gate_aclk_lcdc0_src", "gate_dclk_lcdc0",
+				"gate_dclk_lcdc1", "gate_pclkin_cif0",
+				"gate_timer2", "gate_timer4",
+				"gate_hsicphy", "gate_cif0_out",
+				"gate_timer5", "gate_aclk_vepu",
+				"gate_hclk_vepu", "gate_aclk_vdpu",
+				"gate_hclk_vdpu", "reserved",
+				"gate_timer6", "gate_aclk_gpu_src";
+
+			#clock-cells = <1>;
+		};
+
+		clk_gates4: gate-clk at 200000e0 {
+			compatible = "rockchip,rk2928-gate-clk";
+			reg = <0x200000e0 0x4>;
+			clocks = <&clk_gates2 2>, <&clk_gates2 3>,
+				 <&clk_gates2 1>, <&clk_gates2 1>,
+				 <&clk_gates2 1>, <&clk_gates2 2>,
+				 <&clk_gates2 2>, <&clk_gates2 2>,
+				 <&clk_gates0 4>, <&clk_gates0 4>,
+				 <&clk_gates0 3>, <&dummy>,
+				 <&clk_gates0 3>, <&dummy>,
+				 <&dummy>, <&dummy>;
+
+			clock-output-names =
+				"gate_hclk_peri_axi_matrix", "gate_pclk_peri_axi_matrix",
+				"gate_aclk_cpu_peri", "gate_aclk_peri_axi_matrix",
+				"gate_aclk_pei_niu", "gate_hclk_usb_peri",
+				"gate_hclk_peri_ahb_arbi", "gate_hclk_emem_peri",
+				"gate_hclk_cpubus", "gate_hclk_ahb2apb",
+				"gate_aclk_strc_sys", "reserved",
+				"gate_aclk_intmem", "reserved",
+				"gate_hclk_imem1", "gate_hclk_imem0";
+
+			#clock-cells = <1>;
+		};
+
+		clk_gates5: gate-clk at 200000e4 {
+			compatible = "rockchip,rk2928-gate-clk";
+			reg = <0x200000e4 0x4>;
+			clocks = <&clk_gates0 3>, <&clk_gates2 1>,
+				 <&clk_gates0 5>, <&clk_gates0 5>,
+				 <&clk_gates0 5>, <&clk_gates0 5>,
+				 <&clk_gates0 4>, <&clk_gates0 5>,
+				 <&clk_gates2 1>, <&clk_gates2 2>,
+				 <&clk_gates2 2>, <&clk_gates2 2>,
+				 <&clk_gates2 2>, <&clk_gates4 5>;
+
+			clock-output-names =
+				"gate_aclk_dmac1", "gate_aclk_dmac2",
+				"gate_pclk_efuse", "gate_pclk_tzpc",
+				"gate_pclk_grf", "gate_pclk_pmu",
+				"gate_hclk_rom", "gate_pclk_ddrupctl",
+				"gate_aclk_smc", "gate_hclk_nandc",
+				"gate_hclk_mmc0", "gate_hclk_mmc1",
+				"gate_hclk_emmc", "gate_hclk_otg0";
+
+			#clock-cells = <1>;
+		};
+
+		clk_gates6: gate-clk at 200000e8 {
+			compatible = "rockchip,rk2928-gate-clk";
+			reg = <0x200000e8 0x4>;
+			clocks = <&clk_gates3 0>, <&clk_gates0 4>,
+				 <&clk_gates0 4>, <&clk_gates1 4>,
+				 <&clk_gates0 4>, <&clk_gates3 0>,
+				 <&dummy>, <&dummy>,
+				 <&clk_gates3 0>, <&clk_gates0 4>,
+				 <&clk_gates0 4>, <&clk_gates1 4>,
+				 <&clk_gates0 4>, <&clk_gates3 0>;
+
+			clock-output-names =
+				"gate_aclk_lcdc0", "gate_hclk_lcdc0",
+				"gate_hclk_lcdc1", "gate_aclk_lcdc1",
+				"gate_hclk_cif0", "gate_aclk_cif0",
+				"reserved", "reserved",
+				"gate_aclk_ipp", "gate_hclk_ipp",
+				"gate_hclk_rga", "gate_aclk_rga",
+				"gate_hclk_vio_bus", "gate_aclk_vio0";
+
+			#clock-cells = <1>;
+		};
+
+		clk_gates7: gate-clk at 200000ec {
+			compatible = "rockchip,rk2928-gate-clk";
+			reg = <0x200000ec 0x4>;
+			clocks = <&clk_gates2 2>, <&clk_gates0 4>,
+				 <&clk_gates0 4>, <&dummy>,
+				 <&dummy>, <&clk_gates2 2>,
+				 <&clk_gates2 2>, <&clk_gates0 5>,
+				 <&dummy>, <&clk_gates0 5>,
+				 <&clk_gates0 5>, <&clk_gates2 3>,
+				 <&clk_gates2 3>, <&clk_gates2 3>,
+				 <&clk_gates2 3>, <&clk_gates2 3>;
+
+			clock-output-names =
+				"gate_hclk_emac", "gate_hclk_spdif",
+				"gate_hclk_i2s0_2ch", "gate_hclk_otg1",
+				"gate_hclk_hsic", "gate_hclk_hsadc",
+				"gate_hclk_pidf", "gate_pclk_timer0",
+				"reserved", "gate_pclk_timer2",
+				"gate_pclk_pwm01", "gate_pclk_pwm23",
+				"gate_pclk_spi0", "gate_pclk_spi1",
+				"gate_pclk_saradc", "gate_pclk_wdt";
+
+			#clock-cells = <1>;
+		};
+
+		clk_gates8: gate-clk at 200000f0 {
+			compatible = "rockchip,rk2928-gate-clk";
+			reg = <0x200000f0 0x4>;
+			clocks = <&clk_gates0 5>, <&clk_gates0 5>,
+				 <&clk_gates2 3>, <&clk_gates2 3>,
+				 <&clk_gates0 5>, <&clk_gates0 5>,
+				 <&clk_gates2 3>, <&clk_gates2 3>,
+				 <&clk_gates2 3>, <&clk_gates0 5>,
+				 <&clk_gates0 5>, <&clk_gates0 5>,
+				 <&clk_gates2 3>, <&dummy>;
+
+			clock-output-names =
+				"gate_pclk_uart0", "gate_pclk_uart1",
+				"gate_pclk_uart2", "gate_pclk_uart3",
+				"gate_pclk_i2c0", "gate_pclk_i2c1",
+				"gate_pclk_i2c2", "gate_pclk_i2c3",
+				"gate_pclk_i2c4", "gate_pclk_gpio0",
+				"gate_pclk_gpio1", "gate_pclk_gpio2",
+				"gate_pclk_gpio3", "gate_aclk_gps";
+
+			#clock-cells = <1>;
+		};
+
+		clk_gates9: gate-clk at 200000f4 {
+			compatible = "rockchip,rk2928-gate-clk";
+			reg = <0x200000f4 0x4>;
+			clocks = <&dummy>, <&dummy>,
+				 <&dummy>, <&dummy>,
+				 <&dummy>, <&dummy>,
+				 <&dummy>, <&dummy>;
+
+			clock-output-names =
+				"gate_clk_core_dbg", "gate_pclk_dbg",
+				"gate_clk_trace", "gate_atclk",
+				"gate_clk_l2c", "gate_aclk_vio1",
+				"gate_pclk_publ", "gate_aclk_gpu";
+
+			#clock-cells = <1>;
+		};
+	};
+
+};
diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
new file mode 100644
index 0000000..3ba1968
--- /dev/null
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -0,0 +1,80 @@
+/*
+ * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
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
+ */
+
+/dts-v1/;
+#include "rk3188.dtsi"
+
+/ {
+	model = "Radxa Rock";
+
+	memory {
+		reg = <0x60000000 0x80000000>;
+	};
+
+	soc {
+		uart0: serial at 10124000 {
+			status = "okay";
+		};
+
+		uart1: serial at 10126000 {
+			status = "okay";
+		};
+
+		uart2: serial at 20064000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart2_xfer>;
+			status = "okay";
+		};
+
+		uart3: serial at 20068000 {
+			status = "okay";
+		};
+
+		gpio-keys {
+			compatible = "gpio-keys";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			autorepeat;
+
+			button at 0 {
+				gpios = <&gpio0 4 GPIO_ACTIVE_LOW>;
+				linux,code = <116>;
+				label = "GPIO Key Power";
+				linux,input-type = <1>;
+				gpio-key,wakeup = <1>;
+				debounce-interval = <100>;
+			};
+		};
+
+		gpio-leds {
+			compatible = "gpio-leds";
+
+			green {
+				gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
+				default-state = "off";
+			};
+
+			yellow {
+				gpios = <&gpio0 14 GPIO_ACTIVE_LOW>;
+				default-state = "off";
+			};
+
+			sleep {
+				gpios = <&gpio0 15 0>;
+				default-state = "off";
+			};
+		};
+
+	};
+};
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
new file mode 100644
index 0000000..1a26b03
--- /dev/null
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -0,0 +1,253 @@
+/*
+ * Copyright (c) 2013 MundoReader S.L.
+ * Author: Heiko Stuebner <heiko@sntech.de>
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
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include "rk3xxx.dtsi"
+#include "rk3188-clocks.dtsi"
+
+/ {
+	compatible = "rockchip,rk3188";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
+			reg = <0x0>;
+		};
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
+			reg = <0x1>;
+		};
+		cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
+			reg = <0x2>;
+		};
+		cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
+			reg = <0x3>;
+		};
+	};
+
+	soc {
+		global-timer at 1013c200 {
+			interrupts = <GIC_PPI 11 0xf04>;
+		};
+
+		local-timer at 1013c600 {
+			interrupts = <GIC_PPI 13 0xf04>;
+		};
+
+		pinctrl at 20008000 {
+			compatible = "rockchip,rk3188-pinctrl";
+			reg = <0x20008000 0xa0>,
+			      <0x20008164 0x1a0>;
+			reg-names = "base", "pull";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			gpio0: gpio0 at 0x2000a000 {
+				compatible = "rockchip,rk3188-gpio-bank0";
+				reg = <0x2000a000 0x100>,
+				      <0x20004064 0x8>;
+				interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk_gates8 9>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpio1: gpio1 at 0x2003c000 {
+				compatible = "rockchip,gpio-bank";
+				reg = <0x2003c000 0x100>;
+				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk_gates8 10>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpio2: gpio2 at 2003e000 {
+				compatible = "rockchip,gpio-bank";
+				reg = <0x2003e000 0x100>;
+				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk_gates8 11>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpio3: gpio3 at 20080000 {
+				compatible = "rockchip,gpio-bank";
+				reg = <0x20080000 0x100>;
+				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk_gates8 12>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			pcfg_pull_up: pcfg_pull_up {
+				bias-pull-up;
+			};
+
+			pcfg_pull_down: pcfg_pull_down {
+				bias-pull-down;
+			};
+
+			pcfg_pull_none: pcfg_pull_none {
+				bias-disable;
+			};
+
+			uart0 {
+				uart0_xfer: uart0-xfer {
+					rockchip,pins = <RK_GPIO1 0 RK_FUNC_1 &pcfg_pull_none>,
+							<RK_GPIO1 1 RK_FUNC_1 &pcfg_pull_none>;
+				};
+
+				uart0_cts: uart0-cts {
+					rockchip,pins = <RK_GPIO1 2 RK_FUNC_1 &pcfg_pull_none>;
+				};
+
+				uart0_rts: uart0-rts {
+					rockchip,pins = <RK_GPIO1 3 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
+
+			uart1 {
+				uart1_xfer: uart1-xfer {
+					rockchip,pins = <RK_GPIO1 4 RK_FUNC_1 &pcfg_pull_none>,
+							<RK_GPIO1 5 RK_FUNC_1 &pcfg_pull_none>;
+				};
+
+				uart1_cts: uart1-cts {
+					rockchip,pins = <RK_GPIO1 6 RK_FUNC_1 &pcfg_pull_none>;
+				};
+
+				uart1_rts: uart1-rts {
+					rockchip,pins = <RK_GPIO1 7 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
+
+			uart2 {
+				uart2_xfer: uart2-xfer {
+					rockchip,pins = <RK_GPIO1 8 RK_FUNC_1 &pcfg_pull_none>,
+							<RK_GPIO1 9 RK_FUNC_1 &pcfg_pull_none>;
+				};
+				/* no rts / cts for uart2 */
+			};
+
+			uart3 {
+				uart3_xfer: uart3-xfer {
+					rockchip,pins = <RK_GPIO1 10 RK_FUNC_1 &pcfg_pull_none>,
+							<RK_GPIO1 11 RK_FUNC_1 &pcfg_pull_none>;
+				};
+
+				uart3_cts: uart3-cts {
+					rockchip,pins = <RK_GPIO1 12 RK_FUNC_1 &pcfg_pull_none>;
+				};
+
+				uart3_rts: uart3-rts {
+					rockchip,pins = <RK_GPIO1 13 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
+
+			sd0 {
+				sd0_clk: sd0-clk {
+					rockchip,pins = <RK_GPIO3 2 RK_FUNC_1 &pcfg_pull_none>;
+				};
+
+				sd0_cmd: sd0-cmd {
+					rockchip,pins = <RK_GPIO3 3 RK_FUNC_1 &pcfg_pull_none>;
+				};
+
+				sd0_cd: sd0-cd {
+					rockchip,pins = <RK_GPIO3 8 RK_FUNC_1 &pcfg_pull_none>;
+				};
+
+				sd0_wp: sd0-wp {
+					rockchip,pins = <RK_GPIO3 9 RK_FUNC_1 &pcfg_pull_none>;
+				};
+
+				sd0_pwr: sd0-pwr {
+					rockchip,pins = <RK_GPIO3 1 RK_FUNC_1 &pcfg_pull_none>;
+				};
+
+				sd0_bus1: sd0-bus-width1 {
+					rockchip,pins = <RK_GPIO3 4 RK_FUNC_1 &pcfg_pull_none>;
+				};
+
+				sd0_bus4: sd0-bus-width4 {
+					rockchip,pins = <RK_GPIO3 4 RK_FUNC_1 &pcfg_pull_none>,
+							<RK_GPIO3 5 RK_FUNC_1 &pcfg_pull_none>,
+							<RK_GPIO3 6 RK_FUNC_1 &pcfg_pull_none>,
+							<RK_GPIO3 7 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
+
+			sd1 {
+				sd1_clk: sd1-clk {
+					rockchip,pins = <RK_GPIO3 21 RK_FUNC_1 &pcfg_pull_none>;
+				};
+
+				sd1_cmd: sd1-cmd {
+					rockchip,pins = <RK_GPIO3 16 RK_FUNC_1 &pcfg_pull_none>;
+				};
+
+				sd1_cd: sd1-cd {
+					rockchip,pins = <RK_GPIO3 22 RK_FUNC_1 &pcfg_pull_none>;
+				};
+
+				sd1_wp: sd1-wp {
+					rockchip,pins = <RK_GPIO3 23 RK_FUNC_1 &pcfg_pull_none>;
+				};
+
+				sd1_bus1: sd1-bus-width1 {
+					rockchip,pins = <RK_GPIO3 17 RK_FUNC_1 &pcfg_pull_none>;
+				};
+
+				sd1_bus4: sd1-bus-width4 {
+					rockchip,pins = <RK_GPIO3 17 RK_FUNC_1 &pcfg_pull_none>,
+							<RK_GPIO3 18 RK_FUNC_1 &pcfg_pull_none>,
+							<RK_GPIO3 19 RK_FUNC_1 &pcfg_pull_none>,
+							<RK_GPIO3 20 RK_FUNC_1 &pcfg_pull_none>;
+				};
+			};
+		};
+	};
+};
-- 
1.7.10.4
