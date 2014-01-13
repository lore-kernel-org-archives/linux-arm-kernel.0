From: florian.meier@koalo.de (Florian Meier)
Date: Mon, 13 Jan 2014 12:13:50 +0100
Subject: [PATCH 2/2] BCM2835: Add I2S driver to device tree
Message-ID: <52D3CA6E.1010803@koalo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the definitions for the BCM2835 I2S driver
to the device tree. Some GPIO settings are needed for
the correct pin functions.

Signed-off-by: Florian Meier <florian.meier@koalo.de>
---
 arch/arm/boot/dts/bcm2835-rpi-b.dts | 12 +++++++++++-
 arch/arm/boot/dts/bcm2835.dtsi      | 10 ++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts
b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index 2a3b1c1..e83ed2f 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -23,7 +23,7 @@

 &gpio {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gpioout &alt0 &alt3>;
+	pinctrl-0 = <&gpioout &alt0 &alt2 &alt3>;

 	gpioout: gpioout {
 		brcm,pins = <6>;
@@ -39,6 +39,16 @@
 		brcm,pins = <48 49 50 51 52 53>;
 		brcm,function = <7>; /* alt3 */
 	};
+
+	/* I2S interface */
+	alt2: alt2 {
+		brcm,pins = <28 29 30 31>;
+		brcm,function = <6>; /* alt2 */
+	};
+};
+
+&bcm2835_i2s {
+	status = "okay";
 };

 &i2c0 {
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 1da6b36..ca2259c 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -134,6 +134,16 @@
 			#dma-cells = <1>;
 			brcm,dma-channel-mask = <0x7f35>;
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
1.8.3.2
