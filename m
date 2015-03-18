From: rjui@broadcom.com (Ray Jui)
Date: Tue, 17 Mar 2015 22:45:21 -0700
Subject: [PATCH v6 5/6] ARM: dts: enable clock support for Broadcom Cygnus
In-Reply-To: <1426657522-2473-1-git-send-email-rjui@broadcom.com>
References: <1426657522-2473-1-git-send-email-rjui@broadcom.com>
Message-ID: <1426657522-2473-6-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace current device tree dummy clocks with real clock support for
Broadcom Cygnus SoC

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus-clock.dtsi |  112 ++++++++++++++++++++++++-------
 arch/arm/boot/dts/bcm-cygnus.dtsi       |    2 +-
 2 files changed, 88 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus-clock.dtsi b/arch/arm/boot/dts/bcm-cygnus-clock.dtsi
index 60d8389..92aab3d 100644
--- a/arch/arm/boot/dts/bcm-cygnus-clock.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus-clock.dtsi
@@ -36,56 +36,118 @@ clocks {
 	ranges;
 
 	osc: oscillator {
+		#clock-cells = <0>;
 		compatible = "fixed-clock";
-		#clock-cells = <1>;
 		clock-frequency = <25000000>;
 	};
 
-	apb_clk: apb_clk {
-		compatible = "fixed-clock";
+	/* Cygnus ARM PLL */
+	armpll: armpll {
 		#clock-cells = <0>;
-		clock-frequency = <1000000000>;
+		compatible = "brcm,cygnus-armpll";
+		clocks = <&osc>;
+		reg = <0x19000000 0x1000>;
 	};
 
-	periph_clk: periph_clk {
-		compatible = "fixed-clock";
+	/* peripheral clock for system timer */
+	arm_periph_clk: arm_periph_clk {
 		#clock-cells = <0>;
-		clock-frequency = <500000000>;
+		compatible = "fixed-factor-clock";
+		clocks = <&armpll>;
+		clock-div = <2>;
+		clock-mult = <1>;
 	};
 
-	sdio_clk: lcpll_ch2 {
-		compatible = "fixed-clock";
+	/* APB bus clock */
+	apb_clk: apb_clk {
 		#clock-cells = <0>;
-		clock-frequency = <200000000>;
+		compatible = "fixed-factor-clock";
+		clocks = <&armpll>;
+		clock-div = <4>;
+		clock-mult = <1>;
 	};
 
-	axi81_clk: axi81_clk {
-		compatible = "fixed-clock";
+	genpll: genpll {
 		#clock-cells = <0>;
-		clock-frequency = <100000000>;
+		compatible = "brcm,cygnus-genpll";
+		reg = <0x0301d000 0x2c>,
+			<0x0301c020 0x4>;
+		clocks = <&osc>;
 	};
 
-	keypad_clk: keypad_clk {
-		compatible = "fixed-clock";
+	/* various clocks running off the GENPLL */
+	genpll_clks: genpll_clks {
+		#clock-cells = <1>;
+		compatible = "brcm,cygnus-genpll-clk";
+		reg = <0x0301d000 0x2c>;
+		clocks = <&genpll>;
+		clock-output-names = "axi21", "250mhz", "ihost_sys",
+			"enet_sw", "audio_125", "can";
+	};
+
+	/* always 1/2 of the axi21 clock */
+	axi41_clk: axi41_clk {
 		#clock-cells = <0>;
-		clock-frequency = <31806>;
+		compatible = "fixed-factor-clock";
+		clocks = <&genpll_clks 0>;
+		clock-div = <2>;
+		clock-mult = <1>;
 	};
 
-	adc_clk: adc_clk {
-		compatible = "fixed-clock";
+	/* always 1/4 of the axi21 clock */
+	axi81_clk: axi81_clk {
 		#clock-cells = <0>;
-		clock-frequency = <1562500>;
+		compatible = "fixed-factor-clock";
+		clocks = <&genpll_clks 0>;
+		clock-div = <4>;
+		clock-mult = <1>;
 	};
 
-	pwm_clk: pwm_clk {
-		compatible = "fixed-clock";
+	lcpll0: lcpll0 {
 		#clock-cells = <0>;
-		clock-frequency = <1000000>;
+		compatible = "brcm,cygnus-lcpll0";
+		reg = <0x0301d02c 0x1c>,
+			<0x0301c020 0x4>;
+		clocks = <&osc>;
 	};
 
-	lcd_clk: mipipll_ch1 {
-		compatible = "fixed-clock";
+	/* various clocks running off the LCPLL0 */
+	lcpll0_clks: lcpll0_clks {
+		#clock-cells = <1>;
+		compatible = "brcm,cygnus-lcpll0-clk";
+		reg = <0x0301d02c 0x1c>;
+		clocks = <&lcpll0>;
+		clock-output-names = "pcie_phy", "ddr_phy", "sdio",
+			"usb_phy", "smart_card", "ch5";
+	};
+
+	mipipll: mipipll {
 		#clock-cells = <0>;
-		clock-frequency = <100000000>;
+		compatible = "brcm,cygnus-mipipll";
+		reg = <0x180a9800 0x2c>,
+			<0x0301c020 0x4>,
+			<0x180aa024 0x4>;
+		clocks = <&osc>;
+
+		assigned-clocks = <&mipipll>;
+		assigned-clock-rates = <2100000000>;
+	};
+
+	mipipll_clks: mipipll_clks {
+		#clock-cells = <1>;
+		compatible = "brcm,cygnus-mipipll-clk";
+		reg = <0x180a9800 0x2c>;
+		clocks = <&mipipll>;
+		clock-output-names = "ch0_unused", "ch1_lcd", "ch2_v3d",
+			"ch3_unused", "ch4_unused", "ch5_unused";
+	};
+
+	asiu_clks: asiu_clks {
+		#clock-cells = <1>;
+		compatible = "brcm,cygnus-asiu-clk";
+		reg = <0x0301d048 0xc>,
+			<0x180aa024 0x4>;
+		clocks = <&osc>;
+		clock-output-names = "keypad", "adc/touch", "pwm";
 	};
 };
diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index ff5fb6a..35a25e4 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -154,7 +154,7 @@
 		compatible = "arm,cortex-a9-global-timer";
 		reg = <0x19020200 0x100>;
 		interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&periph_clk>;
+		clocks = <&arm_periph_clk>;
 	};
 
 };
-- 
1.7.9.5
