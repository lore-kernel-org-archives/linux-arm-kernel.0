From: pawel.mikolaj.chmiel@gmail.com (=?UTF-8?q?Pawe=C5=82=20Chmiel?=)
Date: Sat,  7 Jul 2018 12:09:41 +0200
Subject: [PATCH v4 3/5] ARM: dts: s5pv210: Add initial DTS for SGH-T959P phone
In-Reply-To: <1530958183-10956-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530958183-10956-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <1530958183-10956-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Bakker <xc-racer2@live.ca>

This DTS file have initial support Samsung SGH-T959P phone,
also known as Samsung Galaxy S 4G or fascinate4g.
It belongs to Samsung Aries devices family.
Initial version have support for:
- sdcard
- max8998 pmic and rtc
- max17040 fuel gauge
- gpio keys
- fimd (no panel driver yet)
- usb (peripherial mode)
- wifi

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
---

Changes from v1:
  - Added missing commit msg
  - Removed duplicated and unneeded headers
  - Added stdout-path
  - Added information why we hardcode bootargs
---
---
 arch/arm/boot/dts/Makefile                |  1 +
 arch/arm/boot/dts/s5pv210-fascinate4g.dts | 45 +++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 arch/arm/boot/dts/s5pv210-fascinate4g.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 522ebdca1d3d..d00e995875bb 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -846,6 +846,7 @@ dtb-$(CONFIG_ARCH_S3C64XX) += \
 	s3c6410-smdk6410.dtb
 dtb-$(CONFIG_ARCH_S5PV210) += \
 	s5pv210-aquila.dtb \
+	s5pv210-fascinate4g.dtb \
 	s5pv210-galaxys.dtb \
 	s5pv210-goni.dtb \
 	s5pv210-smdkc110.dtb \
diff --git a/arch/arm/boot/dts/s5pv210-fascinate4g.dts b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
new file mode 100644
index 000000000000..ccf761b1babf
--- /dev/null
+++ b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include "s5pv210-aries.dtsi"
+
+/ {
+	model = "Samsung Galaxy S Fascinate 4G (SGH-T959P) based on S5PV210";
+	compatible = "samsung,fascinate4g", "samsung,aries", "samsung,s5pv210";
+
+	chosen {
+		stdout-path = &uart2;
+		/*
+		 * It's hard to change those parameters in stock bootloader,
+		 * since it requires special hardware/cable.
+		 * Let's hardocde bootargs for now, till u-boot port is finished,
+		 * with which it should be easier.
+		 */
+		bootargs = "root=/dev/mmcblk1p1 rw rootwait ignore_loglevel earlyprintk";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		power {
+			label = "power";
+			gpios = <&gph2 6 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+
+		vol-down {
+			label = "volume_down";
+			gpios = <&gph3 2 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		vol-up {
+			label = "volume_up";
+			gpios = <&gph3 1 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+	};
+};
-- 
2.7.4
