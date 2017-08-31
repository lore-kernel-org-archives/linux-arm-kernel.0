From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 31 Aug 2017 15:52:20 +0200
Subject: [PATCH v3 3/9] ARM64: dts: meson: add mmc clk gate pins
In-Reply-To: <20170831135226.19784-1-jbrunet@baylibre.com>
References: <20170831135226.19784-1-jbrunet@baylibre.com>
Message-ID: <20170831135226.19784-4-jbrunet@baylibre.com>
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
index d4f9c5b550c7..4157987f4a3d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -168,7 +168,8 @@
 &sd_emmc_a {
 	status = "okay";
 	pinctrl-0 = <&sdio_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdio_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 	#address-cells = <1>;
 	#size-cells = <0>;
 
@@ -194,7 +195,8 @@
 &sd_emmc_b {
 	status = "okay";
 	pinctrl-0 = <&sdcard_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdcard_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -212,7 +214,8 @@
 &sd_emmc_c {
 	status = "okay";
 	pinctrl-0 = <&emmc_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
 	cap-mmc-highspeed;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index 7dae6acd3c8c..60d5f2da6916 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -250,7 +250,8 @@
 &sd_emmc_a {
 	status = "okay";
 	pinctrl-0 = <&sdio_pins>, <&sdio_irq_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdio_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 	#address-cells = <1>;
 	#size-cells = <0>;
 
@@ -276,7 +277,8 @@
 &sd_emmc_b {
 	status = "okay";
 	pinctrl-0 = <&sdcard_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdcard_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -294,7 +296,8 @@
 &sd_emmc_c {
 	status = "disabled";
 	pinctrl-0 = <&emmc_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
 	max-frequency = <200000000>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index a690956d6c75..38dfdde5c147 100644
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
@@ -232,7 +232,8 @@
 &sd_emmc_a {
 	status = "okay";
 	pinctrl-0 = <&sdio_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdio_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 	#address-cells = <1>;
 	#size-cells = <0>;
 
@@ -253,7 +254,8 @@
 &sd_emmc_b {
 	status = "okay";
 	pinctrl-0 = <&sdcard_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdcard_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -271,7 +273,8 @@
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
index d77e19591ee3..704b214e8894 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -194,7 +194,8 @@
 &sd_emmc_a {
 	status = "okay";
 	pinctrl-0 = <&sdio_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdio_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 	#address-cells = <1>;
 	#size-cells = <0>;
 
@@ -220,7 +221,8 @@
 &sd_emmc_b {
 	status = "okay";
 	pinctrl-0 = <&sdcard_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdcard_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -238,7 +240,8 @@
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
index 8f0c0cb02157..af834cdbba79 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -392,6 +392,17 @@
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
@@ -430,6 +441,17 @@
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
@@ -442,6 +464,17 @@
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
index 69ca14ac10fa..a014c052241e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -197,7 +197,8 @@
 &sd_emmc_b {
 	status = "okay";
 	pinctrl-0 = <&sdcard_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdcard_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -215,7 +216,8 @@
 &sd_emmc_c {
 	status = "okay";
 	pinctrl-0 = <&emmc_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&emmc_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
 	cap-mmc-highspeed;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
index 21274a6c1b9b..1b8f32867aa1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
@@ -189,7 +189,8 @@
 &sd_emmc_a {
 	status = "okay";
 	pinctrl-0 = <&sdio_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdio_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 	#address-cells = <1>;
 	#size-cells = <0>;
 
@@ -210,7 +211,8 @@
 &sd_emmc_b {
 	status = "okay";
 	pinctrl-0 = <&sdcard_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdcard_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -228,7 +230,8 @@
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
index 829d84db5fc5..d8dd3298b15c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -281,6 +281,17 @@
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
@@ -319,6 +330,17 @@
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
@@ -331,6 +353,17 @@
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
index ff8a9f780485..22c697732f66 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -175,7 +175,8 @@
 &sd_emmc_b {
 	status = "okay";
 	pinctrl-0 = <&sdcard_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdcard_clk_gate_pins>;
+	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <4>;
 	cap-sd-highspeed;
@@ -193,7 +194,8 @@
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
