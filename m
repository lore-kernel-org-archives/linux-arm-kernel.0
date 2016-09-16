From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 16 Sep 2016 21:42:42 +0200
Subject: [PATCH 01/10] ARM: dts: exynos: Fix invalid GIC interrupt flags in
 exynos4
In-Reply-To: <1474054971-16831-1-git-send-email-krzk@kernel.org>
References: <1474054971-16831-1-git-send-email-krzk@kernel.org>
Message-ID: <1474054971-16831-2-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Interrupt of type IRQ_TYPE_NONE is not allowed for GIC interrupts and
generates an error:
	genirq: Setting trigger mode 0 for irq 16 failed (gic_set_type+0x0/0x68)

The GIC requires shared interrupts to be edge rising or level high.
Platform declares support for both.  Choose level high everywhere.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Alban Browaeys <alban.browaeys@gmail.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4.dtsi | 94 ++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 44 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 5f034eb5a5e2..e6f4da7f0038 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -21,6 +21,7 @@
 
 #include <dt-bindings/clock/exynos4.h>
 #include <dt-bindings/clock/exynos-audss-clk.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include "exynos-syscon-restart.dtsi"
 
 / {
@@ -168,7 +169,7 @@
 	dsi_0: dsi at 11C80000 {
 		compatible = "samsung,exynos4210-mipi-dsi";
 		reg = <0x11C80000 0x10000>;
-		interrupts = <0 79 0>;
+		interrupts = <0 79 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&pd_lcd0>;
 		phys = <&mipi_phy 1>;
 		phy-names = "dsim";
@@ -191,7 +192,7 @@
 		fimc_0: fimc at 11800000 {
 			compatible = "samsung,exynos4210-fimc";
 			reg = <0x11800000 0x1000>;
-			interrupts = <0 84 0>;
+			interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_FIMC0>, <&clock CLK_SCLK_FIMC0>;
 			clock-names = "fimc", "sclk_fimc";
 			power-domains = <&pd_cam>;
@@ -203,7 +204,7 @@
 		fimc_1: fimc at 11810000 {
 			compatible = "samsung,exynos4210-fimc";
 			reg = <0x11810000 0x1000>;
-			interrupts = <0 85 0>;
+			interrupts = <0 85 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_FIMC1>, <&clock CLK_SCLK_FIMC1>;
 			clock-names = "fimc", "sclk_fimc";
 			power-domains = <&pd_cam>;
@@ -215,7 +216,7 @@
 		fimc_2: fimc at 11820000 {
 			compatible = "samsung,exynos4210-fimc";
 			reg = <0x11820000 0x1000>;
-			interrupts = <0 86 0>;
+			interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_FIMC2>, <&clock CLK_SCLK_FIMC2>;
 			clock-names = "fimc", "sclk_fimc";
 			power-domains = <&pd_cam>;
@@ -227,7 +228,7 @@
 		fimc_3: fimc at 11830000 {
 			compatible = "samsung,exynos4210-fimc";
 			reg = <0x11830000 0x1000>;
-			interrupts = <0 87 0>;
+			interrupts = <0 87 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_FIMC3>, <&clock CLK_SCLK_FIMC3>;
 			clock-names = "fimc", "sclk_fimc";
 			power-domains = <&pd_cam>;
@@ -239,7 +240,7 @@
 		csis_0: csis at 11880000 {
 			compatible = "samsung,exynos4210-csis";
 			reg = <0x11880000 0x4000>;
-			interrupts = <0 78 0>;
+			interrupts = <0 78 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_CSIS0>, <&clock CLK_SCLK_CSIS0>;
 			clock-names = "csis", "sclk_csis";
 			bus-width = <4>;
@@ -254,7 +255,7 @@
 		csis_1: csis at 11890000 {
 			compatible = "samsung,exynos4210-csis";
 			reg = <0x11890000 0x4000>;
-			interrupts = <0 80 0>;
+			interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_CSIS1>, <&clock CLK_SCLK_CSIS1>;
 			clock-names = "csis", "sclk_csis";
 			bus-width = <2>;
@@ -270,7 +271,7 @@
 	watchdog: watchdog at 10060000 {
 		compatible = "samsung,s3c2410-wdt";
 		reg = <0x10060000 0x100>;
-		interrupts = <0 43 0>;
+		interrupts = <0 43 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_WDT>;
 		clock-names = "watchdog";
 		status = "disabled";
@@ -280,7 +281,8 @@
 		compatible = "samsung,s3c6410-rtc";
 		reg = <0x10070000 0x100>;
 		interrupt-parent = <&pmu_system_controller>;
-		interrupts = <0 44 0>, <0 45 0>;
+		interrupts = <0 44 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 45 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_RTC>;
 		clock-names = "rtc";
 		status = "disabled";
@@ -289,7 +291,7 @@
 	keypad: keypad at 100A0000 {
 		compatible = "samsung,s5pv210-keypad";
 		reg = <0x100A0000 0x100>;
-		interrupts = <0 109 0>;
+		interrupts = <0 109 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_KEYIF>;
 		clock-names = "keypad";
 		status = "disabled";
@@ -298,7 +300,7 @@
 	sdhci_0: sdhci at 12510000 {
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12510000 0x100>;
-		interrupts = <0 73 0>;
+		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_SDMMC0>, <&clock CLK_SCLK_MMC0>;
 		clock-names = "hsmmc", "mmc_busclk.2";
 		status = "disabled";
@@ -307,7 +309,7 @@
 	sdhci_1: sdhci at 12520000 {
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12520000 0x100>;
-		interrupts = <0 74 0>;
+		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_SDMMC1>, <&clock CLK_SCLK_MMC1>;
 		clock-names = "hsmmc", "mmc_busclk.2";
 		status = "disabled";
@@ -316,7 +318,7 @@
 	sdhci_2: sdhci at 12530000 {
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12530000 0x100>;
-		interrupts = <0 75 0>;
+		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_SDMMC2>, <&clock CLK_SCLK_MMC2>;
 		clock-names = "hsmmc", "mmc_busclk.2";
 		status = "disabled";
@@ -325,7 +327,7 @@
 	sdhci_3: sdhci at 12540000 {
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12540000 0x100>;
-		interrupts = <0 76 0>;
+		interrupts = <0 76 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_SDMMC3>, <&clock CLK_SCLK_MMC3>;
 		clock-names = "hsmmc", "mmc_busclk.2";
 		status = "disabled";
@@ -344,7 +346,7 @@
 	hsotg: hsotg at 12480000 {
 		compatible = "samsung,s3c6400-hsotg";
 		reg = <0x12480000 0x20000>;
-		interrupts = <0 71 0>;
+		interrupts = <0 71 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_USB_DEVICE>;
 		clock-names = "otg";
 		phys = <&exynos_usbphy 0>;
@@ -355,7 +357,7 @@
 	ehci: ehci at 12580000 {
 		compatible = "samsung,exynos4210-ehci";
 		reg = <0x12580000 0x100>;
-		interrupts = <0 70 0>;
+		interrupts = <0 70 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_USB_HOST>;
 		clock-names = "usbhost";
 		status = "disabled";
@@ -381,7 +383,7 @@
 	ohci: ohci at 12590000 {
 		compatible = "samsung,exynos4210-ohci";
 		reg = <0x12590000 0x100>;
-		interrupts = <0 70 0>;
+		interrupts = <0 70 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_USB_HOST>;
 		clock-names = "usbhost";
 		status = "disabled";
@@ -423,7 +425,7 @@
 	mfc: codec at 13400000 {
 		compatible = "samsung,mfc-v5";
 		reg = <0x13400000 0x10000>;
-		interrupts = <0 94 0>;
+		interrupts = <0 94 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&pd_mfc>;
 		clocks = <&clock CLK_MFC>, <&clock CLK_SCLK_MFC>;
 		clock-names = "mfc", "sclk_mfc";
@@ -434,7 +436,7 @@
 	serial_0: serial at 13800000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13800000 0x100>;
-		interrupts = <0 52 0>;
+		interrupts = <0 52 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_UART0>, <&clock CLK_SCLK_UART0>;
 		clock-names = "uart", "clk_uart_baud0";
 		dmas = <&pdma0 15>, <&pdma0 16>;
@@ -445,7 +447,7 @@
 	serial_1: serial at 13810000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13810000 0x100>;
-		interrupts = <0 53 0>;
+		interrupts = <0 53 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_UART1>, <&clock CLK_SCLK_UART1>;
 		clock-names = "uart", "clk_uart_baud0";
 		dmas = <&pdma1 15>, <&pdma1 16>;
@@ -456,7 +458,7 @@
 	serial_2: serial at 13820000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13820000 0x100>;
-		interrupts = <0 54 0>;
+		interrupts = <0 54 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_UART2>, <&clock CLK_SCLK_UART2>;
 		clock-names = "uart", "clk_uart_baud0";
 		dmas = <&pdma0 17>, <&pdma0 18>;
@@ -467,7 +469,7 @@
 	serial_3: serial at 13830000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13830000 0x100>;
-		interrupts = <0 55 0>;
+		interrupts = <0 55 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_UART3>, <&clock CLK_SCLK_UART3>;
 		clock-names = "uart", "clk_uart_baud0";
 		dmas = <&pdma1 17>, <&pdma1 18>;
@@ -480,7 +482,7 @@
 		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13860000 0x100>;
-		interrupts = <0 58 0>;
+		interrupts = <0 58 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_I2C0>;
 		clock-names = "i2c";
 		pinctrl-names = "default";
@@ -493,7 +495,7 @@
 		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13870000 0x100>;
-		interrupts = <0 59 0>;
+		interrupts = <0 59 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_I2C1>;
 		clock-names = "i2c";
 		pinctrl-names = "default";
@@ -506,7 +508,7 @@
 		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13880000 0x100>;
-		interrupts = <0 60 0>;
+		interrupts = <0 60 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_I2C2>;
 		clock-names = "i2c";
 		pinctrl-names = "default";
@@ -519,7 +521,7 @@
 		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13890000 0x100>;
-		interrupts = <0 61 0>;
+		interrupts = <0 61 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_I2C3>;
 		clock-names = "i2c";
 		pinctrl-names = "default";
@@ -532,7 +534,7 @@
 		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138A0000 0x100>;
-		interrupts = <0 62 0>;
+		interrupts = <0 62 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_I2C4>;
 		clock-names = "i2c";
 		pinctrl-names = "default";
@@ -545,7 +547,7 @@
 		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138B0000 0x100>;
-		interrupts = <0 63 0>;
+		interrupts = <0 63 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_I2C5>;
 		clock-names = "i2c";
 		pinctrl-names = "default";
@@ -558,7 +560,7 @@
 		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138C0000 0x100>;
-		interrupts = <0 64 0>;
+		interrupts = <0 64 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_I2C6>;
 		clock-names = "i2c";
 		pinctrl-names = "default";
@@ -571,7 +573,7 @@
 		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138D0000 0x100>;
-		interrupts = <0 65 0>;
+		interrupts = <0 65 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_I2C7>;
 		clock-names = "i2c";
 		pinctrl-names = "default";
@@ -584,7 +586,7 @@
 		#size-cells = <0>;
 		compatible = "samsung,s3c2440-hdmiphy-i2c";
 		reg = <0x138E0000 0x100>;
-		interrupts = <0 93 0>;
+		interrupts = <0 93 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_I2C_HDMI>;
 		clock-names = "i2c";
 		status = "disabled";
@@ -598,7 +600,7 @@
 	spi_0: spi at 13920000 {
 		compatible = "samsung,exynos4210-spi";
 		reg = <0x13920000 0x100>;
-		interrupts = <0 66 0>;
+		interrupts = <0 66 IRQ_TYPE_LEVEL_HIGH>;
 		dmas = <&pdma0 7>, <&pdma0 6>;
 		dma-names = "tx", "rx";
 		#address-cells = <1>;
@@ -613,7 +615,7 @@
 	spi_1: spi at 13930000 {
 		compatible = "samsung,exynos4210-spi";
 		reg = <0x13930000 0x100>;
-		interrupts = <0 67 0>;
+		interrupts = <0 67 IRQ_TYPE_LEVEL_HIGH>;
 		dmas = <&pdma1 7>, <&pdma1 6>;
 		dma-names = "tx", "rx";
 		#address-cells = <1>;
@@ -628,7 +630,7 @@
 	spi_2: spi at 13940000 {
 		compatible = "samsung,exynos4210-spi";
 		reg = <0x13940000 0x100>;
-		interrupts = <0 68 0>;
+		interrupts = <0 68 IRQ_TYPE_LEVEL_HIGH>;
 		dmas = <&pdma0 9>, <&pdma0 8>;
 		dma-names = "tx", "rx";
 		#address-cells = <1>;
@@ -643,7 +645,11 @@
 	pwm: pwm at 139D0000 {
 		compatible = "samsung,exynos4210-pwm";
 		reg = <0x139D0000 0x1000>;
-		interrupts = <0 37 0>, <0 38 0>, <0 39 0>, <0 40 0>, <0 41 0>;
+		interrupts = <0 37 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 38 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 39 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 40 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 41 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_PWM>;
 		clock-names = "timers";
 		#pwm-cells = <3>;
@@ -660,7 +666,7 @@
 		pdma0: pdma at 12680000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x12680000 0x1000>;
-			interrupts = <0 35 0>;
+			interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_PDMA0>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
@@ -671,7 +677,7 @@
 		pdma1: pdma at 12690000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x12690000 0x1000>;
-			interrupts = <0 36 0>;
+			interrupts = <0 36 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_PDMA1>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
@@ -682,7 +688,7 @@
 		mdma1: mdma at 12850000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x12850000 0x1000>;
-			interrupts = <0 34 0>;
+			interrupts = <0 34 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_MDMA>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
@@ -712,7 +718,7 @@
 	jpeg_codec: jpeg-codec at 11840000 {
 		compatible = "samsung,exynos4210-jpeg";
 		reg = <0x11840000 0x1000>;
-		interrupts = <0 88 0>;
+		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_JPEG>;
 		clock-names = "jpeg";
 		power-domains = <&pd_cam>;
@@ -722,7 +728,7 @@
 	rotator: rotator at 12810000 {
 		compatible = "samsung,exynos4210-rotator";
 		reg = <0x12810000 0x64>;
-		interrupts = <0 83 0>;
+		interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_ROTATOR>;
 		clock-names = "rotator";
 		iommus = <&sysmmu_rotator>;
@@ -731,7 +737,7 @@
 	hdmi: hdmi at 12D00000 {
 		compatible = "samsung,exynos4210-hdmi";
 		reg = <0x12D00000 0x70000>;
-		interrupts = <0 92 0>;
+		interrupts = <0 92 IRQ_TYPE_LEVEL_HIGH>;
 		clock-names = "hdmi", "sclk_hdmi", "sclk_pixel", "sclk_hdmiphy",
 			"mout_hdmi";
 		clocks = <&clock CLK_HDMI>, <&clock CLK_SCLK_HDMI>,
@@ -746,7 +752,7 @@
 	hdmicec: cec at 100B0000 {
 		compatible = "samsung,s5p-cec";
 		reg = <0x100B0000 0x200>;
-		interrupts = <0 114 0>;
+		interrupts = <0 114 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_HDMI_CEC>;
 		clock-names = "hdmicec";
 		samsung,syscon-phandle = <&pmu_system_controller>;
@@ -757,7 +763,7 @@
 
 	mixer: mixer at 12C10000 {
 		compatible = "samsung,exynos4210-mixer";
-		interrupts = <0 91 0>;
+		interrupts = <0 91 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0x12C10000 0x2100>, <0x12c00000 0x300>;
 		power-domains = <&pd_tv>;
 		iommus = <&sysmmu_tv>;
@@ -984,7 +990,7 @@
 	sss: sss at 10830000 {
 		compatible = "samsung,exynos4210-secss";
 		reg = <0x10830000 0x300>;
-		interrupts = <0 112 0>;
+		interrupts = <0 112 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_SSS>;
 		clock-names = "secss";
 	};
-- 
2.7.4
