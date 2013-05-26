From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 26 May 2013 17:33:40 +0200
Subject: [PATCH 4/5] ARM: at91: dt: add Calao USB-A9G20 low power version
In-Reply-To: <1369582421-25562-1-git-send-email-plagnioj@jcrosoft.com>
References: <20130526153037.GQ24476@game.jcrosoft.org>
 <1369582421-25562-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1369582421-25562-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the low power version have a mmc-spi

eanble mmc-spi and RV3029C2 RTC in at91_dt_defconfig

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: gregory hermant <gregory.hermant@calao-systems.com>
---
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/usb_a9g20.dts                    |   18 +-----------
 .../dts/{usb_a9g20.dts => usb_a9g20_common.dtsi}   |    5 +---
 arch/arm/boot/dts/usb_a9g20_lpw.dts                |   31 ++++++++++++++++++++
 arch/arm/configs/at91_dt_defconfig                 |    2 ++
 5 files changed, 36 insertions(+), 21 deletions(-)
 copy arch/arm/boot/dts/{usb_a9g20.dts => usb_a9g20_common.dtsi} (81%)
 create mode 100644 arch/arm/boot/dts/usb_a9g20_lpw.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b9f7121..f62d126 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -21,6 +21,7 @@ dtb-$(CONFIG_ARCH_AT91) += at91sam9g20ek_2mmc.dtb
 dtb-$(CONFIG_ARCH_AT91) += kizbox.dtb
 dtb-$(CONFIG_ARCH_AT91) += tny_a9g20.dtb
 dtb-$(CONFIG_ARCH_AT91) += usb_a9g20.dtb
+dtb-$(CONFIG_ARCH_AT91) += usb_a9g20_lpw.dtb
 # sam9g45
 dtb-$(CONFIG_ARCH_AT91) += at91sam9m10g45ek.dtb
 dtb-$(CONFIG_ARCH_AT91) += pm9g45.dtb
diff --git a/arch/arm/boot/dts/usb_a9g20.dts b/arch/arm/boot/dts/usb_a9g20.dts
index c979c06..ec77cf8 100644
--- a/arch/arm/boot/dts/usb_a9g20.dts
+++ b/arch/arm/boot/dts/usb_a9g20.dts
@@ -6,25 +6,9 @@
  * Licensed under GPLv2 or later.
  */
 /dts-v1/;
-#include "at91sam9g20.dtsi"
-#include "usb_a9260_common.dtsi"
+#include "usb_a9g20_common.dtsi"
 
 / {
 	model = "Calao USB A9G20";
 	compatible = "calao,usb-a9g20", "atmel,at91sam9g20", "atmel,at91sam9";
-
-	chosen {
-		bootargs = "mem=64M console=ttyS0,115200 root=/dev/mtdblock5 rw rootfstype=ubifs";
-	};
-
-	memory {
-		reg = <0x20000000 0x4000000>;
-	};
-
-	i2c at 0 {
-		rv3029c2 at 56 {
-			compatible = "rv3029c2";
-			reg = <0x56>;
-		};
-	};
 };
diff --git a/arch/arm/boot/dts/usb_a9g20.dts b/arch/arm/boot/dts/usb_a9g20_common.dtsi
similarity index 81%
copy from arch/arm/boot/dts/usb_a9g20.dts
copy to arch/arm/boot/dts/usb_a9g20_common.dtsi
index c979c06..0b3b361 100644
--- a/arch/arm/boot/dts/usb_a9g20.dts
+++ b/arch/arm/boot/dts/usb_a9g20_common.dtsi
@@ -5,14 +5,11 @@
  *
  * Licensed under GPLv2 or later.
  */
-/dts-v1/;
+
 #include "at91sam9g20.dtsi"
 #include "usb_a9260_common.dtsi"
 
 / {
-	model = "Calao USB A9G20";
-	compatible = "calao,usb-a9g20", "atmel,at91sam9g20", "atmel,at91sam9";
-
 	chosen {
 		bootargs = "mem=64M console=ttyS0,115200 root=/dev/mtdblock5 rw rootfstype=ubifs";
 	};
diff --git a/arch/arm/boot/dts/usb_a9g20_lpw.dts b/arch/arm/boot/dts/usb_a9g20_lpw.dts
new file mode 100644
index 0000000..f8cb1b9
--- /dev/null
+++ b/arch/arm/boot/dts/usb_a9g20_lpw.dts
@@ -0,0 +1,31 @@
+/*
+ * usb_a9g20_lpw.dts - Device Tree file for Caloa USB A9G20 Low Power board
+ *
+ *  Copyright (C) 2013 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Licensed under GPLv2 or later.
+ */
+/dts-v1/;
+#include "usb_a9g20_common.dtsi"
+
+/ {
+	model = "Calao USB A9G20 Low Power";
+	compatible = "calao,usb-a9g20-lpw", "calao,usb-a9g20", "atmel,at91sam9g20", "atmel,at91sam9";
+
+	ahb {
+		apb {
+			spi1: spi at fffcc000 {
+				cs-gpios = <&pioB 3 GPIO_ACTIVE_HIGH>;
+				status = "okay";
+				mmc-slot at 0 {
+					compatible = "mmc-spi-slot";
+					reg = <0>;
+					voltage-ranges = <3200 3400>;
+					spi-max-frequency = <25000000>;
+					interrupt-parent = <&pioC>;
+					interrupts = <4 IRQ_TYPE_EDGE_BOTH>;
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index a8800d3..75fd842 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -161,6 +161,7 @@ CONFIG_USB_ATMEL_USBA=y
 CONFIG_USB_G_SERIAL=y
 CONFIG_MMC=y
 CONFIG_MMC_ATMELMCI=y
+CONFIG_MMC_SPI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
@@ -169,6 +170,7 @@ CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_GPIO=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_RV3029C2=y
 CONFIG_RTC_DRV_AT91RM9200=y
 CONFIG_RTC_DRV_AT91SAM9=y
 CONFIG_DMADEVICES=y
-- 
1.7.10.4
