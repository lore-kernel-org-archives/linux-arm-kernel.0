From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 26 Jul 2013 18:05:32 +0800
Subject: [PATCH v6 10/11] ARM: dts: support common clock in arch mmp
In-Reply-To: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
References: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1374833133-21119-11-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support common clock in DTS file for arch mmp.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/boot/dts/pxa168-aspenite.dts |   3 +
 arch/arm/boot/dts/pxa168-clk.dtsi     | 304 ++++++++++++++++++
 arch/arm/boot/dts/pxa168.dtsi         |  10 +
 arch/arm/boot/dts/pxa910-clk.dtsi     | 569 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/pxa910-dkb.dts      |  11 +
 arch/arm/boot/dts/pxa910.dtsi         |  12 +-
 6 files changed, 908 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/pxa168-clk.dtsi
 create mode 100644 arch/arm/boot/dts/pxa910-clk.dtsi

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
index 0000000..c0d5bd1
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
+					mmp-fixed-factor = <1 2>;
+				};
+				refclk118m: refclk117mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&refclk156m>;
+					/* 117.9648MHz */
+					clock-output-names = "refclk118mhz";
+					/* multiple & divider */
+					mmp-fixed-factor = <6144 8125>;
+				};
+				refclk104m: refclk104mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&pll1_312m>;
+					clock-output-names = "refclk104mhz";
+					/* multiple & divider */
+					mmp-fixed-factor = <1 3>;
+				};
+				refclk59m: refclk59mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&refclk118m>;
+					clock-names = "baud_58.98mhz";
+					/* 58.9824MHz */
+					clock-output-names = "refclk59mhz";
+					/* multiple & divider */
+					mmp-fixed-factor = <1 2>;
+				};
+				refclk15m: refclk15mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&refclk156m>;
+					clock-names = "baud_14.86mhz";
+					/* 14.857MHz */
+					clock-output-names = "refclk15mhz";
+					/* multiple & divider */
+					mmp-fixed-factor = <2 21>;
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
+					mmp-clk-sel = <0>;
+					/* register offset & mask */
+					mmp-clk-reg = <0x2c 0x70>;
+					mmp-clk-delay = <10>;
+				};
+				apbc_twsi2_clk: apbc_twsi2_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&refclk32m>;
+					clock-names = "apbc_twsi2_clk";
+					/* register value of each item */
+					mmp-clk-sel = <0>;
+					/* register offset & mask */
+					mmp-clk-reg = <0x6c 0x70>;
+					mmp-clk-delay = <10>;
+				};
+				apbc_rtc_clk: apbc_rtc_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&osc_32k>;
+					clock-names = "apbc_rtc_clk";
+					mmp-clk-sel = <0>;
+					/* register offset & mask */
+					mmp-clk-reg = <0x28 0x70>;
+					marvell,mmp-apbc-power-ctl;
+					mmp-clk-delay = <10>;
+				};
+				apbc_gpio_clk: apbc_gpio_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&refclk26m>;
+					clock-names = "apbc_gpio_clk";
+					mmp-clk-sel = <0>;
+					/* register offset & mask */
+					mmp-clk-reg = <0x8 0x0>;
+					mmp-clk-delay = <10>;
+				};
+				apbc_uart1_mux: apbc_uart1_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk59m &refclk15m>;
+					clock-output-names = "apbc_uart1_mux";
+					/* register offset & mask */
+					mmp-clk-reg = <0x0 0x70>;
+					/* register value of each item */
+					mmp-clk-sel = <0 0x10>;
+				};
+				apbc_uart1_clk: apbc_uart1_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_uart1_mux>;
+					clock-names = "apbc_uart1_clk";
+					mmp-clk-reg = <0x0 0x70>;
+					mmp-clk-delay = <10>;
+				};
+				apbc_uart2_mux: apbc_uart2_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk59m &refclk15m>;
+					clock-output-names = "apbc_uart2_mux";
+					/* register offset & mask */
+					mmp-clk-reg = <0x4 0x70>;
+					/* register value of each item */
+					mmp-clk-sel = <0 0x10>;
+				};
+				apbc_uart2_clk: apbc_uart2_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_uart2_mux>;
+					clock-names = "apbc_uart2_clk";
+					mmp-clk-reg = <0x4 0x70>;
+					mmp-clk-delay = <10>;
+				};
+				apbc_uart3_mux: apbc_uart3_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk59m &refclk15m>;
+					clock-output-names = "apbc_uart3_mux";
+					/* register offset & mask */
+					mmp-clk-reg = <0x70 0x70>;
+					/* register value of each item */
+					mmp-clk-sel = <0 0x10>;
+				};
+				apbc_uart3_clk: apbc_uart3_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_uart3_mux>;
+					clock-names = "apbc_uart3_clk";
+					mmp-clk-reg = <0x70 0x70>;
+					mmp-clk-delay = <10>;
+				};
+				apbc_pwm1_mux: apbc_pwm1_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk13m &osc_32k>;
+					clock-output-names = "apbc_pwm1_mux";
+					mmp-clk-sel = <0 0x10>;
+					mmp-clk-reg = <0xc 0x70>;
+				};
+				apbc_pwm1_clk: apbc_pwm1_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_pwm1_mux>;
+					clock-names = "apbc_pwm1_clk";
+					mmp-clk-reg = <0xc 0x70>;
+					mmp-clk-delay = <10>;
+				};
+				apbc_pwm2_mux: apbc_pwm2_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk13m &osc_32k>;
+					clock-output-names = "apbc_pwm2_mux";
+					mmp-clk-sel = <0 0x10>;
+					mmp-clk-reg = <0x10 0x70>;
+				};
+				apbc_pwm2_clk: apbc_pwm2_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_pwm2_mux>;
+					clock-names = "apbc_pwm2_clk";
+					mmp-clk-reg = <0x10 0x70>;
+					mmp-clk-delay = <10>;
+				};
+				apbc_pwm3_mux: apbc_pwm3_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk13m &osc_32k>;
+					clock-output-names = "apbc_pwm3_mux";
+					mmp-clk-sel = <0 0x10>;
+					mmp-clk-reg = <0x14 0x70>;
+				};
+				apbc_pwm3_clk: apbc_pwm3_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_pwm3_mux>;
+					clock-names = "apbc_pwm3_clk";
+					mmp-clk-reg = <0x14 0x70>;
+					mmp-clk-delay = <10>;
+				};
+				apbc_pwm4_mux: apbc_pwm4_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk13m &osc_32k>;
+					clock-output-names = "apbc_pwm4_mux";
+					mmp-clk-sel = <0 0x10>;
+					mmp-clk-reg = <0x18 0x70>;
+				};
+				apbc_pwm4_clk: apbc_pwm4_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_pwm4_mux>;
+					clock-names = "apbc_pwm4_clk";
+					mmp-clk-reg = <0x18 0x70>;
+					mmp-clk-delay = <10>;
+				};
+				apbc_kpc_mux: apbc_kpc_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&osc_32k &refclk16k &refclk26m>;
+					clock-output-names = "apbc_kpc_mux";
+					mmp-clk-sel = <0 0x10 0x20>;
+					mmp-clk-reg = <0x30 0x70>;
+				};
+				apbc_kpc_clk: apbc_kpc_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_kpc_mux>;
+					clock-names = "apbc_kpc_clk";
+					mmp-clk-reg = <0x30 0x70>;
+					mmp-clk-delay = <10>;
+				};
+				apbc_timer0_mux: apbc_timer0_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk13m &osc_32k &refclk7m &refclk3m>;
+					clock-output-names = "apbc_timer0_mux";
+					mmp-clk-sel = <0 0x10 0x20 0x30>;
+					mmp-clk-reg = <0x34 0x70>;
+				};
+				apbc_timer0_clk: apbc_timer0_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&timer0_mux>;
+					clock-names = "apbc_timer0_clk";
+					mmp-clk-reg = <0x34 0x70>;
+					mmp-clk-delay = <10>;
+				};
+			};
+			timer0_mux: timer0_mux {
+				compatible = "marvell,mmp-clkmux";
+				#clock-cells = <0>;
+				clocks = <&apbc_timer0_mux &osc_32k>;
+				clock-output-names = "timer0_mux";
+				mmp-clk-sel = <0 0x2>;
+				mmp-clk-reg = <0x14000 0x1c>;
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
index 0000000..2d9f9ca
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
+					mmp-clk-reg = <0x4 0x7>;
+				};
+				/* pdclk -- DDR Interface clock */
+				pdclk_refclk: refclk_pdclk {
+					compatible = "marvell,mmp-apmu-clkdiv";
+					#clock-cells = <0>;
+					clocks = <&pj1_refclk>;
+					clock-output-names = "pdclk";
+					marvell,mmp-clock-frequency = <78000000 104000000 156000000 201000000 250250000>;
+					/* register offset & mask */
+					mmp-clk-reg = <0x4 0x38>;
+				};
+				/* baclk -- AXI Fabric Bus Interface clock */
+				baclk_refclk: refclk_baclk {
+					compatible = "marvell,mmp-apmu-clkdiv";
+					#clock-cells = <0>;
+					clocks = <&pj1_refclk>;
+					clock-output-names = "baclk";
+					marvell,mmp-clock-frequency = <78000000 104000000 156000000 201000000 250250000>;
+					/* register offset & mask */
+					mmp-clk-reg = <0x4 0x1c0>;
+				};
+				/* xpclk -- L2 interface clock */
+				xpclk_refclk: refclk_xpclk {
+					compatible = "marvell,mmp-apmu-clkdiv";
+					#clock-cells = <0>;
+					clocks = <&pj1_refclk>;
+					clock-output-names = "xpclk";
+					marvell,mmp-clock-frequency = <104000000 156000000 250250000 312000000 403000000 500500000>;
+					/* register offset & mask */
+					mmp-clk-reg = <0x4 0xe00>;
+				};
+				/* dclk -- DDR Controller clock */
+				dclk2x_refclk: refclk_dclk2x {
+					compatible = "marvell,mmp-apmu-clkdiv";
+					#clock-cells = <0>;
+					clocks = <&ddr_refclk>;
+					clock-output-names = "dclk2x";
+					marvell,mmp-clock-frequency = <208000000 312000000 402000000 500500000>;
+					/* register offset & mask */
+					mmp-clk-reg = <0x4 0x7000>;
+				};
+				dclk_refclk: refclk_dclk {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&dclk2x_refclk>;
+					clock-output-names = "dclk";
+					/* multiple & divider */
+					mmp-fixed-factor = <1 2>;
+				};
+				/* aclk -- AXI Fabric clock */
+				aclk_refclk: refclk_aclk {
+					compatible = "marvell,mmp-apmu-clkdiv";
+					#clock-cells = <0>;
+					clocks = <&axi_refclk>;
+					clock-output-names = "aclk";
+					marvell,mmp-clock-frequency = <104000000 156000000>;
+					/* register offset & mask */
+					mmp-clk-reg = <0x4 0x38000>;
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
+					mmp-clk-sel = <0 0x20000000 0x40000000>;
+					/* register offset & mask */
+					mmp-clk-reg = <0x8 0xe0000000>;
+				};
+				ddr_refclk: refclk_ddr {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&pll1_312m &pll1_624m &pll2>;
+					clock-output-names = "refclk_ddr";
+					/* register value of each item */
+					mmp-clk-sel = <0 0x00800000 0x01000000>;
+					/* register offset & mask */
+					mmp-clk-reg = <0x8 0x01800000>;
+				};
+				axi_refclk: refclk_axi {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&pll1_312m &pll1_624m>;
+					clock-output-names = "refclk_axi";
+					/* register value of each item */
+					mmp-clk-sel = <0 0x00080000>;
+					/* register offset & mask */
+					mmp-clk-reg = <0x8 0x00080000>;
+				};
+				refclk156m: refclk156mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&pll1_312m>;
+					clock-output-names = "refclk156mhz";
+					/* multiple & divider */
+					mmp-fixed-factor = <1 2>;
+				};
+				refclk118m: refclk117mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&refclk156m>;
+					/* 117.9648MHz */
+					clock-output-names = "refclk118mhz";
+					/* multiple & divider */
+					mmp-fixed-factor = <6144 8125>;
+				};
+				refclk104m: refclk104mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&pll1_312m>;
+					clock-output-names = "refclk104mhz";
+					/* multiple & divider */
+					mmp-fixed-factor = <1 3>;
+				};
+				refclk59m: refclk59mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&refclk118m>;
+					clock-names = "baud_58.98mhz";
+					/* 58.9824MHz */
+					clock-output-names = "refclk59mhz";
+					/* multiple & divider */
+					mmp-fixed-factor = <1 2>;
+				};
+				refclk52m: refclk52mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&refclk104m>;
+					clock-output-names = "refclk52mhz";
+					/* multiple & divider */
+					mmp-fixed-factor = <1 2>;
+				};
+				refclk48m: refclk48mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&pll1_624m>;
+					clock-output-names = "refclk48mhz";
+					/* multiple & divider */
+					mmp-fixed-factor = <1 13>;
+				};
+				refclk32m: refclk32mhz@ {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&refclk48m>;
+					clock-output-names = "refclk32mhz";
+					/* multiple & divider */
+					mmp-fixed-factor = <2 3>;
+				};
+				refclk26m: refclk26mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&refclk52m>;
+					clock-output-names = "refclk26mhz";
+					/* multiple & divider */
+					mmp-fixed-factor = <1 2>;
+				};
+				refclk15m: refclk15mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&refclk156m>;
+					clock-names = "baud_14.86mhz";
+					/* 14.857MHz */
+					clock-output-names = "refclk15mhz";
+					/* multiple & divider */
+					mmp-fixed-factor = <2 21>;
+				};
+				refclk13m: refclk13mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&refclk26m>;
+					clock-output-names = "refclk13mhz";
+					/* multiple & divider */
+					mmp-fixed-factor = <1 2>;
+				};
+				refclk7m: refclk7mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&refclk13m>;
+					clock-output-names = "refclk7mhz";
+					/* multiple & divider */
+					mmp-fixed-factor = <1 2>;
+				};
+				refclk3m: refclk3mhz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&refclk7m>;
+					clock-output-names = "refclk3mhz";
+					/* multiple & divider */
+					mmp-fixed-factor = <1 2>;
+				};
+				refclk16k: refclk16khz {
+					compatible = "marvell,mmp-fixed-clkfactor";
+					#clock-cells = <0>;
+					clocks = <&osc_32k>;
+					clock-output-names = "refclk16khz";
+					/* multiple & divider */
+					mmp-fixed-factor = <1 2>;
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
+					mmp-clk-sel = <0>;
+					/* register offset & mask */
+					mmp-clk-reg = <0x2c 0x70>;
+					mmp-clk-delay = <10>;
+				};
+				apbc_rtc_clk: apbc_rtc_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&osc_32k>;
+					clock-names = "apbc_rtc_clk";
+					mmp-clk-sel = <0>;
+					/* register offset & mask */
+					mmp-clk-reg = <0x28 0x70>;
+					marvell,mmp-apbc-power-ctl;
+					mmp-clk-delay = <10>;
+				};
+				apbc_gpio_clk: apbc_gpio_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&refclk26m>;
+					clock-names = "apbc_gpio_clk";
+					mmp-clk-sel = <0>;
+					/* register offset & mask */
+					mmp-clk-reg = <0x8 0x0>;
+					mmp-clk-delay = <10>;
+				};
+				apbc_uart1_mux: apbc_uart1_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk59m &refclk15m>;
+					clock-output-names = "apbc_uart1_mux";
+					/* register offset & mask */
+					mmp-clk-reg = <0x0 0x70>;
+					/* register value of each item */
+					mmp-clk-sel = <0 0x10>;
+				};
+				apbc_uart1_clk: apbc_uart1_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_uart1_mux>;
+					clock-names = "apbc_uart1_clk";
+					mmp-clk-reg = <0x0 0x70>;
+					mmp-clk-delay = <10>;
+				};
+				apbc_uart2_mux: apbc_uart2_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk59m &refclk15m>;
+					clock-output-names = "apbc_uart2_mux";
+					/* register offset & mask */
+					mmp-clk-reg = <0x4 0x70>;
+					/* register value of each item */
+					mmp-clk-sel = <0 0x10>;
+				};
+				apbc_uart2_clk: apbc_uart2_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_uart2_mux>;
+					clock-names = "apbc_uart2_clk";
+					mmp-clk-reg = <0x4 0x70>;
+					mmp-clk-delay = <10>;
+				};
+				apbc_pwm1_mux: apbc_pwm1_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk13m &osc_32k>;
+					clock-output-names = "apbc_pwm1_mux";
+					mmp-clk-sel = <0 0x10>;
+					mmp-clk-reg = <0xc 0x70>;
+				};
+				apbc_pwm1_clk: apbc_pwm1_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_pwm1_mux>;
+					clock-names = "apbc_pwm1_clk";
+					mmp-clk-reg = <0xc 0x70>;
+					mmp-clk-delay = <10>;
+				};
+				apbc_pwm2_mux: apbc_pwm2_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk13m &osc_32k>;
+					clock-output-names = "apbc_pwm2_mux";
+					mmp-clk-sel = <0 0x10>;
+					mmp-clk-reg = <0x10 0x70>;
+				};
+				apbc_pwm2_clk: apbc_pwm2_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_pwm2_mux>;
+					clock-names = "apbc_pwm2_clk";
+					mmp-clk-reg = <0x10 0x70>;
+					mmp-clk-delay = <10>;
+				};
+				apbc_pwm3_mux: apbc_pwm3_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk13m &osc_32k>;
+					clock-output-names = "apbc_pwm3_mux";
+					mmp-clk-sel = <0 0x10>;
+					mmp-clk-reg = <0x14 0x70>;
+				};
+				apbc_pwm3_clk: apbc_pwm3_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_pwm3_mux>;
+					clock-names = "apbc_pwm3_clk";
+					mmp-clk-reg = <0x14 0x70>;
+					mmp-clk-delay = <10>;
+				};
+				apbc_pwm4_mux: apbc_pwm4_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk13m &osc_32k>;
+					clock-output-names = "apbc_pwm4_mux";
+					mmp-clk-sel = <0 0x10>;
+					mmp-clk-reg = <0x18 0x70>;
+				};
+				apbc_pwm4_clk: apbc_pwm4_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_pwm4_mux>;
+					clock-names = "apbc_pwm4_clk";
+					mmp-clk-reg = <0x18 0x70>;
+					mmp-clk-delay = <10>;
+				};
+				apbc_ssp1_mux: apbc_ssp1_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk7m &refclk13m &refclk26m &refclk52m>;
+					clock-output-names = "apbc_ssp1_mux";
+					mmp-clk-sel = <0 0x10 0x20 0x30>;
+					mmp-clk-reg = <0x1c 0x70>;
+				};
+				apbc_ssp1_clk: apbc_ssp1_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_ssp1_mux>;
+					clock-names = "apbc_ssp1_clk";
+					mmp-clk-reg = <0x1c 0x70>;
+					mmp-clk-delay = <10>;
+				};
+				apbc_ssp2_mux: apbc_ssp2_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk7m &refclk13m &refclk26m &refclk52m>;
+					clock-output-names = "apbc_ssp2_mux";
+					mmp-clk-sel = <0 0x10 0x20 0x30>;
+					mmp-clk-reg = <0x20 0x70>;
+				};
+				apbc_ssp2_clk: apbc_ssp2_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_ssp2_mux>;
+					clock-names = "apbc_ssp2_clk";
+					mmp-clk-reg = <0x20 0x70>;
+					mmp-clk-delay = <10>;
+				};
+				apbc_ssp3_mux: apbc_ssp3_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk7m &refclk13m &refclk26m &refclk52m>;
+					clock-output-names = "apbc_ssp3_mux";
+					mmp-clk-sel = <0 0x10 0x20 0x30>;
+					mmp-clk-reg = <0x4c 0x70>;
+				};
+				apbc_ssp3_clk: apbc_ssp3_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_ssp3_mux>;
+					clock-names = "apbc_ssp3_clk";
+					mmp-clk-reg = <0x4c 0x70>;
+					mmp-clk-delay = <10>;
+				};
+				apbc_kpc_mux: apbc_kpc_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&osc_32k &refclk16k &refclk26m>;
+					clock-output-names = "apbc_kpc_mux";
+					mmp-clk-sel = <0 0x10 0x20>;
+					mmp-clk-reg = <0x30 0x70>;
+				};
+				apbc_kpc_clk: apbc_kpc_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbc_kpc_mux>;
+					clock-names = "apbc_kpc_clk";
+					mmp-clk-reg = <0x30 0x70>;
+					mmp-clk-delay = <10>;
+				};
+				apbc_timer0_mux: apbc_timer0_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk13m &osc_32k &refclk7m &refclk3m>;
+					clock-output-names = "apbc_timer0_mux";
+					mmp-clk-sel = <0 0x10 0x20 0x30>;
+					mmp-clk-reg = <0x34 0x70>;
+				};
+				apbc_timer0_clk: apbc_timer0_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&timer0_mux>;
+					clock-names = "apbc_timer0_clk";
+					mmp-clk-reg = <0x34 0x70>;
+					mmp-clk-delay = <10>;
+				};
+				apbc_timer1_mux: apbc_timer1_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk13m &osc_32k &refclk7m &refclk3m>;
+					clock-output-names = "apbc_timer1_mux";
+					mmp-clk-sel = <0 0x10 0x20 0x30>;
+					mmp-clk-reg = <0x44 0x70>;
+				};
+				apbc_timer1_clk: apbc_timer1_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&timer1_mux>;
+					clock-names = "apbc_timer1_clk";
+					mmp-clk-reg = <0x44 0x70>;
+					mmp-clk-delay = <10>;
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
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&refclk32m>;
+					clock-output-names = "apbcp_twsi2_clk";
+					/* register offset & mask */
+					mmp-clk-reg = <0x28 0x70>;
+					mmp-clk-delay = <10>;
+				};
+				apbcp_uart3_mux: apbcp_uart3_mux {
+					compatible = "marvell,mmp-clkmux";
+					#clock-cells = <0>;
+					clocks = <&refclk59m &refclk15m>;
+					clock-output-names = "apbcp_uart3_mux";
+					/* register offset & mask */
+					mmp-clk-reg = <0x1c 0x70>;
+					/* register value of each item */
+					mmp-clk-sel = <0 0x10>;
+				};
+				apbcp_uart3_clk: apbcp_uart3_clk {
+					compatible = "marvell,mmp-apbc-clk";
+					#clock-cells = <0>;
+					clocks = <&apbcp_uart3_mux>;
+					clock-names = "apbcp_uart3_clk";
+					mmp-clk-reg = <0x1c 0x70>;
+					mmp-clk-delay = <10>;
+				};
+			};
+
+			timer0_mux: timer0_mux {
+				compatible = "marvell,mmp-clkmux";
+				#clock-cells = <0>;
+				clocks = <&refclk3m &osc_32k &apbc_timer0_mux>;
+				clock-output-names = "timer0_mux";
+				mmp-clk-sel = <0 0x1 0x3>;
+				mmp-clk-reg = <0x14000 0x1c>;
+			};
+
+			timer1_mux: timer1_mux {
+				compatible = "marvell,mmp-clkmux";
+				#clock-cells = <0>;
+				clocks = <&refclk3m &osc_32k &apbc_timer1_mux>;
+				clock-output-names = "timer1_mux";
+				mmp-clk-sel = <0 0x1 0x3>;
+				mmp-clk-reg = <0x16000 0x1c>;
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
-- 
1.8.1.2
