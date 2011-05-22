From: awg@embtoolkit.org (Abdoulaye Walsimou Gaye)
Date: Sun, 22 May 2011 19:49:58 +0200
Subject: [PATCH] ARM: s3c24xx: fix build errors introduced by bb072c3cf21d1
Message-ID: <1306086598-18001-1-git-send-email-awg@embtoolkit.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Abdoulaye Walsimou Gaye <awg@embtoolkit.org>
---
 arch/arm/mach-s3c2410/Makefile |    1 -
 arch/arm/mach-s3c2410/irq.c    |   34 ----------------------------------
 arch/arm/plat-s3c24xx/dma.c    |    2 +-
 arch/arm/plat-s3c24xx/irq-pm.c |    6 ++++++
 4 files changed, 7 insertions(+), 36 deletions(-)
 delete mode 100644 arch/arm/mach-s3c2410/irq.c

diff --git a/arch/arm/mach-s3c2410/Makefile b/arch/arm/mach-s3c2410/Makefile
index 0d468e9..8169535 100644
--- a/arch/arm/mach-s3c2410/Makefile
+++ b/arch/arm/mach-s3c2410/Makefile
@@ -10,7 +10,6 @@ obj-n				:=
 obj-				:=
 
 obj-$(CONFIG_CPU_S3C2410)	+= s3c2410.o
-obj-$(CONFIG_CPU_S3C2410)	+= irq.o
 obj-$(CONFIG_CPU_S3C2410_DMA)	+= dma.o
 obj-$(CONFIG_CPU_S3C2410_DMA)	+= dma.o
 obj-$(CONFIG_S3C2410_PM)	+= pm.o sleep.o
diff --git a/arch/arm/mach-s3c2410/irq.c b/arch/arm/mach-s3c2410/irq.c
deleted file mode 100644
index 2854129..0000000
--- a/arch/arm/mach-s3c2410/irq.c
+++ /dev/null
@@ -1,34 +0,0 @@
-/* linux/arch/arm/mach-s3c2410/irq.c
- *
- * Copyright (c) 2006 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
-*/
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/syscore_ops.h>
-
-#include <plat/cpu.h>
-#include <plat/pm.h>
-
-struct syscore_ops s3c24xx_irq_syscore_ops = {
-	.suspend	= s3c24xx_irq_suspend,
-	.resume		= s3c24xx_irq_resume,
-};
diff --git a/arch/arm/plat-s3c24xx/dma.c b/arch/arm/plat-s3c24xx/dma.c
index c10d10c..2abf966 100644
--- a/arch/arm/plat-s3c24xx/dma.c
+++ b/arch/arm/plat-s3c24xx/dma.c
@@ -1199,7 +1199,7 @@ EXPORT_SYMBOL(s3c2410_dma_getposition);
 
 #ifdef CONFIG_PM
 
-static void s3c2410_dma_suspend_chan(s3c2410_dma_chan *cp)
+static void s3c2410_dma_suspend_chan(struct s3c2410_dma_chan *cp)
 {
 	printk(KERN_DEBUG "suspending dma channel %d\n", cp->number);
 
diff --git a/arch/arm/plat-s3c24xx/irq-pm.c b/arch/arm/plat-s3c24xx/irq-pm.c
index 0efb2e2..a3e0a2c 100644
--- a/arch/arm/plat-s3c24xx/irq-pm.c
+++ b/arch/arm/plat-s3c24xx/irq-pm.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/syscore_ops.h>
 
 #include <plat/cpu.h>
 #include <plat/pm.h>
@@ -24,6 +25,11 @@
 
 /* state for IRQs over sleep */
 
+struct syscore_ops s3c24xx_irq_syscore_ops = {
+	.suspend	= s3c24xx_irq_suspend,
+	.resume		= s3c24xx_irq_resume,
+};
+
 /* default is to allow for EINT0..EINT15, and IRQ_RTC as wakeup sources
  *
  * set bit to 1 in allow bitfield to enable the wakeup settings on it
-- 
1.7.4.1
