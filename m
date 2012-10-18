From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 18 Oct 2012 19:19:30 +0200
Subject: [PATCH 8/8] ARM: plat-nomadik: convert platforms to SPARSE_IRQ
Message-ID: <1350580770-8586-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This converts the Nomadik and Ux500 platforms to use SPARSE_IRQ.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                          | 2 ++
 arch/arm/mach-nomadik/include/mach/irqs.h | 2 +-
 arch/arm/mach-ux500/board-mop500.c        | 1 -
 arch/arm/mach-ux500/cpu-db8500.c          | 1 +
 arch/arm/mach-ux500/devices-common.c      | 1 +
 arch/arm/mach-ux500/devices-db8500.c      | 1 +
 arch/arm/mach-ux500/devices-db8500.h      | 1 +
 arch/arm/mach-ux500/include/mach/irqs.h   | 2 +-
 drivers/pinctrl/pinctrl-nomadik.c         | 3 +--
 9 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c5f2c18..8d7fcd3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -885,6 +885,7 @@ config ARCH_U8500
 	select GENERIC_CLOCKEVENTS
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
+	select SPARSE_IRQ
 	help
 	  Support for ST-Ericsson's Ux500 architecture
 
@@ -899,6 +900,7 @@ config ARCH_NOMADIK
 	select MIGHT_HAVE_CACHE_L2X0
 	select PINCTRL
 	select PINCTRL_STN8815
+	select SPARSE_IRQ
 	help
 	  Support for the Nomadik platform by ST-Ericsson
 
diff --git a/arch/arm/mach-nomadik/include/mach/irqs.h b/arch/arm/mach-nomadik/include/mach/irqs.h
index a118e61..b549d05 100644
--- a/arch/arm/mach-nomadik/include/mach/irqs.h
+++ b/arch/arm/mach-nomadik/include/mach/irqs.h
@@ -72,7 +72,7 @@
 #define NOMADIK_NR_GPIO			128 /* last 4 not wired to pins */
 #define NOMADIK_GPIO_TO_IRQ(gpio)	((gpio) + NOMADIK_GPIO_OFFSET)
 #define NOMADIK_IRQ_TO_GPIO(irq)	((irq) - NOMADIK_GPIO_OFFSET)
-#define NR_IRQS				NOMADIK_GPIO_TO_IRQ(NOMADIK_NR_GPIO)
+#define NOMADIK_NR_IRQS			NOMADIK_GPIO_TO_IRQ(NOMADIK_NR_GPIO)
 
 /* Following two are used by entry_macro.S, to access our dual-vic */
 #define VIC_REG_IRQSR0		0
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 0213e89..9268056 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -1,4 +1,3 @@
-
 /*
  * Copyright (C) 2008-2009 ST-Ericsson
  *
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 87a8f9f..8bff078 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -26,6 +26,7 @@
 #include <mach/setup.h>
 #include <mach/devices.h>
 #include <mach/db8500-regs.h>
+#include <mach/irqs.h>
 
 #include "devices-db8500.h"
 #include "ste-dma40-db8500.h"
diff --git a/arch/arm/mach-ux500/devices-common.c b/arch/arm/mach-ux500/devices-common.c
index 692a77a..16b5f71 100644
--- a/arch/arm/mach-ux500/devices-common.c
+++ b/arch/arm/mach-ux500/devices-common.c
@@ -14,6 +14,7 @@
 #include <linux/platform_data/pinctrl-nomadik.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 
 #include "devices-common.h"
 
diff --git a/arch/arm/mach-ux500/devices-db8500.c b/arch/arm/mach-ux500/devices-db8500.c
index bdc963c..318d490 100644
--- a/arch/arm/mach-ux500/devices-db8500.c
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -16,6 +16,7 @@
 
 #include <mach/hardware.h>
 #include <mach/setup.h>
+#include <mach/irqs.h>
 
 #include "ste-dma40-db8500.h"
 
diff --git a/arch/arm/mach-ux500/devices-db8500.h b/arch/arm/mach-ux500/devices-db8500.h
index 3c8010f..4b24c99 100644
--- a/arch/arm/mach-ux500/devices-db8500.h
+++ b/arch/arm/mach-ux500/devices-db8500.h
@@ -8,6 +8,7 @@
 #ifndef __DEVICES_DB8500_H
 #define __DEVICES_DB8500_H
 
+#include <mach/irqs.h>
 #include "devices-common.h"
 
 struct ske_keypad_platform_data;
diff --git a/arch/arm/mach-ux500/include/mach/irqs.h b/arch/arm/mach-ux500/include/mach/irqs.h
index e892854..fc77b42 100644
--- a/arch/arm/mach-ux500/include/mach/irqs.h
+++ b/arch/arm/mach-ux500/include/mach/irqs.h
@@ -46,6 +46,6 @@
 #include <mach/irqs-board-mop500.h>
 #endif
 
-#define NR_IRQS			IRQ_BOARD_END
+#define UX500_NR_IRQS		IRQ_BOARD_END
 
 #endif /* ASM_ARCH_IRQS_H */
diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index 0a712c2..abf9dea 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -32,9 +32,8 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/mfd/dbx500-prcmu.h>
 #include <linux/platform_data/pinctrl-nomadik.h>
-
 #include <asm/mach/irq.h>
-
+#include <mach/irqs.h>
 #include "pinctrl-nomadik.h"
 
 /*
-- 
1.7.11.3
