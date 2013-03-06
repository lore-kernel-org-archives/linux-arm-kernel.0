From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 06 Mar 2013 18:06:37 +0530
Subject: [PATCH 1/2] ARM: dts: add pin state information in client nodes for
 Exynos4 platforms
In-Reply-To: <1362573398-15126-1-git-send-email-thomas.abraham@linaro.org>
References: <1362573398-15126-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1362573398-15126-2-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add default pin state information for all client nodes that require
pin configuration support using pinctrl interface.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/boot/dts/exynos4.dtsi            |   10 +++++
 arch/arm/boot/dts/exynos4210-smdkv310.dts |   53 +++++++++++++----------------
 2 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index e1347fc..d160892 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -165,6 +165,8 @@
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13860000 0x100>;
 		interrupts = <0 58 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c0_bus>;
 		status = "disabled";
 	};
 
@@ -174,6 +176,8 @@
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13870000 0x100>;
 		interrupts = <0 59 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c1_bus>;
 		status = "disabled";
 	};
 
@@ -239,6 +243,8 @@
 		rx-dma-channel = <&pdma0 6>; /* preliminary */
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi0_bus>;
 		status = "disabled";
 	};
 
@@ -250,6 +256,8 @@
 		rx-dma-channel = <&pdma1 6>; /* preliminary */
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi1_bus>;
 		status = "disabled";
 	};
 
@@ -261,6 +269,8 @@
 		rx-dma-channel = <&pdma0 8>; /* preliminary */
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi2_bus>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index f634907..55442a5 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -30,16 +30,9 @@
 	};
 
 	sdhci at 12530000 {
-		samsung,sdhci-bus-width = <4>;
-		linux,mmc_cap_4_bit_data;
-		samsung,sdhci-cd-internal;
-		gpio-cd = <&gpk2 2 2 3 3>;
-		gpios = <&gpk2 0 2 0 3>,
-			<&gpk2 1 2 0 3>,
-			<&gpk2 3 2 3 3>,
-			<&gpk2 4 2 3 3>,
-			<&gpk2 5 2 3 3>,
-			<&gpk2 6 2 3 3>;
+		bus-width = <4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
 		status = "okay";
 	};
 
@@ -59,25 +52,32 @@
 		status = "okay";
 	};
 
+	pinctrl at 11000000 {
+		keypad_rows: keypad-rows {
+			samsung,pins = "gpx2-0", "gpx2-1";
+			samsung,pin-function = <3>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <0>;
+		};
+
+		keypad_cols: keypad-cols {
+			samsung,pins = "gpx1-0", "gpx1-1", "gpx1-2", "gpx1-3",
+				       "gpx1-4", "gpx1-5", "gpx1-6", "gpx1-7";
+			samsung,pin-function = <3>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+	};
+
 	keypad at 100A0000 {
 		samsung,keypad-num-rows = <2>;
 		samsung,keypad-num-columns = <8>;
 		linux,keypad-no-autorepeat;
 		linux,keypad-wakeup;
+		pinctrl-names = "default";
+		pinctrl-0 = <&keypad_rows &keypad_cols>;
 		status = "okay";
 
-		row-gpios = <&gpx2 0 3 3 0>,
-			    <&gpx2 1 3 3 0>;
-
-		col-gpios = <&gpx1 0 3 0 0>,
-			    <&gpx1 1 3 0 0>,
-			    <&gpx1 2 3 0 0>,
-			    <&gpx1 3 3 0 0>,
-			    <&gpx1 4 3 0 0>,
-			    <&gpx1 5 3 0 0>,
-			    <&gpx1 6 3 0 0>,
-			    <&gpx1 7 3 0 0>;
-
 		key_1 {
 			keypad,row = <0>;
 			keypad,column = <3>;
@@ -143,9 +143,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		samsung,i2c-sda-delay = <100>;
-		samsung,i2c-max-bus-freq = <20000>;
-		gpios = <&gpd1 0 2 3 0>,
-			<&gpd1 1 2 3 0>;
+		samsung,i2c-max-bus-freq = <100000>;
 		status = "okay";
 
 		eeprom at 50 {
@@ -160,9 +158,6 @@
 	};
 
 	spi_2: spi at 13940000 {
-		gpios = <&gpc1 1 5 3 0>,
-			<&gpc1 3 5 3 0>,
-			<&gpc1 4 5 3 0>;
 		status = "okay";
 
 		w25x80 at 0 {
@@ -173,7 +168,7 @@
 			spi-max-frequency = <1000000>;
 
 			controller-data {
-				cs-gpio = <&gpc1 2 1 0 3>;
+				cs-gpio = <&gpc1 2 0>;
 				samsung,spi-feedback-delay = <0>;
 			};
 
-- 
1.6.6.rc2
