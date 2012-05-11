From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 May 2012 14:42:47 +0800
Subject: [PATCH 4/5] ARM: dts: imx51-babbage: enable audio support
In-Reply-To: <1336718568-26810-1-git-send-email-shawn.guo@linaro.org>
References: <1336718568-26810-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1336718568-26810-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx51-babbage.dts |   28 +++++++++++++++++++++++++++-
 arch/arm/boot/dts/imx51.dtsi        |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index d42a404..de065b5 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -162,6 +162,11 @@
 						};
 					};
 				};
+
+				ssi2: ssi at 70014000 {
+					fsl,mode = "i2s-slave";
+					status = "okay";
+				};
 			};
 
 			wdog at 73f98000 { /* WDOG1 */
@@ -191,12 +196,19 @@
 			i2c at 83fc4000 { /* I2C2 */
 				status = "okay";
 
-				codec: sgtl5000 at 0a {
+				sgtl5000: codec at 0a {
 					compatible = "fsl,sgtl5000";
 					reg = <0x0a>;
+					clock-frequency = <26000000>;
+					VDDA-supply = <&vdig_reg>;
+					VDDIO-supply = <&vvideo_reg>;
 				};
 			};
 
+			audmux at 83fd0000 {
+				status = "okay";
+			};
+
 			ethernet at 83fec000 {
 				phy-mode = "mii";
 				status = "okay";
@@ -214,4 +226,18 @@
 			gpio-key,wakeup;
 		};
 	};
+
+	sound {
+		compatible = "fsl,imx51-babbage-sgtl5000",
+			     "fsl,imx-audio-sgtl5000";
+		model = "imx51-babbage-sgtl5000";
+		ssi-controller = <&ssi2>;
+		audio-codec = <&sgtl5000>;
+		audio-routing =
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"Headphone Jack", "HP_OUT";
+		mux-int-port = <2>;
+		mux-ext-port = <3>;
+	};
 };
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 66f0ebd..bfa65ab 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -102,6 +102,15 @@
 					status = "disabled";
 				};
 
+				ssi2: ssi at 70014000 {
+					compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
+					reg = <0x70014000 0x4000>;
+					interrupts = <30>;
+					fsl,fifo-depth = <15>;
+					fsl,ssi-dma-events = <25 24 23 22>; /* TX0 RX0 TX1 RX1 */
+					status = "disabled";
+				};
+
 				esdhc at 70020000 { /* ESDHC3 */
 					compatible = "fsl,imx51-esdhc";
 					reg = <0x70020000 0x4000>;
@@ -235,6 +244,30 @@
 				status = "disabled";
 			};
 
+			ssi1: ssi at 83fcc000 {
+				compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
+				reg = <0x83fcc000 0x4000>;
+				interrupts = <29>;
+				fsl,fifo-depth = <15>;
+				fsl,ssi-dma-events = <29 28 27 26>; /* TX0 RX0 TX1 RX1 */
+				status = "disabled";
+			};
+
+			audmux at 83fd0000 {
+				compatible = "fsl,imx51-audmux", "fsl,imx31-audmux";
+				reg = <0x83fd0000 0x4000>;
+				status = "disabled";
+			};
+
+			ssi3: ssi at 83fe8000 {
+				compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
+				reg = <0x83fe8000 0x4000>;
+				interrupts = <96>;
+				fsl,fifo-depth = <15>;
+				fsl,ssi-dma-events = <47 46 37 35>; /* TX0 RX0 TX1 RX1 */
+				status = "disabled";
+			};
+
 			ethernet at 83fec000 {
 				compatible = "fsl,imx51-fec", "fsl,imx27-fec";
 				reg = <0x83fec000 0x4000>;
-- 
1.7.5.4
