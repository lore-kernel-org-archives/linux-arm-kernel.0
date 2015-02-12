From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Feb 2015 20:35:43 +0100
Subject: [PATCH 6/9] ARM: s3c24xx: fix header file inclusions
In-Reply-To: <1423769746-582629-1-git-send-email-arnd@arndb.de>
References: <1423769746-582629-1-git-send-email-arnd@arndb.de>
Message-ID: <1423769746-582629-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pm-core.h file does not include all the necessary headers,
and has a static declaration for a function that is not
defined in the same file, causing SAMSUNG_PM_DEBUG to
break on s3c24xx:

arch/arm/mach-s3c24xx/include/mach/pm-core.h:50:91: warning: 's3c_pm_show_resume_irqs' used but never defined
arch/arm/mach-s3c24xx/include/mach/pm-core.h: In function 's3c_pm_debug_init_uart':
arch/arm/mach-s3c24xx/include/mach/pm-core.h:16:34: error: 'S3C2410_CLKCON' undeclared (first use in this function)
  unsigned long tmp = __raw_readl(S3C2410_CLKCON);
                                  ^

This moves the code around slightly to avoid the errors.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c24xx/include/mach/pm-core.h | 24 ++++++++++++++++++++++--
 arch/arm/plat-samsung/pm-debug.c             |  1 +
 arch/arm/plat-samsung/pm.c                   | 20 --------------------
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/include/mach/pm-core.h b/arch/arm/mach-s3c24xx/include/mach/pm-core.h
index 2eef7e6f7675..69459dbbdcad 100644
--- a/arch/arm/mach-s3c24xx/include/mach/pm-core.h
+++ b/arch/arm/mach-s3c24xx/include/mach/pm-core.h
@@ -10,6 +10,11 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/delay.h>
+#include <linux/io.h>
+
+#include "regs-clock.h"
+#include "regs-irq.h"
 
 static inline void s3c_pm_debug_init_uart(void)
 {
@@ -42,8 +47,23 @@ static inline void s3c_pm_arch_stop_clocks(void)
 	__raw_writel(0x00, S3C2410_CLKCON);  /* turn off clocks over sleep */
 }
 
-static void s3c_pm_show_resume_irqs(int start, unsigned long which,
-				    unsigned long mask);
+/* s3c2410_pm_show_resume_irqs
+ *
+ * print any IRQs asserted at resume time (ie, we woke from)
+*/
+static inline void s3c_pm_show_resume_irqs(int start, unsigned long which,
+					   unsigned long mask)
+{
+	int i;
+
+	which &= ~mask;
+
+	for (i = 0; i <= 31; i++) {
+		if (which & (1L<<i)) {
+			S3C_PMDBG("IRQ %d asserted@resume\n", start+i);
+		}
+	}
+}
 
 static inline void s3c_pm_arch_show_resume_irqs(void)
 {
diff --git a/arch/arm/plat-samsung/pm-debug.c b/arch/arm/plat-samsung/pm-debug.c
index 39609601f407..64e15da33b42 100644
--- a/arch/arm/plat-samsung/pm-debug.c
+++ b/arch/arm/plat-samsung/pm-debug.c
@@ -23,6 +23,7 @@
 #include <plat/pm-common.h>
 
 #ifdef CONFIG_SAMSUNG_ATAGS
+#include <plat/pm.h>
 #include <mach/pm-core.h>
 #else
 static inline void s3c_pm_debug_init_uart(void) {}
diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index f8c0f9797dcf..82777c649774 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -65,26 +65,6 @@ int s3c_irqext_wake(struct irq_data *data, unsigned int state)
 	return 0;
 }
 
-/* s3c2410_pm_show_resume_irqs
- *
- * print any IRQs asserted at resume time (ie, we woke from)
-*/
-static void __maybe_unused s3c_pm_show_resume_irqs(int start,
-						   unsigned long which,
-						   unsigned long mask)
-{
-	int i;
-
-	which &= ~mask;
-
-	for (i = 0; i <= 31; i++) {
-		if (which & (1L<<i)) {
-			S3C_PMDBG("IRQ %d asserted@resume\n", start+i);
-		}
-	}
-}
-
-
 void (*pm_cpu_prep)(void);
 int (*pm_cpu_sleep)(unsigned long);
 
-- 
2.1.0.rc2
