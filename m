From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Feb 2015 20:35:42 +0100
Subject: [PATCH 5/9] ARM: s3c24xx: fix building without PM_SLEEP
In-Reply-To: <1423769746-582629-1-git-send-email-arnd@arndb.de>
References: <1423769746-582629-1-git-send-email-arnd@arndb.de>
Message-ID: <1423769746-582629-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We get lots of link errors based on the assumption that
any s3c24xx kernel would enable CONFIG_PM_SLEEP if it
enables CONFIG_PM. This tries to clean that up.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c24xx/Kconfig           |  8 ++++----
 arch/arm/mach-s3c24xx/Makefile          |  3 ++-
 arch/arm/mach-s3c24xx/pm-s3c2416.c      |  3 ++-
 arch/arm/mach-s3c24xx/pm.c              |  6 ++++--
 arch/arm/mach-s3c24xx/s3c2410.c         |  2 +-
 arch/arm/mach-s3c24xx/s3c2412.c         |  2 +-
 arch/arm/mach-s3c24xx/s3c2416.c         |  2 +-
 arch/arm/mach-s3c24xx/s3c2440.c         |  4 ++--
 arch/arm/mach-s3c24xx/s3c2442.c         |  4 ++--
 arch/arm/mach-s3c24xx/s3c244x.c         |  7 ++-----
 arch/arm/plat-samsung/include/plat/pm.h | 12 ++++++++++--
 11 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 389173690716..a6d3b5bcc4c2 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -39,14 +39,14 @@ config CPU_S3C2412
 	bool "SAMSUNG S3C2412"
 	select CPU_ARM926T
 	select S3C2412_COMMON_CLK
-	select S3C2412_PM if PM
+	select S3C2412_PM if PM_SLEEP
 	help
 	  Support for the S3C2412 and S3C2413 SoCs from the S3C24XX line
 
 config CPU_S3C2416
 	bool "SAMSUNG S3C2416/S3C2450"
 	select CPU_ARM926T
-	select S3C2416_PM if PM
+	select S3C2416_PM if PM_SLEEP
 	select S3C2443_COMMON_CLK
 	help
 	  Support for the S3C2416 SoC from the S3C24XX line
@@ -55,7 +55,7 @@ config CPU_S3C2440
 	bool "SAMSUNG S3C2440"
 	select CPU_ARM920T
 	select S3C2410_COMMON_CLK
-	select S3C2410_PM if PM
+	select S3C2410_PM if PM_SLEEP
 	help
 	  Support for S3C2440 Samsung Mobile CPU based systems.
 
@@ -63,7 +63,7 @@ config CPU_S3C2442
 	bool "SAMSUNG S3C2442"
 	select CPU_ARM920T
 	select S3C2410_COMMON_CLK
-	select S3C2410_PM if PM
+	select S3C2410_PM if PM_SLEEP
 	help
 	  Support for S3C2442 Samsung Mobile CPU based systems.
 
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index b40a22fe082a..05920c8a5764 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -32,7 +32,8 @@ obj-$(CONFIG_CPU_S3C2443)	+= s3c2443.o
 
 # PM
 
-obj-$(CONFIG_PM)		+= pm.o irq-pm.o sleep.o
+obj-$(CONFIG_PM)		+= pm.o
+obj-$(CONFIG_PM_SLEEP)		+= irq-pm.o sleep.o
 
 # common code
 
diff --git a/arch/arm/mach-s3c24xx/pm-s3c2416.c b/arch/arm/mach-s3c24xx/pm-s3c2416.c
index 44923895f558..c0e328e37bd6 100644
--- a/arch/arm/mach-s3c24xx/pm-s3c2416.c
+++ b/arch/arm/mach-s3c24xx/pm-s3c2416.c
@@ -23,6 +23,7 @@
 
 #include "s3c2412-power.h"
 
+#ifdef CONFIG_PM_SLEEP
 extern void s3c2412_sleep_enter(void);
 
 static int s3c2416_cpu_suspend(unsigned long arg)
@@ -70,7 +71,7 @@ static __init int s3c2416_pm_init(void)
 }
 
 arch_initcall(s3c2416_pm_init);
-
+#endif
 
 static void s3c2416_pm_resume(void)
 {
diff --git a/arch/arm/mach-s3c24xx/pm.c b/arch/arm/mach-s3c24xx/pm.c
index b19256ec8d40..5d510bca0844 100644
--- a/arch/arm/mach-s3c24xx/pm.c
+++ b/arch/arm/mach-s3c24xx/pm.c
@@ -50,6 +50,7 @@
 
 #define PFX "s3c24xx-pm: "
 
+#ifdef CONFIG_PM_SLEEP
 static struct sleep_save core_save[] = {
 	/* we restore the timings here, with the proviso that the board
 	 * brings the system up in an slower, or equal frequency setting
@@ -67,6 +68,7 @@ static struct sleep_save core_save[] = {
 	SAVE_ITEM(S3C2410_BANKCON4),
 	SAVE_ITEM(S3C2410_BANKCON5),
 };
+#endif
 
 /* s3c_pm_check_resume_pin
  *
@@ -121,7 +123,7 @@ void s3c_pm_configure_extint(void)
 	}
 }
 
-
+#ifdef CONFIG_PM_SLEEP
 void s3c_pm_restore_core(void)
 {
 	s3c_pm_do_restore_core(core_save, ARRAY_SIZE(core_save));
@@ -131,4 +133,4 @@ void s3c_pm_save_core(void)
 {
 	s3c_pm_do_save(core_save, ARRAY_SIZE(core_save));
 }
-
+#endif
diff --git a/arch/arm/mach-s3c24xx/s3c2410.c b/arch/arm/mach-s3c24xx/s3c2410.c
index 2a6985a4a0ff..5061d66ca10c 100644
--- a/arch/arm/mach-s3c24xx/s3c2410.c
+++ b/arch/arm/mach-s3c24xx/s3c2410.c
@@ -121,7 +121,7 @@ int __init s3c2410_init(void)
 {
 	printk("S3C2410: Initialising architecture\n");
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	register_syscore_ops(&s3c2410_pm_syscore_ops);
 	register_syscore_ops(&s3c24xx_irq_syscore_ops);
 #endif
diff --git a/arch/arm/mach-s3c24xx/s3c2412.c b/arch/arm/mach-s3c24xx/s3c2412.c
index ecf2c77ab88b..64a13605cfc3 100644
--- a/arch/arm/mach-s3c24xx/s3c2412.c
+++ b/arch/arm/mach-s3c24xx/s3c2412.c
@@ -172,7 +172,7 @@ int __init s3c2412_init(void)
 {
 	printk("S3C2412: Initialising architecture\n");
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	register_syscore_ops(&s3c2412_pm_syscore_ops);
 	register_syscore_ops(&s3c24xx_irq_syscore_ops);
 #endif
diff --git a/arch/arm/mach-s3c24xx/s3c2416.c b/arch/arm/mach-s3c24xx/s3c2416.c
index bfd4da86deb8..3f8ca2a3ef17 100644
--- a/arch/arm/mach-s3c24xx/s3c2416.c
+++ b/arch/arm/mach-s3c24xx/s3c2416.c
@@ -98,7 +98,7 @@ int __init s3c2416_init(void)
 	s3c_adc_setname("s3c2416-adc");
 	s3c_rtc_setname("s3c2416-rtc");
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	register_syscore_ops(&s3c2416_pm_syscore_ops);
 	register_syscore_ops(&s3c24xx_irq_syscore_ops);
 	register_syscore_ops(&s3c2416_irq_syscore_ops);
diff --git a/arch/arm/mach-s3c24xx/s3c2440.c b/arch/arm/mach-s3c24xx/s3c2440.c
index 03d379f1fc52..eb733555fab5 100644
--- a/arch/arm/mach-s3c24xx/s3c2440.c
+++ b/arch/arm/mach-s3c24xx/s3c2440.c
@@ -57,11 +57,11 @@ int __init s3c2440_init(void)
 
 	/* register suspend/resume handlers */
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	register_syscore_ops(&s3c2410_pm_syscore_ops);
 	register_syscore_ops(&s3c24xx_irq_syscore_ops);
-#endif
 	register_syscore_ops(&s3c244x_pm_syscore_ops);
+#endif
 
 	/* register our system device for everything else */
 
diff --git a/arch/arm/mach-s3c24xx/s3c2442.c b/arch/arm/mach-s3c24xx/s3c2442.c
index 7b043349f1c8..893998ede022 100644
--- a/arch/arm/mach-s3c24xx/s3c2442.c
+++ b/arch/arm/mach-s3c24xx/s3c2442.c
@@ -60,11 +60,11 @@ int __init s3c2442_init(void)
 {
 	printk("S3C2442: Initialising architecture\n");
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	register_syscore_ops(&s3c2410_pm_syscore_ops);
 	register_syscore_ops(&s3c24xx_irq_syscore_ops);
-#endif
 	register_syscore_ops(&s3c244x_pm_syscore_ops);
+#endif
 
 	return device_register(&s3c2442_dev);
 }
diff --git a/arch/arm/mach-s3c24xx/s3c244x.c b/arch/arm/mach-s3c24xx/s3c244x.c
index 177f97802745..b14119585dc7 100644
--- a/arch/arm/mach-s3c24xx/s3c244x.c
+++ b/arch/arm/mach-s3c24xx/s3c244x.c
@@ -108,7 +108,7 @@ static int __init s3c2442_core_init(void)
 core_initcall(s3c2442_core_init);
 
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static struct sleep_save s3c244x_sleep[] = {
 	SAVE_ITEM(S3C2440_DSC0),
 	SAVE_ITEM(S3C2440_DSC1),
@@ -127,12 +127,9 @@ static void s3c244x_resume(void)
 {
 	s3c_pm_do_restore(s3c244x_sleep, ARRAY_SIZE(s3c244x_sleep));
 }
-#else
-#define s3c244x_suspend NULL
-#define s3c244x_resume  NULL
-#endif
 
 struct syscore_ops s3c244x_pm_syscore_ops = {
 	.suspend	= s3c244x_suspend,
 	.resume		= s3c244x_resume,
 };
+#endif
diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-samsung/include/plat/pm.h
index e5a046dc22f5..7f415ce74591 100644
--- a/arch/arm/plat-samsung/include/plat/pm.h
+++ b/arch/arm/plat-samsung/include/plat/pm.h
@@ -43,7 +43,11 @@ extern unsigned long s3c_irqwake_eintmask;
 
 /* IRQ masks for IRQs allowed to go to sleep (see irq.c) */
 extern unsigned long s3c_irqwake_intallow;
+#ifdef CONFIG_PM_SLEEP
 extern unsigned long s3c_irqwake_eintallow;
+#else
+#define s3c_irqwake_eintallow 0
+#endif
 
 /* per-cpu sleep functions */
 
@@ -60,14 +64,18 @@ extern int s3c2410_cpu_suspend(unsigned long);
 
 #ifdef CONFIG_PM_SLEEP
 extern int s3c_irq_wake(struct irq_data *data, unsigned int state);
-extern int s3c_irqext_wake(struct irq_data *data, unsigned int state);
 extern void s3c_cpu_resume(void);
 #else
 #define s3c_irq_wake NULL
-#define s3c_irqext_wake NULL
 #define s3c_cpu_resume NULL
 #endif
 
+#ifdef CONFIG_SAMSUNG_PM
+extern int s3c_irqext_wake(struct irq_data *data, unsigned int state);
+#else
+#define s3c_irqext_wake NULL
+#endif
+
 #ifdef CONFIG_S3C_PM_DEBUG_LED_SMDK
 /**
  * s3c_pm_debug_smdkled() - Debug PM suspend/resume via SMDK Board LEDs
-- 
2.1.0.rc2
