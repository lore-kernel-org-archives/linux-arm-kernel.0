From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  6 Jun 2016 18:36:33 +0200
Subject: [PATCH 4/8] arm64: tegra: Add DSI panel on Jetson TX1
In-Reply-To: <20160606163637.14234-1-thierry.reding@gmail.com>
References: <20160606163637.14234-1-thierry.reding@gmail.com>
Message-ID: <20160606163637.14234-4-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Some variants of the Jetson TX1 ship with a 8.0" WUXGA TFT LCD panel
connected via four DSI lanes.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 45 +++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     | 50 ++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
index 683b339a980c..983775e637a4 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
@@ -6,4 +6,49 @@
 / {
 	model = "NVIDIA Jetson TX1 Developer Kit";
 	compatible = "nvidia,p2371-2180", "nvidia,tegra210";
+
+	host1x at 50000000 {
+		dsi at 54300000 {
+			status = "okay";
+
+			avdd-dsi-csi-supply = <&vdd_dsi_csi>;
+
+			panel at 0 {
+				compatible = "auo,b080uan01";
+				reg = <0>;
+
+				enable-gpios = <&gpio TEGRA_GPIO(V, 2)
+						GPIO_ACTIVE_HIGH>;
+				power-supply = <&vdd_5v0_io>;
+				backlight = <&backlight>;
+			};
+		};
+	};
+
+	i2c at 7000c400 {
+		backlight: backlight at 2c {
+			compatible = "ti,lp8557";
+			reg = <0x2c>;
+
+			dev-ctrl = /bits/ 8 <0x80>;
+			init-brt = /bits/ 8 <0xff>;
+
+			pwm-period = <29334>;
+
+			pwms = <&pwm 0 29334>;
+			pwm-names = "lp8557";
+
+			/* 3 LED string */
+			rom_14h {
+				rom-addr = /bits/ 8 <0x14>;
+				rom-val = /bits/ 8 <0x87>;
+			};
+
+			/* boost frequency 1 MHz */
+			rom_13h {
+				rom-addr = /bits/ 8 <0x13>;
+				rom-val = /bits/ 8 <0x01>;
+			};
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
index b28aff5e104d..78a16a57fec7 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
@@ -1261,6 +1261,23 @@
 		};
 	};
 
+	pwm at 7000a000 {
+		status = "okay";
+	};
+
+	i2c at 7000c400 {
+		status = "okay";
+		clock-frequency = <100000>;
+
+		exp1: gpio at 74 {
+			compatible = "ti,tca9539";
+			reg = <0x74>;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+	};
+
 	/* MMC/SD */
 	sdhci at 700b0000 {
 		status = "okay";
@@ -1340,6 +1357,39 @@
 			regulator-enable-ramp-delay = <472>;
 			regulator-disable-ramp-delay = <4880>;
 		};
+
+		vdd_dsi_csi: regulator at 5 {
+			compatible = "regulator-fixed";
+			reg = <5>;
+			regulator-name = "AVDD_DSI_CSI_1V2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			vin-supply = <&vdd_sys_1v2>;
+		};
+
+		vdd_3v3_dis: regulator at 6 {
+			compatible = "regulator-fixed";
+			reg = <6>;
+			regulator-name = "VDD_DIS_3V3_LCD";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+			gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			vin-supply = <&vdd_3v3_sys>;
+		};
+
+		vdd_1v8_dis: regulator at 7 {
+			compatible = "regulator-fixed";
+			reg = <7>;
+			regulator-name = "VDD_LCD_1V8_DIS";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+			gpio = <&exp1 14 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			vin-supply = <&vdd_1v8>;
+		};
 	};
 
 	gpio-keys {
-- 
2.8.3
