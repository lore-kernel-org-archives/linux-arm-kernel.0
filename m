From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 15 Feb 2011 10:15:09 +0100
Subject: [PATCH] ARM: Samsung: change suspend/resume code to depend on
	CONFIG_SUSPEND
Message-ID: <1297761309-12801-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most suspend/resume code depends on CONFIG_PM. This causes problems
if one wants to enable Runtime PM (to control power domains for example),
but doesn't need system suspend/resume feature. This also enables to use
Runtime PM feature on S5PV310 which doesn't implement system suspend/resume
callbacks yet.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s3c2410/mach-bast.c              |    2 +-
 arch/arm/mach-s3c2412/mach-jive.c              |    2 +-
 arch/arm/mach-s3c2440/mach-osiris.c            |    2 +-
 arch/arm/mach-s3c2440/s3c244x.c                |    2 +-
 arch/arm/mach-s3c64xx/Makefile                 |    6 +++---
 arch/arm/mach-s5pv210/cpufreq.c                |    4 ++--
 arch/arm/mach-s5pv310/cpufreq.c                |    4 ++--
 arch/arm/mach-s5pv310/irq-eint.c               |    2 +-
 arch/arm/plat-s3c24xx/Makefile                 |    6 +++---
 arch/arm/plat-s3c24xx/cpu-freq.c               |    2 +-
 arch/arm/plat-s3c24xx/dma.c                    |    2 +-
 arch/arm/plat-s3c24xx/include/plat/irq.h       |    2 +-
 arch/arm/plat-s5p/Makefile                     |    4 ++--
 arch/arm/plat-s5p/irq-eint.c                   |    4 ++--
 arch/arm/plat-samsung/Makefile                 |    4 ++--
 arch/arm/plat-samsung/adc.c                    |    2 +-
 arch/arm/plat-samsung/gpio.c                   |    2 +-
 arch/arm/plat-samsung/include/plat/gpio-core.h |    6 +++---
 arch/arm/plat-samsung/include/plat/pm.h        |    4 ++--
 arch/arm/plat-samsung/pwm.c                    |    2 +-
 20 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-bast.c b/arch/arm/mach-s3c2410/mach-bast.c
index 2970ea9..18187a4 100644
--- a/arch/arm/mach-s3c2410/mach-bast.c
+++ b/arch/arm/mach-s3c2410/mach-bast.c
@@ -213,7 +213,7 @@ static struct s3c2410_uartcfg bast_uartcfgs[] __initdata = {
 
 /* NAND Flash on BAST board */
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_SUSPEND
 static int bast_pm_suspend(struct sys_device *sd, pm_message_t state)
 {
 	/* ensure that an nRESET is not generated on resume. */
diff --git a/arch/arm/mach-s3c2412/mach-jive.c b/arch/arm/mach-s3c2412/mach-jive.c
index 923e01b..10643ef8 100644
--- a/arch/arm/mach-s3c2412/mach-jive.c
+++ b/arch/arm/mach-s3c2412/mach-jive.c
@@ -485,7 +485,7 @@ static struct s3c2410_udc_mach_info jive_udc_cfg __initdata = {
 
 /* Jive power management device */
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_SUSPEND
 static int jive_pm_suspend(struct sys_device *sd, pm_message_t state)
 {
 	/* Write the magic value u-boot uses to check for resume into
diff --git a/arch/arm/mach-s3c2440/mach-osiris.c b/arch/arm/mach-s3c2440/mach-osiris.c
index 14dc678..06d115a 100644
--- a/arch/arm/mach-s3c2440/mach-osiris.c
+++ b/arch/arm/mach-s3c2440/mach-osiris.c
@@ -281,7 +281,7 @@ static struct platform_device osiris_pcmcia = {
 
 /* Osiris power management device */
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_SUSPEND
 static unsigned char pm_osiris_ctrl0;
 
 static int osiris_pm_suspend(struct sys_device *sd, pm_message_t state)
diff --git a/arch/arm/mach-s3c2440/s3c244x.c b/arch/arm/mach-s3c2440/s3c244x.c
index 90c1707..7e693a0 100644
--- a/arch/arm/mach-s3c2440/s3c244x.c
+++ b/arch/arm/mach-s3c2440/s3c244x.c
@@ -134,7 +134,7 @@ void __init s3c244x_init_clocks(int xtal)
 	s3c2410_baseclk_add();
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_SUSPEND
 
 static struct sleep_save s3c244x_sleep[] = {
 	SAVE_ITEM(S3C2440_DSC0),
diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index 4657363..183ebb3 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -43,9 +43,9 @@ obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
 
 # PM
 
-obj-$(CONFIG_PM)		+= pm.o
-obj-$(CONFIG_PM)		+= sleep.o
-obj-$(CONFIG_PM)		+= irq-pm.o
+obj-$(CONFIG_SUSPEND)		+= pm.o
+obj-$(CONFIG_SUSPEND)		+= sleep.o
+obj-$(CONFIG_SUSPEND)		+= irq-pm.o
 
 # Machine support
 
diff --git a/arch/arm/mach-s5pv210/cpufreq.c b/arch/arm/mach-s5pv210/cpufreq.c
index a6f2292..7e697cd 100644
--- a/arch/arm/mach-s5pv210/cpufreq.c
+++ b/arch/arm/mach-s5pv210/cpufreq.c
@@ -389,7 +389,7 @@ static int s5pv210_target(struct cpufreq_policy *policy,
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_SUSPEND
 static int s5pv210_cpufreq_suspend(struct cpufreq_policy *policy,
 				   pm_message_t pmsg)
 {
@@ -470,7 +470,7 @@ static struct cpufreq_driver s5pv210_driver = {
 	.get		= s5pv210_getspeed,
 	.init		= s5pv210_cpu_init,
 	.name		= "s5pv210",
-#ifdef CONFIG_PM
+#ifdef CONFIG_SUSPEND
 	.suspend	= s5pv210_cpufreq_suspend,
 	.resume		= s5pv210_cpufreq_resume,
 #endif
diff --git a/arch/arm/mach-s5pv310/cpufreq.c b/arch/arm/mach-s5pv310/cpufreq.c
index b04cbc7..8493b6d 100644
--- a/arch/arm/mach-s5pv310/cpufreq.c
+++ b/arch/arm/mach-s5pv310/cpufreq.c
@@ -457,7 +457,7 @@ static int s5pv310_target(struct cpufreq_policy *policy,
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_SUSPEND
 static int s5pv310_cpufreq_suspend(struct cpufreq_policy *policy,
 				   pm_message_t pmsg)
 {
@@ -497,7 +497,7 @@ static struct cpufreq_driver s5pv310_driver = {
 	.get		= s5pv310_getspeed,
 	.init		= s5pv310_cpufreq_cpu_init,
 	.name		= "s5pv310_cpufreq",
-#ifdef CONFIG_PM
+#ifdef CONFIG_SUSPEND
 	.suspend	= s5pv310_cpufreq_suspend,
 	.resume		= s5pv310_cpufreq_resume,
 #endif
diff --git a/arch/arm/mach-s5pv310/irq-eint.c b/arch/arm/mach-s5pv310/irq-eint.c
index 477bd9e..39c7f7b 100644
--- a/arch/arm/mach-s5pv310/irq-eint.c
+++ b/arch/arm/mach-s5pv310/irq-eint.c
@@ -152,7 +152,7 @@ static struct irq_chip s5pv310_irq_eint = {
 	.irq_mask_ack	= s5pv310_irq_eint_maskack,
 	.irq_ack	= s5pv310_irq_eint_ack,
 	.irq_set_type	= s5pv310_irq_eint_set_type,
-#ifdef CONFIG_PM
+#ifdef CONFIG_SUSPEND
 	.irq_set_wake	= s3c_irqext_wake,
 #endif
 };
diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
index c2064c3..763b7bb 100644
--- a/arch/arm/plat-s3c24xx/Makefile
+++ b/arch/arm/plat-s3c24xx/Makefile
@@ -26,9 +26,9 @@ obj-$(CONFIG_CPU_FREQ_S3C24XX_DEBUGFS) += cpu-freq-debugfs.o
 # Architecture dependant builds
 
 obj-$(CONFIG_PM_SIMTEC)		+= pm-simtec.o
-obj-$(CONFIG_PM)		+= pm.o
-obj-$(CONFIG_PM)		+= irq-pm.o
-obj-$(CONFIG_PM)		+= sleep.o
+obj-$(CONFIG_SUSPEND)		+= pm.o
+obj-$(CONFIG_SUSPEND)		+= irq-pm.o
+obj-$(CONFIG_SUSPEND)		+= sleep.o
 obj-$(CONFIG_S3C2410_CLOCK)	+= s3c2410-clock.o
 obj-$(CONFIG_S3C2443_CLOCK)	+= s3c2443-clock.o
 obj-$(CONFIG_S3C2410_DMA)	+= dma.o
diff --git a/arch/arm/plat-s3c24xx/cpu-freq.c b/arch/arm/plat-s3c24xx/cpu-freq.c
index 25a8fc7..1d38db5 100644
--- a/arch/arm/plat-s3c24xx/cpu-freq.c
+++ b/arch/arm/plat-s3c24xx/cpu-freq.c
@@ -429,7 +429,7 @@ static int s3c_cpufreq_verify(struct cpufreq_policy *policy)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_SUSPEND
 static struct cpufreq_frequency_table suspend_pll;
 static unsigned int suspend_freq;
 
diff --git a/arch/arm/plat-s3c24xx/dma.c b/arch/arm/plat-s3c24xx/dma.c
index 6ad274e..6199b6e 100644
--- a/arch/arm/plat-s3c24xx/dma.c
+++ b/arch/arm/plat-s3c24xx/dma.c
@@ -1202,7 +1202,7 @@ static inline struct s3c2410_dma_chan *to_dma_chan(struct sys_device *dev)
 
 /* system device class */
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_SUSPEND
 
 static int s3c2410_dma_suspend(struct sys_device *dev, pm_message_t state)
 {
diff --git a/arch/arm/plat-s3c24xx/include/plat/irq.h b/arch/arm/plat-s3c24xx/include/plat/irq.h
index ec087d6..ca6354f 100644
--- a/arch/arm/plat-s3c24xx/include/plat/irq.h
+++ b/arch/arm/plat-s3c24xx/include/plat/irq.h
@@ -106,7 +106,7 @@ s3c_irqsub_ack(unsigned int irqno, unsigned int parentmask, unsigned int group)
 
 /* exported for use in arch/arm/mach-s3c2410 */
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_SUSPEND
 extern int s3c_irq_wake(struct irq_data *data, unsigned int state);
 #else
 #define s3c_irq_wake NULL
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index 4bd5cf9..ce5a0a7 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -20,8 +20,8 @@ obj-y				+= irq.o
 obj-$(CONFIG_S5P_EXT_INT)	+= irq-eint.o
 obj-$(CONFIG_S5P_GPIO_INT)	+= irq-gpioint.o
 obj-$(CONFIG_S5P_SYSTEM_MMU)	+= sysmmu.o
-obj-$(CONFIG_PM)		+= pm.o
-obj-$(CONFIG_PM)		+= irq-pm.o
+obj-$(CONFIG_SUSPEND)		+= pm.o
+obj-$(CONFIG_SUSPEND)		+= irq-pm.o
 
 # devices
 
diff --git a/arch/arm/plat-s5p/irq-eint.c b/arch/arm/plat-s5p/irq-eint.c
index 225aa25..e203a65 100644
--- a/arch/arm/plat-s5p/irq-eint.c
+++ b/arch/arm/plat-s5p/irq-eint.c
@@ -125,7 +125,7 @@ static struct irq_chip s5p_irq_eint = {
 	.irq_mask_ack	= s5p_irq_eint_maskack,
 	.irq_ack	= s5p_irq_eint_ack,
 	.irq_set_type	= s5p_irq_eint_set_type,
-#ifdef CONFIG_PM
+#ifdef CONFIG_SUSPEND
 	.irq_set_wake	= s3c_irqext_wake,
 #endif
 };
@@ -195,7 +195,7 @@ static struct irq_chip s5p_irq_vic_eint = {
 	.irq_mask_ack	= s5p_irq_vic_eint_maskack,
 	.irq_ack	= s5p_irq_vic_eint_ack,
 	.irq_set_type	= s5p_irq_eint_set_type,
-#ifdef CONFIG_PM
+#ifdef CONFIG_SUSPEND
 	.irq_set_wake	= s3c_irqext_wake,
 #endif
 };
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 29932f8..7e92457 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -68,8 +68,8 @@ obj-$(CONFIG_S3C_PL330_DMA)	+= s3c-pl330.o
 
 # PM support
 
-obj-$(CONFIG_PM)		+= pm.o
-obj-$(CONFIG_PM)		+= pm-gpio.o
+obj-$(CONFIG_SUSPEND)		+= pm.o
+obj-$(CONFIG_SUSPEND)		+= pm-gpio.o
 obj-$(CONFIG_SAMSUNG_PM_CHECK)	+= pm-check.o
 
 obj-$(CONFIG_SAMSUNG_WAKEMASK)	+= wakeup-mask.o
diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index e8f2be2..d818405 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -412,7 +412,7 @@ static int __devexit s3c_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_SUSPEND
 static int s3c_adc_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct adc_device *adc = platform_get_drvdata(pdev);
diff --git a/arch/arm/plat-samsung/gpio.c b/arch/arm/plat-samsung/gpio.c
index 7743c4b..4f3700f 100644
--- a/arch/arm/plat-samsung/gpio.c
+++ b/arch/arm/plat-samsung/gpio.c
@@ -143,7 +143,7 @@ __init void s3c_gpiolib_add(struct s3c_gpio_chip *chip)
 	if (!gc->get)
 		gc->get = s3c_gpiolib_get;
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_SUSPEND
 	if (chip->pm != NULL) {
 		if (!chip->pm->save || !chip->pm->resume)
 			printk(KERN_ERR "gpio: %s has missing PM functions\n",
diff --git a/arch/arm/plat-samsung/include/plat/gpio-core.h b/arch/arm/plat-samsung/include/plat/gpio-core.h
index dac35d0..8b5209b 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-core.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-core.h
@@ -68,7 +68,7 @@ struct s3c_gpio_chip {
 	int			irq_base;
 	int			group;
 	spinlock_t		 lock;
-#ifdef CONFIG_PM
+#ifdef CONFIG_SUSPEND
 	u32			pm_save[4];
 #endif
 };
@@ -153,7 +153,7 @@ static inline struct s3c_gpio_chip *s3c_gpiolib_getchip(unsigned int chip)
 static inline void s3c_gpiolib_track(struct s3c_gpio_chip *chip) { }
 #endif
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_SUSPEND
 extern struct s3c_gpio_pm s3c_gpio_pm_1bit;
 extern struct s3c_gpio_pm s3c_gpio_pm_2bit;
 extern struct s3c_gpio_pm s3c_gpio_pm_4bit;
@@ -164,7 +164,7 @@ extern struct s3c_gpio_pm s3c_gpio_pm_4bit;
 #define s3c_gpio_pm_4bit NULL
 #define __gpio_pm(x) NULL
 
-#endif /* CONFIG_PM */
+#endif /* CONFIG_SUSPEND */
 
 /* locking wrappers to deal with multiple access to the same gpio bank */
 #define s3c_gpio_lock(_oc, _fl) spin_lock_irqsave(&(_oc)->lock, _fl)
diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-samsung/include/plat/pm.h
index 30518cc..69f4cc8 100644
--- a/arch/arm/plat-samsung/include/plat/pm.h
+++ b/arch/arm/plat-samsung/include/plat/pm.h
@@ -19,7 +19,7 @@
 
 struct sys_device;
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_SUSPEND
 
 extern __init int s3c_pm_init(void);
 
@@ -103,7 +103,7 @@ extern void s3c_pm_do_save(struct sleep_save *ptr, int count);
 extern void s3c_pm_do_restore(struct sleep_save *ptr, int count);
 extern void s3c_pm_do_restore_core(struct sleep_save *ptr, int count);
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_SUSPEND
 extern int s3c_irqext_wake(struct irq_data *data, unsigned int state);
 extern int s3c24xx_irq_suspend(struct sys_device *dev, pm_message_t state);
 extern int s3c24xx_irq_resume(struct sys_device *dev);
diff --git a/arch/arm/plat-samsung/pwm.c b/arch/arm/plat-samsung/pwm.c
index 2eeb49f..926f08d 100644
--- a/arch/arm/plat-samsung/pwm.c
+++ b/arch/arm/plat-samsung/pwm.c
@@ -380,7 +380,7 @@ static int __devexit s3c_pwm_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_SUSPEND
 static int s3c_pwm_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct pwm_device *pwm = platform_get_drvdata(pdev);
-- 
1.7.1.569.g6f426
