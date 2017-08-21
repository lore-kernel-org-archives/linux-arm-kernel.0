From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 21 Aug 2017 18:06:31 +0200
Subject: [PATCH v2 3/9] ARM64: dts: meson: add mmc clk gate pins
In-Reply-To: <20170821160637.22456-1-jbrunet@baylibre.com>
References: <20170821160637.22456-1-jbrunet@baylibre.com>
Message-ID: <20170821160637.22456-4-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the pinctrl to switch mmc clk pins in gpio (pulled down) mode. This
is necessary to be able to gate the clk outside of the SoC while
keeping it running in the controller

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |  9 ++++--
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts      |  9 ++++--
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    | 11 +++++---
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |  8 ++++--
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |  9 ++++--
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |  9 ++++--
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 33 ++++++++++++++++++++++
 .../dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts |  6 ++--
 .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts   |  6 ++--
 .../dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    |  9 ++++--
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi     |  9 ++++--
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         | 33 ++++++++++++++++++++++
 .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |  6 ++--
 13 files changed, 126 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
index cff39c5a2632..9ac904f75013 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -161,7 +161,8 @@
 &sd_emmc_a {
 	status = "okay";
 	pinctrl-0 = <&sdio_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdio_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 	#address-cells = <1>;
 	#size-cells = <0>;
 
@@ -187,7 +188,8 @@
 &sd_emmc_b {
 	status = "okay";
 	pinctrl-0 = <&sdcard_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdcard_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -205,7 +207,8 @@
 &sd_emmc_c {
 	status = "okay";
 	pinctrl-0 = <&emmc_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
 	cap-mmc-highspeed;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index b48a4576158a..e4c6b2fd52ee 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -192,7 +192,8 @@
 &sd_emmc_a {
 	status = "okay";
 	pinctrl-0 = <&sdio_pins>, <&sdio_irq_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdio_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 	#address-cells = <1>;
 	#size-cells = <0>;
 
@@ -218,7 +219,8 @@
 &sd_emmc_b {
 	status = "okay";
 	pinctrl-0 = <&sdcard_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdcard_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -236,7 +238,8 @@
 &sd_emmc_c {
 	status = "disabled";
 	pinctrl-0 = <&emmc_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
 	max-frequency = <200000000>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index c64c2256d092..7342c31f73b6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -51,7 +51,7 @@
 / {
 	compatible = "nexbox,a95x", "amlogic,meson-gxbb";
 	model = "NEXBOX A95X";
-	
+
 	aliases {
 		serial0 = &uart_AO;
 	};
@@ -225,7 +225,8 @@
 &sd_emmc_a {
 	status = "okay";
 	pinctrl-0 = <&sdio_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdio_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 	#address-cells = <1>;
 	#size-cells = <0>;
 
@@ -246,7 +247,8 @@
 &sd_emmc_b {
 	status = "okay";
 	pinctrl-0 = <&sdcard_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdcard_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -264,7 +266,8 @@
 &sd_emmc_c {
 	status = "okay";
 	pinctrl-0 = <&emmc_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
 	cap-mmc-highspeed;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index a12303becab4..1ffa1c238a72 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -50,7 +50,7 @@
 / {
 	compatible = "hardkernel,odroid-c2", "amlogic,meson-gxbb";
 	model = "Hardkernel ODROID-C2";
-	
+
 	aliases {
 		serial0 = &uart_AO;
 	};
@@ -253,7 +253,8 @@
 &sd_emmc_b {
 	status = "okay";
 	pinctrl-0 = <&sdcard_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdcard_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -271,7 +272,8 @@
 &sd_emmc_c {
 	status = "okay";
 	pinctrl-0 = <&emmc_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
 	max-frequency = <200000000>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index 30b880b694de..99c409d1c8f8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -187,7 +187,8 @@
 &sd_emmc_a {
 	status = "okay";
 	pinctrl-0 = <&sdio_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdio_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 	#address-cells = <1>;
 	#size-cells = <0>;
 
@@ -213,7 +214,8 @@
 &sd_emmc_b {
 	status = "okay";
 	pinctrl-0 = <&sdcard_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdcard_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -231,7 +233,8 @@
 &sd_emmc_c {
 	status = "okay";
 	pinctrl-0 = <&emmc_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
 	cap-mmc-highspeed;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 0262ef8d48e4..f2bc6dea1fc6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -155,7 +155,8 @@
 &sd_emmc_a {
 	status = "okay";
 	pinctrl-0 = <&sdio_pins &sdio_irq_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdio_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 	#address-cells = <1>;
 	#size-cells = <0>;
 
@@ -181,7 +182,8 @@
 &sd_emmc_b {
 	status = "okay";
 	pinctrl-0 = <&sdcard_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdcard_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -198,7 +200,8 @@
 &sd_emmc_c {
 	status = "okay";
 	pinctrl-0 = <&emmc_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
 	cap-mmc-highspeed;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 9a1e478f80d5..1d6314e2eb8a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -383,6 +383,17 @@
 			};
 		};
 
+		emmc_clk_gate_pins: emmc_clk_gate {
+			mux {
+				groups = "BOOT_8";
+				function = "gpio_periphs";
+			};
+			cfg-pull-down {
+				pins = "BOOT_8";
+				bias-pull-down;
+			};
+		};
+
 		nor_pins: nor {
 			mux {
 				groups = "nor_d",
@@ -421,6 +432,17 @@
 			};
 		};
 
+		sdcard_clk_gate_pins: sdcard_clk_gate {
+			mux {
+				groups = "CARD_2";
+				function = "gpio_periphs";
+			};
+			cfg-pull-down {
+				pins = "CARD_2";
+				bias-pull-down;
+			};
+		};
+
 		sdio_pins: sdio {
 			mux {
 				groups = "sdio_d0",
@@ -433,6 +455,17 @@
 			};
 		};
 
+		sdio_clk_gate_pins: sdio_clk_gate {
+			mux {
+				groups = "GPIOX_4";
+				function = "gpio_periphs";
+			};
+			cfg-pull-down {
+				pins = "GPIOX_4";
+				bias-pull-down;
+			};
+		};
+
 		sdio_irq_pins: sdio_irq {
 			mux {
 				groups = "sdio_irq";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
index f779a985f923..977b4240f3c1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
@@ -123,7 +123,8 @@
 &sd_emmc_b {
 	status = "okay";
 	pinctrl-0 = <&sdcard_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdcard_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -141,7 +142,8 @@
 &sd_emmc_c {
 	status = "okay";
 	pinctrl-0 = <&emmc_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
 	cap-mmc-highspeed;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 51c4ecc3b31e..2b56f7d9be2b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -134,7 +134,8 @@
 &sd_emmc_b {
 	status = "okay";
 	pinctrl-0 = <&sdcard_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdcard_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -156,7 +157,8 @@
 &sd_emmc_c {
 	status = "okay";
 	pinctrl-0 = <&emmc_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
 	cap-mmc-highspeed;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
index 83c35efbae8b..df448b11a16b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
@@ -182,7 +182,8 @@
 &sd_emmc_a {
 	status = "okay";
 	pinctrl-0 = <&sdio_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdio_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 	#address-cells = <1>;
 	#size-cells = <0>;
 
@@ -203,7 +204,8 @@
 &sd_emmc_b {
 	status = "okay";
 	pinctrl-0 = <&sdcard_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdcard_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -221,7 +223,8 @@
 &sd_emmc_c {
 	status = "okay";
 	pinctrl-0 = <&emmc_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
 	cap-mmc-highspeed;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
index 8899121f79e1..129af9068814 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
@@ -95,7 +95,8 @@
 &sd_emmc_a {
 	status = "okay";
 	pinctrl-0 = <&sdio_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdio_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 	#address-cells = <1>;
 	#size-cells = <0>;
 
@@ -116,7 +117,8 @@
 &sd_emmc_b {
 	status = "okay";
 	pinctrl-0 = <&sdcard_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdcard_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -134,7 +136,8 @@
 &sd_emmc_c {
 	status = "okay";
 	pinctrl-0 = <&emmc_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
 	cap-mmc-highspeed;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 071eca074a91..e3433a4bf451 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -271,6 +271,17 @@
 			};
 		};
 
+		emmc_clk_gate_pins: emmc_clk_gate {
+			mux {
+				groups = "BOOT_8";
+				function = "gpio_periphs";
+			};
+			cfg-pull-down {
+				pins = "BOOT_8";
+				bias-pull-down;
+			};
+		};
+
 		nor_pins: nor {
 			mux {
 				groups = "nor_d",
@@ -309,6 +320,17 @@
 			};
 		};
 
+		sdcard_clk_gate_pins: sdcard_clk_gate {
+			mux {
+				groups = "CARD_2";
+				function = "gpio_periphs";
+			};
+			cfg-pull-down {
+				pins = "CARD_2";
+				bias-pull-down;
+			};
+		};
+
 		sdio_pins: sdio {
 			mux {
 				groups = "sdio_d0",
@@ -321,6 +343,17 @@
 			};
 		};
 
+		sdio_clk_gate_pins: sdio_clk_gate {
+			mux {
+				groups = "GPIOX_4";
+				function = "gpio_periphs";
+			};
+			cfg-pull-down {
+				pins = "GPIOX_4";
+				bias-pull-down;
+			};
+		};
+
 		sdio_irq_pins: sdio_irq {
 			mux {
 				groups = "sdio_irq";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
index 583da09acf66..7af153535073 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -168,7 +168,8 @@
 &sd_emmc_b {
 	status = "okay";
 	pinctrl-0 = <&sdcard_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdcard_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -186,7 +187,8 @@
 &sd_emmc_c {
 	status = "okay";
 	pinctrl-0 = <&emmc_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
 	cap-mmc-highspeed;
-- 
2.9.5
