From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 17 Sep 2014 06:39:35 +0100
Subject: [PATCH] ARM: DT: apq8064: add support to sdcc4 for wlan.
Message-ID: <1410932375-4858-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds sdcc4 node to enable wlan support on IFC6410

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts |  4 ++++
 arch/arm/boot/dts/qcom-apq8064.dtsi        | 38 ++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index 3287f12..a69a059 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -28,6 +28,10 @@
 			sdcc3: sdcc at 12180000 {
 				status = "okay";
 			};
+			/* WLAN */
+			sdcc4: sdcc at 121c0000 {
+				status = "okay";
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index b1e476a..f31d20b 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -85,6 +85,13 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&ps_hold>;
 
+			sdc4_gpios: sdc4-gpios {
+				pios {
+					pins = "gpio63", "gpio64", "gpio65", "gpio66", "gpio67", "gpio68";
+					function = "sdc4";
+				};
+			};
+
 			ps_hold: ps_hold {
 				mux {
 					pins = "gpio78";
@@ -226,6 +233,16 @@
 			qcom,ee = <0>;
 		};
 
+		sdcc4bam:dma at 121c2000{
+			compatible = "qcom,bam-v1.3.0";
+			reg = <0x121c2000 0x8000>;
+			interrupts = <0 95 0>;
+			clocks = <&gcc SDC4_H_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+		};
+
 		amba {
 			compatible = "arm,amba-bus";
 			#address-cells = <1>;
@@ -268,6 +285,27 @@
 				dmas = <&sdcc3bam 2>, <&sdcc3bam 1>;
 				dma-names = "tx", "rx";
 			};
+
+			sdcc4: sdcc at 121c0000 {
+				compatible	= "arm,pl18x", "arm,primecell";
+				arm,primecell-periphid = <0x00051180>;
+				status		= "disabled";
+				reg		= <0x121c0000 0x2000>;
+				interrupts	= <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names	= "cmd_irq";
+				clocks		= <&gcc SDC4_CLK>, <&gcc SDC4_H_CLK>;
+				clock-names	= "mclk", "apb_pclk";
+				bus-width	= <4>;
+				cap-sd-highspeed;
+				cap-mmc-highspeed;
+				max-frequency	= <48000000>;
+				vmmc-supply = <&vsdcc_fixed>;
+				vqmmc-supply = <&vsdcc_fixed>;
+				dmas = <&sdcc4bam 2>, <&sdcc4bam 1>;
+				dma-names = "tx", "rx";
+				pinctrl-names = "default";
+				pinctrl-0 = <&sdc4_gpios>;
+			};
 		};
 	};
 };
-- 
1.9.1
