From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 21 Oct 2014 11:13:56 +0530
Subject: [PATCH v2 6/7] arm64: dts: Add nodes for mmc, i2c, rtc,
 watchdog on Exynos7
In-Reply-To: <1413870237-1821-1-git-send-email-a.kesavan@samsung.com>
References: <1413870237-1821-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1413870237-1821-7-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for 3 mmc channels, 12 i2c channels, rtc, and watchdog
on Exynos7.

Signed-off-by: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts |   41 ++++
 arch/arm64/boot/dts/exynos/exynos7.dtsi         |  256 +++++++++++++++++++++++
 2 files changed, 297 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
index e2c8283..d081c26 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
@@ -18,6 +18,8 @@
 
 	aliases {
 		serial0 = &serial_2;
+		mshc0 = &mmc_0;
+		mshc2 = &mmc_2;
 	};
 
 	chosen {
@@ -37,3 +39,42 @@
 &serial_2 {
 	status = "okay";
 };
+
+&rtc {
+	status = "okay";
+};
+
+&watchdog {
+	status = "okay";
+};
+
+&mmc_0 {
+	status = "okay";
+	num-slots = <1>;
+	broken-cd;
+	caps2-mmc-hs200-1_8v;
+	supports-highspeed;
+	non-removable;
+	card-detect-delay = <200>;
+	clock-frequency = <800000000>;
+	samsung,dw-mshc-ciu-div = <3>;
+	samsung,dw-mshc-sdr-timing = <0 4>;
+	samsung,dw-mshc-ddr-timing = <0 2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_qrdy &sd0_bus1 &sd0_bus4 &sd0_bus8>;
+	bus-width = <8>;
+};
+
+&mmc_2 {
+	status = "okay";
+	num-slots = <1>;
+	supports-highspeed;
+	card-detect-delay = <200>;
+	clock-frequency = <400000000>;
+	samsung,dw-mshc-ciu-div = <3>;
+	samsung,dw-mshc-sdr-timing = <2 3>;
+	samsung,dw-mshc-ddr-timing = <1 2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
+	bus-width = <4>;
+};
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 6db8c78..1300ded 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -113,6 +113,27 @@
 				      "dout_sclk_mfc_pll";
 		};
 
+		clock_top1: clock-controller at 105e0000 {
+			compatible = "samsung,exynos7-clock-top1";
+			reg = <0x105e0000 0xb000>;
+			#clock-cells = <1>;
+			clocks = <&fin_pll>, <&clock_topc DOUT_SCLK_BUS0_PLL>,
+				 <&clock_topc DOUT_SCLK_BUS1_PLL>,
+				 <&clock_topc DOUT_SCLK_CC_PLL>,
+				 <&clock_topc DOUT_SCLK_MFC_PLL>;
+			clock-names = "fin_pll", "dout_sclk_bus0_pll",
+				      "dout_sclk_bus1_pll", "dout_sclk_cc_pll",
+				      "dout_sclk_mfc_pll";
+		};
+
+		clock_ccore: clock-controller at 105b0000 {
+			compatible = "samsung,exynos7-clock-ccore";
+			reg = <0x105b0000 0xd00>;
+			#clock-cells = <1>;
+			clocks = <&fin_pll>, <&clock_topc DOUT_ACLK_CCORE_133>;
+			clock-names = "fin_pll", "dout_aclk_ccore_133";
+		};
+
 		clock_peric0: clock-controller at 13610000 {
 			compatible = "samsung,exynos7-clock-peric0";
 			reg = <0x13610000 0xd00>;
@@ -143,6 +164,27 @@
 			clock-names = "fin_pll", "dout_aclk_peris_66";
 		};
 
+		clock_fsys0: clock-controller at 10e90000 {
+			compatible = "samsung,exynos7-clock-fsys0";
+			reg = <0x10e90000 0xd00>;
+			#clock-cells = <1>;
+			clocks = <&fin_pll>, <&clock_top1 DOUT_ACLK_FSYS0_200>,
+				 <&clock_top1 DOUT_SCLK_MMC2>;
+			clock-names = "fin_pll", "dout_aclk_fsys0_200",
+				      "dout_sclk_mmc2";
+		};
+
+		clock_fsys1: clock-controller at 156e0000 {
+			compatible = "samsung,exynos7-clock-fsys1";
+			reg = <0x156e0000 0xd00>;
+			#clock-cells = <1>;
+			clocks = <&fin_pll>, <&clock_top1 DOUT_ACLK_FSYS1_200>,
+				 <&clock_top1 DOUT_SCLK_MMC0>,
+				 <&clock_top1 DOUT_SCLK_MMC1>;
+			clock-names = "fin_pll", "dout_aclk_fsys1_200",
+				      "dout_sclk_mmc0", "dout_sclk_mmc1";
+		};
+
 		serial_0: serial at 13630000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x13630000 0x100>;
@@ -236,6 +278,162 @@
 			interrupts = <0 203 0>;
 		};
 
+		hsi2c_0: hsi2c at 13640000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x13640000 0x1000>;
+			interrupts = <0 441 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c0_bus>;
+			clocks = <&clock_peric0 PCLK_HSI2C0>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_1: hsi2c at 13650000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x13650000 0x1000>;
+			interrupts = <0 442 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c1_bus>;
+			clocks = <&clock_peric0 PCLK_HSI2C1>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_2: hsi2c at 14e60000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x14e60000 0x1000>;
+			interrupts = <0 459 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c2_bus>;
+			clocks = <&clock_peric1 PCLK_HSI2C2>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_3: hsi2c at 14e70000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x14e70000 0x1000>;
+			interrupts = <0 460 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c3_bus>;
+			clocks = <&clock_peric1 PCLK_HSI2C3>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_4: hsi2c at 13660000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x13660000 0x1000>;
+			interrupts = <0 443 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c4_bus>;
+			clocks = <&clock_peric0 PCLK_HSI2C4>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_5: hsi2c at 13670000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x13670000 0x1000>;
+			interrupts = <0 444 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c5_bus>;
+			clocks = <&clock_peric0 PCLK_HSI2C5>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_6: hsi2c at 14e00000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x14e00000 0x1000>;
+			interrupts = <0 461 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c6_bus>;
+			clocks = <&clock_peric1 PCLK_HSI2C6>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_7: hsi2c at 13e10000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x13e10000 0x1000>;
+			interrupts = <0 462 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c7_bus>;
+			clocks = <&clock_peric1 PCLK_HSI2C7>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_8: hsi2c at 14e20000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x14e20000 0x1000>;
+			interrupts = <0 463 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c8_bus>;
+			clocks = <&clock_peric1 PCLK_HSI2C8>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_9: hsi2c at 13680000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x13680000 0x1000>;
+			interrupts = <0 445 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c9_bus>;
+			clocks = <&clock_peric0 PCLK_HSI2C9>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_10: hsi2c at 13690000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x13690000 0x1000>;
+			interrupts = <0 446 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c10_bus>;
+			clocks = <&clock_peric0 PCLK_HSI2C10>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_11: hsi2c at 136a0000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x136a0000 0x1000>;
+			interrupts = <0 447 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c11_bus>;
+			clocks = <&clock_peric0 PCLK_HSI2C11>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
 		timer {
 			compatible = "arm,armv8-timer";
 			interrupts = <1 13 0xff01>,
@@ -248,6 +446,64 @@
 			compatible = "samsung,exynos7-pmu", "syscon";
 			reg = <0x105c0000 0x5000>;
 		};
+
+		rtc: rtc at 10590000 {
+			compatible = "samsung,s3c6410-rtc";
+			reg = <0x10590000 0x100>;
+			interrupts = <0 355 0>, <0 356 0>;
+			clocks = <&clock_ccore PCLK_RTC>;
+			clock-names = "rtc";
+			status = "disabled";
+		};
+
+		watchdog: watchdog at 101d0000 {
+			compatible = "samsung,exynos7-wdt";
+			reg = <0x101d0000 0x100>;
+			interrupts = <0 110 0>;
+			clocks = <&clock_peris PCLK_WDT>;
+			clock-names = "watchdog";
+			samsung,syscon-phandle = <&pmu_system_controller>;
+			status = "disabled";
+		};
+
+		mmc_0: mmc at 15740000 {
+			compatible = "samsung,exynos7-dw-mshc-smu";
+			interrupts = <0 201 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x15740000 0x2000>;
+			clocks = <&clock_fsys1 ACLK_MMC0>,
+				 <&clock_top1 CLK_SCLK_MMC0>;
+			clock-names = "biu", "ciu";
+			fifo-depth = <0x40>;
+			status = "disabled";
+		};
+
+		mmc_1: mmc at 15750000 {
+			compatible = "samsung,exynos7-dw-mshc";
+			interrupts = <0 202 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x15750000 0x2000>;
+			clocks = <&clock_fsys1 ACLK_MMC1>,
+				 <&clock_top1 CLK_SCLK_MMC1>;
+			clock-names = "biu", "ciu";
+			fifo-depth = <0x40>;
+			status = "disabled";
+		};
+
+		mmc_2: mmc at 15560000 {
+			compatible = "samsung,exynos7-dw-mshc-smu";
+			interrupts = <0 216 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x15560000 0x2000>;
+			clocks = <&clock_fsys0 ACLK_MMC2>,
+				 <&clock_top1 CLK_SCLK_MMC2>;
+			clock-names = "biu", "ciu";
+			fifo-depth = <0x40>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
1.7.9.5
