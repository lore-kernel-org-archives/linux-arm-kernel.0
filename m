From: broonie@kernel.org (Mark Brown)
Date: Wed,  9 Jul 2014 10:50:25 +0200
Subject: [PATCH] BCM2835: Add I2S driver to device tree
Message-ID: <1404895825-25668-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

[Tweaked slightly to disable by default -- broonie]

Signed-off-by: Florian Meier <florian.meier@koalo.de>
Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/arm/boot/dts/bcm2835-rpi-b.dts |  8 +++++++-
 arch/arm/boot/dts/bcm2835.dtsi      | 11 +++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index 2a3b1c1..58a0d60 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -23,7 +23,7 @@
 
 &gpio {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gpioout &alt0 &alt3>;
+	pinctrl-0 = <&gpioout &alt0 &alt2 &alt3>;
 
 	gpioout: gpioout {
 		brcm,pins = <6>;
@@ -39,6 +39,12 @@
 		brcm,pins = <48 49 50 51 52 53>;
 		brcm,function = <7>; /* alt3 */
 	};
+
+	/* I2S interface */
+	alt2: alt2 {
+		brcm,pins = <28 29 30 31>;
+		brcm,function = <6>; /* alt2 */
+	};
 };
 
 &i2c0 {
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index b8473c4..a0aff1f 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -99,6 +99,7 @@
 			dmas = <&dma 2>,
 			       <&dma 3>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		spi: spi at 7e204000 {
@@ -148,6 +149,16 @@
 		arm-pmu {
 			compatible = "arm,arm1176-pmu";
 		};
+
+		bcm2835_i2s: i2s at 7e203000 {
+			compatible = "brcm,bcm2835-i2s";
+			reg = <0x7e203000 0x20>,
+			      <0x7e101098 0x02>;
+
+			dmas = <&dma 2>,
+			       <&dma 3>;
+			dma-names = "tx", "rx";
+		};
 	};
 
 	clocks {
-- 
2.0.0
