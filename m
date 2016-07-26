From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 26 Jul 2016 18:53:33 +0000
Subject: [PATCH V2 RFC 6/6] ARM: dts: bcm2835: Add Raspberry Pi Zero
In-Reply-To: <1469559213-16160-1-git-send-email-stefan.wahren@i2se.com>
References: <1469559213-16160-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1469559213-16160-7-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Raspberry Pi Zero is a minified version of model A+. It's
notable there is no PWR LED and the ACT LED is inverted.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/Makefile             |    3 +-
 arch/arm/boot/dts/bcm2835-rpi-zero.dts |   57 ++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-zero.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e38e7c9..cafa3b1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -69,7 +69,8 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
 	bcm2835-rpi-b-rev2.dtb \
 	bcm2835-rpi-b-plus.dtb \
 	bcm2835-rpi-a-plus.dtb \
-	bcm2836-rpi-2-b.dtb
+	bcm2836-rpi-2-b.dtb \
+	bcm2835-rpi-zero.dtb
 dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm4708-asus-rt-ac56u.dtb \
 	bcm4708-asus-rt-ac68u.dtb \
diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero.dts b/arch/arm/boot/dts/bcm2835-rpi-zero.dts
new file mode 100644
index 0000000..12bc82d
--- /dev/null
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero.dts
@@ -0,0 +1,57 @@
+/dts-v1/;
+#include "bcm2835.dtsi"
+#include "bcm2835-rpi.dtsi"
+
+/ {
+	compatible = "raspberrypi,model-zero", "brcm,bcm2835";
+	model = "Raspberry Pi Zero";
+
+	leds {
+		act {
+			gpios = <&gpio 47 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+
+&usb {
+	dr_mode = "host";
+	h-rx-fifo-size = <774>;
+	h-np-tx-fifo-size = <256>;
+	h-tx-fifo-size = <512>;
+/*
+ * Settings for otg
+ *
+	dr_mode = "otg";
+	h-rx-fifo-size = <774>;
+	h-np-tx-fifo-size = <32>;
+	h-tx-fifo-size = <0>;
+	g-np-tx-fifo-size = <16>;
+	g-rx-fifo-size = <256>;
+	g-tx-fifo-size = <256 128 128 64 64 64 32>;
+ *
+ * Settings for peripheral
+ *
+	dr_mode = "peripheral";
+	h-rx-fifo-size = <774>;
+	h-np-tx-fifo-size = <0>;
+	h-tx-fifo-size = <0>;
+	g-np-tx-fifo-size = <16>;
+	g-rx-fifo-size = <256>;
+	g-tx-fifo-size = <256 128 128 64 64 64 32>;
+ */
+};
+
+&gpio {
+	pinctrl-0 = <&gpioout &alt0 &i2s_alt0 &alt3>;
+
+	/* I2S interface */
+	i2s_alt0: i2s_alt0 {
+		brcm,pins = <18 19 20 21>;
+		brcm,function = <BCM2835_FSEL_ALT0>;
+	};
+};
+
+&hdmi {
+	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
+};
-- 
1.7.9.5
