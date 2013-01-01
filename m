From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 1 Jan 2013 22:54:48 +0100
Subject: [PATCH v2 03/11] ARM: S3C24XX: cleanup irq-pm integration
In-Reply-To: <201301012251.15899.heiko@sntech.de>
References: <201301012251.15899.heiko@sntech.de>
Message-ID: <201301012254.49106.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch integrates the irq-pm functions we moved in the previous patch.
This includes some static attributes and the removal of the irq suspend
and resume declaratons from the plat-samsung/pm.h header.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/common.h          |    2 ++
 arch/arm/mach-s3c24xx/s3c2410.c         |    4 +++-
 arch/arm/mach-s3c24xx/s3c2412.c         |    4 +++-
 arch/arm/mach-s3c24xx/s3c2416.c         |    4 +++-
 arch/arm/mach-s3c24xx/s3c2440.c         |    4 +++-
 arch/arm/mach-s3c24xx/s3c2442.c         |    4 +++-
 arch/arm/plat-s3c24xx/irq.c             |   22 +++++++++++-----------
 arch/arm/plat-samsung/include/plat/pm.h |    6 ------
 8 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c24xx/common.h
index c2f596e..ed6276f 100644
--- a/arch/arm/mach-s3c24xx/common.h
+++ b/arch/arm/mach-s3c24xx/common.h
@@ -15,4 +15,6 @@
 void s3c2410_restart(char mode, const char *cmd);
 void s3c244x_restart(char mode, const char *cmd);
 
+extern struct syscore_ops s3c24xx_irq_syscore_ops;
+
 #endif /* __ARCH_ARM_MACH_S3C24XX_COMMON_H */
diff --git a/arch/arm/mach-s3c24xx/s3c2410.c b/arch/arm/mach-s3c24xx/s3c2410.c
index a3c5cb0..9ebef95 100644
--- a/arch/arm/mach-s3c24xx/s3c2410.c
+++ b/arch/arm/mach-s3c24xx/s3c2410.c
@@ -49,6 +49,8 @@
 #include <plat/gpio-cfg.h>
 #include <plat/gpio-cfg-helpers.h>
 
+#include "common.h"
+
 /* Initial IO mappings */
 
 static struct map_desc s3c2410_iodesc[] __initdata = {
@@ -182,8 +184,8 @@ int __init s3c2410_init(void)
 
 #ifdef CONFIG_PM
 	register_syscore_ops(&s3c2410_pm_syscore_ops);
-#endif
 	register_syscore_ops(&s3c24xx_irq_syscore_ops);
+#endif
 
 	return device_register(&s3c2410_dev);
 }
diff --git a/arch/arm/mach-s3c24xx/s3c2412.c b/arch/arm/mach-s3c24xx/s3c2412.c
index 6c5f403..0ec08bd 100644
--- a/arch/arm/mach-s3c24xx/s3c2412.c
+++ b/arch/arm/mach-s3c24xx/s3c2412.c
@@ -51,6 +51,8 @@
 #include <plat/pll.h>
 #include <plat/nand-core.h>
 
+#include "common.h"
+
 #ifndef CONFIG_CPU_S3C2412_ONLY
 void __iomem *s3c24xx_va_gpio2 = S3C24XX_VA_GPIO;
 
@@ -244,8 +246,8 @@ int __init s3c2412_init(void)
 
 #ifdef CONFIG_PM
 	register_syscore_ops(&s3c2412_pm_syscore_ops);
-#endif
 	register_syscore_ops(&s3c24xx_irq_syscore_ops);
+#endif
 
 	return device_register(&s3c2412_dev);
 }
diff --git a/arch/arm/mach-s3c24xx/s3c2416.c b/arch/arm/mach-s3c24xx/s3c2416.c
index 77ee0b7..e30476d 100644
--- a/arch/arm/mach-s3c24xx/s3c2416.c
+++ b/arch/arm/mach-s3c24xx/s3c2416.c
@@ -63,6 +63,8 @@
 #include <plat/rtc-core.h>
 #include <plat/spi-core.h>
 
+#include "common.h"
+
 static struct map_desc s3c2416_iodesc[] __initdata = {
 	IODESC_ENT(WATCHDOG),
 	IODESC_ENT(CLKPWR),
@@ -105,9 +107,9 @@ int __init s3c2416_init(void)
 
 #ifdef CONFIG_PM
 	register_syscore_ops(&s3c2416_pm_syscore_ops);
-#endif
 	register_syscore_ops(&s3c24xx_irq_syscore_ops);
 	register_syscore_ops(&s3c2416_irq_syscore_ops);
+#endif
 
 	return device_register(&s3c2416_dev);
 }
diff --git a/arch/arm/mach-s3c24xx/s3c2440.c b/arch/arm/mach-s3c24xx/s3c2440.c
index 2b3dddb..559e394 100644
--- a/arch/arm/mach-s3c24xx/s3c2440.c
+++ b/arch/arm/mach-s3c24xx/s3c2440.c
@@ -40,6 +40,8 @@
 #include <plat/gpio-cfg.h>
 #include <plat/gpio-cfg-helpers.h>
 
+#include "common.h"
+
 static struct device s3c2440_dev = {
 	.bus		= &s3c2440_subsys,
 };
@@ -57,9 +59,9 @@ int __init s3c2440_init(void)
 
 #ifdef CONFIG_PM
 	register_syscore_ops(&s3c2410_pm_syscore_ops);
+	register_syscore_ops(&s3c24xx_irq_syscore_ops);
 #endif
 	register_syscore_ops(&s3c244x_pm_syscore_ops);
-	register_syscore_ops(&s3c24xx_irq_syscore_ops);
 
 	/* register our system device for everything else */
 
diff --git a/arch/arm/mach-s3c24xx/s3c2442.c b/arch/arm/mach-s3c24xx/s3c2442.c
index 22cb7c9..f732826 100644
--- a/arch/arm/mach-s3c24xx/s3c2442.c
+++ b/arch/arm/mach-s3c24xx/s3c2442.c
@@ -51,6 +51,8 @@
 #include <plat/gpio-cfg.h>
 #include <plat/gpio-cfg-helpers.h>
 
+#include "common.h"
+
 /* S3C2442 extended clock support */
 
 static unsigned long s3c2442_camif_upll_round(struct clk *clk,
@@ -172,9 +174,9 @@ int __init s3c2442_init(void)
 
 #ifdef CONFIG_PM
 	register_syscore_ops(&s3c2410_pm_syscore_ops);
+	register_syscore_ops(&s3c24xx_irq_syscore_ops);
 #endif
 	register_syscore_ops(&s3c244x_pm_syscore_ops);
-	register_syscore_ops(&s3c24xx_irq_syscore_ops);
 
 	return device_register(&s3c2442_dev);
 }
diff --git a/arch/arm/plat-s3c24xx/irq.c b/arch/arm/plat-s3c24xx/irq.c
index 9b4404d..d774c3b 100644
--- a/arch/arm/plat-s3c24xx/irq.c
+++ b/arch/arm/plat-s3c24xx/irq.c
@@ -134,25 +134,25 @@ static inline void s3c_irq_maskack(struct irq_data *data)
 }
 
 #ifdef CONFIG_PM
-/* state for IRQs over sleep */
-
-/* default is to allow for EINT0..EINT15, and IRQ_RTC as wakeup sources
+/* state for IRQs over sleep
  *
+ * default is to allow for EINT0..EINT15, and IRQ_RTC as wakeup sources
  * set bit to 1 in allow bitfield to enable the wakeup settings on it
-*/
+ */
 
-unsigned long s3c_irqwake_intallow	= 1L << (IRQ_RTC - IRQ_EINT0) | 0xfL;
+unsigned long s3c_irqwake_intallow	= 1L << 30 | 0xfL;
 unsigned long s3c_irqwake_eintallow	= 0x0000fff0L;
 
+/* FIXME: must not be static until s3c2412 irqs are included */
 int s3c_irq_wake(struct irq_data *data, unsigned int state)
 {
-	unsigned long irqbit = 1 << (data->irq - IRQ_EINT0);
+	unsigned long irqbit = 1 << data->hwirq;
 
 	if (!(s3c_irqwake_intallow & irqbit))
 		return -ENOENT;
 
-	printk(KERN_INFO "wake %s for irq %d\n",
-	       state ? "enabled" : "disabled", data->irq);
+	pr_info("wake %s for hwirq %lu\n",
+		state ? "enabled" : "disabled", data->hwirq);
 
 	if (!state)
 		s3c_irqwake_intmask |= irqbit;
@@ -635,7 +635,7 @@ static unsigned long save_extint[3];
 static unsigned long save_eintflt[4];
 static unsigned long save_eintmask;
 
-int s3c24xx_irq_suspend(void)
+static int s3c24xx_irq_suspend(void)
 {
 	unsigned int i;
 
@@ -651,7 +651,7 @@ int s3c24xx_irq_suspend(void)
 	return 0;
 }
 
-void s3c24xx_irq_resume(void)
+static void s3c24xx_irq_resume(void)
 {
 	unsigned int i;
 
@@ -664,9 +664,9 @@ void s3c24xx_irq_resume(void)
 	s3c_pm_do_restore(irq_save, ARRAY_SIZE(irq_save));
 	__raw_writel(save_eintmask, S3C24XX_EINTMASK);
 }
-#endif
 
 struct syscore_ops s3c24xx_irq_syscore_ops = {
 	.suspend	= s3c24xx_irq_suspend,
 	.resume		= s3c24xx_irq_resume,
 };
+#endif
diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-samsung/include/plat/pm.h
index 887a0c9..f6fcade 100644
--- a/arch/arm/plat-samsung/include/plat/pm.h
+++ b/arch/arm/plat-samsung/include/plat/pm.h
@@ -109,17 +109,11 @@ extern void s3c_pm_do_restore_core(struct sleep_save *ptr, int count);
 #ifdef CONFIG_PM
 extern int s3c_irq_wake(struct irq_data *data, unsigned int state);
 extern int s3c_irqext_wake(struct irq_data *data, unsigned int state);
-extern int s3c24xx_irq_suspend(void);
-extern void s3c24xx_irq_resume(void);
 #else
 #define s3c_irq_wake NULL
 #define s3c_irqext_wake NULL
-#define s3c24xx_irq_suspend NULL
-#define s3c24xx_irq_resume  NULL
 #endif
 
-extern struct syscore_ops s3c24xx_irq_syscore_ops;
-
 /* PM debug functions */
 
 #ifdef CONFIG_SAMSUNG_PM_DEBUG
-- 
1.7.2.3
