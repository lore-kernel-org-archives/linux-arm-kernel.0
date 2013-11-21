From: arno@natisbad.org (Arnaud Ebalard)
Date: Fri, 22 Nov 2013 00:00:12 +0100
Subject: [PATCHv2] ARM: mvebu: Add RN104 SATA LEDs driven via NXP PCA9554 I2C
 to GPIO muxer
Message-ID: <87mwkx4ayr.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


NETGEAR ReadyNAS 104 has a NXP PCA9554 I2C to GPIO chip. Among the 8 GPIO
lines the chip makes available, four are used on the device to control
the SATA LEDs (the four remaining ones are used for SATA disk presence).
This patch adds DT entries for NXP PCA9554 and the four SATA GPIO LEDs.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
Hi Jason,

For some reason, I have forgotten this one in my drafts folder and
noticed that just now. It goes on top of 45e8815f (ARM: mvebu: Add
Netgear ReadyNAS 104 board) which is now sitting in Linus tree.

If you wonder why NETGEAR was short on GPIO lines from the Armada 370
SoC and had to add this, the answer is: the front Winstar WH1602 LCD
consumes 7 lines.

Changes since v1:

 Following comments from Sebastian:
  - Changed values for macros for GPIO voltage level

Cheers,

a+

 arch/arm/boot/dts/armada-370-netgear-rn104.dts | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index b0b32f5..e65c24c 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -12,6 +12,7 @@
 /dts-v1/;
 
 #include "armada-370.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "NETGEAR ReadyNAS 104";
@@ -123,6 +124,13 @@
 					fan_startv = <1>;
 					pwm_polarity = <0>;
 				};
+
+				pca9554: pca9554 at 23 {
+					compatible = "nxp,pca9554";
+					gpio-controller;
+					#gpio-cells = <2>;
+					reg = <0x23>;
+				};
 			};
 		};
 	};
@@ -154,6 +162,30 @@
 			gpios = <&gpio2 0 1>;    /* GPIO 64 Active Low */
 			linux,default-trigger = "keep";
 		};
+
+		sata1_led {
+			label = "rn104:blue:sata1";
+			gpios = <&pca9554 0 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		sata2_led {
+			label = "rn104:blue:sata2";
+			gpios = <&pca9554 1 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		sata3_led {
+			label = "rn104:blue:sata3";
+			gpios = <&pca9554 2 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		sata4_led {
+			label = "rn104:blue:sata4";
+			gpios = <&pca9554 3 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
 	};
 
 	gpio_keys {
-- 
1.8.4.rc3
