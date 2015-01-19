From: riproute@gmail.com (Dan Haab)
Date: Mon, 19 Jan 2015 12:45:37 -0700
Subject: [PATCH] ARM: BCM5301X: Add DT for Luxul XWC-1000
Message-ID: <1421696737-11779-1-git-send-email-riproute@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dan Haab <dhaab@luxul.com>

Luxul XWC-1000 is a controller device based on BCM4708 SoC. The only
unusual thing in its DTS file is "ubi" partition on NAND flash.

Signed-off-by: Dan Haab <dhaab@luxul.com>
---
As requested, I'm resending this patch including Linux ARM ML.

P.S.
We've successfully tested our device with earlyprintk which you may want to
enable in the future.
---
 arch/arm/boot/dts/Makefile                   |  1 +
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts | 60 ++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 2ca4bab..a03afbd 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -57,6 +57,7 @@ dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b-plus.dtb
 dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm4708-buffalo-wzr-1750dhp.dtb \
+	bcm4708-luxul-xwc-1000.dtb \
 	bcm4708-netgear-r6250.dtb \
 	bcm4708-netgear-r6300-v2.dtb \
 	bcm47081-asus-rt-n18u.dtb \
diff --git a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
new file mode 100644
index 0000000..946c728
--- /dev/null
+++ b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
@@ -0,0 +1,60 @@
+/*
+ * Broadcom BCM470X / BCM5301X ARM platform code.
+ * DTS for Luxul XWC-1000
+ *
+ * Copyright 2014 Luxul Inc.
+ *
+ * Licensed under the GNU/GPL. See COPYING for details.
+ */
+
+/dts-v1/;
+
+#include "bcm4708.dtsi"
+
+/ {
+	compatible = "luxul,xwc-1000", "brcm,bcm4708";
+	model = "Luxul XWC-1000 (BCM4708)";
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+	};
+
+	memory {
+		reg = <0x00000000 0x08000000>;
+	};
+
+	axi at 18000000 {
+		nand at 28000 {
+			reg = <0x00028000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "ubi";
+				reg = <0x00000000 0x08000000>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		status {
+			label = "bcm53xx:green:status";
+			gpios = <&chipcommon 0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "timer";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		restart {
+			label = "Reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&chipcommon 7 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
-- 
1.8.4.5
