From: eric@anholt.net (Eric Anholt)
Date: Fri,  9 Oct 2015 14:27:48 -0700
Subject: [PATCH v3 7/7] ARM: bcm2835: Add VC4 to the device tree.
In-Reply-To: <1444426068-15817-1-git-send-email-eric@anholt.net>
References: <1444426068-15817-1-git-send-email-eric@anholt.net>
Message-ID: <1444426068-15817-8-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VC4 is the GPU (display and 3D) present on the 2835.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

v2: Sort by register address, mark HDMI as disabled by default in the
    SoC file and enable it from -rpi.

v3: Add references to the pixel/HSM clocks for HDMI.  Rename
    compatibility strings and clean up node names.

 arch/arm/boot/dts/bcm2835-rpi.dtsi |  4 ++++
 arch/arm/boot/dts/bcm2835.dtsi     | 42 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 3572f03..dcaaee2 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -56,6 +56,10 @@
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
index 1e61eb7..21e354a9 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -1,4 +1,5 @@
 #include <dt-bindings/pinctrl/bcm2835.h>
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/bcm2835.h>
 #include "skeleton.dtsi"
 
@@ -149,6 +150,18 @@
 			status = "disabled";
 		};
 
+		pixelvalve at 7e206000 {
+			compatible = "brcm,bcm2835-pixelvalve0";
+			reg = <0x7e206000 0x100>;
+			interrupts = <2 13>; /* pwa2 */
+		};
+
+		pixelvalve at 7e207000 {
+			compatible = "brcm,bcm2835-pixelvalve1";
+			reg = <0x7e207000 0x100>;
+			interrupts = <2 14>; /* pwa1 */
+		};
+
 		sdhci: sdhci at 7e300000 {
 			compatible = "brcm,bcm2835-sdhci";
 			reg = <0x7e300000 0x100>;
@@ -157,6 +170,12 @@
 			status = "disabled";
 		};
 
+		hvs at 7e400000 {
+			compatible = "brcm,bcm2835-hvs";
+			reg = <0x7e400000 0x6000>;
+			interrupts = <2 1>;
+		};
+
 		i2c1: i2c at 7e804000 {
 			compatible = "brcm,bcm2835-i2c";
 			reg = <0x7e804000 0x1000>;
@@ -177,6 +196,25 @@
 			status = "disabled";
 		};
 
+		pixelvalve at 7e807000 {
+			compatible = "brcm,bcm2835-pixelvalve2";
+			reg = <0x7e807000 0x100>;
+			interrupts = <2 10>; /* pixelvalve */
+		};
+
+		hdmi: hdmi at 7e902000 {
+			compatible = "brcm,bcm2835-hdmi";
+			reg = <0x7e902000 0x600>,
+			      <0x7e808000 0x100>;
+			interrupts = <2 8>, <2 9>;
+			ddc = <&i2c2>;
+			hpd-gpio = <&gpio 46 GPIO_ACTIVE_HIGH>;
+			clocks = <&clocks BCM2835_PLLH_PIX>,
+				 <&clocks BCM2835_CLOCK_HSM>;
+			clock-names = "pixel", "hdmi";
+			status = "disabled";
+		};
+
 		usb at 7e980000 {
 			compatible = "brcm,bcm2835-usb";
 			reg = <0x7e980000 0x10000>;
@@ -186,6 +224,10 @@
 		arm-pmu {
 			compatible = "arm,arm1176-pmu";
 		};
+
+		vc4: gpu at 7e4c0000 {
+			compatible = "brcm,bcm2835-vc4";
+		};
 	};
 
 	clocks {
-- 
2.1.4
