From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:44:16 +0100
Subject: [PATCH 48/51] ARM: plat-s5p: use arm_arch_reset instead of arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-49-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates plat-s5p to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-exynos4/include/mach/system.h        |    2 --
 arch/arm/mach-s5p64x0/include/mach/system.h        |    2 --
 arch/arm/mach-s5pc100/include/mach/system.h        |    2 --
 arch/arm/mach-s5pv210/include/mach/system.h        |    2 --
 arch/arm/plat-s5p/Makefile                         |    1 +
 .../plat/system-reset.h => system-reset.c}         |   17 +++++++++++++----
 6 files changed, 14 insertions(+), 12 deletions(-)
 rename arch/arm/plat-s5p/{include/plat/system-reset.h => system-reset.c} (66%)

diff --git a/arch/arm/mach-exynos4/include/mach/system.h b/arch/arm/mach-exynos4/include/mach/system.h
index 5e3220c..0063a6d 100644
--- a/arch/arm/mach-exynos4/include/mach/system.h
+++ b/arch/arm/mach-exynos4/include/mach/system.h
@@ -13,8 +13,6 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H __FILE__
 
-#include <plat/system-reset.h>
-
 static void arch_idle(void)
 {
 	/* nothing here yet */
diff --git a/arch/arm/mach-s5p64x0/include/mach/system.h b/arch/arm/mach-s5p64x0/include/mach/system.h
index 60f5753..cf26e09 100644
--- a/arch/arm/mach-s5p64x0/include/mach/system.h
+++ b/arch/arm/mach-s5p64x0/include/mach/system.h
@@ -13,8 +13,6 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H __FILE__
 
-#include <plat/system-reset.h>
-
 static void arch_idle(void)
 {
 	/* nothing here yet */
diff --git a/arch/arm/mach-s5pc100/include/mach/system.h b/arch/arm/mach-s5pc100/include/mach/system.h
index a9ea57c..afc96c2 100644
--- a/arch/arm/mach-s5pc100/include/mach/system.h
+++ b/arch/arm/mach-s5pc100/include/mach/system.h
@@ -11,8 +11,6 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H __FILE__
 
-#include <plat/system-reset.h>
-
 static void arch_idle(void)
 {
 	/* nothing here yet */
diff --git a/arch/arm/mach-s5pv210/include/mach/system.h b/arch/arm/mach-s5pv210/include/mach/system.h
index af8a200..bf288ce 100644
--- a/arch/arm/mach-s5pv210/include/mach/system.h
+++ b/arch/arm/mach-s5pv210/include/mach/system.h
@@ -13,8 +13,6 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H __FILE__
 
-#include <plat/system-reset.h>
-
 static void arch_idle(void)
 {
 	/* nothing here yet */
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index 4b53e04..2511d58 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -16,6 +16,7 @@ obj-y				+= dev-pmu.o
 obj-y				+= dev-uart.o
 obj-y				+= cpu.o
 obj-y				+= clock.o
+obj-y				+= system-reset.o
 obj-y				+= irq.o
 obj-$(CONFIG_S5P_EXT_INT)	+= irq-eint.o
 obj-$(CONFIG_S5P_GPIO_INT)	+= irq-gpioint.o
diff --git a/arch/arm/plat-s5p/include/plat/system-reset.h b/arch/arm/plat-s5p/system-reset.c
similarity index 66%
rename from arch/arm/plat-s5p/include/plat/system-reset.h
rename to arch/arm/plat-s5p/system-reset.c
index f307f34..84a38ab 100644
--- a/arch/arm/plat-s5p/include/plat/system-reset.h
+++ b/arch/arm/plat-s5p/system-reset.c
@@ -1,22 +1,24 @@
-/* linux/arch/arm/plat-s5p/include/plat/system-reset.h
+/* linux/arch/arm/plat-s5p/system-reset.c
  *
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
  * Based on arch/arm/mach-s3c2410/include/mach/system-reset.h
  *
- * S5P - System define for arch_reset()
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
 */
 
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <asm/system.h>
+
 #include <plat/watchdog-reset.h>
 
 void (*s5p_reset_hook)(void);
 
-static void arch_reset(char mode, const char *cmd)
+static void s5p_arch_reset(char mode, const char *cmd)
 {
 	/* SWRESET support in s5p_reset_hook() */
 
@@ -29,3 +31,10 @@ static void arch_reset(char mode, const char *cmd)
 
 	arch_wdt_reset();
 }
+
+static int __init s5p_arch_reset_init(void)
+{
+	arm_arch_reset = s5p_arch_reset;
+	return 0;
+}
+arch_initcall(s5p_arch_reset_init);
-- 
1.7.4.1
