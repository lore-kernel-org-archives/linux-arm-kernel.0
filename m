From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 09 Nov 2013 22:07:43 +0100
Subject: [PATCH] ARM: mvebu: Add RN104 SATA LEDs driven via NXP PCA9554 I2C to
 GPIO muxer
Message-ID: <877gchmggw.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


NETGEAR ReadyNAS 104 has a NXP PCA9554 I2C to GPIO chip. Among the 8 GPIO
lines the chip makes available, four are used on the device to control
the SATA LEDs (the four remaining ones are used for SATA disk presence).
This patch adds DT entries for NXP PCA9554 and the four SATA GPIO LEDs.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
Hi Jason,

This one depends on the patch (ARM: mvebu: Add Netgear ReadyNAS 104
board) which you pushed to Olof for inclusion in v3.13.

If you wonder why NETGEAR was short on GPIO lines from the Armada 370
SoC and had to add this, the answer is: the front Winstar WH1602 LCD
consumes 7 lines.

Cheers,

a+

 arch/arm/boot/dts/armada-370-netgear-rn104.dts | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index b0b32f5..1efc871 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -123,6 +123,13 @@
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
@@ -154,6 +161,30 @@
 			gpios = <&gpio2 0 1>;    /* GPIO 64 Active Low */
 			linux,default-trigger = "keep";
 		};
+
+		sata1_led {
+			label = "rn104:blue:sata1";
+			gpios = <&pca9554 0 1>;  /* Active Low */
+			default-state = "off";
+		};
+
+		sata2_led {
+			label = "rn104:blue:sata2";
+			gpios = <&pca9554 1 1>;  /* Active Low */
+			default-state = "off";
+		};
+
+		sata3_led {
+			label = "rn104:blue:sata3";
+			gpios = <&pca9554 2 1>;  /* Active Low */
+			default-state = "off";
+		};
+
+		sata4_led {
+			label = "rn104:blue:sata4";
+			gpios = <&pca9554 3 1>;  /* Active Low */
+			default-state = "off";
+		};
 	};
 
 	gpio_keys {
-- 
1.8.4.rc3
