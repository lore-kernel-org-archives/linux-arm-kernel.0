From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 06 Feb 2014 20:12:48 +0100
Subject: [PATCH v2 03/12] ARM: SAMSUNG: pm: Save UART DIVSLOT register based on
 SoC type
In-Reply-To: <1391713977-22300-1-git-send-email-t.figa@samsung.com>
References: <1391713977-22300-1-git-send-email-t.figa@samsung.com>
Message-ID: <1391713977-22300-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only SoC that does not have DIVSLOT register is S3C2410, so instead
of exporting a variable for platforms to set if DIVSLOT register should
be preserved, it's enough to simply check whether we are running on
a S3C2410 instead.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s3c64xx/pm.c              |  1 -
 arch/arm/mach-s5p64x0/pm.c              |  1 -
 arch/arm/plat-samsung/include/plat/pm.h |  2 --
 arch/arm/plat-samsung/pm.c              | 18 +++++-------------
 4 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index b5a6698..6b37694 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -332,7 +332,6 @@ static __init int s3c64xx_pm_initcall(void)
 {
 	pm_cpu_prep = s3c64xx_pm_prepare;
 	pm_cpu_sleep = s3c64xx_cpu_suspend;
-	pm_uart_udivslot = 1;
 
 #ifdef CONFIG_S3C_PM_DEBUG_LED_SMDK
 	gpio_request(S3C64XX_GPN(12), "DEBUG_LED0");
diff --git a/arch/arm/mach-s5p64x0/pm.c b/arch/arm/mach-s5p64x0/pm.c
index 861e15c..ec8229c 100644
--- a/arch/arm/mach-s5p64x0/pm.c
+++ b/arch/arm/mach-s5p64x0/pm.c
@@ -161,7 +161,6 @@ static int s5p64x0_pm_add(struct device *dev, struct subsys_interface *sif)
 {
 	pm_cpu_prep = s5p64x0_pm_prepare;
 	pm_cpu_sleep = s5p64x0_cpu_suspend;
-	pm_uart_udivslot = 1;
 
 	return 0;
 }
diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-samsung/include/plat/pm.h
index ff6063f..21758c6 100644
--- a/arch/arm/plat-samsung/include/plat/pm.h
+++ b/arch/arm/plat-samsung/include/plat/pm.h
@@ -54,8 +54,6 @@ extern int (*pm_cpu_sleep)(unsigned long);
 
 extern unsigned long s3c_pm_flags;
 
-extern unsigned char pm_uart_udivslot;  /* true to save UART UDIVSLOT */
-
 /* from sleep.S */
 
 extern int s3c2410_cpu_suspend(unsigned long);
diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index e5b0f2c..5d9daf6 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -23,6 +23,7 @@
 #include <asm/cacheflush.h>
 #include <asm/suspend.h>
 
+#include <plat/cpu.h>
 #include <plat/regs-serial.h>
 
 #ifdef CONFIG_SAMSUNG_ATAGS
@@ -71,17 +72,6 @@ static inline void s3c_pm_debug_init(void)
 	s3c_pm_debug_init_uart();
 }
 
-#else
-#define s3c_pm_debug_init() do { } while(0)
-
-#endif /* CONFIG_SAMSUNG_PM_DEBUG */
-
-/* Save the UART configurations if we are configured for debug. */
-
-unsigned char pm_uart_udivslot;
-
-#ifdef CONFIG_SAMSUNG_PM_DEBUG
-
 static struct pm_uart_save uart_save;
 
 static void s3c_pm_save_uart(unsigned int uart, struct pm_uart_save *save)
@@ -94,7 +84,7 @@ static void s3c_pm_save_uart(unsigned int uart, struct pm_uart_save *save)
 	save->umcon = __raw_readl(regs + S3C2410_UMCON);
 	save->ubrdiv = __raw_readl(regs + S3C2410_UBRDIV);
 
-	if (pm_uart_udivslot)
+	if (!soc_is_s3c2410())
 		save->udivslot = __raw_readl(regs + S3C2443_DIVSLOT);
 
 	S3C_PMDBG("UART[%d]: ULCON=%04x, UCON=%04x, UFCON=%04x, UBRDIV=%04x\n",
@@ -118,7 +108,7 @@ static void s3c_pm_restore_uart(unsigned int uart, struct pm_uart_save *save)
 	__raw_writel(save->umcon, regs + S3C2410_UMCON);
 	__raw_writel(save->ubrdiv, regs + S3C2410_UBRDIV);
 
-	if (pm_uart_udivslot)
+	if (!soc_is_s3c2410())
 		__raw_writel(save->udivslot, regs + S3C2443_DIVSLOT);
 }
 
@@ -127,6 +117,8 @@ static void s3c_pm_restore_uarts(void)
 	s3c_pm_restore_uart(CONFIG_DEBUG_S3C_UART, &uart_save);
 }
 #else
+#define s3c_pm_debug_init() do { } while (0)
+
 static void s3c_pm_save_uarts(void) { }
 static void s3c_pm_restore_uarts(void) { }
 #endif
-- 
1.8.5.2
