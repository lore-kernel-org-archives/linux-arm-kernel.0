From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Fri, 26 Jul 2013 00:42:14 +0200
Subject: [PATCH v3 2/3] ARM: BCM5301X: add early debugging support
In-Reply-To: <1374792135-30343-1-git-send-email-hauke@hauke-m.de>
References: <1374792135-30343-1-git-send-email-hauke@hauke-m.de>
Message-ID: <1374792135-30343-3-git-send-email-hauke@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for early debugging of BCM5301X SoC.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/arm/Kconfig.debug            |    5 +++++
 arch/arm/include/debug/bcm5301x.S |   19 +++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 arch/arm/include/debug/bcm5301x.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index e401a76..3a3c8fc 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -93,6 +93,10 @@ choice
 		bool "Kernel low-level debugging on BCM2835 PL011 UART"
 		depends on ARCH_BCM2835
 
+	config DEBUG_BCM5301X
+		bool "Kernel low-level debugging on BCM5301X UART1"
+		depends on ARCH_BCM5301X
+
 	config DEBUG_CLPS711X_UART1
 		bool "Kernel low-level debugging messages via UART1"
 		depends on ARCH_CLPS711X
@@ -762,6 +766,7 @@ endchoice
 config DEBUG_LL_INCLUDE
 	string
 	default "debug/bcm2835.S" if DEBUG_BCM2835
+	default "debug/bcm5301x.S" if DEBUG_BCM5301X
 	default "debug/cns3xxx.S" if DEBUG_CNS3XXX
 	default "debug/exynos.S" if DEBUG_EXYNOS_UART
 	default "debug/highbank.S" if DEBUG_HIGHBANK_UART
diff --git a/arch/arm/include/debug/bcm5301x.S b/arch/arm/include/debug/bcm5301x.S
new file mode 100644
index 0000000..be16945
--- /dev/null
+++ b/arch/arm/include/debug/bcm5301x.S
@@ -0,0 +1,19 @@
+/*
+ * Macros used for EARLY_PRINTK, in low-level UART debug console
+ *
+ * Copyright 2013 Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Licensed under the GNU/GPL. See COPYING for details.
+ */
+
+#define BCM5301X_UART1_PHYS	0x18000300
+#define BCM5301X_UART1_VIRT	0xf1000300
+#define BCM5301X_UART1_SH	0
+
+	.macro	addruart, rp, rv, tmp
+	ldr	\rp, =BCM5301X_UART1_PHYS 	@ MMU off, Physical
+	ldr	\rv, =BCM5301X_UART1_VIRT 	@ MMU on, Virtual
+	.endm
+
+#define UART_SHIFT	BCM5301X_UART1_SH
+#include <asm/hardware/debug-8250.S>
-- 
1.7.10.4
