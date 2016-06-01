From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  1 Jun 2016 23:43:38 +0200
Subject: [PATCH 29/32] ARM: bcm2835: Use i2c-gpio for the expander, instead.
In-Reply-To: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
Message-ID: <1464817421-8519-30-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Anholt <eric@anholt.net>

I'm seeing a ton of CLKT errors from i2c-bcm2835.c, and haven't
figured out a cause.

Signed-off-by: Eric Anholt <eric@anholt.net>

Conflicts:
	arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
---
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts | 32 ++++++++++++------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
index 4bc191e..202e8c3 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
@@ -23,6 +23,22 @@
 			linux,default-trigger = "default-on";
 		};
 	};
+
+	i2c_gpio {
+		compatible = "i2c-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpios = <&gpio 44 0
+			 &gpio 45 0>;
+
+		gpio_expander: gpio at 43 {
+			gpio-controller;
+			#gpio-cells = <2>;
+			reg = <0x43>;
+			compatible = "fcs,fxl6408";
+		};
+	};
 };
 
 &i2s {
@@ -39,19 +55,3 @@
 &hdmi {
 	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
 };
-
-/* Connect the GPIO expander to I2C1 */
-&i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_gpio44>;
-
-	gpio_expander: gpio at 43 {
-		gpio-controller;
-		#gpio-cells = <2>;
-		reg = <0x43>;
-		compatible = "fcs,fxl6408";
-	};
-};
-
-bt {
-};
-- 
1.8.3.1
