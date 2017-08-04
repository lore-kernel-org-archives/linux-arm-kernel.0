From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri,  4 Aug 2017 20:08:15 +0200
Subject: [PATCH 5/6] ARM64: dts: meson: add mmc clk gate pins
In-Reply-To: <20170804180816.18737-1-jbrunet@baylibre.com>
References: <20170804180816.18737-1-jbrunet@baylibre.com>
Message-ID: <20170804180816.18737-6-jbrunet@baylibre.com>
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
index dc478d094c11..ac16096d095e 100644
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
 	cap-sd-highspeed;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index 5d59fd75cae7..919c956a204c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -195,7 +195,8 @@
 &sd_emmc_a {
 	status = "okay";
 	pinctrl-0 = <&sdio_pins>, <&sdio_irq_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdio_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 	#address-cells = <1>;
 	#size-cells = <0>;
 
@@ -221,7 +222,8 @@
 &sd_emmc_b {
 	status = "okay";
 	pinctrl-0 = <&sdcard_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdcard_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -242,7 +244,8 @@
 &sd_emmc_c {
 	status = "disabled";
 	pinctrl-0 = <&emmc_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
 	cap-sd-highspeed;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index a1078b3e1c76..21cd94247f6c 100644
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
 	cap-sd-highspeed;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index d147c853ab05..d2fac2f62a21 100644
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
 	cap-sd-highspeed;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index 900a13cc24ee..738bb45fd07b 100644
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
@@ -234,7 +236,8 @@
 &sd_emmc_c {
 	status = "okay";
 	pinctrl-0 = <&emmc_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
 	cap-sd-highspeed;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 346753fb6324..8acd8d8b375a 100644
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
 	cap-sd-highspeed;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 9a1e478f80d5..cac7a5530c4f 100644
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
+				groups = "GPIOX_5";
+				function = "gpio_periphs";
+			};
+			cfg-pull-down {
+				pins = "GPIOX_5";
+				bias-pull-down;
+			};
+		};
+
 		sdio_irq_pins: sdio_irq {
 			mux {
 				groups = "sdio_irq";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
index 2a5804ce7f4b..068623e75fec 100644
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
 	cap-sd-highspeed;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 185d737f1549..0537b92cd226 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -137,7 +137,8 @@
 &sd_emmc_b {
 	status = "okay";
 	pinctrl-0 = <&sdcard_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdcard_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -159,7 +160,8 @@
 &sd_emmc_c {
 	status = "okay";
 	pinctrl-0 = <&emmc_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
 	cap-mmc-highspeed;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
index 6633a5d8fdd3..cf3b6e7860a4 100644
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
 	cap-sd-highspeed;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
index f3eea8e89d12..e2509a834a62 100644
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
 	cap-sd-highspeed;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 071eca074a91..c222f19fca3f 100644
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
+				groups = "GPIOX_5";
+				function = "gpio_periphs";
+			};
+			cfg-pull-down {
+				pins = "GPIOX_5";
+				bias-pull-down;
+			};
+		};
+
 		sdio_irq_pins: sdio_irq {
 			mux {
 				groups = "sdio_irq";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
index 5f626d683088..ae988bdf1f92 100644
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
 	cap-sd-highspeed;
-- 
2.9.4
