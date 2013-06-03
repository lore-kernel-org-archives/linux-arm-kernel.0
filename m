From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon,  3 Jun 2013 17:30:43 +0800
Subject: [PATCH v3 09/11] clk: mmp: parse clock from dts
In-Reply-To: <1370251845-31373-1-git-send-email-haojian.zhuang@gmail.com>
References: <1370251845-31373-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1370251845-31373-10-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Parse clock information from DTS file for mach-mmp.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/boot/dts/pxa168-aspenite.dts |   3 +
 arch/arm/boot/dts/pxa168-clk.dtsi     | 304 ++++++++++++++++++
 arch/arm/boot/dts/pxa168.dtsi         |  10 +
 arch/arm/boot/dts/pxa910-clk.dtsi     | 569 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/pxa910-dkb.dts      |  11 +
 arch/arm/boot/dts/pxa910.dtsi         |  12 +-
 arch/arm/mach-mmp/mmp-dt.c            |   2 +
 drivers/clk/mmp/Makefile              |   2 +-
 drivers/clk/mmp/clk-mmp.c             | 363 ++++++++++++++++++++++
 9 files changed, 1274 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/pxa168-clk.dtsi
 create mode 100644 arch/arm/boot/dts/pxa910-clk.dtsi
 create mode 100644 drivers/clk/mmp/clk-mmp.c

diff --git a/arch/arm/boot/dts/pxa168-aspenite.dts b/arch/arm/boot/dts/pxa168-aspenite.dts
index e762fac..2597e98 100644
--- a/arch/arm/boot/dts/pxa168-aspenite.dts
+++ b/arch/arm/boot/dts/pxa168-aspenite.dts
@@ -24,6 +24,9 @@
 
 	soc {
 		apb at d4000000 {
+			timer0: timer at d4014000 {
+				status = "okay";
+			};
 			uart1: uart at d4017000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/pxa168-clk.dtsi b/arch/arm/boot/dts/pxa168-clk.dtsi
new file mode 100644
index 0000000..f9c298df
--- /dev/null
+++ b/arch/arm/boot/dts/pxa168-clk.dtsi
@@ -0,0 +1,304 @@
+/*
+ *  Copyright (C) 2013
+ *  Author: Haojian Zhuang <haojian.zhuang@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	soc {
+		apb at d4000000 {	/* APB */
+			compatible = "mrvl,apb-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xd4000000 0x00200000>;
+			ranges;
+
+			mpmu: clocks at 50000 {
+				compatible = "marvell,mmp-mpmu";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xd4050000 0x1100>;
+
+				osc_32k: osc32khz {
+					compatible = "fixed-clock";
+					#clock-cells = <0>;
+					clock-frequency = <32768>;
+					clock-output-names = "osc32khz";
+				};
+				osc_26m: osc26mhz {
+					compatible = "fixed-clock";
+					#clock-cells = <0>;
+					clock-frequency = <26000000>;
+					clock-output-names = "osc26mhz";
+				};
+				pll1_312m: refclk312mhz {
+					compatible = "marvell,mmp-fixed-clkrate";
+					#clock-cells = <0>;
+					clocks = <&osc_26m>;
+					clock-frequency = <312000000>;
+					clock-output-names = "refclk312mhz";
+				};
+				refclk156m: refclk156mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&pll1_312m>;
+					clock-output-names = "refclk156mhz";
+					/* multiple & divider */
+					marvell,mmp-fixed-factor = <1 2>;
+				};
+				refclk118m: refclk117mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&refclk156m>;
+					/* 117.9648MHz */
+					clock-output-names = "refclk118mhz";
+					/* multiple & divider */
+					marvell,mmp-fixed-factor = <6144 8125>;
+				};
+				refclk104m: refclk104mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&pll1_312m>;
+					clock-output-names = "refclk104mhz";
+					/* multiple & divider */
+					marvell,mmp-fixed-factor = <1 3>;
+				};
+				refclk59m: refclk59mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&refclk118m>;
+					clock-names = "baud_58.98mhz";
+					/* 58.9824MHz */
+					clock-output-names = "refclk59mhz";
+					/* multiple & divider */
+					marvell,mmp-fixed-factor = <1 2>;
+				};
+				refclk15m: refclk15mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&refclk156m>;
+					clock-names = "baud_14.86mhz";
+					/* 14.857MHz */
+					clock-output-names = "refclk15mhz";
+					/* multiple & divider */
+					marvell,mmp-fixed-factor = <2 21>;
+				};
+			};
+
+			apbc: clocks at 15000 {
+				compatible = "marvell,mmp-apbc";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				#clock-cells = <0>;
+				reg = <0xd4015000 0x100>;
+
+				apbc_twsi1_clk: apbc_twsi1_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&refclk32m>;
+					clock-names = "apbc_twsi1_clk";
+					/* register value of each item */
+					marvell,mmp-clk-sel = <0>;
+					/* register offset & mask */
+					marvell,mmp-clk-reg = <0x2c 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_twsi2_clk: apbc_twsi2_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&refclk32m>;
+					clock-names = "apbc_twsi2_clk";
+					/* register value of each item */
+					marvell,mmp-clk-sel = <0>;
+					/* register offset & mask */
+					marvell,mmp-clk-reg = <0x6c 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_rtc_clk: apbc_rtc_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&osc_32k>;
+					clock-names = "apbc_rtc_clk";
+					marvell,mmp-clk-sel = <0>;
+					/* register offset & mask */
+					marvell,mmp-clk-reg = <0x28 0x70>;
+					marvell,mmp-apbc-power-ctl;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_gpio_clk: apbc_gpio_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&refclk26m>;
+					clock-names = "apbc_gpio_clk";
+					marvell,mmp-clk-sel = <0>;
+					/* register offset & mask */
+					marvell,mmp-clk-reg = <0x8 0x0>;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_uart1_mux: apbc_uart1_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk59m &refclk15m>;
+					clock-output-names = "apbc_uart1_mux";
+					/* register offset & mask */
+					marvell,mmp-clk-reg = <0x0 0x70>;
+					/* register value of each item */
+					marvell,mmp-clk-sel = <0 0x10>;
+				};
+				apbc_uart1_clk: apbc_uart1_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_uart1_mux>;
+					clock-names = "apbc_uart1_clk";
+					marvell,mmp-clk-reg = <0x0 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_uart2_mux: apbc_uart2_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk59m &refclk15m>;
+					clock-output-names = "apbc_uart2_mux";
+					/* register offset & mask */
+					marvell,mmp-clk-reg = <0x4 0x70>;
+					/* register value of each item */
+					marvell,mmp-clk-sel = <0 0x10>;
+				};
+				apbc_uart2_clk: apbc_uart2_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_uart2_mux>;
+					clock-names = "apbc_uart2_clk";
+					marvell,mmp-clk-reg = <0x4 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_uart3_mux: apbc_uart3_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk59m &refclk15m>;
+					clock-output-names = "apbc_uart3_mux";
+					/* register offset & mask */
+					marvell,mmp-clk-reg = <0x70 0x70>;
+					/* register value of each item */
+					marvell,mmp-clk-sel = <0 0x10>;
+				};
+				apbc_uart3_clk: apbc_uart3_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_uart3_mux>;
+					clock-names = "apbc_uart3_clk";
+					marvell,mmp-clk-reg = <0x70 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_pwm1_mux: apbc_pwm1_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk13m &osc_32k>;
+					clock-output-names = "apbc_pwm1_mux";
+					marvell,mmp-clk-sel = <0 0x10>;
+					marvell,mmp-clk-reg = <0xc 0x70>;
+				};
+				apbc_pwm1_clk: apbc_pwm1_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_pwm1_mux>;
+					clock-names = "apbc_pwm1_clk";
+					marvell,mmp-clk-reg = <0xc 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_pwm2_mux: apbc_pwm2_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk13m &osc_32k>;
+					clock-output-names = "apbc_pwm2_mux";
+					marvell,mmp-clk-sel = <0 0x10>;
+					marvell,mmp-clk-reg = <0x10 0x70>;
+				};
+				apbc_pwm2_clk: apbc_pwm2_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_pwm2_mux>;
+					clock-names = "apbc_pwm2_clk";
+					marvell,mmp-clk-reg = <0x10 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_pwm3_mux: apbc_pwm3_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk13m &osc_32k>;
+					clock-output-names = "apbc_pwm3_mux";
+					marvell,mmp-clk-sel = <0 0x10>;
+					marvell,mmp-clk-reg = <0x14 0x70>;
+				};
+				apbc_pwm3_clk: apbc_pwm3_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_pwm3_mux>;
+					clock-names = "apbc_pwm3_clk";
+					marvell,mmp-clk-reg = <0x14 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_pwm4_mux: apbc_pwm4_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk13m &osc_32k>;
+					clock-output-names = "apbc_pwm4_mux";
+					marvell,mmp-clk-sel = <0 0x10>;
+					marvell,mmp-clk-reg = <0x18 0x70>;
+				};
+				apbc_pwm4_clk: apbc_pwm4_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_pwm4_mux>;
+					clock-names = "apbc_pwm4_clk";
+					marvell,mmp-clk-reg = <0x18 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_kpc_mux: apbc_kpc_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&osc_32k &refclk16k &refclk26m>;
+					clock-output-names = "apbc_kpc_mux";
+					marvell,mmp-clk-sel = <0 0x10 0x20>;
+					marvell,mmp-clk-reg = <0x30 0x70>;
+				};
+				apbc_kpc_clk: apbc_kpc_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_kpc_mux>;
+					clock-names = "apbc_kpc_clk";
+					marvell,mmp-clk-reg = <0x30 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_timer0_mux: apbc_timer0_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk13m &osc_32k &refclk7m &refclk3m>;
+					clock-output-names = "apbc_timer0_mux";
+					marvell,mmp-clk-sel = <0 0x10 0x20 0x30>;
+					marvell,mmp-clk-reg = <0x34 0x70>;
+				};
+				apbc_timer0_clk: apbc_timer0_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&timer0_mux>;
+					clock-names = "apbc_timer0_clk";
+					marvell,mmp-clk-reg = <0x34 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+			};
+			timer0_mux: timer0_mux {
+				compatible = "marvell,mmp-clkmux";
+				#clock-cells = <0>;
+				clocks = <&apbc_timer0_mux &osc_32k>;
+				clock-output-names = "timer0_mux";
+				marvell,mmp-clk-sel = <0 0x2>;
+				marvell,mmp-clk-reg = <0x14000 0x1c>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/pxa168.dtsi b/arch/arm/boot/dts/pxa168.dtsi
index 975dad2..250bf2c 100644
--- a/arch/arm/boot/dts/pxa168.dtsi
+++ b/arch/arm/boot/dts/pxa168.dtsi
@@ -8,6 +8,7 @@
  */
 
 /include/ "skeleton.dtsi"
+/include/ "pxa910-clk.dtsi"
 
 / {
 	aliases {
@@ -53,12 +54,15 @@
 				compatible = "mrvl,mmp-timer";
 				reg = <0xd4014000 0x100>;
 				interrupts = <13>;
+				clocks = <&apbc_timer0_clk>;
+				status = "disabled";
 			};
 
 			uart1: uart at d4017000 {
 				compatible = "mrvl,mmp-uart";
 				reg = <0xd4017000 0x1000>;
 				interrupts = <27>;
+				clocks = <&apbc_uart1_clk>;
 				status = "disabled";
 			};
 
@@ -66,6 +70,7 @@
 				compatible = "mrvl,mmp-uart";
 				reg = <0xd4018000 0x1000>;
 				interrupts = <28>;
+				clocks = <&apbc_uart2_clk>;
 				status = "disabled";
 			};
 
@@ -73,6 +78,7 @@
 				compatible = "mrvl,mmp-uart";
 				reg = <0xd4026000 0x1000>;
 				interrupts = <29>;
+				clocks = <&apbc_uart3_clk>;
 				status = "disabled";
 			};
 
@@ -87,6 +93,7 @@
 				interrupt-names = "gpio_mux";
 				interrupt-controller;
 				#interrupt-cells = <1>;
+				clocks = <&apbc_gpio_clk>;
 				ranges;
 
 				gcb0: gpio at d4019000 {
@@ -111,6 +118,7 @@
 				reg = <0xd4011000 0x1000>;
 				interrupts = <7>;
 				mrvl,i2c-fast-mode;
+				clocks = <&apbc_twsi1_clk>;
 				status = "disabled";
 			};
 
@@ -118,6 +126,7 @@
 				compatible = "mrvl,mmp-twsi";
 				reg = <0xd4025000 0x1000>;
 				interrupts = <58>;
+				clocks = <&apbc_twsi2_clk>;
 				status = "disabled";
 			};
 
@@ -126,6 +135,7 @@
 				reg = <0xd4010000 0x1000>;
 				interrupts = <5 6>;
 				interrupt-names = "rtc 1Hz", "rtc alarm";
+				clocks = <&apbc_rtc_clk>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm/boot/dts/pxa910-clk.dtsi b/arch/arm/boot/dts/pxa910-clk.dtsi
new file mode 100644
index 0000000..035697f
--- /dev/null
+++ b/arch/arm/boot/dts/pxa910-clk.dtsi
@@ -0,0 +1,569 @@
+/*
+ *  Copyright (C) 2013
+ *  Author: Haojian Zhuang <haojian.zhuang@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	soc {
+		axi at d4200000 {	/* AXI */
+			compatible = "mrvl,axi-bus", "simple-bus";
+			reg = <0xd4200000 0x00200000>;
+			ranges;
+
+			apmu: clocks at 82800 {
+				compatible = "marvell,mmp-apmu";
+				reg = <0xd4282800 0x100>;
+
+				/*
+				 * Processor clocks: pclk, pdclk, baclk, xpclk
+				 * DDR Controller clocks: dclk
+				 * AXI Fabric clocks: aclk
+				 */
+				pclk_refclk: refclk_pclk {
+					compatible = "marvell,mmp-apmu-clkdiv";
+					#clock-cells = <0>;
+					clocks = <&pj1_refclk>;
+					clock-output-names = "pclk";
+					marvell,mmp-clock-frequency = <104000000 156000000 208000000 312000000 500500000 624000000 806000000 1001000000>;
+					/* register offset & mask */
+					marvell,mmp-clk-reg = <0x4 0x7>;
+				};
+				/* pdclk -- DDR Interface clock */
+				pdclk_refclk: refclk_pdclk {
+					compatible = "marvell,mmp-apmu-clkdiv";
+					#clock-cells = <0>;
+					clocks = <&pj1_refclk>;
+					clock-output-names = "pdclk";
+					marvell,mmp-clock-frequency = <78000000 104000000 156000000 201000000 250250000>;
+					/* register offset & mask */
+					marvell,mmp-clk-reg = <0x4 0x38>;
+				};
+				/* baclk -- AXI Fabric Bus Interface clock */
+				baclk_refclk: refclk_baclk {
+					compatible = "marvell,mmp-apmu-clkdiv";
+					#clock-cells = <0>;
+					clocks = <&pj1_refclk>;
+					clock-output-names = "baclk";
+					marvell,mmp-clock-frequency = <78000000 104000000 156000000 201000000 250250000>;
+					/* register offset & mask */
+					marvell,mmp-clk-reg = <0x4 0x1c0>;
+				};
+				/* xpclk -- L2 interface clock */
+				xpclk_refclk: refclk_xpclk {
+					compatible = "marvell,mmp-apmu-clkdiv";
+					#clock-cells = <0>;
+					clocks = <&pj1_refclk>;
+					clock-output-names = "xpclk";
+					marvell,mmp-clock-frequency = <104000000 156000000 250250000 312000000 403000000 500500000>;
+					/* register offset & mask */
+					marvell,mmp-clk-reg = <0x4 0xe00>;
+				};
+				/* dclk -- DDR Controller clock */
+				dclk2x_refclk: refclk_dclk2x {
+					compatible = "marvell,mmp-apmu-clkdiv";
+					#clock-cells = <0>;
+					clocks = <&ddr_refclk>;
+					clock-output-names = "dclk2x";
+					marvell,mmp-clock-frequency = <208000000 312000000 402000000 500500000>;
+					/* register offset & mask */
+					marvell,mmp-clk-reg = <0x4 0x7000>;
+				};
+				dclk_refclk: refclk_dclk {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&dclk2x_refclk>;
+					clock-output-names = "dclk";
+					/* multiple & divider */
+					marvell,mmp-fixed-factor = <1 2>;
+				};
+				/* aclk -- AXI Fabric clock */
+				aclk_refclk: refclk_aclk {
+					compatible = "marvell,mmp-apmu-clkdiv";
+					#clock-cells = <0>;
+					clocks = <&axi_refclk>;
+					clock-output-names = "aclk";
+					marvell,mmp-clock-frequency = <104000000 156000000>;
+					/* register offset & mask */
+					marvell,mmp-clk-reg = <0x4 0x38000>;
+				};
+			};
+		};
+
+		apb at d4000000 {	/* APB */
+			compatible = "mrvl,apb-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xd4000000 0x00200000>;
+			ranges;
+
+			mpmu: clocks at 50000 {
+				compatible = "marvell,mmp-mpmu";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xd4050000 0x1100>;
+
+				osc_32k: osc32khz {
+					compatible = "fixed-clock";
+					#clock-cells = <0>;
+					clock-frequency = <32768>;
+					clock-output-names = "osc32khz";
+				};
+				osc_26m: osc26mhz {
+					compatible = "fixed-clock";
+					#clock-cells = <0>;
+					clock-frequency = <26000000>;
+					clock-output-names = "osc26mhz";
+				};
+				pll1_312m: refclk312mhz {
+					compatible = "marvell,mmp-fixed-clkrate";
+					#clock-cells = <0>;
+					clocks = <&osc_26m>;
+					clock-frequency = <312000000>;
+					clock-output-names = "refclk312mhz";
+				};
+				pll1_624m: refclk624mhz {
+					compatible = "marvell,mmp-fixed-clkrate";
+					#clock-cells = <0>;
+					clocks = <&osc_26m>;
+					clock-frequency = <624000000>;
+					clock-output-names = "refclk624mhz";
+				};
+				pj1_refclk: refclk_pj1 {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&pll1_312m &pll1_624m &pll2>;
+					clock-output-names = "refclk_pj1";
+					/* register value of each item */
+					marvell,mmp-clk-sel = <0 0x20000000 0x40000000>;
+					/* register offset & mask */
+					marvell,mmp-clk-reg = <0x8 0xe0000000>;
+				};
+				ddr_refclk: refclk_ddr {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&pll1_312m &pll1_624m &pll2>;
+					clock-output-names = "refclk_ddr";
+					/* register value of each item */
+					marvell,mmp-clk-sel = <0 0x00800000 0x01000000>;
+					/* register offset & mask */
+					marvell,mmp-clk-reg = <0x8 0x01800000>;
+				};
+				axi_refclk: refclk_axi {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&pll1_312m &pll1_624m>;
+					clock-output-names = "refclk_axi";
+					/* register value of each item */
+					marvell,mmp-clk-sel = <0 0x00080000>;
+					/* register offset & mask */
+					marvell,mmp-clk-reg = <0x8 0x00080000>;
+				};
+				refclk156m: refclk156mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&pll1_312m>;
+					clock-output-names = "refclk156mhz";
+					/* multiple & divider */
+					marvell,mmp-fixed-factor = <1 2>;
+				};
+				refclk118m: refclk117mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&refclk156m>;
+					/* 117.9648MHz */
+					clock-output-names = "refclk118mhz";
+					/* multiple & divider */
+					marvell,mmp-fixed-factor = <6144 8125>;
+				};
+				refclk104m: refclk104mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&pll1_312m>;
+					clock-output-names = "refclk104mhz";
+					/* multiple & divider */
+					marvell,mmp-fixed-factor = <1 3>;
+				};
+				refclk59m: refclk59mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&refclk118m>;
+					clock-names = "baud_58.98mhz";
+					/* 58.9824MHz */
+					clock-output-names = "refclk59mhz";
+					/* multiple & divider */
+					marvell,mmp-fixed-factor = <1 2>;
+				};
+				refclk52m: refclk52mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&refclk104m>;
+					clock-output-names = "refclk52mhz";
+					/* multiple & divider */
+					marvell,mmp-fixed-factor = <1 2>;
+				};
+				refclk48m: refclk48mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&pll1_624m>;
+					clock-output-names = "refclk48mhz";
+					/* multiple & divider */
+					marvell,mmp-fixed-factor = <1 13>;
+				};
+				refclk32m: refclk32mhz@ {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&refclk48m>;
+					clock-output-names = "refclk32mhz";
+					/* multiple & divider */
+					marvell,mmp-fixed-factor = <2 3>;
+				};
+				refclk26m: refclk26mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&refclk52m>;
+					clock-output-names = "refclk26mhz";
+					/* multiple & divider */
+					marvell,mmp-fixed-factor = <1 2>;
+				};
+				refclk15m: refclk15mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&refclk156m>;
+					clock-names = "baud_14.86mhz";
+					/* 14.857MHz */
+					clock-output-names = "refclk15mhz";
+					/* multiple & divider */
+					marvell,mmp-fixed-factor = <2 21>;
+				};
+				refclk13m: refclk13mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&refclk26m>;
+					clock-output-names = "refclk13mhz";
+					/* multiple & divider */
+					marvell,mmp-fixed-factor = <1 2>;
+				};
+				refclk7m: refclk7mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&refclk13m>;
+					clock-output-names = "refclk7mhz";
+					/* multiple & divider */
+					marvell,mmp-fixed-factor = <1 2>;
+				};
+				refclk3m: refclk3mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&refclk7m>;
+					clock-output-names = "refclk3mhz";
+					/* multiple & divider */
+					marvell,mmp-fixed-factor = <1 2>;
+				};
+				refclk16k: refclk16khz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&osc_32k>;
+					clock-output-names = "refclk16khz";
+					/* multiple & divider */
+					marvell,mmp-fixed-factor = <1 2>;
+				};
+			};
+
+			apbc: clocks at 15000 {
+				compatible = "marvell,mmp-apbc";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				#clock-cells = <0>;
+				reg = <0xd4015000 0x100>;
+
+				apbc_twsi1_clk: apbc_twsi1_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&refclk32m>;
+					clock-names = "apbc_twsi1_clk";
+					/* register value of each item */
+					marvell,mmp-clk-sel = <0>;
+					/* register offset & mask */
+					marvell,mmp-clk-reg = <0x2c 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_rtc_clk: apbc_rtc_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&osc_32k>;
+					clock-names = "apbc_rtc_clk";
+					marvell,mmp-clk-sel = <0>;
+					/* register offset & mask */
+					marvell,mmp-clk-reg = <0x28 0x70>;
+					marvell,mmp-apbc-power-ctl;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_gpio_clk: apbc_gpio_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&refclk26m>;
+					clock-names = "apbc_gpio_clk";
+					marvell,mmp-clk-sel = <0>;
+					/* register offset & mask */
+					marvell,mmp-clk-reg = <0x8 0x0>;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_uart1_mux: apbc_uart1_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk59m &refclk15m>;
+					clock-output-names = "apbc_uart1_mux";
+					/* register offset & mask */
+					marvell,mmp-clk-reg = <0x0 0x70>;
+					/* register value of each item */
+					marvell,mmp-clk-sel = <0 0x10>;
+				};
+				apbc_uart1_clk: apbc_uart1_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_uart1_mux>;
+					clock-names = "apbc_uart1_clk";
+					marvell,mmp-clk-reg = <0x0 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_uart2_mux: apbc_uart2_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk59m &refclk15m>;
+					clock-output-names = "apbc_uart2_mux";
+					/* register offset & mask */
+					marvell,mmp-clk-reg = <0x4 0x70>;
+					/* register value of each item */
+					marvell,mmp-clk-sel = <0 0x10>;
+				};
+				apbc_uart2_clk: apbc_uart2_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_uart2_mux>;
+					clock-names = "apbc_uart2_clk";
+					marvell,mmp-clk-reg = <0x4 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_pwm1_mux: apbc_pwm1_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk13m &osc_32k>;
+					clock-output-names = "apbc_pwm1_mux";
+					marvell,mmp-clk-sel = <0 0x10>;
+					marvell,mmp-clk-reg = <0xc 0x70>;
+				};
+				apbc_pwm1_clk: apbc_pwm1_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_pwm1_mux>;
+					clock-names = "apbc_pwm1_clk";
+					marvell,mmp-clk-reg = <0xc 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_pwm2_mux: apbc_pwm2_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk13m &osc_32k>;
+					clock-output-names = "apbc_pwm2_mux";
+					marvell,mmp-clk-sel = <0 0x10>;
+					marvell,mmp-clk-reg = <0x10 0x70>;
+				};
+				apbc_pwm2_clk: apbc_pwm2_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_pwm2_mux>;
+					clock-names = "apbc_pwm2_clk";
+					marvell,mmp-clk-reg = <0x10 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_pwm3_mux: apbc_pwm3_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk13m &osc_32k>;
+					clock-output-names = "apbc_pwm3_mux";
+					marvell,mmp-clk-sel = <0 0x10>;
+					marvell,mmp-clk-reg = <0x14 0x70>;
+				};
+				apbc_pwm3_clk: apbc_pwm3_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_pwm3_mux>;
+					clock-names = "apbc_pwm3_clk";
+					marvell,mmp-clk-reg = <0x14 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_pwm4_mux: apbc_pwm4_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk13m &osc_32k>;
+					clock-output-names = "apbc_pwm4_mux";
+					marvell,mmp-clk-sel = <0 0x10>;
+					marvell,mmp-clk-reg = <0x18 0x70>;
+				};
+				apbc_pwm4_clk: apbc_pwm4_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_pwm4_mux>;
+					clock-names = "apbc_pwm4_clk";
+					marvell,mmp-clk-reg = <0x18 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_ssp1_mux: apbc_ssp1_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk7m &refclk13m &refclk26m &refclk52m>;
+					clock-output-names = "apbc_ssp1_mux";
+					marvell,mmp-clk-sel = <0 0x10 0x20 0x30>;
+					marvell,mmp-clk-reg = <0x1c 0x70>;
+				};
+				apbc_ssp1_clk: apbc_ssp1_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_ssp1_mux>;
+					clock-names = "apbc_ssp1_clk";
+					marvell,mmp-clk-reg = <0x1c 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_ssp2_mux: apbc_ssp2_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk7m &refclk13m &refclk26m &refclk52m>;
+					clock-output-names = "apbc_ssp2_mux";
+					marvell,mmp-clk-sel = <0 0x10 0x20 0x30>;
+					marvell,mmp-clk-reg = <0x20 0x70>;
+				};
+				apbc_ssp2_clk: apbc_ssp2_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_ssp2_mux>;
+					clock-names = "apbc_ssp2_clk";
+					marvell,mmp-clk-reg = <0x20 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_ssp3_mux: apbc_ssp3_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk7m &refclk13m &refclk26m &refclk52m>;
+					clock-output-names = "apbc_ssp3_mux";
+					marvell,mmp-clk-sel = <0 0x10 0x20 0x30>;
+					marvell,mmp-clk-reg = <0x4c 0x70>;
+				};
+				apbc_ssp3_clk: apbc_ssp3_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_ssp3_mux>;
+					clock-names = "apbc_ssp3_clk";
+					marvell,mmp-clk-reg = <0x4c 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_kpc_mux: apbc_kpc_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&osc_32k &refclk16k &refclk26m>;
+					clock-output-names = "apbc_kpc_mux";
+					marvell,mmp-clk-sel = <0 0x10 0x20>;
+					marvell,mmp-clk-reg = <0x30 0x70>;
+				};
+				apbc_kpc_clk: apbc_kpc_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_kpc_mux>;
+					clock-names = "apbc_kpc_clk";
+					marvell,mmp-clk-reg = <0x30 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_timer0_mux: apbc_timer0_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk13m &osc_32k &refclk7m &refclk3m>;
+					clock-output-names = "apbc_timer0_mux";
+					marvell,mmp-clk-sel = <0 0x10 0x20 0x30>;
+					marvell,mmp-clk-reg = <0x34 0x70>;
+				};
+				apbc_timer0_clk: apbc_timer0_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&timer0_mux>;
+					clock-names = "apbc_timer0_clk";
+					marvell,mmp-clk-reg = <0x34 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+				apbc_timer1_mux: apbc_timer1_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk13m &osc_32k &refclk7m &refclk3m>;
+					clock-output-names = "apbc_timer1_mux";
+					marvell,mmp-clk-sel = <0 0x10 0x20 0x30>;
+					marvell,mmp-clk-reg = <0x44 0x70>;
+				};
+				apbc_timer1_clk: apbc_timer1_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&timer1_mux>;
+					clock-names = "apbc_timer1_clk";
+					marvell,mmp-clk-reg = <0x44 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+			};
+
+			apbcp: clocks at 3b000 {
+				compatible = "marvell,mmp-apbcp";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0xd403b000 0x100>;
+
+				apbcp_twsi2_clk: apbcp_twsi2_clk {
+					compatible = "marvell,mmp-apbcp-clock";
+					#clock-cells = <0>;
+					clocks = <&refclk32m>;
+					clock-output-names = "apbcp_twsi2_clk";
+					marvell,mmp-clk-sel = <0>;
+					/* register offset & mask */
+					marvell,mmp-clk-reg = <0x28 0x70>;
+				};
+				apbcp_uart3_mux: apbcp_uart3_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk59m &refclk15m>;
+					clock-output-names = "apbcp_uart3_mux";
+					/* register offset & mask */
+					marvell,mmp-clk-reg = <0x1c 0x70>;
+					/* register value of each item */
+					marvell,mmp-clk-sel = <0 0x10>;
+				};
+				apbcp_uart3_clk: apbcp_uart3_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbcp_uart3_mux>;
+					clock-names = "apbcp_uart3_clk";
+					marvell,mmp-clk-reg = <0x1c 0x70>;
+					marvell,mmp-clk-delay = <10>;
+				};
+			};
+
+			timer0_mux: timer0_mux {
+				compatible = "marvell,mmp-clkmux";
+				#clock-cells = <0>;
+				clocks = <&refclk3m &osc_32k &apbc_timer0_mux>;
+				clock-output-names = "timer0_mux";
+				marvell,mmp-clk-sel = <0 0x1 0x3>;
+				marvell,mmp-clk-reg = <0x14000 0x1c>;
+			};
+
+			timer1_mux: timer1_mux {
+				compatible = "marvell,mmp-clkmux";
+				#clock-cells = <0>;
+				clocks = <&refclk3m &osc_32k &apbc_timer1_mux>;
+				clock-output-names = "timer1_mux";
+				marvell,mmp-clk-sel = <0 0x1 0x3>;
+				marvell,mmp-clk-reg = <0x16000 0x1c>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/pxa910-dkb.dts b/arch/arm/boot/dts/pxa910-dkb.dts
index 595492a..b892ebe 100644
--- a/arch/arm/boot/dts/pxa910-dkb.dts
+++ b/arch/arm/boot/dts/pxa910-dkb.dts
@@ -24,6 +24,17 @@
 
 	soc {
 		apb at d4000000 {
+			pll2: refclk1001mhz {
+				/* Reference clock for internal PLL2 */
+				compatible = "marvell,mmp-fixed-clkrate";
+				#clock-cells = <0>;
+				clocks = <&osc_26m>;
+				clock-frequency = <1001000000>;
+				clock-output-names = "refclk1001mhz";
+			};
+			timer0: timer at d4014000 {
+				status = "okay";
+			};
 			uart1: uart at d4017000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/pxa910.dtsi b/arch/arm/boot/dts/pxa910.dtsi
index 0247c62..cd888d3 100644
--- a/arch/arm/boot/dts/pxa910.dtsi
+++ b/arch/arm/boot/dts/pxa910.dtsi
@@ -8,6 +8,7 @@
  */
 
 /include/ "skeleton.dtsi"
+/include/ "pxa910-clk.dtsi"
 
 / {
 	aliases {
@@ -44,7 +45,6 @@
 				reg = <0xd4282000 0x1000>;
 				mrvl,intc-nr-irqs = <64>;
 			};
-
 		};
 
 		apb at d4000000 {	/* APB */
@@ -58,12 +58,15 @@
 				compatible = "mrvl,mmp-timer";
 				reg = <0xd4014000 0x100>;
 				interrupts = <13>;
+				clocks = <&apbc_timer0_clk>;
+				status = "disabled";
 			};
 
 			timer1: timer at d4016000 {
 				compatible = "mrvl,mmp-timer";
 				reg = <0xd4016000 0x100>;
 				interrupts = <29>;
+				clocks = <&apbc_timer1_clk>;
 				status = "disabled";
 			};
 
@@ -71,6 +74,7 @@
 				compatible = "mrvl,mmp-uart";
 				reg = <0xd4017000 0x1000>;
 				interrupts = <27>;
+				clocks = <&apbc_uart1_clk>;
 				status = "disabled";
 			};
 
@@ -78,6 +82,7 @@
 				compatible = "mrvl,mmp-uart";
 				reg = <0xd4018000 0x1000>;
 				interrupts = <28>;
+				clocks = <&apbc_uart2_clk>;
 				status = "disabled";
 			};
 
@@ -85,6 +90,7 @@
 				compatible = "mrvl,mmp-uart";
 				reg = <0xd4036000 0x1000>;
 				interrupts = <59>;
+				clocks = <&apbcp_uart3_clk>;
 				status = "disabled";
 			};
 
@@ -99,6 +105,7 @@
 				interrupt-names = "gpio_mux";
 				interrupt-controller;
 				#interrupt-cells = <1>;
+				clocks = <&apbc_gpio_clk>;
 				ranges;
 
 				gcb0: gpio at d4019000 {
@@ -124,6 +131,7 @@
 				#size-cells = <0>;
 				reg = <0xd4011000 0x1000>;
 				interrupts = <7>;
+				clocks = <&apbc_twsi1_clk>;
 				mrvl,i2c-fast-mode;
 				status = "disabled";
 			};
@@ -134,6 +142,7 @@
 				#size-cells = <0>;
 				reg = <0xd4037000 0x1000>;
 				interrupts = <54>;
+				clocks = <&apbcp_twsi2_clk>;
 				status = "disabled";
 			};
 
@@ -142,6 +151,7 @@
 				reg = <0xd4010000 0x1000>;
 				interrupts = <5 6>;
 				interrupt-names = "rtc 1Hz", "rtc alarm";
+				clocks = <&apbc_rtc_clk>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm/mach-mmp/mmp-dt.c b/arch/arm/mach-mmp/mmp-dt.c
index aaca3c8..9227b16 100644
--- a/arch/arm/mach-mmp/mmp-dt.c
+++ b/arch/arm/mach-mmp/mmp-dt.c
@@ -9,6 +9,7 @@
  *  publishhed by the Free Software Foundation.
  */
 
+#include <linux/clk-provider.h>
 #include <linux/irqchip.h>
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
@@ -48,6 +49,7 @@ static void __init pxa168_dt_init(void)
 
 static void __init pxa910_dt_init(void)
 {
+	of_clk_init(NULL);
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     pxa910_auxdata_lookup, NULL);
 }
diff --git a/drivers/clk/mmp/Makefile b/drivers/clk/mmp/Makefile
index 392d780..83182e5 100644
--- a/drivers/clk/mmp/Makefile
+++ b/drivers/clk/mmp/Makefile
@@ -2,7 +2,7 @@
 # Makefile for mmp specific clk
 #
 
-obj-y += clk-apbc.o clk-apmu.o clk-frac.o
+obj-y += clk-apbc.o clk-apmu.o clk-frac.o clk-mmp.o
 
 obj-$(CONFIG_CPU_PXA168) += clk-pxa168.o
 obj-$(CONFIG_CPU_PXA910) += clk-pxa910.o
diff --git a/drivers/clk/mmp/clk-mmp.c b/drivers/clk/mmp/clk-mmp.c
new file mode 100644
index 0000000..7ead432
--- /dev/null
+++ b/drivers/clk/mmp/clk-mmp.c
@@ -0,0 +1,363 @@
+/*
+ * Marvell MMP clock driver
+ *
+ * Copyright (c) 2012 Linaro Limited.
+ *
+ * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
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
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+
+#include "clk.h"
+
+enum {
+	MMP_MPMU = 0,
+	MMP_APMU,
+	MMP_APBC,
+	MMP_APBCP,
+	MMP_APB,
+	MMP_MAX,
+};
+
+static void __iomem *mmp_clk_base[MMP_MAX];
+
+static DEFINE_SPINLOCK(mmp_clk_lock);
+
+static const struct of_device_id mmp_of_match[] = {
+	{ .compatible = "marvell,mmp-mpmu", .data = (void *)MMP_MPMU, },
+	{ .compatible = "marvell,mmp-apmu", .data = (void *)MMP_APMU, },
+	{ .compatible = "marvell,mmp-apbc", .data = (void *)MMP_APBC, },
+	{ .compatible = "marvell,mmp-apbcp", .data = (void *)MMP_APBCP, },
+	{ .compatible = "mrvl,apb-bus", .data = (void *)MMP_APB, },
+};
+
+void __iomem __init *mmp_init_clocks(struct device_node *np)
+{
+	struct device_node *parent;
+	const struct of_device_id *match;
+	void __iomem *ret = NULL;
+	int i;
+
+	parent = of_get_parent(np);
+	if (!parent)
+		goto out;
+	match = of_match_node(mmp_of_match, parent);
+	if (!match)
+		goto out;
+
+	i = (unsigned int)match->data;
+	switch (i) {
+	case MMP_MPMU:
+	case MMP_APMU:
+	case MMP_APBC:
+	case MMP_APBCP:
+	case MMP_APB:
+		if (!mmp_clk_base[i]) {
+			ret = of_iomap(parent, 0);
+			WARN_ON(!ret);
+			mmp_clk_base[i] = ret;
+		} else {
+			ret = mmp_clk_base[i];
+		}
+		break;
+	default:
+		goto out;
+	}
+out:
+	return ret;
+}
+
+static void __init mmp_fixed_rate_setup(struct device_node *np)
+{
+	struct clk *clk;
+	const char *clk_name, *parent_name;
+	int rate;
+
+	if (of_property_read_u32(np, "clock-frequency", &rate))
+		return;
+
+	if (of_property_read_string(np, "clock-output-names", &clk_name))
+		return;
+
+	/* this node has only one parent */
+	parent_name = of_clk_get_parent_name(np, 0);
+	if (!parent_name)
+		return;
+
+	clk = clk_register_fixed_rate(NULL, clk_name, parent_name, 0, rate);
+	if (IS_ERR(clk))
+		return;
+	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+}
+CLK_OF_DECLARE(mmp_fixed_rate, "marvell,mmp-fixed-clkrate",
+	       mmp_fixed_rate_setup);
+
+static void __init mmp_fixed_factor_setup(struct device_node *np)
+{
+	struct clk *clk;
+	const char *clk_name, *output_name, *parent_name;
+	u32 data[2];
+
+	if (of_property_read_u32_array(np, "marvell,mmp-fixed-factor",
+				&data[0], 2))
+		return;
+	if (of_property_read_string(np, "clock-output-names", &output_name))
+		return;
+
+	/* this node has only one parent */
+	parent_name = of_clk_get_parent_name(np, 0);
+	if (!parent_name)
+		return;
+
+	clk = clk_register_fixed_factor(NULL, output_name, parent_name, 0,
+			data[0], data[1]);
+	if (IS_ERR(clk))
+		return;
+	if (!of_property_read_string(np, "clock-names", &clk_name))
+		clk_register_clkdev(clk, clk_name, NULL);
+	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+}
+CLK_OF_DECLARE(mmp_fixed_factor, "marvell,mmp-fixed-clkfactor",
+	       mmp_fixed_factor_setup);
+
+static void __init mmp_apmu_div_setup(struct device_node *np)
+{
+	u32 data[2];
+	u8 shift, width;
+	void __iomem *reg, *base;
+	const char *parent_name, *clk_name;
+	struct clk *clk;
+
+	base = mmp_init_clocks(np);
+	if (!base)
+		return;
+
+	if (of_property_read_u32_array(np, "marvell,mmp-clk-reg", &data[0], 2))
+		return;
+	reg = base + data[0];
+	shift = ffs(data[1]) - 1;
+	width = fls(data[1]) - ffs(data[1]) + 1;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+	if (!parent_name)
+		return;
+	if (of_property_read_string(np, "clock-output-names", &clk_name))
+		return;
+
+	clk = clk_register_divider(NULL, clk_name, parent_name,
+			CLK_SET_RATE_PARENT, reg, shift, width, 0,
+			&mmp_clk_lock);
+	if (IS_ERR(clk))
+		return;
+	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	return;
+}
+CLK_OF_DECLARE(mmp_div, "mmp-apmu-clkdiv", mmp_apmu_div_setup);
+
+static int __init mmp_parse_mux(struct device_node *np,
+				const char **parent_names,
+				u8 *num_parents,
+				u32 *clk_sel)
+{
+	int i, cnt, ret;
+
+	/* get the count of items in mux */
+	for (i = 0, cnt = 0; ; i++, cnt++) {
+		/* parent's #clock-cells property is always 0 */
+		if (!of_parse_phandle(np, "clocks", i))
+			break;
+	}
+
+	for (i = 0; ; i++) {
+		if (!of_clk_get_parent_name(np, i))
+			break;
+	}
+	*num_parents = i;
+	if (!*num_parents)
+		return -ENOENT;
+
+	clk_sel = kzalloc(sizeof(u32 *) * *num_parents, GFP_KERNEL);
+	if (!clk_sel)
+		return -ENOMEM;
+	ret = of_property_read_u32_array(np, "marvell,mmp-clk-sel", clk_sel, cnt);
+	if (ret)
+		goto err;
+	return 0;
+err:
+	kfree(clk_sel);
+	return ret;
+}
+
+static void __init mmp_mux_setup(struct device_node *np)
+{
+	u32 data[2], *clk_sel, mux_flags = 0;
+	u8 shift, width, num_parents;
+	void __iomem *reg, *base;
+	const char **parent_names;
+	const char *clk_name;
+	struct clk *clk;
+	int i, ret;
+
+	base = mmp_init_clocks(np);
+	if (!base)
+		return;
+	if (of_property_read_string(np, "clock-output-names", &clk_name))
+		return;
+	if (of_property_read_u32_array(np, "marvell,mmp-clk-reg", &data[0], 2))
+		return;
+	ret = mmp_parse_mux(np, parent_names, &num_parents, clk_sel);
+	if (ret)
+		return;
+
+	reg = base + data[0];
+	shift = ffs(data[1]) - 1;
+	width = fls(data[1]) - ffs(data[1]) + 1;
+
+	parent_names = kzalloc(sizeof(char *) * num_parents, GFP_KERNEL);
+	if (!parent_names)
+		return;
+
+	for (i = 0; i < num_parents; i++)
+		parent_names[i] = of_clk_get_parent_name(np, i);
+	clk = clk_register_mux(NULL, clk_name, parent_names, num_parents,
+			       CLK_SET_RATE_PARENT, reg, shift, width,
+			       mux_flags, &mmp_clk_lock);
+	if (IS_ERR(clk)) {
+		kfree(parent_names);
+		return;
+	}
+	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+}
+CLK_OF_DECLARE(mmp_mux, "marvell,mmp-clkmux", mmp_mux_setup);
+
+#define APBC_NO_BUS_CTRL	BIT(0)
+#define APBC_POWER_CTRL		BIT(1)
+
+static void __init mmp_apbc_setup(struct device_node *np)
+{
+	u32 data[2], delay, apbc_flags, clkdev;
+	void __iomem *reg, *base;
+	const char **parent_names;
+	const char *clk_name = NULL;
+	struct clk *clk;
+
+	base = mmp_init_clocks(np);
+	if (!base)
+		return;
+
+	if (of_property_read_string(np, "clock-names", &clk_name))
+		clkdev = 1;
+	else {
+		of_property_read_string(np, "clock-output-names", &clk_name);
+		clkdev = 0;
+	}
+
+	if (of_property_read_u32_array(np, "marvell,mmp-clk-reg", &data[0], 2))
+		return;
+	/* If marvell,mmp-clk-delay property isn't defined, set delay as 10us */
+	if (of_property_read_u32(np, "marvell,mmp-clk-delay", &delay))
+		delay = 10;
+	if (of_get_property(np, "marvell,mmp-apbc-power-ctl", NULL))
+		apbc_flags |= APBC_POWER_CTRL;
+
+	reg = base + data[0];
+
+	/* only has the fixed parent */
+	parent_names = kzalloc(sizeof(char *), GFP_KERNEL);
+	if (!parent_names)
+		return;
+	parent_names[0] = of_clk_get_parent_name(np, 0);
+
+	clk = mmp_clk_register_apbc(clk_name, parent_names[0],
+				    reg, delay, 0, &mmp_clk_lock);
+	if (IS_ERR(clk)) {
+		kfree(parent_names);
+		return;
+	}
+	if (clkdev)
+		clk_register_clkdev(clk, clk_name, NULL);
+	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+}
+CLK_OF_DECLARE(mmp_apbc, "marvell,mmp-apbc-clk", mmp_apbc_setup);
+
+static void __init mmp_apbcp_setup(struct device_node *np)
+{
+	int i, cnt;
+	u32 *clk_sel, data[2];
+	u8 num_parents, shift, width;
+	void __iomem *reg, *base;
+	const char **parent_names, *clk_name;
+	struct clk *clk;
+
+	base = mmp_init_clocks(np);
+	if (!base)
+		return;
+
+	if (of_property_read_string(np, "clock-output-names", &clk_name))
+		return;
+	/* get the count of items in mux */
+	for (i = 0, cnt = 0; ; i++, cnt++) {
+		/* parent's #clock-cells property is always 0 */
+		if (!of_parse_phandle(np, "clocks", i))
+			break;
+	}
+
+	for (i = 0; ; i++) {
+		if (!of_clk_get_parent_name(np, i))
+			break;
+	}
+	num_parents = i;
+	if (!num_parents)
+		return;
+
+	if (of_property_read_u32_array(np, "marvell,mmp-clk-reg", &data[0], 2))
+		return;
+	reg = base + data[0];
+	shift = ffs(data[1]) - 1;
+	width = fls(data[1]) - ffs(data[1]) + 1;
+
+	clk_sel = kzalloc(sizeof(u32 *) * num_parents, GFP_KERNEL);
+	if (!clk_sel)
+		return;
+	if (of_property_read_u32_array(np, "marvell,mmp-clk-sel", clk_sel, cnt))
+		goto err_sel;
+	parent_names = kzalloc(sizeof(char *) * num_parents, GFP_KERNEL);
+	if (!parent_names)
+		goto err_sel;
+
+	for (i = 0; i < num_parents; i++)
+		parent_names[i] = of_clk_get_parent_name(np, i);
+	clk = clk_register_mux(NULL, clk_name, parent_names, num_parents, 0,
+				reg, shift, width, 0, &mmp_clk_lock);
+	if (IS_ERR(clk))
+		goto err_mux;
+	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	return;
+err_mux:
+	kfree(parent_names);
+err_sel:
+	kfree(clk_sel);
+}
+CLK_OF_DECLARE(mmp_apbcp, "mmp-apbcp-clk", mmp_apbcp_setup);
-- 
1.8.1.2
