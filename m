From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 13 May 2013 13:24:31 -0600
Subject: [PATCH 3/4] ARM: tegra: convert device tree files to use GPIO defines
In-Reply-To: <1368473072-10145-1-git-send-email-swarren@wwwdotorg.org>
References: <1368473072-10145-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1368473072-10145-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Use TEGRA_GPIO() macro to name all GPIOs referenced by GPIO properties,
and some interrupts properties. Use standard GPIO flag defines too.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts     |   12 ++++----
 arch/arm/boot/dts/tegra114.dtsi            |    2 ++
 arch/arm/boot/dts/tegra20-colibri-512.dtsi |   16 ++++++----
 arch/arm/boot/dts/tegra20-harmony.dts      |   46 ++++++++++++++++------------
 arch/arm/boot/dts/tegra20-iris-512.dts     |    2 +-
 arch/arm/boot/dts/tegra20-medcom-wide.dts  |    6 ++--
 arch/arm/boot/dts/tegra20-paz00.dts        |   24 +++++++++------
 arch/arm/boot/dts/tegra20-plutux.dts       |    6 ++--
 arch/arm/boot/dts/tegra20-seaboard.dts     |   39 ++++++++++++-----------
 arch/arm/boot/dts/tegra20-tamonten.dtsi    |    7 +++--
 arch/arm/boot/dts/tegra20-tec.dts          |    7 +++--
 arch/arm/boot/dts/tegra20-trimslice.dts    |   19 +++++++-----
 arch/arm/boot/dts/tegra20-ventana.dts      |   41 ++++++++++++++-----------
 arch/arm/boot/dts/tegra20-whistler.dts     |   10 +++---
 arch/arm/boot/dts/tegra20.dtsi             |    2 ++
 arch/arm/boot/dts/tegra30-beaver.dts       |   20 ++++++------
 arch/arm/boot/dts/tegra30-cardhu-a02.dts   |   14 ++++-----
 arch/arm/boot/dts/tegra30-cardhu-a04.dts   |   16 +++++-----
 arch/arm/boot/dts/tegra30-cardhu.dtsi      |   39 +++++++++++------------
 arch/arm/boot/dts/tegra30.dtsi             |    2 ++
 20 files changed, 182 insertions(+), 148 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 3c563af..718af25 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -828,7 +828,7 @@
 	};
 
 	sdhci at 78000400 {
-		cd-gpios = <&gpio 170 1>; /* gpio PV2 */
+		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
 		bus-width = <4>;
 		status = "okay";
 	};
@@ -873,7 +873,7 @@
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			enable-active-high;
-			gpio = <&gpio 61 0>; /* GPIO PH5 */
+			gpio = <&gpio TEGRA_GPIO(H, 5) GPIO_ACTIVE_HIGH>;
 		};
 
 		lcd_bl_en_reg: regulator at 2 {
@@ -883,7 +883,7 @@
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 			enable-active-high;
-			gpio = <&gpio 58 0>; /* GPIO PH2 */
+			gpio = <&gpio TEGRA_GPIO(H, 2) GPIO_ACTIVE_HIGH>;
 		};
 
 		usb1_vbus_reg: regulator at 3 {
@@ -893,7 +893,7 @@
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 			enable-active-high;
-			gpio = <&gpio 108 0>; /* GPIO PN4 */
+			gpio = <&gpio TEGRA_GPIO(N, 4) GPIO_ACTIVE_HIGH>;
 			gpio-open-drain;
 			vin-supply = <&tps65090_dcdc1_reg>;
 		};
@@ -905,7 +905,7 @@
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 			enable-active-high;
-			gpio = <&gpio 86 0>; /* GPIO PK6 */
+			gpio = <&gpio TEGRA_GPIO(K, 6) GPIO_ACTIVE_HIGH>;
 			gpio-open-drain;
 			vin-supply = <&tps65090_dcdc1_reg>;
 		};
@@ -917,7 +917,7 @@
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 			enable-active-high;
-			gpio = <&gpio 81 0>; /* GPIO PK1 */
+			gpio = <&gpio TEGRA_GPIO(K, 1) GPIO_ACTIVE_HIGH>;
 			vin-supply = <&tps65090_dcdc1_reg>;
 		};
 	};
diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index aeeb53b..6cd6d41 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -1,3 +1,5 @@
+#include <dt-bindings/gpio/tegra-gpio.h>
+
 #include "skeleton.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
index 390a4fb..f5be14c 100644
--- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
@@ -14,7 +14,8 @@
 			pll-supply = <&hdmi_pll_reg>;
 
 			nvidia,ddc-i2c-bus = <&i2c_ddc>;
-			nvidia,hpd-gpio = <&gpio 111 0>; /* PN7 */
+			nvidia,hpd-gpio = <&gpio TEGRA_GPIO(N, 7)
+				GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -443,17 +444,20 @@
 
 	ac97: ac97 {
 		status = "okay";
-		nvidia,codec-reset-gpio = <&gpio 168 0>; /* gpio PV0 */
-		nvidia,codec-sync-gpio = <&gpio 120 0>; /* gpio PP0 */
+		nvidia,codec-reset-gpio = <&gpio TEGRA_GPIO(V, 0)
+			GPIO_ACTIVE_HIGH>;
+		nvidia,codec-sync-gpio = <&gpio TEGRA_GPIO(P, 0)
+			GPIO_ACTIVE_HIGH>;
 	};
 
 	usb at c5004000 {
 		status = "okay";
-		nvidia,phy-reset-gpio = <&gpio 169 0>; /* gpio PV1 */
+		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
+			GPIO_ACTIVE_HIGH>;
 	};
 
 	sdhci at c8000600 {
-		cd-gpios = <&gpio 23 1>; /* gpio PC7 */
+		cd-gpios = <&gpio TEGRA_GPIO(C, 7) GPIO_ACTIVE_LOW>;
 	};
 
 	clocks {
@@ -510,7 +514,7 @@
 			enable-active-high;
 			regulator-boot-on;
 			regulator-always-on;
-			gpio = <&gpio 217 0>;
+			gpio = <&gpio TEGRA_GPIO(BB, 1) GPIO_ACTIVE_HIGH>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index 3f968f2..3cce7b0 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -18,7 +18,8 @@
 			pll-supply = <&hdmi_pll_reg>;
 
 			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
-			nvidia,hpd-gpio = <&gpio 111 0>; /* PN7 */
+			nvidia,hpd-gpio = <&gpio TEGRA_GPIO(N, 7)
+				GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -262,7 +263,7 @@
 			compatible = "wlf,wm8903";
 			reg = <0x1a>;
 			interrupt-parent = <&gpio>;
-			interrupts = <187 0x04>;
+			interrupts = <TEGRA_GPIO(X, 3) 0x04>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -430,7 +431,8 @@
 
 	usb at c5004000 {
 		status = "okay";
-		nvidia,phy-reset-gpio = <&gpio 169 0>; /* gpio PV1 */
+		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
+			GPIO_ACTIVE_HIGH>;
 	};
 
 	usb at c5008000 {
@@ -438,22 +440,23 @@
 	};
 
 	usb-phy at c5004400 {
-		nvidia,phy-reset-gpio = <&gpio 169 0>; /* gpio PV1 */
+		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
+			GPIO_ACTIVE_HIGH>;
 	};
 
 	sdhci at c8000200 {
 		status = "okay";
-		cd-gpios = <&gpio 69 1>; /* gpio PI5 */
-		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
-		power-gpios = <&gpio 155 0>; /* gpio PT3 */
+		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
+		wp-gpios = <&gpio TEGRA_GPIO(H, 1) GPIO_ACTIVE_HIGH>;
+		power-gpios = <&gpio TEGRA_GPIO(T, 3) GPIO_ACTIVE_HIGH>;
 		bus-width = <4>;
 	};
 
 	sdhci at c8000600 {
 		status = "okay";
-		cd-gpios = <&gpio 58 1>; /* gpio PH2 */
-		wp-gpios = <&gpio 59 0>; /* gpio PH3 */
-		power-gpios = <&gpio 70 0>; /* gpio PI6 */
+		cd-gpios = <&gpio TEGRA_GPIO(H, 2) GPIO_ACTIVE_LOW>;
+		wp-gpios = <&gpio TEGRA_GPIO(H, 3) GPIO_ACTIVE_HIGH>;
+		power-gpios = <&gpio TEGRA_GPIO(I, 6) GPIO_ACTIVE_HIGH>;
 		bus-width = <8>;
 	};
 
@@ -475,7 +478,7 @@
 
 		power {
 			label = "Power";
-			gpios = <&gpio 170 1>; /* gpio PV2, active low */
+			gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <116>; /* KEY_POWER */
 			gpio-key,wakeup;
 		};
@@ -618,7 +621,7 @@
 			regulator-name = "vdd_1v5";
 			regulator-min-microvolt = <1500000>;
 			regulator-max-microvolt = <1500000>;
-			gpio = <&pmic 0 0>;
+			gpio = <&pmic 0 GPIO_ACTIVE_HIGH>;
 		};
 
 		regulator at 2 {
@@ -627,7 +630,7 @@
 			regulator-name = "vdd_1v2";
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
-			gpio = <&pmic 1 0>;
+			gpio = <&pmic 1 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 		};
 
@@ -637,7 +640,7 @@
 			regulator-name = "vdd_1v05";
 			regulator-min-microvolt = <1050000>;
 			regulator-max-microvolt = <1050000>;
-			gpio = <&pmic 2 0>;
+			gpio = <&pmic 2 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 			/* Hack until board-harmony-pcie.c is removed */
 			status = "disabled";
@@ -649,7 +652,7 @@
 			regulator-name = "vdd_pnl";
 			regulator-min-microvolt = <2800000>;
 			regulator-max-microvolt = <2800000>;
-			gpio = <&gpio 22 0>; /* gpio PC6 */
+			gpio = <&gpio TEGRA_GPIO(C, 6) GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 		};
 
@@ -659,7 +662,7 @@
 			regulator-name = "vdd_bl";
 			regulator-min-microvolt = <2800000>;
 			regulator-max-microvolt = <2800000>;
-			gpio = <&gpio 176 0>; /* gpio PW0 */
+			gpio = <&gpio TEGRA_GPIO(W, 0) GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 		};
 	};
@@ -682,10 +685,13 @@
 		nvidia,i2s-controller = <&tegra_i2s1>;
 		nvidia,audio-codec = <&wm8903>;
 
-		nvidia,spkr-en-gpios = <&wm8903 2 0>;
-		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
-		nvidia,int-mic-en-gpios = <&gpio 184 0>; /*gpio PX0 */
-		nvidia,ext-mic-en-gpios = <&gpio 185 0>; /* gpio PX1 */
+		nvidia,spkr-en-gpios = <&wm8903 2 GPIO_ACTIVE_HIGH>;
+		nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(W, 2)
+			GPIO_ACTIVE_HIGH>;
+		nvidia,int-mic-en-gpios = <&gpio TEGRA_GPIO(X, 0)
+			GPIO_ACTIVE_HIGH>;
+		nvidia,ext-mic-en-gpios = <&gpio TEGRA_GPIO(X, 1)
+			GPIO_ACTIVE_HIGH>;
 
 		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 94>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
diff --git a/arch/arm/boot/dts/tegra20-iris-512.dts b/arch/arm/boot/dts/tegra20-iris-512.dts
index 248f7ea..f1c5a64 100644
--- a/arch/arm/boot/dts/tegra20-iris-512.dts
+++ b/arch/arm/boot/dts/tegra20-iris-512.dts
@@ -73,7 +73,7 @@
 			regulator-max-microvolt = <5000000>;
 			regulator-boot-on;
 			regulator-always-on;
-			gpio = <&gpio 178 0>;
+			gpio = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_HIGH>;
 		};
 
 		vcc_sd_reg: regulator at 1 {
diff --git a/arch/arm/boot/dts/tegra20-medcom-wide.dts b/arch/arm/boot/dts/tegra20-medcom-wide.dts
index d7e32fa..3adfbfe 100644
--- a/arch/arm/boot/dts/tegra20-medcom-wide.dts
+++ b/arch/arm/boot/dts/tegra20-medcom-wide.dts
@@ -15,7 +15,7 @@
 			compatible = "wlf,wm8903";
 			reg = <0x1a>;
 			interrupt-parent = <&gpio>;
-			interrupts = <187 0x04>;
+			interrupts = <TEGRA_GPIO(X, 3) 0x04>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -56,8 +56,8 @@
 		nvidia,i2s-controller = <&tegra_i2s1>;
 		nvidia,audio-codec = <&wm8903>;
 
-		nvidia,spkr-en-gpios = <&wm8903 2 0>;
-		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
+		nvidia,spkr-en-gpios = <&wm8903 2 GPIO_ACTIVE_HIGH>;
+		nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_HIGH>;
 
 		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 94>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index df57639..d2b631d 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -18,7 +18,8 @@
 			pll-supply = <&hdmi_pll_reg>;
 
 			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
-			nvidia,hpd-gpio = <&gpio 111 0>; /* PN7 */
+			nvidia,hpd-gpio = <&gpio TEGRA_GPIO(N, 7)
+				GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -274,7 +275,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clock-frequency = <80000>;
-		request-gpios = <&gpio 170 0>; /* gpio PV2 */
+		request-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
 		slave-addr = <138>;
 		clocks = <&tegra_car 67>, <&tegra_car 124>;
 		clock-names = "div-clk", "fast-clk";
@@ -429,7 +430,8 @@
 
 	usb at c5004000 {
 		status = "okay";
-		nvidia,phy-reset-gpio = <&gpio 168 0>; /* gpio PV0 */
+		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 0)
+			GPIO_ACTIVE_HIGH>;
 	};
 
 	usb at c5008000 {
@@ -437,14 +439,15 @@
 	};
 
 	usb-phy at c5004400 {
-		nvidia,phy-reset-gpio = <&gpio 168 0>; /* gpio PV0 */
+		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 0)
+			GPIO_ACTIVE_HIGH>;
 	};
 
 	sdhci at c8000000 {
 		status = "okay";
-		cd-gpios = <&gpio 173 1>; /* gpio PV5 */
-		wp-gpios = <&gpio 57 0>;  /* gpio PH1 */
-		power-gpios = <&gpio 169 0>; /* gpio PV1 */
+		cd-gpios = <&gpio TEGRA_GPIO(V, 5) GPIO_ACTIVE_LOW>;
+		wp-gpios = <&gpio TEGRA_GPIO(H, 1) GPIO_ACTIVE_HIGH>;
+		power-gpios = <&gpio TEGRA_GPIO(V, 1) GPIO_ACTIVE_HIGH>;
 		bus-width = <4>;
 	};
 
@@ -472,7 +475,7 @@
 
 		power {
 			label = "Power";
-			gpios = <&gpio 79 1>; /* gpio PJ7, active low */
+			gpios = <&gpio TEGRA_GPIO(J, 7) GPIO_ACTIVE_LOW>;
 			linux,code = <116>; /* KEY_POWER */
 			gpio-key,wakeup;
 		};
@@ -483,7 +486,7 @@
 
 		wifi {
 			label = "wifi-led";
-			gpios = <&gpio 24 0>; /* gpio PD0 */
+			gpios = <&gpio TEGRA_GPIO(D, 0) GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "rfkill0";
 		};
 	};
@@ -520,7 +523,8 @@
 
 		nvidia,audio-codec = <&alc5632>;
 		nvidia,i2s-controller = <&tegra_i2s1>;
-		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
+		nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(W, 2)
+			GPIO_ACTIVE_HIGH>;
 
 		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 94>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
diff --git a/arch/arm/boot/dts/tegra20-plutux.dts b/arch/arm/boot/dts/tegra20-plutux.dts
index 508e56a..3d8e69b 100644
--- a/arch/arm/boot/dts/tegra20-plutux.dts
+++ b/arch/arm/boot/dts/tegra20-plutux.dts
@@ -17,7 +17,7 @@
 			compatible = "wlf,wm8903";
 			reg = <0x1a>;
 			interrupt-parent = <&gpio>;
-			interrupts = <187 0x04>;
+			interrupts = <TEGRA_GPIO(X, 3) 0x04>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -50,8 +50,8 @@
 		nvidia,i2s-controller = <&tegra_i2s1>;
 		nvidia,audio-codec = <&wm8903>;
 
-		nvidia,spkr-en-gpios = <&wm8903 2 0>;
-		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
+		nvidia,spkr-en-gpios = <&wm8903 2 GPIO_ACTIVE_HIGH>;
+		nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_HIGH>;
 
 		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 94>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 368e6fb..519ae6b 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -18,7 +18,8 @@
 			pll-supply = <&hdmi_pll_reg>;
 
 			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
-			nvidia,hpd-gpio = <&gpio 111 0>; /* PN7 */
+			nvidia,hpd-gpio = <&gpio TEGRA_GPIO(N, 7)
+				GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -313,7 +314,7 @@
 			compatible = "wlf,wm8903";
 			reg = <0x1a>;
 			interrupt-parent = <&gpio>;
-			interrupts = <187 0x04>;
+			interrupts = <TEGRA_GPIO(X, 3) 0x04>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -328,14 +329,14 @@
 			compatible = "isil,isl29018";
 			reg = <0x44>;
 			interrupt-parent = <&gpio>;
-			interrupts = <202 0x04>; /* GPIO PZ2 */
+			interrupts = <TEGRA_GPIO(Z, 2) 0x04>;
 		};
 
 		gyrometer at 68 {
 			compatible = "invn,mpu3050";
 			reg = <0x68>;
 			interrupt-parent = <&gpio>;
-			interrupts = <204 0x04>; /* gpio PZ4 */
+			interrupts = <TEGRA_GPIO(Z, 4) 0x04>;
 		};
 	};
 
@@ -511,7 +512,7 @@
 			compatible = "ak,ak8975";
 			reg = <0xc>;
 			interrupt-parent = <&gpio>;
-			interrupts = <109 0x04>; /* gpio PN5 */
+			interrupts = <TEGRA_GPIO(N, 5) 0x04>;
 		};
 	};
 
@@ -565,13 +566,14 @@
 
 	usb at c5000000 {
 		status = "okay";
-		nvidia,vbus-gpio = <&gpio 24 0>; /* PD0 */
+		nvidia,vbus-gpio = <&gpio TEGRA_GPIO(D, 0) GPIO_ACTIVE_HIGH>;
 		dr_mode = "otg";
 	};
 
 	usb at c5004000 {
 		status = "okay";
-		nvidia,phy-reset-gpio = <&gpio 169 0>; /* gpio PV1 */
+		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
+			GPIO_ACTIVE_HIGH>;
 	};
 
 	usb at c5008000 {
@@ -579,21 +581,22 @@
 	};
 
 	usb-phy at c5004400 {
-		nvidia,phy-reset-gpio = <&gpio 169 0>; /* gpio PV1 */
+		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
+			GPIO_ACTIVE_HIGH>;
 	};
 
 	sdhci at c8000000 {
 		status = "okay";
-		power-gpios = <&gpio 86 0>; /* gpio PK6 */
+		power-gpios = <&gpio TEGRA_GPIO(K, 6) GPIO_ACTIVE_HIGH>;
 		bus-width = <4>;
 		keep-power-in-suspend;
 	};
 
 	sdhci at c8000400 {
 		status = "okay";
-		cd-gpios = <&gpio 69 1>; /* gpio PI5 */
-		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
-		power-gpios = <&gpio 70 0>; /* gpio PI6 */
+		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
+		wp-gpios = <&gpio TEGRA_GPIO(H, 1) GPIO_ACTIVE_HIGH>;
+		power-gpios = <&gpio TEGRA_GPIO(I, 6) GPIO_ACTIVE_HIGH>;
 		bus-width = <4>;
 	};
 
@@ -621,14 +624,14 @@
 
 		power {
 			label = "Power";
-			gpios = <&gpio 170 1>; /* gpio PV2, active low */
+			gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <116>; /* KEY_POWER */
 			gpio-key,wakeup;
 		};
 
 		lid {
 			label = "Lid";
-			gpios = <&gpio 23 0>; /* gpio PC7 */
+			gpios = <&gpio TEGRA_GPIO(C, 7) GPIO_ACTIVE_HIGH>;
 			linux,input-type = <5>; /* EV_SW */
 			linux,code = <0>; /* SW_LID */
 			debounce-interval = <1>;
@@ -795,7 +798,7 @@
 			regulator-name = "vdd_1v5";
 			regulator-min-microvolt = <1500000>;
 			regulator-max-microvolt = <1500000>;
-			gpio = <&pmic 0 0>;
+			gpio = <&pmic 0 GPIO_ACTIVE_HIGH>;
 		};
 
 		regulator at 2 {
@@ -804,7 +807,7 @@
 			regulator-name = "vdd_1v2";
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
-			gpio = <&pmic 1 0>;
+			gpio = <&pmic 1 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 		};
 	};
@@ -827,8 +830,8 @@
 		nvidia,i2s-controller = <&tegra_i2s1>;
 		nvidia,audio-codec = <&wm8903>;
 
-		nvidia,spkr-en-gpios = <&wm8903 2 0>;
-		nvidia,hp-det-gpios = <&gpio 185 0>; /* gpio PX1 */
+		nvidia,spkr-en-gpios = <&wm8903 2 GPIO_ACTIVE_HIGH>;
+		nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(X, 1) GPIO_ACTIVE_HIGH>;
 
 		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 94>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi
index eb6ba60..78d50a3 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
@@ -14,7 +14,8 @@
 			pll-supply = <&hdmi_pll_reg>;
 
 			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
-			nvidia,hpd-gpio = <&gpio 111 0>; /* PN7 */
+			nvidia,hpd-gpio = <&gpio TEGRA_GPIO(N, 7)
+				GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -471,8 +472,8 @@
 	};
 
 	sdhci at c8000600 {
-		cd-gpios = <&gpio 58 1>; /* gpio PH2 */
-		wp-gpios = <&gpio 59 0>; /* gpio PH3 */
+		cd-gpios = <&gpio TEGRA_GPIO(H, 2) GPIO_ACTIVE_LOW>;
+		wp-gpios = <&gpio TEGRA_GPIO(H, 3) GPIO_ACTIVE_HIGH>;
 		bus-width = <4>;
 		status = "okay";
 	};
diff --git a/arch/arm/boot/dts/tegra20-tec.dts b/arch/arm/boot/dts/tegra20-tec.dts
index 9a2a6a4..db58bb7 100644
--- a/arch/arm/boot/dts/tegra20-tec.dts
+++ b/arch/arm/boot/dts/tegra20-tec.dts
@@ -17,7 +17,7 @@
 			compatible = "wlf,wm8903";
 			reg = <0x1a>;
 			interrupt-parent = <&gpio>;
-			interrupts = <187 0x04>;
+			interrupts = <TEGRA_GPIO(X, 3) 0x04>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -50,8 +50,9 @@
 		nvidia,i2s-controller = <&tegra_i2s1>;
 		nvidia,audio-codec = <&wm8903>;
 
-		nvidia,spkr-en-gpios = <&wm8903 2 0>;
-		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
+		nvidia,spkr-en-gpios = <&wm8903 2 GPIO_ACTIVE_HIGH>;
+		nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(W, 2)
+			GPIO_ACTIVE_HIGH>;
 
 		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 94>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index cf4fdce..0e097c1 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -18,7 +18,8 @@
 			pll-supply = <&hdmi_pll_reg>;
 
 			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
-			nvidia,hpd-gpio = <&gpio 111 0>; /* PN7 */
+			nvidia,hpd-gpio = <&gpio TEGRA_GPIO(N, 7)
+				GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -311,12 +312,13 @@
 
 	usb at c5000000 {
 		status = "okay";
-		nvidia,vbus-gpio = <&gpio 170 0>; /* gpio PV2 */
+		nvidia,vbus-gpio = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
 	};
 
 	usb at c5004000 {
 		status = "okay";
-		nvidia,phy-reset-gpio = <&gpio 168 0>; /* gpio PV0 */
+		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 0)
+			GPIO_ACTIVE_HIGH>;
 	};
 
 	usb at c5008000 {
@@ -324,7 +326,8 @@
 	};
 
 	usb-phy at c5004400 {
-		nvidia,phy-reset-gpio = <&gpio 168 0>; /* gpio PV0 */
+		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 0)
+			GPIO_ACTIVE_HIGH>;
 	};
 
 	sdhci at c8000000 {
@@ -334,8 +337,8 @@
 
 	sdhci at c8000600 {
 		status = "okay";
-		cd-gpios = <&gpio 121 1>; /* gpio PP1 */
-		wp-gpios = <&gpio 122 0>; /* gpio PP2 */
+		cd-gpios = <&gpio TEGRA_GPIO(P, 1) GPIO_ACTIVE_LOW>;
+		wp-gpios = <&gpio TEGRA_GPIO(P, 2) GPIO_ACTIVE_HIGH>;
 		bus-width = <4>;
 	};
 
@@ -357,7 +360,7 @@
 
 		power {
 			label = "Power";
-			gpios = <&gpio 190 1>; /* gpio PX6, active low */
+			gpios = <&gpio TEGRA_GPIO(X, 6) GPIO_ACTIVE_LOW>;
 			linux,code = <116>; /* KEY_POWER */
 			gpio-key,wakeup;
 		};
@@ -365,7 +368,7 @@
 
 	poweroff {
 		compatible = "gpio-poweroff";
-		gpios = <&gpio 191 1>; /* gpio PX7, active low */
+		gpios = <&gpio TEGRA_GPIO(X, 7) GPIO_ACTIVE_LOW>;
 	};
 
 	regulators {
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index 9f9efec..60eb5a3 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -18,7 +18,8 @@
 			pll-supply = <&hdmi_pll_reg>;
 
 			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
-			nvidia,hpd-gpio = <&gpio 111 0>; /* PN7 */
+			nvidia,hpd-gpio = <&gpio TEGRA_GPIO(N, 7)
+				GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -310,7 +311,7 @@
 			compatible = "wlf,wm8903";
 			reg = <0x1a>;
 			interrupt-parent = <&gpio>;
-			interrupts = <187 0x04>;
+			interrupts = <TEGRA_GPIO(X, 3) 0x04>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -325,7 +326,7 @@
 			compatible = "isil,isl29018";
 			reg = <0x44>;
 			interrupt-parent = <&gpio>;
-			interrupts = <202 0x04>; /*gpio PZ2 */
+			interrupts = <TEGRA_GPIO(Z, 2) 0x04>;
 		};
 	};
 
@@ -507,7 +508,8 @@
 
 	usb at c5004000 {
 		status = "okay";
-		nvidia,phy-reset-gpio = <&gpio 169 0>; /* gpio PV1 */
+		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
+			GPIO_ACTIVE_HIGH>;
 	};
 
 	usb at c5008000 {
@@ -515,21 +517,22 @@
 	};
 
 	usb-phy at c5004400 {
-		nvidia,phy-reset-gpio = <&gpio 169 0>; /* gpio PV1 */
+		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
+			GPIO_ACTIVE_HIGH>;
 	};
 
 	sdhci at c8000000 {
 		status = "okay";
-		power-gpios = <&gpio 86 0>; /* gpio PK6 */
+		power-gpios = <&gpio TEGRA_GPIO(K, 6) GPIO_ACTIVE_HIGH>;
 		bus-width = <4>;
 		keep-power-in-suspend;
 	};
 
 	sdhci at c8000400 {
 		status = "okay";
-		cd-gpios = <&gpio 69 1>; /* gpio PI5 */
-		wp-gpios = <&gpio 57 0>; /* gpio PH1 */
-		power-gpios = <&gpio 70 0>; /* gpio PI6 */
+		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
+		wp-gpios = <&gpio TEGRA_GPIO(H, 1) GPIO_ACTIVE_HIGH>;
+		power-gpios = <&gpio TEGRA_GPIO(I, 6) GPIO_ACTIVE_HIGH>;
 		bus-width = <4>;
 	};
 
@@ -557,7 +560,7 @@
 
 		power {
 			label = "Power";
-			gpios = <&gpio 170 1>; /* gpio PV2, active low */
+			gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <116>; /* KEY_POWER */
 			gpio-key,wakeup;
 		};
@@ -583,7 +586,7 @@
 			regulator-name = "vdd_1v5";
 			regulator-min-microvolt = <1500000>;
 			regulator-max-microvolt = <1500000>;
-			gpio = <&pmic 0 0>;
+			gpio = <&pmic 0 GPIO_ACTIVE_HIGH>;
 		};
 
 		regulator at 2 {
@@ -592,7 +595,7 @@
 			regulator-name = "vdd_1v2";
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
-			gpio = <&pmic 1 0>;
+			gpio = <&pmic 1 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 		};
 
@@ -602,7 +605,7 @@
 			regulator-name = "vdd_pnl";
 			regulator-min-microvolt = <2800000>;
 			regulator-max-microvolt = <2800000>;
-			gpio = <&gpio 22 0>; /* gpio PC6 */
+			gpio = <&gpio TEGRA_GPIO(C, 6) GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 		};
 
@@ -612,7 +615,7 @@
 			regulator-name = "vdd_bl";
 			regulator-min-microvolt = <2800000>;
 			regulator-max-microvolt = <2800000>;
-			gpio = <&gpio 176 0>; /* gpio PW0 */
+			gpio = <&gpio TEGRA_GPIO(W, 0) GPIO_ACTIVE_HIGH>;
 			enable-active-high;
 		};
 	};
@@ -635,10 +638,12 @@
 		nvidia,i2s-controller = <&tegra_i2s1>;
 		nvidia,audio-codec = <&wm8903>;
 
-		nvidia,spkr-en-gpios = <&wm8903 2 0>;
-		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
-		nvidia,int-mic-en-gpios = <&gpio 184 0>; /* gpio PX0 */
-		nvidia,ext-mic-en-gpios = <&gpio 185 0>; /* gpio PX1 */
+		nvidia,spkr-en-gpios = <&wm8903 2 GPIO_ACTIVE_HIGH>;
+		nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_HIGH>;
+		nvidia,int-mic-en-gpios = <&gpio TEGRA_GPIO(X, 0)
+			GPIO_ACTIVE_HIGH>;
+		nvidia,ext-mic-en-gpios = <&gpio TEGRA_GPIO(X, 1)
+			GPIO_ACTIVE_HIGH>;
 
 		clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 94>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index 8c415f2..010f481 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -18,7 +18,8 @@
 			pll-supply = <&hdmi_pll_reg>;
 
 			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
-			nvidia,hpd-gpio = <&gpio 111 0>; /* PN7 */
+			nvidia,hpd-gpio = <&gpio TEGRA_GPIO(N, 7)
+				GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -508,18 +509,17 @@
 
 	usb at c5000000 {
 		status = "okay";
-		nvidia,vbus-gpio = <&tca6416 0 0>; /* GPIO_PMU0 */
+		nvidia,vbus-gpio = <&tca6416 0 GPIO_ACTIVE_HIGH>;
 	};
 
 	usb at c5008000 {
 		status = "okay";
-		nvidia,vbus-gpio = <&tca6416 1 0>; /* GPIO_PMU1 */
+		nvidia,vbus-gpio = <&tca6416 1 GPIO_ACTIVE_HIGH>;
 	};
 
 	sdhci at c8000400 {
 		status = "okay";
-		cd-gpios = <&gpio 69 1>; /* gpio PI5 */
-		wp-gpios = <&gpio 173 0>; /* gpio PV5 */
+		wp-gpios = <&gpio TEGRA_GPIO(V, 5) GPIO_ACTIVE_LOW>;
 		bus-width = <8>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index ed5f23f..c6ceb8a 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -1,3 +1,5 @@
+#include <dt-bindings/gpio/tegra-gpio.h>
+
 #include "skeleton.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index b92ab8a..a11e375 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -264,9 +264,9 @@
 
 	sdhci at 78000000 {
 		status = "okay";
-		cd-gpios = <&gpio 69 1>; /* gpio PI5 */
-		wp-gpios = <&gpio 155 0>; /* gpio PT3 */
-		power-gpios = <&gpio 31 0>; /* gpio PD7 */
+		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
+		wp-gpios = <&gpio TEGRA_GPIO(T, 3) GPIO_ACTIVE_HIGH>;
+		power-gpios = <&gpio TEGRA_GPIO(D, 7) GPIO_ACTIVE_HIGH>;
 		bus-width = <4>;
 	};
 
@@ -312,7 +312,7 @@
 			regulator-boot-on;
 			regulator-always-on;
 			enable-active-high;
-			gpio = <&pmic 0 0>; /* PMIC TPS65911 GPIO0 */
+			gpio = <&pmic 0 GPIO_ACTIVE_HIGH>;
 		};
 
 		ddr_reg: regulator at 2 {
@@ -324,7 +324,7 @@
 			regulator-always-on;
 			regulator-boot-on;
 			enable-active-high;
-			gpio = <&pmic 7 0>; /* PMIC TPS65911 GPIO7 */
+			gpio = <&pmic 7 GPIO_ACTIVE_HIGH>;
 			vin-supply = <&vdd_5v_in_reg>;
 		};
 
@@ -337,7 +337,7 @@
 			regulator-always-on;
 			regulator-boot-on;
 			enable-active-high;
-			gpio = <&gpio 30 0>; /* gpio PD6 */
+			gpio = <&gpio TEGRA_GPIO(D, 6) GPIO_ACTIVE_HIGH>;
 			vin-supply = <&vdd_5v_in_reg>;
 		};
 
@@ -348,7 +348,7 @@
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 			enable-active-high;
-			gpio = <&gpio 68 0>; /* GPIO PI4 */
+			gpio = <&gpio TEGRA_GPIO(I, 4) GPIO_ACTIVE_HIGH>;
 			gpio-open-drain;
 			vin-supply = <&vdd_5v_in_reg>;
 		};
@@ -360,7 +360,7 @@
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 			enable-active-high;
-			gpio = <&gpio 63 0>; /* GPIO PH7 */
+			gpio = <&gpio TEGRA_GPIO(H, 7) GPIO_ACTIVE_HIGH>;
 			gpio-open-drain;
 			vin-supply = <&vdd_5v_in_reg>;
 		};
@@ -374,7 +374,7 @@
 			regulator-always-on;
 			regulator-boot-on;
 			enable-active-high;
-			gpio = <&pmic 6 0>; /* PMIC TPS65911 GPIO6 */
+			gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
 			vin-supply = <&vdd_5v_in_reg>;
 		};
 
@@ -387,7 +387,7 @@
 			regulator-always-on;
 			regulator-boot-on;
 			enable-active-high;
-			gpio = <&gpio 95 0>; /* gpio PL7 */
+			gpio = <&gpio TEGRA_GPIO(L, 7) GPIO_ACTIVE_HIGH>;
 			vin-supply = <&sys_3v3_reg>;
 		};
 	};
diff --git a/arch/arm/boot/dts/tegra30-cardhu-a02.dts b/arch/arm/boot/dts/tegra30-cardhu-a02.dts
index 3934b0f..1082c5e 100644
--- a/arch/arm/boot/dts/tegra30-cardhu-a02.dts
+++ b/arch/arm/boot/dts/tegra30-cardhu-a02.dts
@@ -22,7 +22,7 @@
 			regulator-always-on;
 			regulator-boot-on;
 			enable-active-high;
-			gpio = <&pmic 6 0>;
+			gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
 		};
 
 		sys_3v3_reg: regulator at 101 {
@@ -34,7 +34,7 @@
 			regulator-always-on;
 			regulator-boot-on;
 			enable-active-high;
-			gpio = <&pmic 7 0>;
+			gpio = <&pmic 7 GPIO_ACTIVE_HIGH>;
 		};
 
 		usb1_vbus_reg: regulator at 102 {
@@ -44,7 +44,7 @@
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 			enable-active-high;
-			gpio = <&gpio 68 0>; /* GPIO PI4 */
+			gpio = <&gpio TEGRA_GPIO(I, 4) GPIO_ACTIVE_HIGH>;
 			gpio-open-drain;
 			vin-supply = <&vdd_5v0_reg>;
 		};
@@ -56,7 +56,7 @@
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 			enable-active-high;
-			gpio = <&gpio 63 0>; /* GPIO PH7 */
+			gpio = <&gpio TEGRA_GPIO(H, 7) GPIO_ACTIVE_HIGH>;
 			gpio-open-drain;
 			vin-supply = <&vdd_5v0_reg>;
 		};
@@ -68,7 +68,7 @@
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 			enable-active-high;
-			gpio = <&pmic 2 0>;
+			gpio = <&pmic 2 GPIO_ACTIVE_HIGH>;
 		};
 
 		vdd_bl_reg: regulator at 105 {
@@ -80,13 +80,13 @@
 			regulator-always-on;
 			regulator-boot-on;
 			enable-active-high;
-			gpio = <&gpio 83 0>; /* GPIO PK3 */
+			gpio = <&gpio TEGRA_GPIO(K, 3) GPIO_ACTIVE_HIGH>;
 		};
 	};
 
 	sdhci at 78000400 {
 		status = "okay";
-		power-gpios = <&gpio 28 0>; /* gpio PD4 */
+		power-gpios = <&gpio TEGRA_GPIO(D, 4) GPIO_ACTIVE_HIGH>;
 		bus-width = <4>;
 		keep-power-in-suspend;
 	};
diff --git a/arch/arm/boot/dts/tegra30-cardhu-a04.dts b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
index af3ff7a..bf012bdd 100644
--- a/arch/arm/boot/dts/tegra30-cardhu-a04.dts
+++ b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
@@ -22,7 +22,7 @@
 			regulator-always-on;
 			regulator-boot-on;
 			enable-active-high;
-			gpio = <&pmic 7 0>;
+			gpio = <&pmic 7 GPIO_ACTIVE_HIGH>;
 		};
 
 		sys_3v3_reg: regulator at 101 {
@@ -34,7 +34,7 @@
 			regulator-always-on;
 			regulator-boot-on;
 			enable-active-high;
-			gpio = <&pmic 6 0>;
+			gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
 		};
 
 		usb1_vbus_reg: regulator at 102 {
@@ -44,7 +44,7 @@
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 			enable-active-high;
-			gpio = <&gpio 238 0>; /* GPIO PDD6 */
+			gpio = <&gpio TEGRA_GPIO(DD, 6) GPIO_ACTIVE_HIGH>;
 			gpio-open-drain;
 			vin-supply = <&vdd_5v0_reg>;
 		};
@@ -56,7 +56,7 @@
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 			enable-active-high;
-			gpio = <&gpio 236 0>; /* GPIO PDD4 */
+			gpio = <&gpio TEGRA_GPIO(DD, 4) GPIO_ACTIVE_HIGH>;
 			gpio-open-drain;
 			vin-supply = <&vdd_5v0_reg>;
 		};
@@ -68,7 +68,7 @@
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 			enable-active-high;
-			gpio = <&pmic 8 0>;
+			gpio = <&pmic 8 GPIO_ACTIVE_HIGH>;
 		};
 
 		vdd_bl_reg: regulator at 105 {
@@ -80,7 +80,7 @@
 			regulator-always-on;
 			regulator-boot-on;
 			enable-active-high;
-			gpio = <&gpio 234 0>; /* GPIO PDD2 */
+			gpio = <&gpio TEGRA_GPIO(DD, 2) GPIO_ACTIVE_HIGH>;
 		};
 
 		vdd_bl2_reg: regulator at 106 {
@@ -92,13 +92,13 @@
 			regulator-always-on;
 			regulator-boot-on;
 			enable-active-high;
-			gpio = <&gpio 232 0>; /* GPIO PDD0 */
+			gpio = <&gpio TEGRA_GPIO(DD, 0) GPIO_ACTIVE_HIGH>;
 		};
 	};
 
 	sdhci at 78000400 {
 		status = "okay";
-		power-gpios = <&gpio 27 0>; /* gpio PD3 */
+		power-gpios = <&gpio TEGRA_GPIO(D, 3) GPIO_ACTIVE_HIGH>;
 		bus-width = <4>;
 		keep-power-in-suspend;
 	};
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index e54eed2..c177fd9 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -146,7 +146,7 @@
 			compatible = "isil,isl29028";
 			reg = <0x44>;
 			interrupt-parent = <&gpio>;
-			interrupts = <88 0x04>; /*gpio PL0 */
+			interrupts = <TEGRA_GPIO(L, 0) 0x04>;
 		};
 	};
 
@@ -163,7 +163,7 @@
 			compatible = "wlf,wm8903";
 			reg = <0x1a>;
 			interrupt-parent = <&gpio>;
-			interrupts = <179 0x04>; /* gpio PW3 */
+			interrupts = <TEGRA_GPIO(W, 3) 0x04>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -318,9 +318,9 @@
 
 	sdhci at 78000000 {
 		status = "okay";
-		cd-gpios = <&gpio 69 1>; /* gpio PI5 */
-		wp-gpios = <&gpio 155 0>; /* gpio PT3 */
-		power-gpios = <&gpio 31 0>; /* gpio PD7 */
+		cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
+		wp-gpios = <&gpio TEGRA_GPIO(T, 3) GPIO_ACTIVE_HIGH>;
+		power-gpios = <&gpio TEGRA_GPIO(D, 7) GPIO_ACTIVE_HIGH>;
 		bus-width = <4>;
 	};
 
@@ -364,7 +364,7 @@
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			enable-active-high;
-			gpio = <&gpio 220 0>; /* gpio PBB4 */
+			gpio = <&gpio TEGRA_GPIO(BB, 4) GPIO_ACTIVE_HIGH>;
 			vin-supply = <&vio_reg>;
 		};
 
@@ -377,7 +377,7 @@
 			regulator-boot-on;
 			regulator-always-on;
 			enable-active-high;
-			gpio = <&pmic 0 0>; /* PMIC TPS65911 GPIO0 */
+			gpio = <&pmic 0 GPIO_ACTIVE_HIGH>;
 		};
 
 		emmc_3v3_reg: regulator at 3 {
@@ -389,7 +389,7 @@
 			regulator-always-on;
 			regulator-boot-on;
 			enable-active-high;
-			gpio = <&gpio 25 0>; /* gpio PD1 */
+			gpio = <&gpio TEGRA_GPIO(D, 1) GPIO_ACTIVE_HIGH>;
 			vin-supply = <&sys_3v3_reg>;
 		};
 
@@ -400,7 +400,7 @@
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
 			enable-active-high;
-			gpio = <&gpio 30 0>; /* gpio PD6 */
+			gpio = <&gpio TEGRA_GPIO(D, 6) GPIO_ACTIVE_HIGH>;
 		};
 
 		pex_hvdd_3v3_reg: regulator at 5 {
@@ -410,7 +410,7 @@
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
 			enable-active-high;
-			gpio = <&gpio 95 0>; /* gpio PL7 */
+			gpio = <&gpio TEGRA_GPIO(L, 7) GPIO_ACTIVE_HIGH>;
 			vin-supply = <&sys_3v3_reg>;
 		};
 
@@ -421,7 +421,7 @@
 			regulator-min-microvolt = <2800000>;
 			regulator-max-microvolt = <2800000>;
 			enable-active-high;
-			gpio = <&gpio 142 0>; /* gpio PR6 */
+			gpio = <&gpio TEGRA_GPIO(R, 6) GPIO_ACTIVE_HIGH>;
 			vin-supply = <&sys_3v3_reg>;
 		};
 
@@ -432,7 +432,7 @@
 			regulator-min-microvolt = <2800000>;
 			regulator-max-microvolt = <2800000>;
 			enable-active-high;
-			gpio = <&gpio 143 0>; /* gpio PR7 */
+			gpio = <&gpio TEGRA_GPIO(R, 7) GPIO_ACTIVE_HIGH>;
 			vin-supply = <&sys_3v3_reg>;
 		};
 
@@ -443,7 +443,7 @@
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
 			enable-active-high;
-			gpio = <&gpio 144 0>; /* gpio PS0 */
+			gpio = <&gpio TEGRA_GPIO(S, 0) GPIO_ACTIVE_HIGH>;
 			vin-supply = <&sys_3v3_reg>;
 		};
 
@@ -456,7 +456,7 @@
 			regulator-always-on;
 			regulator-boot-on;
 			enable-active-high;
-			gpio = <&gpio 24 0>; /* gpio PD0 */
+			gpio = <&gpio TEGRA_GPIO(D, 0) GPIO_ACTIVE_HIGH>;
 			vin-supply = <&sys_3v3_reg>;
 		};
 
@@ -467,7 +467,7 @@
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
 			enable-active-high;
-			gpio = <&gpio 94 0>; /* gpio PL6 */
+			gpio = <&gpio TEGRA_GPIO(L, 6) GPIO_ACTIVE_HIGH>;
 			vin-supply = <&sys_3v3_reg>;
 		};
 
@@ -480,7 +480,7 @@
 			regulator-always-on;
 			regulator-boot-on;
 			enable-active-high;
-			gpio = <&gpio 92 0>; /* gpio PL4 */
+			gpio = <&gpio TEGRA_GPIO(L, 4) GPIO_ACTIVE_HIGH>;
 			vin-supply = <&sys_3v3_reg>;
 		};
 
@@ -491,7 +491,7 @@
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
 			enable-active-high;
-			gpio = <&gpio 152 0>; /* GPIO PT0 */
+			gpio = <&gpio TEGRA_GPIO(T, 0) GPIO_ACTIVE_HIGH>;
 			gpio-open-drain;
 			vin-supply = <&vdd_5v0_reg>;
 		};
@@ -515,8 +515,9 @@
 		nvidia,i2s-controller = <&tegra_i2s1>;
 		nvidia,audio-codec = <&wm8903>;
 
-		nvidia,spkr-en-gpios = <&wm8903 2 0>;
-		nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
+		nvidia,spkr-en-gpios = <&wm8903 2 GPIO_ACTIVE_HIGH>;
+		nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(W, 2)
+			GPIO_ACTIVE_HIGH>;
 
 		clocks = <&tegra_car 184>, <&tegra_car 185>, <&tegra_car 120>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 38967fd..1fe8c3a 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -1,3 +1,5 @@
+#include <dt-bindings/gpio/tegra-gpio.h>
+
 #include "skeleton.dtsi"
 
 / {
-- 
1.7.10.4
