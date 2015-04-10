From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Fri, 10 Apr 2015 23:36:03 +0200
Subject: [PATCH 8/9] ARM: tegra: colibri t30: activate stmpe811 touch
 controller
In-Reply-To: <cover.1428700856.git.marcel.ziswiler@toradex.com>
References: <cover.1428700856.git.marcel.ziswiler@toradex.com>
Message-ID: <d87e59343cc07b99f85fc6dcb6cc8fe941770f30.1428700856.git.marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Activate STMPE811 touch controller as found on Colibri T30 modules.
While at it change order of HDMI sub nodes as well to be more in line
with Apalis T30.
While at it also update comment about supported module hardware
versions.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

coli
---
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts |  4 +--
 arch/arm/boot/dts/tegra30-colibri.dtsi        | 44 +++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 4d3ddc5..d42c400 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -55,7 +55,7 @@
 
 		/* M41T0M6 real time clock on carrier board */
 		rtc at 68 {
-			compatible = "stm,m41t00";
+			compatible = "st,m41t00";
 			reg = <0x68>;
 		};
 	};
@@ -84,7 +84,7 @@
 		};
 	};
 
-	sdhci at 78000200 {
+	sdmmc: sdhci at 78000200 {
 		status = "okay";
 		bus-width = <4>;
 		cd-gpios = <&gpio TEGRA_GPIO(C, 7) GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index c4ed1be..5f7f4a0 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -3,7 +3,7 @@
 
 /*
  * Toradex Colibri T30 Device Tree
- * Compatible for Revisions 1.1B/1.1C/1.1D
+ * Compatible for Revisions V1.1B, V1.1C, V1.1D, V1.1E; IT: V1.1A
  */
 / {
 	model = "Toradex Colibri T30";
@@ -18,9 +18,9 @@
 			vdd-supply = <&sys_3v3_reg>;
 			pll-supply = <&vio_reg>;
 
+			nvidia,ddc-i2c-bus = <&hdmiddc>;
 			nvidia,hpd-gpio =
 				<&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
-			nvidia,ddc-i2c-bus = <&hdmiddc>;
 		};
 	};
 
@@ -295,6 +295,46 @@
 			};
 		};
 
+		/* STMPE811 touch screen controller */
+		stmpe811 at 41 {
+			compatible = "st,stmpe811";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x41>;
+			interrupts = <TEGRA_GPIO(V, 0) IRQ_TYPE_LEVEL_LOW>;
+			interrupt-parent = <&gpio>;
+			interrupt-controller;
+			id = <0>;
+			blocks = <0x5>;
+			irq-trigger = <0x1>;
+
+			stmpe_touchscreen {
+				compatible = "st,stmpe-ts";
+				reg = <0>;
+				/* 3.25 MHz ADC clock speed */
+				st,adc-freq = <1>;
+				/* 8 sample average control */
+				st,ave-ctrl = <3>;
+				/* 7 length fractional part in z */
+				st,fraction-z = <7>;
+				/*
+				 * 50 mA typical 80 mA max touchscreen drivers
+				 * current limit value
+				 */
+				st,i-drive = <1>;
+				/* 12-bit ADC */
+				st,mod-12b = <1>;
+				/* internal ADC reference */
+				st,ref-sel = <0>;
+				/* ADC converstion time: 80 clocks */
+				st,sample-time = <4>;
+				/* 1 ms panel driver settling time */
+				st,settling = <3>;
+				/* 5 ms touch detect interrupt delay */
+				st,touch-det-delay = <5>;
+			};
+		};
+
 		/*
 		 * LM95245 temperature sensor
 		 * Note: OVERT_N directly connected to PMIC PWRDN
-- 
1.9.3
