From: eric@anholt.net (Eric Anholt)
Date: Tue, 18 Aug 2015 14:54:08 -0700
Subject: [PATCH v2 7/7] ARM: bcm2835: Add VC4 to the device tree.
In-Reply-To: <1439934848-7196-1-git-send-email-eric@anholt.net>
References: <1439934848-7196-1-git-send-email-eric@anholt.net>
Message-ID: <1439934848-7196-8-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VC4 is the GPU (display and 3D) present on the 2835.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

v2: Sort by register address, mark HDMI as disabled by default in the
    SoC file and enable it from -rpi.

 arch/arm/boot/dts/bcm2835-rpi.dtsi |  4 ++++
 arch/arm/boot/dts/bcm2835.dtsi     | 44 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 29cc7ba..f7217906 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -49,6 +49,10 @@
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+};
+
 &sdhci {
 	status = "okay";
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 20574cc..e625a21 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -1,4 +1,5 @@
 #include <dt-bindings/pinctrl/bcm2835.h>
+#include <dt-bindings/gpio/gpio.h>
 #include "skeleton.dtsi"
 
 / {
@@ -131,6 +132,18 @@
 			status = "disabled";
 		};
 
+		pv0: brcm,vc4-pixelvalve at 7e206000 {
+			compatible = "brcm,vc4-pixelvalve";
+			reg = <0x7e206000 0x100>;
+			interrupts = <2 13>; /* pwa2 */
+		};
+
+		pv1: brcm,vc4-pixelvalve at 7e207000 {
+			compatible = "brcm,vc4-pixelvalve";
+			reg = <0x7e207000 0x100>;
+			interrupts = <2 14>; /* pwa1 */
+		};
+
 		sdhci: sdhci at 7e300000 {
 			compatible = "brcm,bcm2835-sdhci";
 			reg = <0x7e300000 0x100>;
@@ -139,6 +152,12 @@
 			status = "disabled";
 		};
 
+		hvs: brcm,hvs at 7e400000 {
+			compatible = "brcm,vc4-hvs";
+			reg = <0x7e400000 0x6000>;
+			interrupts = <2 1>;
+		};
+
 		i2c1: i2c at 7e804000 {
 			compatible = "brcm,bcm2835-i2c";
 			reg = <0x7e804000 0x1000>;
@@ -159,6 +178,23 @@
 			status = "disabled";
 		};
 
+		pv2: brcm,vc4-pixelvalve at 7e807000 {
+			compatible = "brcm,vc4-pixelvalve";
+			reg = <0x7e807000 0x100>;
+			interrupts = <2 10>; /* pixelvalve */
+		};
+
+		hdmi: brcm,vc4-hdmi at 7e902000 {
+			compatible = "brcm,vc4-hdmi";
+			reg = <0x7e902000 0x600>,
+			      <0x7e808000 0x100>;
+			interrupts = <2 8>, <2 9>;
+			ddc = <&i2c2>;
+			hpd-gpio = <&gpio 46 GPIO_ACTIVE_HIGH>;
+			crtc = <&pv2>;
+			status = "disabled";
+		};
+
 		usb at 7e980000 {
 			compatible = "brcm,bcm2835-usb";
 			reg = <0x7e980000 0x10000>;
@@ -168,6 +204,14 @@
 		arm-pmu {
 			compatible = "arm,arm1176-pmu";
 		};
+
+		vc4: vc4 at 0x7e4c0000 {
+			compatible = "brcm,vc4";
+
+			crtcs = <&pv0>, <&pv1>, <&pv2>;
+			encoders = <&hdmi>;
+			hvss = <&hvs>;
+		};
 	};
 
 	clocks {
-- 
2.1.4
