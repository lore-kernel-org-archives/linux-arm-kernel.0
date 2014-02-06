From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 06 Feb 2014 20:12:51 +0100
Subject: [PATCH v2 06/12] ARM: SAMSUNG: pm: Move Samsung PM debug code into
 separate file
In-Reply-To: <1391713977-22300-1-git-send-email-t.figa@samsung.com>
References: <1391713977-22300-1-git-send-email-t.figa@samsung.com>
Message-ID: <1391713977-22300-7-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not all Samsung SoC platforms are going to use the legacy Samsung PM
code enabled by CONFIG_SAMSUNG_PM_DEBUG. To allow using Samsung PM debug
helpers on such platforms, related code is moved to separate file and
a plat/pm-common.h header is added to separate legacy and generic code.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/Makefile                 |  1 +
 arch/arm/plat-samsung/include/plat/pm-common.h | 70 ++++++++++++++++++
 arch/arm/plat-samsung/include/plat/pm.h        | 39 +---------
 arch/arm/plat-samsung/pm-debug.c               | 98 ++++++++++++++++++++++++++
 arch/arm/plat-samsung/pm.c                     | 85 ----------------------
 5 files changed, 170 insertions(+), 123 deletions(-)
 create mode 100644 arch/arm/plat-samsung/include/plat/pm-common.h
 create mode 100644 arch/arm/plat-samsung/pm-debug.c

diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 9267d29..ba30a16 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_SAMSUNG_DMADEV)	+= dma-ops.o
 obj-$(CONFIG_SAMSUNG_PM)	+= pm.o
 obj-$(CONFIG_SAMSUNG_PM_GPIO)	+= pm-gpio.o
 obj-$(CONFIG_SAMSUNG_PM_CHECK)	+= pm-check.o
+obj-$(CONFIG_SAMSUNG_PM_DEBUG)	+= pm-debug.o
 
 obj-$(CONFIG_SAMSUNG_WAKEMASK)	+= wakeup-mask.o
 obj-$(CONFIG_SAMSUNG_WDT_RESET)	+= watchdog-reset.o
diff --git a/arch/arm/plat-samsung/include/plat/pm-common.h b/arch/arm/plat-samsung/include/plat/pm-common.h
new file mode 100644
index 0000000..f72974a
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/pm-common.h
@@ -0,0 +1,70 @@
+/*
+ * Copyright (C) 2013 Samsung Electronics Co., Ltd.
+ *	Tomasz Figa <t.figa@samsung.com>
+ * Copyright (c) 2004 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Written by Ben Dooks, <ben@simtec.co.uk>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __PLAT_SAMSUNG_PM_COMMON_H
+#define __PLAT_SAMSUNG_PM_COMMON_H __FILE__
+
+/* PM debug functions */
+
+/**
+ * struct pm_uart_save - save block for core UART
+ * @ulcon: Save value for S3C2410_ULCON
+ * @ucon: Save value for S3C2410_UCON
+ * @ufcon: Save value for S3C2410_UFCON
+ * @umcon: Save value for S3C2410_UMCON
+ * @ubrdiv: Save value for S3C2410_UBRDIV
+ *
+ * Save block for UART registers to be held over sleep and restored if they
+ * are needed (say by debug).
+*/
+struct pm_uart_save {
+	u32	ulcon;
+	u32	ucon;
+	u32	ufcon;
+	u32	umcon;
+	u32	ubrdiv;
+	u32	udivslot;
+};
+
+#ifdef CONFIG_SAMSUNG_PM_DEBUG
+/**
+ * s3c_pm_dbg() - low level debug function for use in suspend/resume.
+ * @msg: The message to print.
+ *
+ * This function is used mainly to debug the resume process before the system
+ * can rely on printk/console output. It uses the low-level debugging output
+ * routine printascii() to do its work.
+ */
+extern void s3c_pm_dbg(const char *msg, ...);
+
+/**
+ * s3c_pm_debug_init() - suspend/resume low level debug initialization.
+ * @base: Virtual base of UART to use for suspend/resume debugging.
+ *
+ * This function needs to be called before S3C_PMDBG() can be used, to set up
+ * UART port base address and configuration.
+ */
+extern void s3c_pm_debug_init(void);
+
+#define S3C_PMDBG(fmt...) s3c_pm_dbg(fmt)
+
+extern void s3c_pm_save_uarts(void);
+extern void s3c_pm_restore_uarts(void);
+#else
+#define S3C_PMDBG(fmt...) pr_debug(fmt)
+#define s3c_pm_debug_init() do { } while (0)
+
+static inline void s3c_pm_save_uarts(void) { }
+static inline void s3c_pm_restore_uarts(void) { }
+#endif
+
+#endif
diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-samsung/include/plat/pm.h
index 21758c6..2e04396 100644
--- a/arch/arm/plat-samsung/include/plat/pm.h
+++ b/arch/arm/plat-samsung/include/plat/pm.h
@@ -16,6 +16,7 @@
 */
 
 #include <linux/irq.h>
+#include <plat/pm-common.h>
 
 struct device;
 
@@ -76,26 +77,6 @@ struct sleep_save {
 #define SAVE_ITEM(x) \
 	{ .reg = (x) }
 
-/**
- * struct pm_uart_save - save block for core UART
- * @ulcon: Save value for S3C2410_ULCON
- * @ucon: Save value for S3C2410_UCON
- * @ufcon: Save value for S3C2410_UFCON
- * @umcon: Save value for S3C2410_UMCON
- * @ubrdiv: Save value for S3C2410_UBRDIV
- *
- * Save block for UART registers to be held over sleep and restored if they
- * are needed (say by debug).
-*/
-struct pm_uart_save {
-	u32	ulcon;
-	u32	ucon;
-	u32	ufcon;
-	u32	umcon;
-	u32	ubrdiv;
-	u32	udivslot;
-};
-
 /* helper functions to save/restore lists of registers. */
 
 extern void s3c_pm_do_save(struct sleep_save *ptr, int count);
@@ -112,24 +93,6 @@ extern void s3c_cpu_resume(void);
 #define s3c_cpu_resume NULL
 #endif
 
-/* PM debug functions */
-
-#ifdef CONFIG_SAMSUNG_PM_DEBUG
-/**
- * s3c_pm_dbg() - low level debug function for use in suspend/resume.
- * @msg: The message to print.
- *
- * This function is used mainly to debug the resume process before the system
- * can rely on printk/console output. It uses the low-level debugging output
- * routine printascii() to do its work.
- */
-extern void s3c_pm_dbg(const char *msg, ...);
-
-#define S3C_PMDBG(fmt...) s3c_pm_dbg(fmt)
-#else
-#define S3C_PMDBG(fmt...) printk(KERN_DEBUG fmt)
-#endif
-
 #ifdef CONFIG_S3C_PM_DEBUG_LED_SMDK
 /**
  * s3c_pm_debug_smdkled() - Debug PM suspend/resume via SMDK Board LEDs
diff --git a/arch/arm/plat-samsung/pm-debug.c b/arch/arm/plat-samsung/pm-debug.c
new file mode 100644
index 0000000..9f979b2
--- /dev/null
+++ b/arch/arm/plat-samsung/pm-debug.c
@@ -0,0 +1,98 @@
+/*
+ * Copyright (C) 2013 Samsung Electronics Co., Ltd.
+ *	Tomasz Figa <t.figa@samsung.com>
+ * Copyright (C) 2008 Openmoko, Inc.
+ * Copyright (C) 2004-2008 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *	http://armlinux.simtec.co.uk/
+ *
+ * Samsung common power management (suspend to RAM) debug support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/serial_core.h>
+#include <linux/io.h>
+
+#include <asm/mach/map.h>
+
+#include <plat/cpu.h>
+#include <plat/pm-common.h>
+#include <plat/regs-serial.h>
+
+#ifdef CONFIG_SAMSUNG_ATAGS
+#include <mach/pm-core.h>
+#else
+static inline void s3c_pm_debug_init_uart(void) {}
+static inline void s3c_pm_arch_update_uart(void __iomem *regs,
+					   struct pm_uart_save *save) {}
+#endif
+
+static struct pm_uart_save uart_save;
+
+extern void printascii(const char *);
+
+void s3c_pm_dbg(const char *fmt, ...)
+{
+	va_list va;
+	char buff[256];
+
+	va_start(va, fmt);
+	vsnprintf(buff, sizeof(buff), fmt, va);
+	va_end(va);
+
+	printascii(buff);
+}
+
+void s3c_pm_debug_init(void)
+{
+	/* restart uart clocks so we can use them to output */
+	s3c_pm_debug_init_uart();
+}
+
+static inline void __iomem *s3c_pm_uart_base(void)
+{
+	unsigned long paddr;
+	unsigned long vaddr;
+
+	debug_ll_addr(&paddr, &vaddr);
+
+	return (void __iomem *)vaddr;
+}
+
+void s3c_pm_save_uarts(void)
+{
+	void __iomem *regs = s3c_pm_uart_base();
+	struct pm_uart_save *save = &uart_save;
+
+	save->ulcon = __raw_readl(regs + S3C2410_ULCON);
+	save->ucon = __raw_readl(regs + S3C2410_UCON);
+	save->ufcon = __raw_readl(regs + S3C2410_UFCON);
+	save->umcon = __raw_readl(regs + S3C2410_UMCON);
+	save->ubrdiv = __raw_readl(regs + S3C2410_UBRDIV);
+
+	if (!soc_is_s3c2410())
+		save->udivslot = __raw_readl(regs + S3C2443_DIVSLOT);
+
+	S3C_PMDBG("UART[%p]: ULCON=%04x, UCON=%04x, UFCON=%04x, UBRDIV=%04x\n",
+		  regs, save->ulcon, save->ucon, save->ufcon, save->ubrdiv);
+}
+
+void s3c_pm_restore_uarts(void)
+{
+	void __iomem *regs = s3c_pm_uart_base();
+	struct pm_uart_save *save = &uart_save;
+
+	s3c_pm_arch_update_uart(regs, save);
+
+	__raw_writel(save->ulcon, regs + S3C2410_ULCON);
+	__raw_writel(save->ucon,  regs + S3C2410_UCON);
+	__raw_writel(save->ufcon, regs + S3C2410_UFCON);
+	__raw_writel(save->umcon, regs + S3C2410_UMCON);
+	__raw_writel(save->ubrdiv, regs + S3C2410_UBRDIV);
+
+	if (!soc_is_s3c2410())
+		__raw_writel(save->udivslot, regs + S3C2443_DIVSLOT);
+}
diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index 7c1d4385..a655192 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -17,16 +17,11 @@
 #include <linux/errno.h>
 #include <linux/delay.h>
 #include <linux/of.h>
-#include <linux/serial_core.h>
 #include <linux/io.h>
 
 #include <asm/cacheflush.h>
-#include <asm/mach/map.h>
 #include <asm/suspend.h>
 
-#include <plat/cpu.h>
-#include <plat/regs-serial.h>
-
 #ifdef CONFIG_SAMSUNG_ATAGS
 #include <mach/hardware.h>
 #include <mach/map.h>
@@ -46,86 +41,6 @@
 
 unsigned long s3c_pm_flags;
 
-/* Debug code:
- *
- * This code supports debug output to the low level UARTs for use on
- * resume before the console layer is available.
-*/
-
-#ifdef CONFIG_SAMSUNG_PM_DEBUG
-extern void printascii(const char *);
-
-void s3c_pm_dbg(const char *fmt, ...)
-{
-	va_list va;
-	char buff[256];
-
-	va_start(va, fmt);
-	vsnprintf(buff, sizeof(buff), fmt, va);
-	va_end(va);
-
-	printascii(buff);
-}
-
-static inline void s3c_pm_debug_init(void)
-{
-	/* restart uart clocks so we can use them to output */
-	s3c_pm_debug_init_uart();
-}
-
-static struct pm_uart_save uart_save;
-
-static inline void __iomem *s3c_pm_uart_base(void)
-{
-	unsigned long paddr;
-	unsigned long vaddr;
-
-	debug_ll_addr(&paddr, &vaddr);
-
-	return (void __iomem *)vaddr;
-}
-
-static void s3c_pm_save_uarts(void)
-{
-	void __iomem *regs = s3c_pm_uart_base();
-	struct pm_uart_save *save = &uart_save;
-
-	save->ulcon = __raw_readl(regs + S3C2410_ULCON);
-	save->ucon = __raw_readl(regs + S3C2410_UCON);
-	save->ufcon = __raw_readl(regs + S3C2410_UFCON);
-	save->umcon = __raw_readl(regs + S3C2410_UMCON);
-	save->ubrdiv = __raw_readl(regs + S3C2410_UBRDIV);
-
-	if (!soc_is_s3c2410())
-		save->udivslot = __raw_readl(regs + S3C2443_DIVSLOT);
-
-	S3C_PMDBG("UART[%p]: ULCON=%04x, UCON=%04x, UFCON=%04x, UBRDIV=%04x\n",
-		  regs, save->ulcon, save->ucon, save->ufcon, save->ubrdiv);
-}
-
-static void s3c_pm_restore_uarts(void)
-{
-	void __iomem *regs = s3c_pm_uart_base();
-	struct pm_uart_save *save = &uart_save;
-
-	s3c_pm_arch_update_uart(regs, save);
-
-	__raw_writel(save->ulcon, regs + S3C2410_ULCON);
-	__raw_writel(save->ucon,  regs + S3C2410_UCON);
-	__raw_writel(save->ufcon, regs + S3C2410_UFCON);
-	__raw_writel(save->umcon, regs + S3C2410_UMCON);
-	__raw_writel(save->ubrdiv, regs + S3C2410_UBRDIV);
-
-	if (!soc_is_s3c2410())
-		__raw_writel(save->udivslot, regs + S3C2443_DIVSLOT);
-}
-#else
-#define s3c_pm_debug_init() do { } while (0)
-
-static void s3c_pm_save_uarts(void) { }
-static void s3c_pm_restore_uarts(void) { }
-#endif
-
 /* The IRQ ext-int code goes here, it is too small to currently bother
  * with its own file. */
 
-- 
1.8.5.2
