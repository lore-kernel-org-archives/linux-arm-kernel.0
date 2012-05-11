From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 May 2012 14:42:48 +0800
Subject: [PATCH 5/5] ARM: dts: imx53-qsb: enable audio support
In-Reply-To: <1336718568-26810-1-git-send-email-shawn.guo@linaro.org>
References: <1336718568-26810-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1336718568-26810-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx53-qsb.dts |   39 ++++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/imx53.dtsi    |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index 393e90d..2d803a9 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -29,6 +29,11 @@
 					status = "okay";
 				};
 
+				ssi2: ssi at 50014000 {
+					fsl,mode = "i2s-slave";
+					status = "okay";
+				};
+
 				esdhc at 50020000 { /* ESDHC3 */
 					cd-gpios = <&gpio3 11 0>;
 					wp-gpios = <&gpio3 12 0>;
@@ -58,9 +63,11 @@
 			i2c at 63fc4000 { /* I2C2 */
 				status = "okay";
 
-				codec: sgtl5000 at 0a {
+				sgtl5000: codec at 0a {
 					compatible = "fsl,sgtl5000";
 					reg = <0x0a>;
+					VDDA-supply = <&reg_3p2v>;
+					VDDIO-supply = <&reg_3p2v>;
 				};
 			};
 
@@ -150,6 +157,10 @@
 				};
 			};
 
+			audmux at 63fd0000 {
+				status = "okay";
+			};
+
 			ethernet at 63fec000 {
 				phy-mode = "rmii";
 				phy-reset-gpios = <&gpio7 6 0>;
@@ -190,4 +201,30 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		reg_3p2v: 3p2v {
+			compatible = "regulator-fixed";
+			regulator-name = "3P2V";
+			regulator-min-microvolt = <3200000>;
+			regulator-max-microvolt = <3200000>;
+			regulator-always-on;
+		};
+	};
+
+	sound {
+		compatible = "fsl,imx53-qsb-sgtl5000",
+			     "fsl,imx-audio-sgtl5000";
+		model = "imx53-qsb-sgtl5000";
+		ssi-controller = <&ssi2>;
+		audio-codec = <&sgtl5000>;
+		audio-routing =
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"Headphone Jack", "HP_OUT";
+		mux-int-port = <2>;
+		mux-ext-port = <5>;
+	};
 };
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 5188615..e3e8694 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -104,6 +104,15 @@
 					status = "disabled";
 				};
 
+				ssi2: ssi at 50014000 {
+					compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
+					reg = <0x50014000 0x4000>;
+					interrupts = <30>;
+					fsl,fifo-depth = <15>;
+					fsl,ssi-dma-events = <25 24 23 22>; /* TX0 RX0 TX1 RX1 */
+					status = "disabled";
+				};
+
 				esdhc at 50020000 { /* ESDHC3 */
 					compatible = "fsl,imx53-esdhc";
 					reg = <0x50020000 0x4000>;
@@ -290,6 +299,30 @@
 				status = "disabled";
 			};
 
+			ssi1: ssi at 63fcc000 {
+				compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
+				reg = <0x63fcc000 0x4000>;
+				interrupts = <29>;
+				fsl,fifo-depth = <15>;
+				fsl,ssi-dma-events = <29 28 27 26>; /* TX0 RX0 TX1 RX1 */
+				status = "disabled";
+			};
+
+			audmux at 63fd0000 {
+				compatible = "fsl,imx53-audmux", "fsl,imx31-audmux";
+				reg = <0x63fd0000 0x4000>;
+				status = "disabled";
+			};
+
+			ssi3: ssi at 63fe8000 {
+				compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
+				reg = <0x63fe8000 0x4000>;
+				interrupts = <96>;
+				fsl,fifo-depth = <15>;
+				fsl,ssi-dma-events = <47 46 45 44>; /* TX0 RX0 TX1 RX1 */
+				status = "disabled";
+			};
+
 			ethernet at 63fec000 {
 				compatible = "fsl,imx53-fec", "fsl,imx25-fec";
 				reg = <0x63fec000 0x4000>;
-- 
1.7.5.4
