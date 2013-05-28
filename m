From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 28 May 2013 10:21:43 +0800
Subject: [PATCH v2 1/5] irqchip: move mmp irq driver
In-Reply-To: <1369707707-30295-1-git-send-email-haojian.zhuang@gmail.com>
References: <1369707707-30295-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1369707707-30295-2-git-send-email-haojian.zhuang@gmail.com>
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
index 0bdc50b..9c1c9be 100644
--- a/arch/arm/mach-mmp/common.h
+++ b/arch/arm/mach-mmp/common.h
@@ -2,7 +2,6 @@
 
 extern void timer_init(int irq);
 
-extern void __init icu_init_irq(void);
 extern void __init mmp_map_io(void);
 extern void mmp_restart(char, const char *);
 extern void __init pxa168_clk_init(void);
diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-mmp/include/mach/pxa168.h
index 7ed1df2..e01dc2a 100644
--- a/arch/arm/mach-mmp/include/mach/pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/pxa168.h
@@ -2,6 +2,7 @@
 #define __ASM_MACH_PXA168_H
 
 extern void pxa168_timer_init(void);
+extern void __init icu_init_irq(void);
 extern void __init pxa168_init_irq(void);
 extern void pxa168_restart(char, const char *);
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
index cda4cb5..542d47e 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_ARCH_MXS)			+= irq-mxs.o
 obj-$(CONFIG_ARCH_S3C24XX)		+= irq-s3c24xx.o
 obj-$(CONFIG_METAG)			+= irq-metag-ext.o
 obj-$(CONFIG_METAG_PERFCOUNTER_IRQS)	+= irq-metag.o
+obj-$(CONFIG_ARCH_MMP)			+= irq-mmp.o
 obj-$(CONFIG_ARCH_SUNXI)		+= irq-sun4i.o
 obj-$(CONFIG_ARCH_SPEAR3XX)		+= spear-shirq.o
 obj-$(CONFIG_ARM_GIC)			+= irq-gic.o
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
