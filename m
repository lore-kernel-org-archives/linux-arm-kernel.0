From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 5 Aug 2013 12:12:24 -0400
Subject: [PATCH 5/8] ARM: dts: keystone: Add clock tree data to devicetree
In-Reply-To: <1375719147-7578-1-git-send-email-santosh.shilimkar@ti.com>
References: <1375719147-7578-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1375719147-7578-6-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock tree for Keystone 2 based SOCs.

Cc: Mike Turquette <mturquette@linaro.org>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/keystone-clocks.dtsi |  824 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/keystone.dts         |    2 +
 2 files changed, 826 insertions(+)
 create mode 100644 arch/arm/boot/dts/keystone-clocks.dtsi

diff --git a/arch/arm/boot/dts/keystone-clocks.dtsi b/arch/arm/boot/dts/keystone-clocks.dtsi
new file mode 100644
index 0000000..b8c6b3a
--- /dev/null
+++ b/arch/arm/boot/dts/keystone-clocks.dtsi
@@ -0,0 +1,824 @@
+/*
+ * Device Tree Source for Keystone 2 clock tree
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+clocks {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges;
+
+	refclkmain: refclkmain {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <122880000>;
+		clock-output-names = "refclk-main";
+	};
+
+	mainpllclk: mainpllclk at 2310110 {
+		#clock-cells = <0>;
+		compatible = "keystone,pll-clk";
+		clocks = <&refclkmain>;
+		reg = <0x02310110 4	/* PLLCTRL PLLM */
+			0x02620350 4>;	/* MAINPLL_CTL0 */
+		pll_has_pllctrl;
+		pllm_lower_mask	= <0x3f>;
+		pllm_upper_mask = <0x7f000>;
+		pllm_upper_shift = <6>;
+		plld_mask = <0x3f>;
+		fixed_postdiv = <2>;
+	};
+
+	mainmuxclk: mainmuxclk at 2310108 {
+		#clock-cells = <0>;
+		compatible = "mux-clk";
+		clocks = <&mainpllclk>, <&refclkmain>;
+		reg = <0x02310108 4>;
+		bit-shift = <23>;
+		bit-mask = <1>;
+		clock-output-names = "mainmuxclk";
+	};
+
+	chipclk1: chipclk1 {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&mainmuxclk>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "chipclk1";
+	};
+
+	chipclk1rstiso: chipclk1rstiso {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&mainmuxclk>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "chipclk1rstiso";
+	};
+
+	gemtraceclk: gemtraceclk at 2310120 {
+		#clock-cells = <0>;
+		compatible = "divider-clock";
+		clocks = <&mainmuxclk>;
+		reg = <0x02310120 4>;
+		bit-shift = <0>;
+		bit-mask = <8>;
+		clock-output-names = "gemtraceclk";
+	};
+
+	chipstmxptclk: chipstmxptclk {
+		#clock-cells = <0>;
+		compatible = "divider-clock";
+		clocks = <&mainmuxclk>;
+		reg = <0x02310164 4>;
+		bit-shift = <0>;
+		bit-mask = <8>;
+		clock-output-names = "chipstmxptclk";
+	};
+
+	chipclk12: chipclk12 {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&chipclk1>;
+		clock-div = <2>;
+		clock-mult = <1>;
+		clock-output-names = "chipclk12";
+	};
+
+	chipclk13: chipclk13 {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&chipclk1>;
+		clock-div = <3>;
+		clock-mult = <1>;
+		clock-output-names = "chipclk13";
+	};
+
+	chipclk14: chipclk14 {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&chipclk1>;
+		clock-div = <4>;
+		clock-mult = <1>;
+		clock-output-names = "chipclk14";
+	};
+
+	chipclk16: chipclk16 {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&chipclk1>;
+		clock-div = <6>;
+		clock-mult = <1>;
+		clock-output-names = "chipclk16";
+	};
+
+	chipclk112: chipclk112 {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&chipclk1>;
+		clock-div = <12>;
+		clock-mult = <1>;
+		clock-output-names = "chipclk112";
+	};
+
+	chipclk124: chipclk124 {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&chipclk1>;
+		clock-div = <24>;
+		clock-mult = <1>;
+		clock-output-names = "chipclk114";
+	};
+
+	chipclk1rstiso13: chipclk1rstiso13 {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&chipclk1rstiso>;
+		clock-div = <3>;
+		clock-mult = <1>;
+		clock-output-names = "chipclk1rstiso13";
+	};
+
+	chipclk1rstiso14: chipclk1rstiso14 {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&chipclk1rstiso>;
+		clock-div = <4>;
+		clock-mult = <1>;
+		clock-output-names = "chipclk1rstiso14";
+	};
+
+	chipclk1rstiso16: chipclk1rstiso16 {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&chipclk1rstiso>;
+		clock-div = <6>;
+		clock-mult = <1>;
+		clock-output-names = "chipclk1rstiso16";
+	};
+
+	chipclk1rstiso112: chipclk1rstiso112 {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&chipclk1rstiso>;
+		clock-div = <12>;
+		clock-mult = <1>;
+		clock-output-names = "chipclk1rstiso112";
+	};
+
+	clkmodrst0: clkmodrst0 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk16>;
+		clock-output-names = "modrst0";
+		status = "enabled";
+		reg = <0x02350000 4096>;
+	};
+
+
+	clkusb: clkusb {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk16>;
+		clock-output-names = "usb";
+		reg = <0x02350000 4096>;
+		lpsc = <2>;
+	};
+
+	clkaemifspi: clkaemifspi {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk16>;
+		clock-output-names = "aemif-spi";
+		reg = <0x02350000 4096>;
+		status = "enabled";
+		lpsc = <3>;
+	};
+
+
+	clkdebugsstrc: clkdebugsstrc {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "debugss-trc";
+		reg = <0x02350000 4096>;
+		lpsc = <5>;
+		pd = <1>;
+	};
+
+	clktetbtrc: clktetbtrc {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "tetb-trc";
+		reg = <0x02350000 4096>;
+		lpsc = <6>;
+		pd = <1>;
+	};
+
+	clkpa: clkpa {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk16>;
+		clock-output-names = "pa";
+		reg = <0x02350000 4096>;
+		lpsc = <7>;
+		pd = <2>;
+	};
+
+	clkcpgmac: clkcpgmac {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&clkpa>;
+		clock-output-names = "cpgmac";
+		reg = <0x02350000 4096>;
+		lpsc = <8>;
+		pd = <2>;
+	};
+
+	clksa: clksa {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&clkpa>;
+		clock-output-names = "sa";
+		reg = <0x02350000 4096>;
+		lpsc = <9>;
+		pd = <2>;
+	};
+
+	clkpcie: clkpcie {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk12>;
+		clock-output-names = "pcie";
+		reg = <0x02350000 4096>;
+		lpsc = <10>;
+		pd = <3>;
+	};
+
+	clksrio: clksrio {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk1rstiso13>;
+		clock-output-names = "srio";
+		reg = <0x02350000 4096>;
+		lpsc = <11>;
+		pd = <4>;
+	};
+
+	clkhyperlink0: clkhyperlink0 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk12>;
+		clock-output-names = "hyperlink-0";
+		reg = <0x02350000 4096>;
+		lpsc = <12>;
+		pd = <5>;
+	};
+
+	clksr: clksr {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk1rstiso112>;
+		clock-output-names = "sr";
+		reg = <0x02350000 4096>;
+		lpsc = <13>;
+		pd = <6>;
+	};
+
+	clkmsmcsram: clkmsmcsram {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk1>;
+		clock-output-names = "msmcsram";
+		reg = <0x02350000 4096>;
+		lpsc = <14>;
+		pd = <7>;
+	};
+
+	clkgem0: clkgem0 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk1>;
+		clock-output-names = "gem0";
+		reg = <0x02350000 4096>;
+		lpsc = <15>;
+		pd = <8>;
+	};
+
+	clkgem1: clkgem1 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk1>;
+		clock-output-names = "gem1";
+		reg = <0x02350000 4096>;
+		lpsc = <16>;
+		pd = <9>;
+	};
+
+	clkgem2: clkgem2 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk1>;
+		clock-output-names = "gem2";
+		reg = <0x02350000 4096>;
+		lpsc = <17>;
+		pd = <10>;
+	};
+
+	clkgem3: clkgem3 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk1>;
+		clock-output-names = "gem3";
+		reg = <0x02350000 4096>;
+		lpsc = <18>;
+		pd = <11>;
+	};
+
+	clkgem4: clkgem4 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk1>;
+		clock-output-names = "gem4";
+		reg = <0x02350000 4096>;
+		lpsc = <19>;
+		pd = <12>;
+	};
+
+	clkgem5: clkgem5 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk1>;
+		clock-output-names = "gem5";
+		reg = <0x02350000 4096>;
+		lpsc = <20>;
+		pd = <13>;
+	};
+
+	clkgem6: clkgem6 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk1>;
+		clock-output-names = "gem6";
+		reg = <0x02350000 4096>;
+		lpsc = <21>;
+		pd = <14>;
+	};
+
+	clkgem7: clkgem7 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk1>;
+		clock-output-names = "gem7";
+		reg = <0x02350000 4096>;
+		lpsc = <22>;
+		pd = <15>;
+	};
+
+	clkddr30: clkddr30 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk12>;
+		clock-output-names = "ddr3-0";
+		reg = <0x02350000 4096>;
+		lpsc = <23>;
+		pd = <16>;
+	};
+
+	clkddr31: clkddr31 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "ddr3-1";
+		reg = <0x02350000 4096>;
+		lpsc = <24>;
+		pd = <16>;
+	};
+
+	clktac: clktac {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "tac";
+		reg = <0x02350000 4096>;
+		lpsc = <25>;
+		pd = <17>;
+	};
+
+	clkrac01: clktac01 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "rac-01";
+		reg = <0x02350000 4096>;
+		lpsc = <26>;
+		pd = <17>;
+	};
+
+	clkrac23: clktac23 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "rac-23";
+		reg = <0x02350000 4096>;
+		lpsc = <27>;
+		pd = <18>;
+	};
+
+	clkfftc0: clkfftc0 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "fftc-0";
+		reg = <0x02350000 4096>;
+		lpsc = <28>;
+		pd = <19>;
+	};
+
+	clkfftc1: clkfftc1 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "fftc-1";
+		reg = <0x02350000 4096>;
+		lpsc = <29>;
+		pd = <19>;
+	};
+
+	clkfftc2: clkfftc2 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "fftc-2";
+		reg = <0x02350000 4096>;
+		lpsc = <30>;
+		pd = <20>;
+	};
+
+	clkfftc3: clkfftc3 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "fftc-3";
+		reg = <0x02350000 4096>;
+		lpsc = <31>;
+		pd = <20>;
+	};
+
+	clkfftc4: clkfftc4 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "fftc-4";
+		reg = <0x02350000 4096>;
+		lpsc = <32>;
+		pd = <20>;
+	};
+
+	clkfftc5: clkfftc5 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "fftc-5";
+		reg = <0x02350000 4096>;
+		lpsc = <33>;
+		pd = <20>;
+	};
+
+	clkaif: clkaif {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "aif";
+		reg = <0x02350000 4096>;
+		lpsc = <34>;
+		pd = <21>;
+	};
+
+	clktcp3d0: clktcp3d0 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "tcp3d-0";
+		reg = <0x02350000 4096>;
+		lpsc = <35>;
+		pd = <22>;
+	};
+
+	clktcp3d1: clktcp3d1 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "tcp3d-1";
+		reg = <0x02350000 4096>;
+		lpsc = <36>;
+		pd = <22>;
+	};
+
+	clktcp3d2: clktcp3d2 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "tcp3d-2";
+		reg = <0x02350000 4096>;
+		lpsc = <37>;
+		pd = <23>;
+	};
+
+	clktcp3d3: clktcp3d3 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "tcp3d-3";
+		reg = <0x02350000 4096>;
+		lpsc = <38>;
+		pd = <23>;
+	};
+
+	clkvcp0: clkvcp0 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "vcp-0";
+		reg = <0x02350000 4096>;
+		lpsc = <39>;
+		pd = <24>;
+	};
+
+	clkvcp1: clkvcp1 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "vcp-1";
+		reg = <0x02350000 4096>;
+		lpsc = <40>;
+		pd = <24>;
+	};
+
+	clkvcp2: clkvcp2 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "vcp-2";
+		reg = <0x02350000 4096>;
+		lpsc = <41>;
+		pd = <24>;
+	};
+
+	clkvcp3: clkvcp3 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "vcp-3";
+		reg = <0x02350000 4096>;
+		lpsc = <42>;
+		pd = <24>;
+	};
+
+	clkvcp4: clkvcp4 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "vcp-4";
+		reg = <0x02350000 4096>;
+		lpsc = <43>;
+		pd = <25>;
+	};
+
+	clkvcp5: clkvcp5 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "vcp-5";
+		reg = <0x02350000 4096>;
+		lpsc = <44>;
+		pd = <25>;
+	};
+
+	clkvcp6: clkvcp6 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "vcp-6";
+		reg = <0x02350000 4096>;
+		lpsc = <45>;
+		pd = <25>;
+	};
+
+	clkvcp7: clkvcp7 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "vcp-7";
+		reg = <0x02350000 4096>;
+		lpsc = <46>;
+		pd = <25>;
+	};
+
+	clkbcp: clkbcp {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "bcp";
+		reg = <0x02350000 4096>;
+		lpsc = <47>;
+		pd = <26>;
+	};
+
+	clkdxb: clkdxb {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "dxb";
+		reg = <0x02350000 4096>;
+		lpsc = <48>;
+		pd = <27>;
+	};
+
+	clkhyperlink1: clkhyperlink1 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk12>;
+		clock-output-names = "hyperlink-1";
+		reg = <0x02350000 4096>;
+		lpsc = <49>;
+		pd = <28>;
+	};
+
+	clkxge: clkxge {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&chipclk13>;
+		clock-output-names = "xge";
+		reg = <0x02350000 4096>;
+		lpsc = <50>;
+		pd = <29>;
+	};
+
+	clkwdtimer0: clkwdtimer0 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&clkmodrst0>;
+		clock-output-names = "timer0";
+		status = "enabled";
+		reg = <0x02350000 4096>;
+	};
+
+	clkwdtimer1: clkwdtimer1 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&clkmodrst0>;
+		clock-output-names = "timer1";
+		status = "enabled";
+		reg = <0x02350000 4096>;
+	};
+
+	clkwdtimer2: clkwdtimer2 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&clkmodrst0>;
+		clock-output-names = "timer2";
+		status = "enabled";
+		reg = <0x02350000 4096>;
+	};
+
+	clkwdtimer3: clkwdtimer3 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&clkmodrst0>;
+		clock-output-names = "timer3";
+		status = "enabled";
+		reg = <0x02350000 4096>;
+	};
+
+	clkuart0: clkuart0 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&clkmodrst0>;
+		clock-output-names = "uart0";
+		status = "enabled";
+		reg = <0x02350000 4096>;
+	};
+
+	clkuart1: clkuart1 {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&clkmodrst0>;
+		clock-output-names = "uart1";
+		status = "enabled";
+		reg = <0x02350000 4096>;
+	};
+
+	clkaemif: clkaemif {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&clkaemifspi>;
+		clock-output-names = "aemif";
+		status = "enabled";
+		reg = <0x02350000 4096>;
+	};
+
+	clkusim: clkusim {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&clkmodrst0>;
+		clock-output-names = "usim";
+		status = "enabled";
+		reg = <0x02350000 4096>;
+	};
+
+	clki2c: clki2c {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&clkmodrst0>;
+		clock-output-names = "i2c";
+		status = "enabled";
+		reg = <0x02350000 4096>;
+	};
+
+	clkspi: clkspi {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&clkaemifspi>;
+		clock-output-names = "spi";
+		status = "enabled";
+		reg = <0x02350000 4096>;
+	};
+
+	clkgpio: clkgpio {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&clkmodrst0>;
+		clock-output-names = "gpio";
+		status = "enabled";
+		reg = <0x02350000 4096>;
+	};
+
+	clkkeymgr: clkkeymgr {
+		#clock-cells = <0>;
+		compatible = "keystone,psc-clk";
+		clocks = <&clkmodrst0>;
+		clock-output-names = "keymgr";
+		status = "enabled";
+		reg = <0x02350000 4096>;
+	};
+
+	papllclk: papllclk at 2620358 {
+		#clock-cells = <0>;
+		compatible = "keystone,pll-clk";
+		clocks = <&refclkmain>;
+		clock-output-names = "pa-pll-clk";
+		reg = <0x02620358 4>;	/* PAPLL_CTL0 */
+		pllm_lower_mask	= <0x3f>;
+		pllm_upper_mask = <0x7ffc0>;
+		pllm_upper_shift = <6>;
+		plld_mask = <0x3f>;
+		fixed_postdiv = <6>;
+	};
+
+	ddr3allclk: ddr3apllclk at 2620360 {
+		#clock-cells = <0>;
+		compatible = "keystone,pll-clk";
+		clocks = <&refclkmain>;
+		clock-output-names = "ddr-3a-pll-clk";
+		reg = <0x02620360 4>;
+		pllm_lower_mask	= <0x3f>;
+		pllm_upper_mask = <0x7ffc0>;
+		pllm_upper_shift = <6>;
+		plld_mask = <0x3f>;
+		fixed_postdiv = <6>;
+	};
+
+	ddr3bllclk: ddr3bpllclk at 2620368 {
+		#clock-cells = <0>;
+		compatible = "keystone,pll-clk";
+		clocks = <&refclkmain>;
+		clock-output-names = "ddr-3b-pll-clk";
+		reg = <0x02620368 4>;
+		pllm_lower_mask	= <0x3f>;
+		pllm_upper_mask = <0x7ffc0>;
+		pllm_upper_shift = <6>;
+		plld_mask = <0x3f>;
+		fixed_postdiv = <6>;
+	};
+
+	armpllclk: armpllclk at 2620370 {
+		#clock-cells = <0>;
+		compatible = "keystone,pll-clk";
+		clocks = <&refclkmain>;
+		clock-output-names = "arm-pll-clk";
+		reg = <0x02620370 4>;
+		pllm_lower_mask	= <0x3f>;
+		pllm_upper_mask = <0x7ffc0>;
+		pllm_upper_shift = <6>;
+		plld_mask = <0x3f>;
+		fixed_postdiv = <6>;
+	};
+};
diff --git a/arch/arm/boot/dts/keystone.dts b/arch/arm/boot/dts/keystone.dts
index 1334b42..57a7cd9 100644
--- a/arch/arm/boot/dts/keystone.dts
+++ b/arch/arm/boot/dts/keystone.dts
@@ -93,6 +93,8 @@
 			reg = <0x023100e8 4>;	/* pll reset control reg */
 		};
 
+		/include/ "keystone-clocks.dtsi"
+
 		uart0: serial at 02530c00 {
 			compatible = "ns16550a";
 			current-speed = <115200>;
-- 
1.7.9.5
