From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 20 Aug 2013 10:31:07 +0800
Subject: [PATCH v7 05/11] ARM: dts: enable hi4511 with device tree
In-Reply-To: <1376965873-14431-1-git-send-email-haojian.zhuang@linaro.org>
References: <1376965873-14431-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1376965873-14431-6-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Hisilicon Hi4511 development platform with device tree support.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/boot/dts/Makefile    |    1 +
 arch/arm/boot/dts/hi3620.dtsi | 1645 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/hi4511.dts  |  648 ++++++++++++++++
 3 files changed, 2294 insertions(+)
 create mode 100644 arch/arm/boot/dts/hi3620.dtsi
 create mode 100644 arch/arm/boot/dts/hi4511.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ada589c..a93bcfe 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -64,6 +64,7 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
 	exynos5420-smdk5420.dtb \
 	exynos5440-sd5v1.dtb \
 	exynos5440-ssdk5440.dtb
+dtb-$(CONFIG_ARCH_HI3xxx) += hi4511.dtb
 dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
 	ecx-2000.dtb
 dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dtsi
new file mode 100644
index 0000000..39fa37f
--- /dev/null
+++ b/arch/arm/boot/dts/hi3620.dtsi
@@ -0,0 +1,1645 @@
+/*
+ * Hisilicon Ltd. Hi3620 SoC
+ *
+ * Copyright (C) 2012-2013 Hisilicon Ltd.
+ * Copyright (C) 2012-2013 Linaro Ltd.
+ *
+ * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x0>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	osc32k: osc32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "osc32khz";
+	};
+	osc26m: osc26m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "osc26mhz";
+	};
+	pclk: pclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "apb_pclk";
+	};
+	pll_arm0: pll_arm0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1600000000>;
+		clock-output-names = "armpll0";
+	};
+	pll_arm1: pll_arm1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1600000000>;
+		clock-output-names = "armpll1";
+	};
+	pll_peri: pll_peri {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1440000000>;
+		clock-output-names = "armpll2";
+	};
+	pll_usb: pll_usb {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1440000000>;
+		clock-output-names = "armpll3";
+	};
+	pll_hdmi: pll_hdmi {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1188000000>;
+		clock-output-names = "armpll4";
+	};
+	pll_gpu: pll_gpu {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1300000000>;
+		clock-output-names = "armpll5";
+	};
+	rclk_tcxo: rclk_tcxo {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&osc26m>;
+		clock-output-names = "rclk_tcxo";
+		clock-mult = <1>;
+		clock-div = <4>;
+	};
+	rclk_cfgaxi: rclk_cfgaxi {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&pll_peri>;
+		clock-output-names = "rclk_cfgaxi";
+		clock-mult = <1>;
+		clock-div = <30>;
+	};
+	rclk_pico: rclk_pico {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&hsic_div>;
+		clock-output-names = "rclk_pico";
+		clock-mult = <1>;
+		clock-div = <40>;
+	};
+
+	amba {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "arm,amba-bus";
+		interrupt-parent = <&gic>;
+		ranges;
+
+		pmctrl: pmctrl at fca08000 {
+			compatible = "hisilicon,pmctrl";
+			reg = <0xfca08000 0x1000>;
+		};
+
+		sctrl: sctrl at fc802000 {
+			compatible = "hisilicon,sctrl";
+			reg = <0xfc802000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+
+			timer0_mux: timer0_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&osc32k &timerclk01>;
+				clock-output-names = "timer0_mux";
+				reg = <0>;
+				clkmux-mask = <0x8000>;
+				clkmux-table = <0 0x8000>;
+			};
+			timer1_mux: timer1_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&osc32k &timerclk01>;
+				clock-output-names = "timer1_mux";
+				reg = <0>;
+				clkmux-mask = <0x20000>;
+				clkmux-table = <0 0x20000>;
+			};
+			timer2_mux: timer2_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&osc32k &timerclk23>;
+				clock-output-names = "timer2_mux";
+				reg = <0>;
+				clkmux-mask = <0x80000>;
+				clkmux-table = <0 0x80000>;
+			};
+			timer3_mux: timer3_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&osc32k &timerclk23>;
+				clock-output-names = "timer3_mux";
+				reg = <0>;
+				clkmux-mask = <0x200000>;
+				clkmux-table = <0 0x200000>;
+			};
+			timer4_mux: timer4_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&osc32k &timerclk45>;
+				clock-output-names = "timer4_mux";
+				reg = <0x18>;
+				clkmux-mask = <0x1>;
+				clkmux-table = <0 0x1>;
+			};
+			timer5_mux: timer5_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&osc32k &timerclk45>;
+				clock-output-names = "timer5_mux";
+				reg = <0x18>;
+				clkmux-mask = <0x4>;
+				clkmux-table = <0 0x4>;
+			};
+			timer6_mux: timer6_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&osc32k &timerclk67>;
+				clock-output-names = "timer6_mux";
+				reg = <0x18>;
+				clkmux-mask = <0x10>;
+				clkmux-table = <0 0x10>;
+			};
+			timer7_mux: timer7_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&osc32k &timerclk67>;
+				clock-output-names = "timer7_mux";
+				reg = <0x18>;
+				clkmux-mask = <0x40>;
+				clkmux-table = <0 0x40>;
+			};
+			timer8_mux: timer8_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&osc32k &timerclk89>;
+				clock-output-names = "timer8_mux";
+				reg = <0x18>;
+				clkmux-mask = <0x100>;
+				clkmux-table = <0 0x100>;
+			};
+			timer9_mux: timer9_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&osc32k &timerclk89>;
+				clock-output-names = "timer9_mux";
+				reg = <0x18>;
+				clkmux-mask = <0x400>;
+				clkmux-table = <0 0x400>;
+			};
+			uart0_mux: uart0_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&osc26m &pclk>;
+				clock-output-names = "uart0_mux";
+				reg = <0x100>;
+				clkmux-mask = <0x80>;
+				/* each item value */
+				clkmux-table = <0 0x80>;
+				clkmux-hiword-mask;
+			};
+			uart1_mux: uart1_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&osc26m &pclk>;
+				clock-output-names = "uart1_mux";
+				reg = <0x100>;
+				clkmux-mask = <0x100>;
+				clkmux-table = <0x0 0x100>;
+				clkmux-hiword-mask;
+			};
+			uart2_mux: uart2_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&osc26m &pclk>;
+				clock-output-names = "uart2_mux";
+				reg = <0x100>;
+				clkmux-mask = <0x200>;
+				clkmux-table = <0 0x200>;
+				clkmux-hiword-mask;
+			};
+			uart3_mux: uart3_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&osc26m &pclk>;
+				clock-output-names = "uart3_mux";
+				reg = <0x100>;
+				clkmux-mask = <0x400>;
+				clkmux-table = <0 0x400>;
+				clkmux-hiword-mask;
+			};
+			uart4_mux: uart4_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&osc26m &pclk>;
+				clock-output-names = "uart4_mux";
+				reg = <0x100>;
+				clkmux-mask = <0x800>;
+				clkmux-table = <0 0x800>;
+				clkmux-hiword-mask;
+			};
+			spi0_mux: spi0_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&osc26m &rclk_cfgaxi>;
+				clock-output-names = "spi0_mux";
+				reg = <0x100>;
+				clkmux-mask = <0x1000>;
+				clkmux-table = <0 0x1000>;
+				clkmux-hiword-mask;
+			};
+			spi1_mux: spi1_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&osc26m &rclk_cfgaxi>;
+				clock-output-names = "spi1_mux";
+				reg = <0x100>;
+				clkmux-mask = <0x2000>;
+				clkmux-table = <0 0x2000>;
+				clkmux-hiword-mask;
+			};
+			spi2_mux: spi2_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&osc26m &rclk_cfgaxi>;
+				clock-output-names = "spi2_mux";
+				reg = <0x100>;
+				clkmux-mask = <0x4000>;
+				clkmux-table = <0 0x4000>;
+				clkmux-hiword-mask;
+			};
+			rclk_shareAXI: rclk_shareAXI {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&pll_usb &pll_peri>;
+				clock-output-names = "rclk_shareAXI";
+				reg = <0x100>;
+				clkmux-mask = <0x8000>;
+				clkmux-table = <0 0x8000>;
+				clkmux-hiword-mask;
+			};
+			pwm0_mux: pwm0_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&osc32k &osc26m>;
+				clock-output-names = "pwm0_mux";
+				reg = <0x104>;
+				clkmux-mask = <0x400>;
+				clkmux-table = <0 0x400>;
+				clkmux-hiword-mask;
+			};
+			pwm1_mux: pwm1_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&osc32k &osc26m>;
+				clock-output-names = "pwm1_mux";
+				reg = <0x104>;
+				clkmux-mask = <0x800>;
+				clkmux-table = <0 0x800>;
+				clkmux-hiword-mask;
+			};
+			sd_mux: sd_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&pll_usb &pll_peri>;
+				clock-output-names = "sd_mux";
+				reg = <0x108>;
+				clkmux-mask = <0x10>;
+				clkmux-table = <0 0x10>;
+				clkmux-hiword-mask;
+			};
+			mmc1_mux: mmc1_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&pll_usb &pll_peri>;
+				clock-output-names = "mmc1_mux";
+				reg = <0x108>;
+				clkmux-mask = <0x200>;
+				clkmux-table = <0 0x200>;
+				clkmux-hiword-mask;
+			};
+			rclk_mmc1_mux: rclk_mmc1_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&osc26m &mmc1_div>;
+				clock-output-names = "rclk_mmc1_mux";
+				reg = <0x108>;
+				clkmux-mask = <0x400>;
+				clkmux-table = <0 0x400>;
+				clkmux-hiword-mask;
+			};
+			g2d_mux: g2d_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&pll_peri &pll_usb>;
+				clock-output-names = "g2d_mux";
+				reg = <0x10c>;
+				clkmux-mask = <0x20>;
+				clkmux-table = <0 0x20>;
+				clkmux-hiword-mask;
+			};
+			venc_mux: venc_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&pll_peri &pll_usb>;
+				clock-output-names = "venc_mux";
+				reg = <0x10c>;
+				clkmux-mask = <0x800>;
+				clkmux-table = <0 0x800>;
+				clkmux-hiword-mask;
+			};
+			vdec_mux: vdec_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&pll_peri &pll_usb>;
+				clock-output-names = "vdec_mux";
+				reg = <0x110>;
+				clkmux-mask = <0x20>;
+				clkmux-table = <0 0x20>;
+				clkmux-hiword-mask;
+			};
+			vpp_mux: vpp_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&pll_peri &pll_usb>;
+				clock-output-names = "vpp_mux";
+				reg = <0x110>;
+				clkmux-mask = <0x800>;
+				clkmux-table = <0 0x800>;
+				clkmux-hiword-mask;
+			};
+			edc0_mux: edc0_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&pll_peri &pll_usb>;
+				clock-output-names = "edc0_mux";
+				reg = <0x114>;
+				clkmux-mask = <0x40>;
+				clkmux-table = <0 0x40>;
+				clkmux-hiword-mask;
+			};
+			ldi0_mux: ldi0_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&pll_peri &pll_hdmi &pll_usb &pll_gpu>;
+				clock-output-names = "ldi0_mux";
+				reg = <0x114>;
+				clkmux-mask = <0x6000>;
+				clkmux-table = <0 0x2000 0x4000 0x6000>;
+				clkmux-hiword-mask;
+			};
+			edc1_mux: edc1_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&pll_peri &pll_usb>;
+				clock-output-names = "edc1_mux";
+				reg = <0x118>;
+				clkmux-mask = <0x40>;
+				clkmux-table = <0 0x40>;
+				clkmux-hiword-mask;
+			};
+			ldi1_mux: ldi1_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&pll_peri &pll_hdmi &pll_usb &pll_gpu>;
+				clock-output-names = "ldi1_mux";
+				reg = <0x118>;
+				clkmux-mask = <0xc000>;
+				clkmux-table = <0 0x4000 0x8000 0xc000>;
+				clkmux-hiword-mask;
+			};
+			rclk_hsic: rclk_hsic {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&pll_usb &pll_peri>;
+				clock-output-names = "rclk_hsic";
+				reg = <0x130>;
+				clkmux-mask = <0x4>;
+				clkmux-table = <0 0x4>;
+				clkmux-hiword-mask;
+			};
+			mmc2_mux: mmc2_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&pll_usb &pll_peri>;
+				clock-output-names = "mmc2_mux";
+				reg = <0x140>;
+				clkmux-mask = <0x10>;
+				clkmux-table = <0 0x10>;
+				clkmux-hiword-mask;
+			};
+			mmc3_mux: mmc3_mux {
+				compatible = "hisilicon,clk-mux";
+				#clock-cells = <0>;
+				clocks = <&pll_usb &pll_peri>;
+				clock-output-names = "mmc3_mux";
+				reg = <0x140>;
+				clkmux-mask = <0x200>;
+				clkmux-table = <0 0x200>;
+				clkmux-hiword-mask;
+			};
+
+			shareaxi_div: shareaxi_div {
+				compatible = "hisilicon,clk-div";
+				#clock-cells = <0>;
+				clocks = <&rclk_shareAXI>;
+				clock-output-names = "shareaxi_div";
+				reg = <0x100>;
+				clkdiv-mask = <0x1f>;
+				clkdiv-min = <1>;
+				clkdiv-max = <32>;
+				clkdiv-hiword-mask;
+			};
+			cfgaxi_div: cfgaxi_div {
+				compatible = "hisilicon,clk-div";
+				#clock-cells = <0>;
+				clocks = <&shareaxi_div>;
+				clock-output-names = "cfgaxi_div";
+				reg = <0x100>;
+				clkdiv-mask = <0x60>;
+				clkdiv-min = <2>;
+				clkdiv-max = <2>;
+				clkdiv-hiword-mask;
+			};
+			sd_div: sd_div {
+				compatible = "hisilicon,clk-div";
+				#clock-cells = <0>;
+				clocks = <&sd_mux>;
+				clock-output-names = "sd_div";
+				reg = <0x108>;
+				clkdiv-mask = <0xf>;
+				clkdiv-min = <1>;
+				clkdiv-max = <16>;
+				clkdiv-hiword-mask;
+			};
+			mmc1_div: mmc1_div {
+				compatible = "hisilicon,clk-div";
+				#clock-cells = <0>;
+				clocks = <&mmc1_mux>;
+				clock-output-names = "mmc1_div";
+				reg = <0x108>;
+				clkdiv-mask = <0x1e0>;
+				clkdiv-min = <1>;
+				clkdiv-max = <16>;
+				clkdiv-hiword-mask;
+			};
+			hsic_div: hsic_div {
+				compatible = "hisilicon,clk-div";
+				#clock-cells = <0>;
+				clocks = <&rclk_hsic>;
+				clock-output-names = "hsic_div";
+				reg = <0x130>;
+				clkdiv-mask = <0x3>;
+				clkdiv-min = <1>;
+				clkdiv-max = <4>;
+				clkdiv-hiword-mask;
+			};
+			mmc2_div: mmc2_div {
+				compatible = "hisilicon,clk-div";
+				#clock-cells = <0>;
+				clocks = <&mmc1_mux>;
+				clock-output-names = "mmc2_div";
+				reg = <0x140>;
+				clkdiv-mask = <0xf>;
+				clkdiv-min = <1>;
+				clkdiv-max = <16>;
+				clkdiv-hiword-mask;
+			};
+			mmc3_div: mmc3_div {
+				compatible = "hisilicon,clk-div";
+				#clock-cells = <0>;
+				clocks = <&mmc1_mux>;
+				clock-output-names = "mmc3_div";
+				reg = <0x140>;
+				clkdiv-mask = <0x1e0>;
+				clkdiv-min = <1>;
+				clkdiv-max = <16>;
+				clkdiv-hiword-mask;
+			};
+
+			timclk0: timclk0 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&timer0_mux>;
+				clock-output-names = "timclk0";
+				clkgate-inverted;
+				reg = <0>;
+				clkgate = <16>;
+			};
+			timclk1: timclk1 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&timer1_mux>;
+				clock-output-names = "timclk1";
+				clkgate-inverted;
+				reg = <0>;
+				clkgate = <18>;
+			};
+			timclk2: timclk2 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&timer2_mux>;
+				clock-output-names = "timclk2";
+				clkgate-inverted;
+				reg = <0>;
+				clkgate = <20>;
+			};
+			timclk3: timclk3 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&timer3_mux>;
+				clock-output-names = "timclk3";
+				clkgate-inverted;
+				reg = <0>;
+				clkgate = <22>;
+			};
+			timclk4: timclk4 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&timer4_mux>;
+				clock-output-names = "timclk4";
+				clkgate-inverted;
+				reg = <0x18>;
+				clkgate = <1>;
+			};
+			timclk5: timclk5 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&timer5_mux>;
+				clock-output-names = "timclk5";
+				clkgate-inverted;
+				reg = <0x18>;
+				clkgate = <3>;
+			};
+			timclk6: timclk6 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&timer6_mux>;
+				clock-output-names = "timclk6";
+				clkgate-inverted;
+				reg = <0x18>;
+				clkgate = <5>;
+			};
+			timclk7: timclk7 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&timer7_mux>;
+				clock-output-names = "timclk7";
+				clkgate-inverted;
+				reg = <0x18>;
+				clkgate = <7>;
+			};
+			timclk8: timclk8 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&timer8_mux>;
+				clock-output-names = "timclk8";
+				clkgate-inverted;
+				reg = <0x18>;
+				clkgate = <9>;
+			};
+			timclk9: timclk9 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&timer9_mux>;
+				clock-output-names = "timclk9";
+				clkgate-inverted;
+				reg = <0x18>;
+				clkgate = <11>;
+			};
+			timerclk01: timerclk01 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&timer_rclk01>;
+				clock-output-names = "timerclk01";
+				reg = <0x20>;
+				clkgate = <0>;
+				clkgate-seperated-reg;
+			};
+			timer_rclk01: timer_rclk01 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&rclk_tcxo>;
+				clock-output-names = "timer_rclk01";
+				reg = <0x20>;
+				clkgate = <1>;
+				clkgate-seperated-reg;
+			};
+			timerclk23: timerclk23 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&timer_rclk23>;
+				clock-output-names = "timerclk23";
+				reg = <0x20>;
+				clkgate = <2>;
+				clkgate-seperated-reg;
+			};
+			timer_rclk23: timer_rclk23 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&rclk_tcxo>;
+				clock-output-names = "timer_rclk23";
+				reg = <0x20>;
+				clkgate = <3>;
+				clkgate-seperated-reg;
+			};
+			rtcclk: rtcclk {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "rtcclk";
+				reg = <0x20>;
+				clkgate = <5>;
+				clkgate-seperated-reg;
+			};
+			kpc_clk: kpc_clk {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "kpc_clk";
+				reg = <0x20>;
+				clkgate = <6>;
+				clkgate-seperated-reg;
+			};
+			gpioclk0: gpioclk0 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "gpioclk0";
+				reg = <0x20>;
+				clkgate = <8>;
+				clkgate-seperated-reg;
+			};
+			gpioclk1: gpioclk1 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "gpioclk1";
+				reg = <0x20>;
+				clkgate = <9>;
+				clkgate-seperated-reg;
+			};
+			gpioclk2: gpioclk2 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "gpioclk2";
+				reg = <0x20>;
+				clkgate = <10>;
+				clkgate-seperated-reg;
+			};
+			gpioclk3: gpioclk3 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "gpioclk3";
+				reg = <0x20>;
+				clkgate = <11>;
+				clkgate-seperated-reg;
+			};
+			gpioclk4: gpioclk4 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "gpioclk4";
+				reg = <0x20>;
+				clkgate = <12>;
+				clkgate-seperated-reg;
+			};
+			gpioclk5: gpioclk5 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "gpioclk5";
+				reg = <0x20>;
+				clkgate = <13>;
+				clkgate-seperated-reg;
+			};
+			gpioclk6: gpioclk6 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "gpioclk6";
+				reg = <0x20>;
+				clkgate = <14>;
+				clkgate-seperated-reg;
+			};
+			gpioclk7: gpioclk7 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "gpioclk7";
+				reg = <0x20>;
+				clkgate = <15>;
+				clkgate-seperated-reg;
+			};
+			gpioclk8: gpioclk8 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "gpioclk8";
+				reg = <0x20>;
+				clkgate = <16>;
+				clkgate-seperated-reg;
+			};
+			gpioclk9: gpioclk9 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "gpioclk9";
+				reg = <0x20>;
+				clkgate = <17>;
+				clkgate-seperated-reg;
+			};
+			gpioclk10: gpioclk10 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "gpioclk10";
+				reg = <0x20>;
+				clkgate = <18>;
+				clkgate-seperated-reg;
+			};
+			gpioclk11: gpioclk11 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "gpioclk11";
+				reg = <0x20>;
+				clkgate = <19>;
+				clkgate-seperated-reg;
+			};
+			gpioclk12: gpioclk12 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "gpioclk12";
+				reg = <0x20>;
+				clkgate = <20>;
+				clkgate-seperated-reg;
+			};
+			gpioclk13: gpioclk13 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "gpioclk13";
+				reg = <0x20>;
+				clkgate = <21>;
+				clkgate-seperated-reg;
+			};
+			gpioclk14: gpioclk14 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "gpioclk14";
+				reg = <0x20>;
+				clkgate = <22>;
+				clkgate-seperated-reg;
+			};
+			gpioclk15: gpioclk15 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "gpioclk15";
+				reg = <0x20>;
+				clkgate = <23>;
+				clkgate-seperated-reg;
+			};
+			gpioclk16: gpioclk16 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "gpioclk16";
+				reg = <0x20>;
+				clkgate = <24>;
+				clkgate-seperated-reg;
+			};
+			gpioclk17: gpioclk17 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "gpioclk17";
+				reg = <0x20>;
+				clkgate = <25>;
+				clkgate-seperated-reg;
+			};
+			gpioclk18: gpioclk18 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "gpioclk18";
+				reg = <0x20>;
+				clkgate = <26>;
+				clkgate-seperated-reg;
+			};
+			gpioclk19: gpioclk19 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "gpioclk19";
+				reg = <0x20>;
+				clkgate = <27>;
+				clkgate-seperated-reg;
+			};
+			gpioclk20: gpioclk20 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "gpioclk20";
+				reg = <0x20>;
+				clkgate = <28>;
+				clkgate-seperated-reg;
+			};
+			gpioclk21: gpioclk21 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "gpioclk21";
+				reg = <0x20>;
+				clkgate = <29>;
+				clkgate-seperated-reg;
+			};
+			dphy0_clk: dphy0_clk {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&osc26m>;
+				clock-output-names = "dphy0_clk";
+				reg = <0x30>;
+				clkgate = <15>;
+				clkgate-seperated-reg;
+			};
+			dphy1_clk: dphy1_clk {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&osc26m>;
+				clock-output-names = "dphy1_clk";
+				reg = <0x30>;
+				clkgate = <16>;
+				clkgate-seperated-reg;
+			};
+			dphy2_clk: dphy2_clk {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&osc26m>;
+				clock-output-names = "dphy2_clk";
+				reg = <0x30>;
+				clkgate = <17>;
+				clkgate-seperated-reg;
+			};
+			usbpicophy_clk: usbpicophy_clk {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&rclk_pico>;
+				clock-output-names = "usbpicophy_clk";
+				reg = <0x30>;
+				clkgate = <24>;
+				clkgate-seperated-reg;
+			};
+			acp_clk: acp_clk {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&rclk_cfgaxi>;
+				clock-output-names = "acp_clk";
+				reg = <0x30>;
+				clkgate = <28>;
+				clkgate-seperated-reg;
+			};
+			timerclk45: timerclk45 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&rclk_tcxo>;
+				clock-output-names = "timerclk45";
+				reg = <0x40>;
+				clkgate = <3>;
+				clkgate-seperated-reg;
+			};
+			timerclk67: timerclk67 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&rclk_tcxo>;
+				clock-output-names = "timerclk67";
+				reg = <0x40>;
+				clkgate = <4>;
+				clkgate-seperated-reg;
+			};
+			timerclk89: timerclk89 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&rclk_tcxo>;
+				clock-output-names = "timerclk89";
+				reg = <0x40>;
+				clkgate = <5>;
+				clkgate-seperated-reg;
+			};
+			pwmclk0: pwmclk0 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pwm0_mux>;
+				clock-output-names = "pwmclk0";
+				reg = <0x40>;
+				clkgate = <7>;
+				clkgate-seperated-reg;
+			};
+			pwmclk1: pwmclk1 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pwm1_mux>;
+				clock-output-names = "pwmclk1";
+				reg = <0x40>;
+				clkgate = <8>;
+				clkgate-seperated-reg;
+			};
+			uartclk0: uartclk0 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&uart0_mux>;
+				clock-output-names = "uartclk0";
+				reg = <0x40>;
+				clkgate = <16>;
+				clkgate-seperated-reg;
+			};
+			uartclk1: uartclk1 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&uart1_mux>;
+				clock-output-names = "uartclk1";
+				reg = <0x40>;
+				clkgate = <17>;
+				clkgate-seperated-reg;
+			};
+			uartclk2: uartclk2 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&uart2_mux>;
+				clock-output-names = "uartclk2";
+				reg = <0x40>;
+				clkgate = <18>;
+				clkgate-seperated-reg;
+			};
+			uartclk3: uartclk3 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&uart3_mux>;
+				clock-output-names = "uartclk3";
+				reg = <0x40>;
+				clkgate = <19>;
+				clkgate-seperated-reg;
+			};
+			uartclk4: uartclk4 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&uart4_mux>;
+				clock-output-names = "uartclk4";
+				reg = <0x40>;
+				clkgate = <20>;
+				clkgate-seperated-reg;
+			};
+			spiclk0: spiclk0 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&spi0_mux>;
+				clock-output-names = "spiclk0";
+				reg = <0x40>;
+				clkgate = <21>;
+				clkgate-seperated-reg;
+			};
+			spiclk1: spiclk1 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&spi1_mux>;
+				clock-output-names = "spiclk1";
+				reg = <0x40>;
+				clkgate = <22>;
+				clkgate-seperated-reg;
+			};
+			spiclk2: spiclk2 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&spi2_mux>;
+				clock-output-names = "spiclk2";
+				reg = <0x40>;
+				clkgate = <23>;
+				clkgate-seperated-reg;
+			};
+			i2cclk0: i2cclk0 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "i2cclk0";
+				reg = <0x40>;
+				clkgate = <24>;
+				clkgate-seperated-reg;
+			};
+			i2cclk1: i2cclk1 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "i2cclk1";
+				reg = <0x40>;
+				clkgate = <25>;
+				clkgate-seperated-reg;
+			};
+			sci_clk: sci_clk {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&osc26m>;
+				clock-output-names = "sci_clk";
+				reg = <0x40>;
+				clkgate = <26>;
+				clkgate-seperated-reg;
+			};
+			i2cclk2: i2cclk2 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "i2cclk2";
+				reg = <0x40>;
+				clkgate = <28>;
+				clkgate-seperated-reg;
+			};
+			i2cclk3: i2cclk3 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&pclk>;
+				clock-output-names = "i2cclk3";
+				reg = <0x40>;
+				clkgate = <29>;
+				clkgate-seperated-reg;
+			};
+			ddrc_per_clk: ddrc_per_clk {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&rclk_cfgaxi>;
+				clock-output-names = "ddrc_per_clk";
+				reg = <0x50>;
+				clkgate = <9>;
+				clkgate-seperated-reg;
+			};
+			dmac_clk: dmac_clk {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&rclk_cfgaxi>;
+				clock-output-names = "dmac_clk";
+				reg = <0x50>;
+				clkgate = <10>;
+				clkgate-seperated-reg;
+			};
+			usb2dvc_clk: usb2dvc_clk {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&rclk_cfgaxi>;
+				clock-output-names = "usb2dvc_clk";
+				reg = <0x50>;
+				clkgate = <10>;
+				clkgate-seperated-reg;
+			};
+			sd_clk: sd_clk {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&sd_div>;
+				clock-output-names = "sd_clk";
+				reg = <0x50>;
+				clkgate = <20>;
+				clkgate-seperated-reg;
+			};
+			mmc_clk1: mmc_clk1 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&rclk_mmc1_mux>;
+				clock-output-names = "mmc_clk1";
+				reg = <0x50>;
+				clkgate = <21>;
+				clkgate-seperated-reg;
+			};
+			mmc_clk2: mmc_clk2 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&mmc2_div>;
+				clock-output-names = "mmc_clk2";
+				reg = <0x50>;
+				clkgate = <22>;
+				clkgate-seperated-reg;
+			};
+			mmc_clk3: mmc_clk3 {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&mmc3_div>;
+				clock-output-names = "mmc_clk3";
+				reg = <0x50>;
+				clkgate = <23>;
+				clkgate-seperated-reg;
+			};
+			mcu_clk: mcu_clk {
+				compatible = "hisilicon,clk-gate";
+				#clock-cells = <0>;
+				clocks = <&acp_clk>;
+				clock-output-names = "mcu_clk";
+				reg = <0x50>;
+				clkgate = <24>;
+				clkgate-seperated-reg;
+			};
+		};
+
+		L2: l2-cache {
+			compatible = "arm,pl310-cache";
+			reg = <0xfc10000 0x100000>;
+			interrupts = <0 15 4>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		gic: interrupt-controller at fc001000 {
+			compatible = "arm,cortex-a9-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			/* gic dist base, gic cpu base */
+			reg = <0xfc001000 0x1000>, <0xfc000100 0x100>;
+		};
+
+		timer0: timer at fc800000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0xfc800000 0x1000>;
+			/* timer00 & timer01 */
+			interrupts = <0 0 4>, <0 1 4>;
+			clocks = <&timclk0 &timclk1>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		timer1: timer at fc801000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0xfc801000 0x1000>;
+			/* timer10 & timer11 */
+			interrupts = <0 2 4>, <0 3 4>;
+			clocks = <&timclk2 &timclk3>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		timer2: timer at fca01000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0xfca01000 0x1000>;
+			/* timer20 & timer21 */
+			interrupts = <0 4 4>, <0 5 4>;
+			clocks = <&timclk4 &timclk5>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		timer3: timer at fca02000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0xfca02000 0x1000>;
+			/* timer30 & timer31 */
+			interrupts = <0 6 4>, <0 7 4>;
+			clocks = <&timclk6 &timclk7>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		timer4: timer at fca03000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0xfca03000 0x1000>;
+			/* timer40 & timer41 */
+			interrupts = <0 96 4>, <0 97 4>;
+			clocks = <&timclk8 &timclk9>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		uart0: uart at fcb00000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0xfcb00000 0x1000>;
+			interrupts = <0 20 4>;
+			clocks = <&uartclk0>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		uart1: uart at fcb01000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0xfcb01000 0x1000>;
+			interrupts = <0 21 4>;
+			clocks = <&uartclk1>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		uart2: uart at fcb02000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0xfcb02000 0x1000>;
+			interrupts = <0 22 4>;
+			clocks = <&uartclk2>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		uart3: uart at fcb03000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0xfcb03000 0x1000>;
+			interrupts = <0 23 4>;
+			clocks = <&uartclk3>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		uart4: uart at fcb04000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0xfcb04000 0x1000>;
+			interrupts = <0 24 4>;
+			clocks = <&uartclk4>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		gpio0: gpio at fc806000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0xfc806000 0x1000>;
+			interrupts = <0 64 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 2 0 1 &pmx0 3 0 1 &pmx0 4 0 1
+					&pmx0 5 0 1 &pmx0 6 1 1 &pmx0 7 2 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&gpioclk0>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio1: gpio at fc807000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0xfc807000 0x1000>;
+			interrupts = <0 65 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 3 1 &pmx0 1 3 1 &pmx0 2 3 1
+					&pmx0 3 3 1 &pmx0 4 3 1 &pmx0 5 4 1
+					&pmx0 6 5 1 &pmx0 7 6 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&gpioclk1>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio2: gpio at fc808000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0xfc808000 0x1000>;
+			interrupts = <0 66 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 7 1 &pmx0 1 8 1 &pmx0 2 9 1
+					&pmx0 3 10 1 &pmx0 4 3 1 &pmx0 5 3 1
+					&pmx0 6 3 1 &pmx0 7 3 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&gpioclk2>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio3: gpio at fc809000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0xfc809000 0x1000>;
+			interrupts = <0 67 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 3 1 &pmx0 1 3 1 &pmx0 2 3 1
+					&pmx0 3 3 1 &pmx0 4 11 1 &pmx0 5 11 1
+					&pmx0 6 11 1 &pmx0 7 11 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&gpioclk3>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio4: gpio at fc80a000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0xfc80a000 0x1000>;
+			interrupts = <0 68 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 11 1 &pmx0 1 11 1 &pmx0 2 11 1
+					&pmx0 3 11 1 &pmx0 4 12 1 &pmx0 5 12 1
+					&pmx0 6 13 1 &pmx0 7 13 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&gpioclk4>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio5: gpio at fc80b000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0xfc80b000 0x1000>;
+			interrupts = <0 69 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 14 1 &pmx0 1 15 1 &pmx0 2 16 1
+					&pmx0 3 16 1 &pmx0 4 16 1 &pmx0 5 16 1
+					&pmx0 6 16 1 &pmx0 7 16 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&gpioclk5>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio6: gpio at fc80c000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0xfc80c000 0x1000>;
+			interrupts = <0 70 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 16 1 &pmx0 1 16 1 &pmx0 2 17 1
+					&pmx0 3 17 1 &pmx0 4 18 1 &pmx0 5 18 1
+					&pmx0 6 18 1 &pmx0 7 19 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&gpioclk6>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio7: gpio at fc80d000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0xfc80d000 0x1000>;
+			interrupts = <0 71 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 19 1 &pmx0 1 20 1 &pmx0 2 21 1
+					&pmx0 3 22 1 &pmx0 4 23 1 &pmx0 5 24 1
+					&pmx0 6 25 1 &pmx0 7 26 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&gpioclk7>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio8: gpio at fc80e000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0xfc80e000 0x1000>;
+			interrupts = <0 72 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 27 1 &pmx0 1 28 1 &pmx0 2 29 1
+					&pmx0 3 30 1 &pmx0 4 31 1 &pmx0 5 32 1
+					&pmx0 6 33 1 &pmx0 7 34 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&gpioclk8>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio9: gpio at fc80f000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0xfc80f000 0x1000>;
+			interrupts = <0 73 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 35 1 &pmx0 1 36 1 &pmx0 2 37 1
+					&pmx0 3 38 1 &pmx0 4 39 1 &pmx0 5 40 1
+					&pmx0 6 41 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&gpioclk9>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio10: gpio at fc810000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0xfc810000 0x1000>;
+			interrupts = <0 74 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 2 43 1 &pmx0 3 44 1 &pmx0 4 45 1
+					&pmx0 5 45 1 &pmx0 6 46 1 &pmx0 7 46 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&gpioclk10>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio11: gpio at fc811000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0xfc811000 0x1000>;
+			interrupts = <0 75 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 47 1 &pmx0 1 47 1 &pmx0 2 47 1
+					&pmx0 3 47 1 &pmx0 4 47 1 &pmx0 5 48 1
+					&pmx0 6 49 1 &pmx0 7 49 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&gpioclk11>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio12: gpio at fc812000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0xfc812000 0x1000>;
+			interrupts = <0 76 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 49 1 &pmx0 1 50 1 &pmx0 2 49 1
+					&pmx0 3 49 1 &pmx0 4 51 1 &pmx0 5 51 1
+					&pmx0 6 51 1 &pmx0 7 52 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&gpioclk12>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio13: gpio at fc813000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0xfc813000 0x1000>;
+			interrupts = <0 77 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 51 1 &pmx0 1 51 1 &pmx0 2 53 1
+					&pmx0 3 53 1 &pmx0 4 53 1 &pmx0 5 54 1
+					&pmx0 6 55 1 &pmx0 7 56 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&gpioclk13>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio14: gpio at fc814000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0xfc814000 0x1000>;
+			interrupts = <0 78 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 57 1 &pmx0 1 97 1 &pmx0 2 97 1
+					&pmx0 3 58 1 &pmx0 4 59 1 &pmx0 5 60 1
+					&pmx0 6 60 1 &pmx0 7 61 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&gpioclk14>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio15: gpio at fc815000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0xfc815000 0x1000>;
+			interrupts = <0 79 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 61 1 &pmx0 1 62 1 &pmx0 2 62 1
+					&pmx0 3 63 1 &pmx0 4 63 1 &pmx0 5 64 1
+					&pmx0 6 64 1 &pmx0 7 65 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&gpioclk15>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio16: gpio at fc816000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0xfc816000 0x1000>;
+			interrupts = <0 80 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 66 1 &pmx0 1 67 1 &pmx0 2 68 1
+					&pmx0 3 69 1 &pmx0 4 70 1 &pmx0 5 71 1
+					&pmx0 6 72 1 &pmx0 7 73 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&gpioclk16>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio17: gpio at fc817000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0xfc817000 0x1000>;
+			interrupts = <0 81 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 74 1 &pmx0 1 75 1 &pmx0 2 76 1
+					&pmx0 3 77 1 &pmx0 4 78 1 &pmx0 5 79 1
+					&pmx0 6 80 1 &pmx0 7 81 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&gpioclk17>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio18: gpio at fc818000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0xfc818000 0x1000>;
+			interrupts = <0 82 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 82 1 &pmx0 1 83 1 &pmx0 2 83 1
+					&pmx0 3 84 1 &pmx0 4 84 1 &pmx0 5 85 1
+					&pmx0 6 86 1 &pmx0 7 87 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&gpioclk18>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio19: gpio at fc819000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0xfc819000 0x1000>;
+			interrupts = <0 83 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 87 1 &pmx0 1 87 1 &pmx0 2 88 1
+					&pmx0 3 88 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&gpioclk19>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio20: gpio at fc81a000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0xfc81a000 0x1000>;
+			interrupts = <0 84 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 89 1 &pmx0 1 89 1 &pmx0 2 90 1
+					&pmx0 3 90 1 &pmx0 4 91 1 &pmx0 5 92 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&gpioclk20>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio21: gpio at fc81b000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0xfc81b000 0x1000>;
+			interrupts = <0 85 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 3 94 1 &pmx0 7 96 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&gpioclk21>;
+			clock-names = "apb_pclk";
+		};
+
+		pmx0: pinmux at fc803000 {
+			compatible = "pinctrl-single";
+			reg = <0xfc803000 0x188>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#gpio-range-cells = <3>;
+			ranges;
+
+			pinctrl-single,register-width = <32>;
+			pinctrl-single,function-mask = <7>;
+			/* pin base, nr pins & gpio function */
+			pinctrl-single,gpio-range = <&range 0 3 0 &range 3 9 1
+						&range 12 1 0 &range 13 29 1
+						&range 43 1 0 &range 44 49 1
+						&range 94 1 1 &range 96 2 1>;
+
+			range: gpio-range {
+				#pinctrl-single,gpio-range-cells = <3>;
+			};
+		};
+
+		pmx1: pinmux at fc803800 {
+			compatible = "pinconf-single";
+			reg = <0xfc803800 0x2dc>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			pinctrl-single,register-width = <32>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/hi4511.dts b/arch/arm/boot/dts/hi4511.dts
new file mode 100644
index 0000000..7e67564
--- /dev/null
+++ b/arch/arm/boot/dts/hi4511.dts
@@ -0,0 +1,648 @@
+/*
+ *  Copyright (C) 2012-2013 Linaro Ltd.
+ *  Author: Haojian Zhuang <haojian.zhuang@linaro.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ */
+
+/dts-v1/;
+/include/ "hi3620.dtsi"
+
+/ {
+	model = "Hisilicon Hi4511 Development Board";
+	compatible = "hisilicon,hi3620-hi4511";
+
+	chosen {
+		bootargs = "console=ttyAMA0,115200 root=/dev/ram0 earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x40000000 0x20000000>;
+	};
+
+	amba {
+		timer0: timer at fc800000 {
+			status = "ok";
+		};
+
+		uart0: uart at fcb00000 {	/* console */
+			pinctrl-names = "default", "idle";
+			pinctrl-0 = <&uart0_pmx_func &uart0_cfg_func>;
+			pinctrl-1 = <&uart0_pmx_idle &uart0_cfg_idle>;
+			status = "ok";
+		};
+
+		uart1: uart at fcb01000 { /* modem */
+			pinctrl-names = "default", "idle";
+			pinctrl-0 = <&uart1_pmx_func &uart1_cfg_func>;
+			pinctrl-1 = <&uart1_pmx_idle &uart1_cfg_idle>;
+			status = "ok";
+		};
+
+		uart2: uart at fcb02000 { /* audience */
+			pinctrl-names = "default", "idle";
+			pinctrl-0 = <&uart2_pmx_func &uart2_cfg_func>;
+			pinctrl-1 = <&uart2_pmx_idle &uart2_cfg_idle>;
+			status = "ok";
+		};
+
+		uart3: uart at fcb03000 {
+			pinctrl-names = "default", "idle";
+			pinctrl-0 = <&uart3_pmx_func &uart3_cfg_func>;
+			pinctrl-1 = <&uart3_pmx_idle &uart3_cfg_idle>;
+			status = "ok";
+		};
+
+		uart4: uart at fcb04000 {
+			pinctrl-names = "default", "idle";
+			pinctrl-0 = <&uart4_pmx_func &uart4_cfg_func>;
+			pinctrl-1 = <&uart4_pmx_idle &uart4_cfg_func>;
+			status = "ok";
+		};
+
+		pmx0: pinmux at fc803000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&board_pmx_pins>;
+
+			board_pmx_pins: board_pmx_pins {
+				pinctrl-single,pins = <
+					0x008 0x0	/* GPIO -- eFUSE_DOUT */
+					0x100 0x0	/* USIM_CLK & USIM_DATA (IOMG63) */
+				>;
+			};
+			uart0_pmx_func: uart0_pmx_func {
+				pinctrl-single,pins = <
+					0x0f0 0x0
+					0x0f4 0x0	/* UART0_RX & UART0_TX */
+				>;
+			};
+			uart0_pmx_idle: uart0_pmx_idle {
+				pinctrl-single,pins = <
+					/*0x0f0 0x1*/	/* UART0_CTS & UART0_RTS */
+					0x0f4 0x1	/* UART0_RX & UART0_TX */
+				>;
+			};
+			uart1_pmx_func: uart1_pmx_func {
+				pinctrl-single,pins = <
+					0x0f8 0x0	/* UART1_CTS & UART1_RTS (IOMG61) */
+					0x0fc 0x0	/* UART1_RX & UART1_TX (IOMG62) */
+				>;
+			};
+			uart1_pmx_idle: uart1_pmx_idle {
+				pinctrl-single,pins = <
+					0x0f8 0x1	/* GPIO (IOMG61) */
+					0x0fc 0x1	/* GPIO (IOMG62) */
+				>;
+			};
+			uart2_pmx_func: uart2_pmx_func {
+				pinctrl-single,pins = <
+					0x104 0x2	/* UART2_RXD (IOMG96) */
+					0x108 0x2	/* UART2_TXD (IOMG64) */
+				>;
+			};
+			uart2_pmx_idle: uart2_pmx_idle {
+				pinctrl-single,pins = <
+					0x104 0x1	/* GPIO (IOMG96) */
+					0x108 0x1	/* GPIO (IOMG64) */
+				>;
+			};
+			uart3_pmx_func: uart3_pmx_func {
+				pinctrl-single,pins = <
+					0x160 0x2	/* UART3_CTS & UART3_RTS (IOMG85) */
+					0x164 0x2	/* UART3_RXD & UART3_TXD (IOMG86) */
+				>;
+			};
+			uart3_pmx_idle: uart3_pmx_idle {
+				pinctrl-single,pins = <
+					0x160 0x1	/* GPIO (IOMG85) */
+					0x164 0x1	/* GPIO (IOMG86) */
+				>;
+			};
+			uart4_pmx_func: uart4_pmx_func {
+				pinctrl-single,pins = <
+					0x168 0x0	/* UART4_CTS & UART4_RTS (IOMG87) */
+					0x16c 0x0	/* UART4_RXD (IOMG88) */
+					0x170 0x0	/* UART4_TXD (IOMG93) */
+				>;
+			};
+			uart4_pmx_idle: uart4_pmx_idle {
+				pinctrl-single,pins = <
+					0x168 0x1	/* GPIO (IOMG87) */
+					0x16c 0x1	/* GPIO (IOMG88) */
+					0x170 0x1	/* GPIO (IOMG93) */
+				>;
+			};
+			i2c0_pmx_func: i2c0_pmx_func {
+				pinctrl-single,pins = <
+					0x0b4 0x0	/* I2C0_SCL & I2C0_SDA (IOMG45) */
+				>;
+			};
+			i2c0_pmx_idle: i2c0_pmx_idle {
+				pinctrl-single,pins = <
+					0x0b4 0x1	/* GPIO (IOMG45) */
+				>;
+			};
+			i2c1_pmx_func: i2c1_pmx_func {
+				pinctrl-single,pins = <
+					0x0b8 0x0	/* I2C1_SCL & I2C1_SDA (IOMG46) */
+				>;
+			};
+			i2c1_pmx_idle: i2c1_pmx_idle {
+				pinctrl-single,pins = <
+					0x0b8 0x1	/* GPIO (IOMG46) */
+				>;
+			};
+			i2c2_pmx_func: i2c2_pmx_func {
+				pinctrl-single,pins = <
+					0x068 0x0	/* I2C2_SCL (IOMG26) */
+					0x06c 0x0	/* I2C2_SDA (IOMG27) */
+				>;
+			};
+			i2c2_pmx_idle: i2c2_pmx_idle {
+				pinctrl-single,pins = <
+					0x068 0x1	/* GPIO (IOMG26) */
+					0x06c 0x1	/* GPIO (IOMG27) */
+				>;
+			};
+			i2c3_pmx_func: i2c3_pmx_func {
+				pinctrl-single,pins = <
+					0x050 0x2	/* I2C3_SCL (IOMG20) */
+					0x054 0x2	/* I2C3_SDA (IOMG21) */
+				>;
+			};
+			i2c3_pmx_idle: i2c3_pmx_idle {
+				pinctrl-single,pins = <
+					0x050 0x1	/* GPIO (IOMG20) */
+					0x054 0x1	/* GPIO (IOMG21) */
+				>;
+			};
+			spi0_pmx_func: spi0_pmx_func {
+				pinctrl-single,pins = <
+					0x0d4 0x0	/* SPI0_CLK/SPI0_DI/SPI0_DO (IOMG53) */
+					0x0d8 0x0	/* SPI0_CS0 (IOMG54) */
+					0x0dc 0x0	/* SPI0_CS1 (IOMG55) */
+					0x0e0 0x0	/* SPI0_CS2 (IOMG56) */
+					0x0e4 0x0	/* SPI0_CS3 (IOMG57) */
+				>;
+			};
+			spi0_pmx_idle: spi0_pmx_idle {
+				pinctrl-single,pins = <
+					0x0d4 0x1	/* GPIO (IOMG53) */
+					0x0d8 0x1	/* GPIO (IOMG54) */
+					0x0dc 0x1	/* GPIO (IOMG55) */
+					0x0e0 0x1	/* GPIO (IOMG56) */
+					0x0e4 0x1	/* GPIO (IOMG57) */
+				>;
+			};
+			spi1_pmx_func: spi1_pmx_func {
+				pinctrl-single,pins = <
+					0x184 0x0	/* SPI1_CLK/SPI1_DI (IOMG98) */
+					0x0e8 0x0	/* SPI1_DO (IOMG58) */
+					0x0ec 0x0	/* SPI1_CS (IOMG95) */
+				>;
+			};
+			spi1_pmx_idle: spi1_pmx_idle {
+				pinctrl-single,pins = <
+					0x184 0x1	/* GPIO (IOMG98) */
+					0x0e8 0x1	/* GPIO (IOMG58) */
+					0x0ec 0x1	/* GPIO (IOMG95) */
+				>;
+			};
+			kpc_pmx_func: kpc_pmx_func {
+				pinctrl-single,pins = <
+					0x12c 0x0	/* KEY_IN0 (IOMG73) */
+					0x130 0x0	/* KEY_IN1 (IOMG74) */
+					0x134 0x0	/* KEY_IN2 (IOMG75) */
+					0x10c 0x0	/* KEY_OUT0 (IOMG65) */
+					0x110 0x0	/* KEY_OUT1 (IOMG66) */
+					0x114 0x0	/* KEY_OUT2 (IOMG67) */
+				>;
+			};
+			kpc_pmx_idle: kpc_pmx_idle {
+				pinctrl-single,pins = <
+					0x12c 0x1	/* GPIO (IOMG73) */
+					0x130 0x1	/* GPIO (IOMG74) */
+					0x134 0x1	/* GPIO (IOMG75) */
+					0x10c 0x1	/* GPIO (IOMG65) */
+					0x110 0x1	/* GPIO (IOMG66) */
+					0x114 0x1	/* GPIO (IOMG67) */
+				>;
+			};
+			gpio_key_func: gpio_key_func {
+				pinctrl-single,pins = <
+					0x10c 0x1	/* KEY_OUT0/GPIO (IOMG65) */
+					0x130 0x1	/* KEY_IN1/GPIO (IOMG74) */
+				>;
+			};
+			emmc_pmx_func: emmc_pmx_func {
+				pinctrl-single,pins = <
+					0x030 0x2	/* eMMC_CMD/eMMC_CLK (IOMG12) */
+					0x018 0x0	/* NAND_CS3_N (IOMG6) */
+					0x024 0x0	/* NAND_BUSY2_N (IOMG8) */
+					0x028 0x0	/* NAND_BUSY3_N (IOMG9) */
+					0x02c 0x2	/* eMMC_DATA[0:7] (IOMG10) */
+				>;
+			};
+			emmc_pmx_idle: emmc_pmx_idle {
+				pinctrl-single,pins = <
+					0x030 0x0	/* GPIO (IOMG12) */
+					0x018 0x1	/* GPIO (IOMG6) */
+					0x024 0x1	/* GPIO (IOMG8) */
+					0x028 0x1	/* GPIO (IOMG9) */
+					0x02c 0x1	/* GPIO (IOMG10) */
+				>;
+			};
+			sd_pmx_func: sd_pmx_func {
+				pinctrl-single,pins = <
+					0x0bc 0x0	/* SD_CLK/SD_CMD/SD_DATA0/SD_DATA1/SD_DATA2 (IOMG47) */
+					0x0c0 0x0	/* SD_DATA3 (IOMG48) */
+				>;
+			};
+			sd_pmx_idle: sd_pmx_idle {
+				pinctrl-single,pins = <
+					0x0bc 0x1	/* GPIO (IOMG47) */
+					0x0c0 0x1	/* GPIO (IOMG48) */
+				>;
+			};
+			nand_pmx_func: nand_pmx_func {
+				pinctrl-single,pins = <
+					0x00c 0x0	/* NAND_ALE/NAND_CLE/.../NAND_DATA[0:7] (IOMG3) */
+					0x010 0x0	/* NAND_CS1_N (IOMG4) */
+					0x014 0x0	/* NAND_CS2_N (IOMG5) */
+					0x018 0x0	/* NAND_CS3_N (IOMG6) */
+					0x01c 0x0	/* NAND_BUSY0_N (IOMG94) */
+					0x020 0x0	/* NAND_BUSY1_N (IOMG7) */
+					0x024 0x0	/* NAND_BUSY2_N (IOMG8) */
+					0x028 0x0	/* NAND_BUSY3_N (IOMG9) */
+					0x02c 0x0	/* NAND_DATA[8:15] (IOMG10) */
+				>;
+			};
+			nand_pmx_idle: nand_pmx_idle {
+				pinctrl-single,pins = <
+					0x00c 0x1	/* GPIO (IOMG3) */
+					0x010 0x1	/* GPIO (IOMG4) */
+					0x014 0x1	/* GPIO (IOMG5) */
+					0x018 0x1	/* GPIO (IOMG6) */
+					0x01c 0x1	/* GPIO (IOMG94) */
+					0x020 0x1	/* GPIO (IOMG7) */
+					0x024 0x1	/* GPIO (IOMG8) */
+					0x028 0x1	/* GPIO (IOMG9) */
+					0x02c 0x1	/* GPIO (IOMG10) */
+				>;
+			};
+			sdio_pmx_func: sdio_pmx_func {
+				pinctrl-single,pins = <
+					0x0c4 0x0	/* SDIO_CLK/SDIO_CMD/SDIO_DATA[0:3] (IOMG49) */
+				>;
+			};
+			sdio_pmx_idle: sdio_pmx_idle {
+				pinctrl-single,pins = <
+					0x0c4 0x1	/* GPIO (IOMG49) */
+				>;
+			};
+			audio_out_pmx_func: audio_out_pmx_func {
+				pinctrl-single,pins = <
+					0x0f0 0x1	/* GPIO (IOMG59), audio spk & earphone */
+				>;
+			};
+		};
+
+		pmx1: pinmux at fc803800 {
+			pinctrl-names = "default";
+			pinctrl-0 = <	&board_pu_pins &board_pd_pins &board_pd_ps_pins
+					&board_np_pins &board_ps_pins &kpc_cfg_func
+					&audio_out_cfg_func>;
+			board_pu_pins: board_pu_pins {
+				pinctrl-single,pins = <
+					0x014 0		/* GPIO_158 (IOCFG2) */
+					0x018 0		/* GPIO_159 (IOCFG3) */
+					0x01c 0		/* BOOT_MODE0 (IOCFG4) */
+					0x020 0		/* BOOT_MODE1 (IOCFG5) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <1 1 0 1>;
+			};
+			board_pd_pins: board_pd_pins {
+				pinctrl-single,pins = <
+					0x038 0		/* eFUSE_DOUT (IOCFG11) */
+					0x150 0		/* ISP_GPIO8 (IOCFG93) */
+					0x154 0		/* ISP_GPIO9 (IOCFG94) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+			board_pd_ps_pins: board_pd_ps_pins {
+				pinctrl-single,pins = <
+					0x2d8 0		/* CLK_OUT0 (IOCFG190) */
+					0x004 0		/* PMU_SPI_DATA (IOCFG192) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			board_np_pins: board_np_pins {
+				pinctrl-single,pins = <
+					0x24c 0		/* KEYPAD_OUT7 (IOCFG155) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+			board_ps_pins: board_ps_pins {
+				pinctrl-single,pins = <
+					0x000 0		/* PMU_SPI_CLK (IOCFG191) */
+					0x008 0		/* PMU_SPI_CS_N (IOCFG193) */
+				>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			uart0_cfg_func: uart0_cfg_func {
+				pinctrl-single,pins = <
+					0x208 0		/* UART0_RXD (IOCFG138) */
+					0x20c 0		/* UART0_TXD (IOCFG139) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+			uart0_cfg_idle: uart0_cfg_idle {
+				pinctrl-single,pins = <
+					0x208 0		/* UART0_RXD (IOCFG138) */
+					0x20c 0		/* UART0_TXD (IOCFG139) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+			uart1_cfg_func: uart1_cfg_func {
+				pinctrl-single,pins = <
+					0x210 0		/* UART1_CTS (IOCFG140) */
+					0x214 0		/* UART1_RTS (IOCFG141) */
+					0x218 0		/* UART1_RXD (IOCFG142) */
+					0x21c 0		/* UART1_TXD (IOCFG143) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+			uart1_cfg_idle: uart1_cfg_idle {
+				pinctrl-single,pins = <
+					0x210 0		/* UART1_CTS (IOCFG140) */
+					0x214 0		/* UART1_RTS (IOCFG141) */
+					0x218 0		/* UART1_RXD (IOCFG142) */
+					0x21c 0		/* UART1_TXD (IOCFG143) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+			uart2_cfg_func: uart2_cfg_func {
+				pinctrl-single,pins = <
+					0x220 0		/* UART2_CTS (IOCFG144) */
+					0x224 0		/* UART2_RTS (IOCFG145) */
+					0x228 0		/* UART2_RXD (IOCFG146) */
+					0x22c 0		/* UART2_TXD (IOCFG147) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+			uart2_cfg_idle: uart2_cfg_idle {
+				pinctrl-single,pins = <
+					0x220 0		/* GPIO (IOCFG144) */
+					0x224 0		/* GPIO (IOCFG145) */
+					0x228 0		/* GPIO (IOCFG146) */
+					0x22c 0		/* GPIO (IOCFG147) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+			uart3_cfg_func: uart3_cfg_func {
+				pinctrl-single,pins = <
+					0x294 0		/* UART3_CTS (IOCFG173) */
+					0x298 0		/* UART3_RTS (IOCFG174) */
+					0x29c 0		/* UART3_RXD (IOCFG175) */
+					0x2a0 0		/* UART3_TXD (IOCFG176) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+			uart3_cfg_idle: uart3_cfg_idle {
+				pinctrl-single,pins = <
+					0x294 0		/* UART3_CTS (IOCFG173) */
+					0x298 0		/* UART3_RTS (IOCFG174) */
+					0x29c 0		/* UART3_RXD (IOCFG175) */
+					0x2a0 0		/* UART3_TXD (IOCFG176) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+			uart4_cfg_func: uart4_cfg_func {
+				pinctrl-single,pins = <
+					0x2a4 0		/* UART4_CTS (IOCFG177) */
+					0x2a8 0		/* UART4_RTS (IOCFG178) */
+					0x2ac 0		/* UART4_RXD (IOCFG179) */
+					0x2b0 0		/* UART4_TXD (IOCFG180) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+			i2c0_cfg_func: i2c0_cfg_func {
+				pinctrl-single,pins = <
+					0x17c 0		/* I2C0_SCL (IOCFG103) */
+					0x180 0		/* I2C0_SDA (IOCFG104) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			i2c1_cfg_func: i2c1_cfg_func {
+				pinctrl-single,pins = <
+					0x184 0		/* I2C1_SCL (IOCFG105) */
+					0x188 0		/* I2C1_SDA (IOCFG106) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			i2c2_cfg_func: i2c2_cfg_func {
+				pinctrl-single,pins = <
+					0x118 0		/* I2C2_SCL (IOCFG79) */
+					0x11c 0		/* I2C2_SDA (IOCFG80) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			i2c3_cfg_func: i2c3_cfg_func {
+				pinctrl-single,pins = <
+					0x100 0		/* I2C3_SCL (IOCFG73) */
+					0x104 0		/* I2C3_SDA (IOCFG74) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			spi0_cfg_func1: spi0_cfg_func1 {
+				pinctrl-single,pins = <
+					0x1d4 0		/* SPI0_CLK (IOCFG125) */
+					0x1d8 0		/* SPI0_DI (IOCFG126) */
+					0x1dc 0		/* SPI0_DO (IOCFG127) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			spi0_cfg_func2: spi0_cfg_func2 {
+				pinctrl-single,pins = <
+					0x1e0 0		/* SPI0_CS0 (IOCFG128) */
+					0x1e4 0		/* SPI0_CS1 (IOCFG129) */
+					0x1e8 0		/* SPI0_CS2 (IOCFG130 */
+					0x1ec 0		/* SPI0_CS3 (IOCFG131) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <1 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			spi1_cfg_func1: spi1_cfg_func1 {
+				pinctrl-single,pins = <
+					0x1f0 0		/* SPI1_CLK (IOCFG132) */
+					0x1f4 0		/* SPI1_DI (IOCFG133) */
+					0x1f8 0		/* SPI1_DO (IOCFG134) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			spi1_cfg_func2: spi1_cfg_func2 {
+				pinctrl-single,pins = <
+					0x1fc 0		/* SPI1_CS (IOCFG135) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <1 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			kpc_cfg_func: kpc_cfg_func {
+				pinctrl-single,pins = <
+					0x250 0		/* KEY_IN0 (IOCFG156) */
+					0x254 0		/* KEY_IN1 (IOCFG157) */
+					0x258 0		/* KEY_IN2 (IOCFG158) */
+					0x230 0		/* KEY_OUT0 (IOCFG148) */
+					0x234 0		/* KEY_OUT1 (IOCFG149) */
+					0x238 0		/* KEY_OUT2 (IOCFG150) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+			emmc_cfg_func: emmc_cfg_func {
+				pinctrl-single,pins = <
+					0x0ac 0		/* eMMC_CMD (IOCFG40) */
+					0x0b0 0		/* eMMC_CLK (IOCFG41) */
+					0x058 0		/* NAND_CS3_N (IOCFG19) */
+					0x064 0		/* NAND_BUSY2_N (IOCFG22) */
+					0x068 0		/* NAND_BUSY3_N (IOCFG23) */
+					0x08c 0		/* NAND_DATA8 (IOCFG32) */
+					0x090 0		/* NAND_DATA9 (IOCFG33) */
+					0x094 0		/* NAND_DATA10 (IOCFG34) */
+					0x098 0		/* NAND_DATA11 (IOCFG35) */
+					0x09c 0		/* NAND_DATA12 (IOCFG36) */
+					0x0a0 0		/* NAND_DATA13 (IOCFG37) */
+					0x0a4 0		/* NAND_DATA14 (IOCFG38) */
+					0x0a8 0		/* NAND_DATA15 (IOCFG39) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <1 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			sd_cfg_func1: sd_cfg_func1 {
+				pinctrl-single,pins = <
+					0x18c 0		/* SD_CLK (IOCFG107) */
+					0x190 0		/* SD_CMD (IOCFG108) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			sd_cfg_func2: sd_cfg_func2 {
+				pinctrl-single,pins = <
+					0x194 0		/* SD_DATA0 (IOCFG109) */
+					0x198 0		/* SD_DATA1 (IOCFG110) */
+					0x19c 0		/* SD_DATA2 (IOCFG111) */
+					0x1a0 0		/* SD_DATA3 (IOCFG112) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+				pinctrl-single,drive-strength = <0x70 0xf0>;
+			};
+			nand_cfg_func1: nand_cfg_func1 {
+				pinctrl-single,pins = <
+					0x03c 0		/* NAND_ALE (IOCFG12) */
+					0x040 0		/* NAND_CLE (IOCFG13) */
+					0x06c 0		/* NAND_DATA0 (IOCFG24) */
+					0x070 0		/* NAND_DATA1 (IOCFG25) */
+					0x074 0		/* NAND_DATA2 (IOCFG26) */
+					0x078 0		/* NAND_DATA3 (IOCFG27) */
+					0x07c 0		/* NAND_DATA4 (IOCFG28) */
+					0x080 0		/* NAND_DATA5 (IOCFG29) */
+					0x084 0		/* NAND_DATA6 (IOCFG30) */
+					0x088 0		/* NAND_DATA7 (IOCFG31) */
+					0x08c 0		/* NAND_DATA8 (IOCFG32) */
+					0x090 0		/* NAND_DATA9 (IOCFG33) */
+					0x094 0		/* NAND_DATA10 (IOCFG34) */
+					0x098 0		/* NAND_DATA11 (IOCFG35) */
+					0x09c 0		/* NAND_DATA12 (IOCFG36) */
+					0x0a0 0		/* NAND_DATA13 (IOCFG37) */
+					0x0a4 0		/* NAND_DATA14 (IOCFG38) */
+					0x0a8 0		/* NAND_DATA15 (IOCFG39) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			nand_cfg_func2: nand_cfg_func2 {
+				pinctrl-single,pins = <
+					0x044 0		/* NAND_RE_N (IOCFG14) */
+					0x048 0		/* NAND_WE_N (IOCFG15) */
+					0x04c 0		/* NAND_CS0_N (IOCFG16) */
+					0x050 0		/* NAND_CS1_N (IOCFG17) */
+					0x054 0		/* NAND_CS2_N (IOCFG18) */
+					0x058 0		/* NAND_CS3_N (IOCFG19) */
+					0x05c 0		/* NAND_BUSY0_N (IOCFG20) */
+					0x060 0		/* NAND_BUSY1_N (IOCFG21) */
+					0x064 0		/* NAND_BUSY2_N (IOCFG22) */
+					0x068 0		/* NAND_BUSY3_N (IOCFG23) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <1 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			sdio_cfg_func: sdio_cfg_func {
+				pinctrl-single,pins = <
+					0x1a4 0		/* SDIO0_CLK (IOCG113) */
+					0x1a8 0		/* SDIO0_CMD (IOCG114) */
+					0x1ac 0		/* SDIO0_DATA0 (IOCG115) */
+					0x1b0 0		/* SDIO0_DATA1 (IOCG116) */
+					0x1b4 0		/* SDIO0_DATA2 (IOCG117) */
+					0x1b8 0		/* SDIO0_DATA3 (IOCG118) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			audio_out_cfg_func: audio_out_cfg_func {
+				pinctrl-single,pins = <
+					0x200 0		/* GPIO (IOCFG136) */
+					0x204 0		/* GPIO (IOCFG137) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		call {
+			label = "call";
+			gpios = <&gpio17 2 0>;
+			linux,code = <169>;	/* KEY_PHONE */
+		};
+	};
+};
-- 
1.8.1.2
