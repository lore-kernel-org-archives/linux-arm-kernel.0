From: eric@anholt.net (Eric Anholt)
Date: Wed, 12 Aug 2015 17:56:20 -0700
Subject: [PATCH 7/7] ARM: bcm2835: Add VC4 to the device tree.
In-Reply-To: <1439427380-2436-1-git-send-email-eric@anholt.net>
References: <1439427380-2436-1-git-send-email-eric@anholt.net>
Message-ID: <1439427380-2436-8-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2835.dtsi | 43 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 8f3ba88..dda67aa 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -1,4 +1,5 @@
 #include <dt-bindings/pinctrl/bcm2835.h>
+#include <dt-bindings/gpio/gpio.h>
 #include "skeleton.dtsi"
 
 / {
@@ -167,6 +168,48 @@
 		arm-pmu {
 			compatible = "arm,arm1176-pmu";
 		};
+
+		hdmi: brcm,vc4-hdmi at 7e902000 {
+			compatible = "brcm,vc4-hdmi";
+			reg = <0x7e902000 0x600>,
+			      <0x7e808000 0x100>;
+			interrupts = <2 8>, <2 9>;
+			ddc = <&i2c2>;
+			hpd-gpio = <&gpio 46 GPIO_ACTIVE_HIGH>;
+			crtc = <&pv2>;
+		};
+
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
+		pv2: brcm,vc4-pixelvalve at 7e807000 {
+			compatible = "brcm,vc4-pixelvalve";
+			reg = <0x7e807000 0x100>;
+			interrupts = <2 10>; /* pixelvalve */
+		};
+
+		hvs: brcm,hvs at 7e400000 {
+			compatible = "brcm,vc4-hvs";
+			reg = <0x7e400000 0x6000>;
+			interrupts = <2 1>;
+		};
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
