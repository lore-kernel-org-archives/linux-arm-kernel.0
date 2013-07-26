From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 26 Jul 2013 18:05:23 +0800
Subject: [PATCH v6 01/11] irqchip: move mmp irq driver
In-Reply-To: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
References: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1374833133-21119-2-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move irq-mmp driver from mach-mmp directory into irqchip directory.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-mmp/Makefile                           | 2 +-
 arch/arm/mach-mmp/common.h                           | 1 -
 arch/arm/mach-mmp/include/mach/pxa168.h              | 1 +
 arch/arm/mach-mmp/include/mach/pxa910.h              | 1 +
 arch/arm/mach-mmp/pxa910.c                           | 1 +
 drivers/irqchip/Makefile                             | 1 +
 arch/arm/mach-mmp/irq.c => drivers/irqchip/irq-mmp.c | 2 --
 7 files changed, 5 insertions(+), 4 deletions(-)
 rename arch/arm/mach-mmp/irq.c => drivers/irqchip/irq-mmp.c (99%)

diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index 095c155..9b702a1 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Marvell's PXA168 processors line
 #
 
-obj-y				+= common.o devices.o time.o irq.o
+obj-y				+= common.o devices.o time.o
 
 # SoC support
 obj-$(CONFIG_CPU_PXA168)	+= pxa168.o
diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
index 991d7e9..cf445ba 100644
--- a/arch/arm/mach-mmp/common.h
+++ b/arch/arm/mach-mmp/common.h
@@ -3,7 +3,6 @@
 
 extern void timer_init(int irq);
 
-extern void __init icu_init_irq(void);
 extern void __init mmp_map_io(void);
 extern void mmp_restart(enum reboot_mode, const char *);
 extern void __init pxa168_clk_init(void);
diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-mmp/include/mach/pxa168.h
index 459c2d0..a83ba7c 100644
--- a/arch/arm/mach-mmp/include/mach/pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/pxa168.h
@@ -4,6 +4,7 @@
 #include <linux/reboot.h>
 
 extern void pxa168_timer_init(void);
+extern void __init icu_init_irq(void);
 extern void __init pxa168_init_irq(void);
 extern void pxa168_restart(enum reboot_mode, const char *);
 extern void pxa168_clear_keypad_wakeup(void);
diff --git a/arch/arm/mach-mmp/include/mach/pxa910.h b/arch/arm/mach-mmp/include/mach/pxa910.h
index b914afa..9225320 100644
--- a/arch/arm/mach-mmp/include/mach/pxa910.h
+++ b/arch/arm/mach-mmp/include/mach/pxa910.h
@@ -2,6 +2,7 @@
 #define __ASM_MACH_PXA910_H
 
 extern void pxa910_timer_init(void);
+extern void __init icu_init_irq(void);
 extern void __init pxa910_init_irq(void);
 
 #include <linux/i2c.h>
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index ce6393a..a586742 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -23,6 +23,7 @@
 #include <mach/dma.h>
 #include <mach/mfp.h>
 #include <mach/devices.h>
+#include <mach/pxa910.h>
 
 #include "common.h"
 
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e65c41a..c452943 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -2,6 +2,7 @@ obj-$(CONFIG_IRQCHIP)			+= irqchip.o
 
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
+obj-$(CONFIG_ARCH_MMP)			+= irq-mmp.o
 obj-$(CONFIG_ARCH_MVEBU)		+= irq-armada-370-xp.o
 obj-$(CONFIG_ARCH_MXS)			+= irq-mxs.o
 obj-$(CONFIG_ARCH_S3C24XX)		+= irq-s3c24xx.o
diff --git a/arch/arm/mach-mmp/irq.c b/drivers/irqchip/irq-mmp.c
similarity index 99%
rename from arch/arm/mach-mmp/irq.c
rename to drivers/irqchip/irq-mmp.c
index 3c71246..dab6def 100644
--- a/arch/arm/mach-mmp/irq.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -30,8 +30,6 @@
 #include <mach/pm-pxa910.h>
 #endif
 
-#include "common.h"
-
 #define MAX_ICU_NR		16
 
 struct icu_chip_data {
-- 
1.8.1.2
