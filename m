From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue,  8 Jul 2014 16:42:25 +0200
Subject: [PATCH 2/2] ARM: Kirkwood: add DT support for d2 Network v2
In-Reply-To: <1404830545-15581-1-git-send-email-simon.guinot@sequanux.org>
References: <1401132591-26305-1-git-send-email-andrew@lunn.ch>
 <1404830545-15581-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1404830545-15581-3-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DT support for the LaCie NAS d2 Network v2 (d2net_v2).
Most of the hardware characteristics are shared with the 2Big and 5Big
Network v2 boards.

- CPU: Marvell 88F6281 1200Mhz
- SDRAM memory: 256MB DDR2 400Mhz
- 2 SATA ports: internal and eSATA
- Gigabit ethernet: PHY Marvell 88E1116R
- Flash memory: SPI NOR 512KB (Macronix MX25L4005A)
- i2c EEPROM: 512 bytes (24C04 type)
- 2 USB2 ports: host and host/device
- 1 push button
- 1 power switch
- 1 SATA LED (bi-color, blue and red)

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
 arch/arm/boot/dts/Makefile           |  1 +
 arch/arm/boot/dts/kirkwood-d2net.dts | 42 ++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-d2net.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0b216b425eb8..c1dd2d1aa773 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -93,6 +93,7 @@ dtb-$(CONFIG_ARCH_KEYSTONE) += k2hk-evm.dtb \
 kirkwood := \
 	kirkwood-b3.dtb \
 	kirkwood-cloudbox.dtb \
+	kirkwood-d2net.dtb \
 	kirkwood-db-88f6281.dtb \
 	kirkwood-db-88f6282.dtb \
 	kirkwood-dns320.dtb \
diff --git a/arch/arm/boot/dts/kirkwood-d2net.dts b/arch/arm/boot/dts/kirkwood-d2net.dts
new file mode 100644
index 000000000000..6b7856025001
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-d2net.dts
@@ -0,0 +1,42 @@
+/*
+ * Device Tree file for d2 Network v2
+ *
+ * Copyright (C) 2014 Simon Guinot <simon.guinot@sequanux.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+*/
+
+/dts-v1/;
+
+#include "kirkwood-netxbig.dtsi"
+
+/ {
+	model = "LaCie d2 Network v2";
+	compatible = "lacie,d2net_v2", "lacie,netxbig", "marvell,kirkwood-88f6281", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+
+	ns2-leds {
+		compatible = "lacie,ns2-leds";
+
+		blue-sata {
+			label = "d2net_v2:blue:sata";
+			slow-gpio = <&gpio0 29 GPIO_ACTIVE_HIGH>;
+			cmd-gpio = <&gpio0 30 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		red-fail {
+			label = "d2net_v2:red:fail";
+			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
-- 
2.0.0.rc2
