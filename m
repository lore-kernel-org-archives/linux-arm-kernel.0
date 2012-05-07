From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  7 May 2012 22:43:11 +0800
Subject: [PATCH 09/10] ARM: dts: enable mmc for imx23-evk
In-Reply-To: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
References: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1336401793-13753-10-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx23-evk.dts |   11 +++++++++++
 arch/arm/boot/dts/imx23.dtsi    |   19 +++++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index 8cad51e..a7408f6 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -21,6 +21,17 @@
 	};
 
 	apb at 80000000 {
+		apbh at 80000000 {
+			ssp0: ssp at 80010000 {
+				compatible = "fsl,imx23-mmc";
+				pinctrl-names = "default";
+				pinctrl-0 = <&mmc0_8bit_pins_a &mmc0_pins_fixup>;
+				fsl,bus-width = <8>;
+				wp-gpios = <&gpio1 30 0>;
+				status = "okay";
+			};
+		};
+
 		apbx at 80040000 {
 			duart: serial at 80070000 {
 				pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 36c6057..37069b6 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -69,6 +69,8 @@
 
 			ssp0: ssp at 80010000 {
 				reg = <0x80010000 2000>;
+				interrupts = <15 14>;
+				fsl,ssp-dma-channel = <1>;
 				status = "disabled";
 			};
 
@@ -117,6 +119,21 @@
 					fsl,voltage = <1>;
 					fsl,pull-up = <0>;
 				};
+
+				mmc0_8bit_pins_a: mmc0-8bit at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x2020 0x2030 0x2040
+						0x2050 0x0082 0x0092 0x00a2
+						0x00b2 0x2000 0x2010 0x2060>;
+					fsl,drive-strength = <1>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
+
+				mmc0_pins_fixup: mmc0-pins-fixup {
+					fsl,pinmux-ids = <0x2010 0x2060>;
+					fsl,pull-up = <0>;
+				};
 			};
 
 			digctl at 8001c000 {
@@ -161,6 +178,8 @@
 
 			ssp1: ssp at 80034000 {
 				reg = <0x80034000 2000>;
+				interrupts = <2 20>;
+				fsl,ssp-dma-channel = <2>;
 				status = "disabled";
 			};
 
-- 
1.7.5.4
