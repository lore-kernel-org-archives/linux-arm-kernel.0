From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 30 Aug 2011 21:27:28 +0900
Subject: [PATCH 6/7] ARM: SAMSUNG: Update the name of regarding Samsung GPIO
In-Reply-To: <1314707249-12241-1-git-send-email-kgene.kim@samsung.com>
References: <1314707249-12241-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1314707249-12241-7-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to gpio-samsung.c, this patch updates the name of
regarding Samsung GPIO. Basically the samsung_xxx prefix is
used in gpio-samsung.c instead of s3c_xxx, because unified
name can reduce its complexity.

Note: some s3c_xxx stil remains because it is used widely.
It will be updated next time.

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/include/mach/pm-core.h       |    2 +-
 arch/arm/mach-s3c2410/include/mach/gpio-fns.h      |   99 +-----------
 arch/arm/mach-s3c2410/include/mach/gpio-track.h    |    6 +-
 arch/arm/mach-s3c2410/include/mach/pm-core.h       |    2 +-
 arch/arm/mach-s3c2410/s3c2410.c                    |    4 +-
 arch/arm/mach-s3c2412/gpio.c                       |    2 +-
 arch/arm/mach-s3c2416/s3c2416.c                    |    4 +-
 arch/arm/mach-s3c2440/s3c2440.c                    |    4 +-
 arch/arm/mach-s3c2440/s3c2442.c                    |    4 +-
 arch/arm/mach-s3c2443/s3c2443.c                    |    4 +-
 arch/arm/mach-s3c64xx/include/mach/pm-core.h       |    2 +-
 arch/arm/mach-s5pv210/include/mach/pm-core.h       |    2 +-
 arch/arm/plat-s5p/irq-gpioint.c                    |   10 +-
 .../plat-samsung/include/plat/gpio-cfg-helpers.h   |  172 +++++---------------
 arch/arm/plat-samsung/include/plat/gpio-cfg.h      |   34 ++--
 arch/arm/plat-samsung/include/plat/gpio-core.h     |   97 +++--------
 arch/arm/plat-samsung/include/plat/gpio-fns.h      |   98 +++++++++++
 arch/arm/plat-samsung/include/plat/pm.h            |   10 +-
 arch/arm/plat-samsung/pm-gpio.c                    |   72 ++++----
 arch/arm/plat-samsung/pm.c                         |    6 +-
 20 files changed, 250 insertions(+), 384 deletions(-)
 create mode 100644 arch/arm/plat-samsung/include/plat/gpio-fns.h

diff --git a/arch/arm/mach-exynos4/include/mach/pm-core.h b/arch/arm/mach-exynos4/include/mach/pm-core.h
index 1df3b81..3499ec7 100644
--- a/arch/arm/mach-exynos4/include/mach/pm-core.h
+++ b/arch/arm/mach-exynos4/include/mach/pm-core.h
@@ -53,7 +53,7 @@ static inline void s3c_pm_restored_gpios(void)
 	/* nothing here yet */
 }
 
-static inline void s3c_pm_saved_gpios(void)
+static inline void samsung_pm_saved_gpios(void)
 {
 	/* nothing here yet */
 }
diff --git a/arch/arm/mach-s3c2410/include/mach/gpio-fns.h b/arch/arm/mach-s3c2410/include/mach/gpio-fns.h
index bab1392..c53ad34 100644
--- a/arch/arm/mach-s3c2410/include/mach/gpio-fns.h
+++ b/arch/arm/mach-s3c2410/include/mach/gpio-fns.h
@@ -1,98 +1 @@
-/* arch/arm/mach-s3c2410/include/mach/gpio-fns.h
- *
- * Copyright (c) 2003-2009 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C2410 - hardware
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __MACH_GPIO_FNS_H
-#define __MACH_GPIO_FNS_H __FILE__
-
-/* These functions are in the to-be-removed category and it is strongly
- * encouraged not to use these in new code. They will be marked deprecated
- * very soon.
- *
- * Most of the functionality can be either replaced by the gpiocfg calls
- * for the s3c platform or by the generic GPIOlib API.
- *
- * As of 2.6.35-rc, these will be removed, with the few drivers using them
- * either replaced or given a wrapper until the calls can be removed.
-*/
-
-#include <plat/gpio-cfg.h>
-
-static inline void s3c2410_gpio_cfgpin(unsigned int pin, unsigned int cfg)
-{
-	/* 1:1 mapping between cfgpin and setcfg calls at the moment */
-	s3c_gpio_cfgpin(pin, cfg);
-}
-
-/* external functions for GPIO support
- *
- * These allow various different clients to access the same GPIO
- * registers without conflicting. If your driver only owns the entire
- * GPIO register, then it is safe to ioremap/__raw_{read|write} to it.
-*/
-
-extern unsigned int s3c2410_gpio_getcfg(unsigned int pin);
-
-/* s3c2410_gpio_getirq
- *
- * turn the given pin number into the corresponding IRQ number
- *
- * returns:
- *	< 0 = no interrupt for this pin
- *	>=0 = interrupt number for the pin
-*/
-
-extern int s3c2410_gpio_getirq(unsigned int pin);
-
-/* s3c2410_gpio_irqfilter
- *
- * set the irq filtering on the given pin
- *
- * on = 0 => disable filtering
- *      1 => enable filtering
- *
- * config = S3C2410_EINTFLT_PCLK or S3C2410_EINTFLT_EXTCLK orred with
- *          width of filter (0 through 63)
- *
- *
-*/
-
-extern int s3c2410_gpio_irqfilter(unsigned int pin, unsigned int on,
-				  unsigned int config);
-
-/* s3c2410_gpio_pullup
- *
- * This call should be replaced with s3c_gpio_setpull().
- *
- * As a note, there is currently no distinction between pull-up and pull-down
- * in the s3c24xx series devices with only an on/off configuration.
- */
-
-/* s3c2410_gpio_pullup
- *
- * configure the pull-up control on the given pin
- *
- * to = 1 => disable the pull-up
- *      0 => enable the pull-up
- *
- * eg;
- *
- *   s3c2410_gpio_pullup(S3C2410_GPB(0), 0);
- *   s3c2410_gpio_pullup(S3C2410_GPE(8), 0);
-*/
-
-extern void s3c2410_gpio_pullup(unsigned int pin, unsigned int to);
-
-extern void s3c2410_gpio_setpin(unsigned int pin, unsigned int to);
-
-extern unsigned int s3c2410_gpio_getpin(unsigned int pin);
-
-#endif /* __MACH_GPIO_FNS_H */
+#include <plat/gpio-fns.h>
diff --git a/arch/arm/mach-s3c2410/include/mach/gpio-track.h b/arch/arm/mach-s3c2410/include/mach/gpio-track.h
index d67819d..c410a07 100644
--- a/arch/arm/mach-s3c2410/include/mach/gpio-track.h
+++ b/arch/arm/mach-s3c2410/include/mach/gpio-track.h
@@ -17,11 +17,11 @@
 
 #include <mach/regs-gpio.h>
 
-extern struct s3c_gpio_chip s3c24xx_gpios[];
+extern struct samsung_gpio_chip s3c24xx_gpios[];
 
-static inline struct s3c_gpio_chip *s3c_gpiolib_getchip(unsigned int pin)
+static inline struct samsung_gpio_chip *samsung_gpiolib_getchip(unsigned int pin)
 {
-	struct s3c_gpio_chip *chip;
+	struct samsung_gpio_chip *chip;
 
 	if (pin > S3C_GPIO_END)
 		return NULL;
diff --git a/arch/arm/mach-s3c2410/include/mach/pm-core.h b/arch/arm/mach-s3c2410/include/mach/pm-core.h
index 45eea52..2eef7e6 100644
--- a/arch/arm/mach-s3c2410/include/mach/pm-core.h
+++ b/arch/arm/mach-s3c2410/include/mach/pm-core.h
@@ -64,4 +64,4 @@ static inline void s3c_pm_arch_update_uart(void __iomem *regs,
 }
 
 static inline void s3c_pm_restored_gpios(void) { }
-static inline void s3c_pm_saved_gpios(void) { }
+static inline void samsung_pm_saved_gpios(void) { }
diff --git a/arch/arm/mach-s3c2410/s3c2410.c b/arch/arm/mach-s3c2410/s3c2410.c
index f1d3bd8..a99c2f4 100644
--- a/arch/arm/mach-s3c2410/s3c2410.c
+++ b/arch/arm/mach-s3c2410/s3c2410.c
@@ -72,8 +72,8 @@ void __init s3c2410_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 
 void __init s3c2410_map_io(void)
 {
-	s3c24xx_gpiocfg_default.set_pull = s3c_gpio_setpull_1up;
-	s3c24xx_gpiocfg_default.get_pull = s3c_gpio_getpull_1up;
+	s3c24xx_gpiocfg_default.set_pull = s3c24xx_gpio_setpull_1up;
+	s3c24xx_gpiocfg_default.get_pull = s3c24xx_gpio_getpull_1up;
 
 	iotable_init(s3c2410_iodesc, ARRAY_SIZE(s3c2410_iodesc));
 }
diff --git a/arch/arm/mach-s3c2412/gpio.c b/arch/arm/mach-s3c2412/gpio.c
index 3404a87..4526f6b 100644
--- a/arch/arm/mach-s3c2412/gpio.c
+++ b/arch/arm/mach-s3c2412/gpio.c
@@ -28,7 +28,7 @@
 
 int s3c2412_gpio_set_sleepcfg(unsigned int pin, unsigned int state)
 {
-	struct s3c_gpio_chip *chip = s3c_gpiolib_getchip(pin);
+	struct samsung_gpio_chip *chip = samsung_gpiolib_getchip(pin);
 	unsigned long offs = pin - chip->chip.base;
 	unsigned long flags;
 	unsigned long slpcon;
diff --git a/arch/arm/mach-s3c2416/s3c2416.c b/arch/arm/mach-s3c2416/s3c2416.c
index 494ce91..3156b7a 100644
--- a/arch/arm/mach-s3c2416/s3c2416.c
+++ b/arch/arm/mach-s3c2416/s3c2416.c
@@ -118,8 +118,8 @@ void __init s3c2416_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 
 void __init s3c2416_map_io(void)
 {
-	s3c24xx_gpiocfg_default.set_pull = s3c_gpio_setpull_updown;
-	s3c24xx_gpiocfg_default.get_pull = s3c_gpio_getpull_updown;
+	s3c24xx_gpiocfg_default.set_pull = samsung_gpio_setpull_updown;
+	s3c24xx_gpiocfg_default.get_pull = samsung_gpio_getpull_updown;
 
 	/* initialize device information early */
 	s3c2416_default_sdhci0();
diff --git a/arch/arm/mach-s3c2440/s3c2440.c b/arch/arm/mach-s3c2440/s3c2440.c
index ce99ff7..fc84e48 100644
--- a/arch/arm/mach-s3c2440/s3c2440.c
+++ b/arch/arm/mach-s3c2440/s3c2440.c
@@ -68,6 +68,6 @@ void __init s3c2440_map_io(void)
 {
 	s3c244x_map_io();
 
-	s3c24xx_gpiocfg_default.set_pull = s3c_gpio_setpull_1up;
-	s3c24xx_gpiocfg_default.get_pull = s3c_gpio_getpull_1up;
+	s3c24xx_gpiocfg_default.set_pull = s3c24xx_gpio_setpull_1up;
+	s3c24xx_gpiocfg_default.get_pull = s3c24xx_gpio_getpull_1up;
 }
diff --git a/arch/arm/mach-s3c2440/s3c2442.c b/arch/arm/mach-s3c2440/s3c2442.c
index 9ad99f8..48e273c 100644
--- a/arch/arm/mach-s3c2440/s3c2442.c
+++ b/arch/arm/mach-s3c2440/s3c2442.c
@@ -180,6 +180,6 @@ void __init s3c2442_map_io(void)
 {
 	s3c244x_map_io();
 
-	s3c24xx_gpiocfg_default.set_pull = s3c_gpio_setpull_1down;
-	s3c24xx_gpiocfg_default.get_pull = s3c_gpio_getpull_1down;
+	s3c24xx_gpiocfg_default.set_pull = s3c24xx_gpio_setpull_1down;
+	s3c24xx_gpiocfg_default.get_pull = s3c24xx_gpio_getpull_1down;
 }
diff --git a/arch/arm/mach-s3c2443/s3c2443.c b/arch/arm/mach-s3c2443/s3c2443.c
index e6a28ba..5df6458 100644
--- a/arch/arm/mach-s3c2443/s3c2443.c
+++ b/arch/arm/mach-s3c2443/s3c2443.c
@@ -90,8 +90,8 @@ void __init s3c2443_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 
 void __init s3c2443_map_io(void)
 {
-	s3c24xx_gpiocfg_default.set_pull = s3c_gpio_setpull_s3c2443;
-	s3c24xx_gpiocfg_default.get_pull = s3c_gpio_getpull_s3c2443;
+	s3c24xx_gpiocfg_default.set_pull = s3c2443_gpio_setpull;
+	s3c24xx_gpiocfg_default.get_pull = s3c2443_gpio_getpull;
 
 	iotable_init(s3c2443_iodesc, ARRAY_SIZE(s3c2443_iodesc));
 }
diff --git a/arch/arm/mach-s3c64xx/include/mach/pm-core.h b/arch/arm/mach-s3c64xx/include/mach/pm-core.h
index 38659be..fcf3dca 100644
--- a/arch/arm/mach-s3c64xx/include/mach/pm-core.h
+++ b/arch/arm/mach-s3c64xx/include/mach/pm-core.h
@@ -104,7 +104,7 @@ static inline void s3c_pm_restored_gpios(void)
 	__raw_writel(0, S3C64XX_SLPEN);
 }
 
-static inline void s3c_pm_saved_gpios(void)
+static inline void samsung_pm_saved_gpios(void)
 {
 	/* turn on the sleep mode and keep it there, as it seems that during
 	 * suspend the xCON registers get re-set and thus you can end up with
diff --git a/arch/arm/mach-s5pv210/include/mach/pm-core.h b/arch/arm/mach-s5pv210/include/mach/pm-core.h
index 3e22109..eba8aea 100644
--- a/arch/arm/mach-s5pv210/include/mach/pm-core.h
+++ b/arch/arm/mach-s5pv210/include/mach/pm-core.h
@@ -43,4 +43,4 @@ static inline void s3c_pm_arch_update_uart(void __iomem *regs,
 }
 
 static inline void s3c_pm_restored_gpios(void) { }
-static inline void s3c_pm_saved_gpios(void) { }
+static inline void samsung_pm_saved_gpios(void) { }
diff --git a/arch/arm/plat-s5p/irq-gpioint.c b/arch/arm/plat-s5p/irq-gpioint.c
index 327ab9f..4df0a69 100644
--- a/arch/arm/plat-s5p/irq-gpioint.c
+++ b/arch/arm/plat-s5p/irq-gpioint.c
@@ -35,7 +35,7 @@ struct s5p_gpioint_bank {
 	int			start;
 	int			nr_groups;
 	int			irq;
-	struct s3c_gpio_chip	**chips;
+	struct samsung_gpio_chip	**chips;
 	void			(*handler)(unsigned int, struct irq_desc *);
 };
 
@@ -82,7 +82,7 @@ static void s5p_gpioint_handler(unsigned int irq, struct irq_desc *desc)
 	unsigned int pend, mask;
 
 	for (group = 0; group < bank->nr_groups; group++) {
-		struct s3c_gpio_chip *chip = bank->chips[group];
+		struct samsung_gpio_chip *chip = bank->chips[group];
 		if (!chip)
 			continue;
 
@@ -104,7 +104,7 @@ static void s5p_gpioint_handler(unsigned int irq, struct irq_desc *desc)
 	}
 }
 
-static __init int s5p_gpioint_add(struct s3c_gpio_chip *chip)
+static __init int s5p_gpioint_add(struct samsung_gpio_chip *chip)
 {
 	static int used_gpioint_groups = 0;
 	int group = chip->group;
@@ -124,7 +124,7 @@ static __init int s5p_gpioint_add(struct s3c_gpio_chip *chip)
 		return -EINVAL;
 
 	if (!bank->handler) {
-		bank->chips = kzalloc(sizeof(struct s3c_gpio_chip *) *
+		bank->chips = kzalloc(sizeof(struct samsung_gpio_chip *) *
 				      bank->nr_groups, GFP_KERNEL);
 		if (!bank->chips)
 			return -ENOMEM;
@@ -167,7 +167,7 @@ static __init int s5p_gpioint_add(struct s3c_gpio_chip *chip)
 
 int __init s5p_register_gpio_interrupt(int pin)
 {
-	struct s3c_gpio_chip *my_chip = s3c_gpiolib_getchip(pin);
+	struct samsung_gpio_chip *my_chip = samsung_gpiolib_getchip(pin);
 	int offset, group;
 	int ret;
 
diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h b/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
index 9a4e53d..a181d7c 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
@@ -1,11 +1,11 @@
-/* linux/arch/arm/plat-s3c/include/plat/gpio-cfg-helper.h
+/* linux/arch/arm/plat-samsung/include/plat/gpio-cfg-helper.h
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
  *
- * S3C Platform - GPIO pin configuration helper definitions
+ * Samsung Platform - GPIO pin configuration helper definitions
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -24,120 +24,30 @@
  * by disabling interrupts.
 */
 
-static inline int s3c_gpio_do_setcfg(struct s3c_gpio_chip *chip,
-				     unsigned int off, unsigned int config)
+static inline int samsung_gpio_do_setcfg(struct samsung_gpio_chip *chip,
+					 unsigned int off, unsigned int config)
 {
 	return (chip->config->set_config)(chip, off, config);
 }
 
-static inline unsigned s3c_gpio_do_getcfg(struct s3c_gpio_chip *chip,
-					  unsigned int off)
+static inline unsigned samsung_gpio_do_getcfg(struct samsung_gpio_chip *chip,
+					      unsigned int off)
 {
 	return (chip->config->get_config)(chip, off);
 }
 
-static inline int s3c_gpio_do_setpull(struct s3c_gpio_chip *chip,
-				      unsigned int off, s3c_gpio_pull_t pull)
+static inline int samsung_gpio_do_setpull(struct samsung_gpio_chip *chip,
+					  unsigned int off, samsung_gpio_pull_t pull)
 {
 	return (chip->config->set_pull)(chip, off, pull);
 }
 
-static inline s3c_gpio_pull_t s3c_gpio_do_getpull(struct s3c_gpio_chip *chip,
-						  unsigned int off)
+static inline samsung_gpio_pull_t samsung_gpio_do_getpull(struct samsung_gpio_chip *chip,
+							  unsigned int off)
 {
 	return chip->config->get_pull(chip, off);
 }
 
-/**
- * s3c_gpio_setcfg_s3c24xx - S3C24XX style GPIO configuration.
- * @chip: The gpio chip that is being configured.
- * @off: The offset for the GPIO being configured.
- * @cfg: The configuration value to set.
- *
- * This helper deal with the GPIO cases where the control register
- * has two bits of configuration per gpio, which have the following
- * functions:
- *	00 = input
- *	01 = output
- *	1x = special function
-*/
-extern int s3c_gpio_setcfg_s3c24xx(struct s3c_gpio_chip *chip,
-				   unsigned int off, unsigned int cfg);
-
-/**
- * s3c_gpio_getcfg_s3c24xx - S3C24XX style GPIO configuration read.
- * @chip: The gpio chip that is being configured.
- * @off: The offset for the GPIO being configured.
- *
- * The reverse of s3c_gpio_setcfg_s3c24xx(). Will return a value whicg
- * could be directly passed back to s3c_gpio_setcfg_s3c24xx(), from the
- * S3C_GPIO_SPECIAL() macro.
- */
-unsigned int s3c_gpio_getcfg_s3c24xx(struct s3c_gpio_chip *chip,
-				     unsigned int off);
-
-/**
- * s3c_gpio_setcfg_s3c24xx_a - S3C24XX style GPIO configuration (Bank A)
- * @chip: The gpio chip that is being configured.
- * @off: The offset for the GPIO being configured.
- * @cfg: The configuration value to set.
- *
- * This helper deal with the GPIO cases where the control register
- * has one bit of configuration for the gpio, where setting the bit
- * means the pin is in special function mode and unset means output.
-*/
-extern int s3c_gpio_setcfg_s3c24xx_a(struct s3c_gpio_chip *chip,
-				     unsigned int off, unsigned int cfg);
-
-
-/**
- * s3c_gpio_getcfg_s3c24xx_a - S3C24XX style GPIO configuration read (Bank A)
- * @chip: The gpio chip that is being configured.
- * @off: The offset for the GPIO being configured.
- *
- * The reverse of s3c_gpio_setcfg_s3c24xx_a() turning an GPIO into a usable
- * GPIO configuration value.
- *
- * @sa s3c_gpio_getcfg_s3c24xx
- * @sa s3c_gpio_getcfg_s3c64xx_4bit
- */
-extern unsigned s3c_gpio_getcfg_s3c24xx_a(struct s3c_gpio_chip *chip,
-					  unsigned int off);
-
-/**
- * s3c_gpio_setcfg_s3c64xx_4bit - S3C64XX 4bit single register GPIO config.
- * @chip: The gpio chip that is being configured.
- * @off: The offset for the GPIO being configured.
- * @cfg: The configuration value to set.
- *
- * This helper deal with the GPIO cases where the control register has 4 bits
- * of control per GPIO, generally in the form of:
- *	0000 = Input
- *	0001 = Output
- *	others = Special functions (dependent on bank)
- *
- * Note, since the code to deal with the case where there are two control
- * registers instead of one, we do not have a separate set of functions for
- * each case.
-*/
-extern int s3c_gpio_setcfg_s3c64xx_4bit(struct s3c_gpio_chip *chip,
-					unsigned int off, unsigned int cfg);
-
-
-/**
- * s3c_gpio_getcfg_s3c64xx_4bit - S3C64XX 4bit single register GPIO config read.
- * @chip: The gpio chip that is being configured.
- * @off: The offset for the GPIO being configured.
- *
- * The reverse of s3c_gpio_setcfg_s3c64xx_4bit(), turning a gpio configuration
- * register setting into a value the software can use, such as could be passed
- * to s3c_gpio_setcfg_s3c64xx_4bit().
- *
- * @sa s3c_gpio_getcfg_s3c24xx
- */
-extern unsigned s3c_gpio_getcfg_s3c64xx_4bit(struct s3c_gpio_chip *chip,
-					     unsigned int off);
-
 /* Pull-{up,down} resistor controls.
  *
  * S3C2410,S3C2440 = Pull-UP,
@@ -147,7 +57,7 @@ extern unsigned s3c_gpio_getcfg_s3c64xx_4bit(struct s3c_gpio_chip *chip,
  */
 
 /**
- * s3c_gpio_setpull_1up() - Pull configuration for choice of up or none.
+ * s3c24xx_gpio_setpull_1up() - Pull configuration for choice of up or none.
  * @chip: The gpio chip that is being configured.
  * @off: The offset for the GPIO being configured.
  * @param: pull: The pull mode being requested.
@@ -155,11 +65,11 @@ extern unsigned s3c_gpio_getcfg_s3c64xx_4bit(struct s3c_gpio_chip *chip,
  * This is a helper function for the case where we have GPIOs with one
  * bit configuring the presence of a pull-up resistor.
  */
-extern int s3c_gpio_setpull_1up(struct s3c_gpio_chip *chip,
-				unsigned int off, s3c_gpio_pull_t pull);
+extern int s3c24xx_gpio_setpull_1up(struct samsung_gpio_chip *chip,
+				    unsigned int off, samsung_gpio_pull_t pull);
 
 /**
- * s3c_gpio_setpull_1down() - Pull configuration for choice of down or none
+ * s3c24xx_gpio_setpull_1down() - Pull configuration for choice of down or none
  * @chip: The gpio chip that is being configured
  * @off: The offset for the GPIO being configured
  * @param: pull: The pull mode being requested
@@ -167,11 +77,13 @@ extern int s3c_gpio_setpull_1up(struct s3c_gpio_chip *chip,
  * This is a helper function for the case where we have GPIOs with one
  * bit configuring the presence of a pull-down resistor.
  */
-extern int s3c_gpio_setpull_1down(struct s3c_gpio_chip *chip,
-				  unsigned int off, s3c_gpio_pull_t pull);
+extern int s3c24xx_gpio_setpull_1down(struct samsung_gpio_chip *chip,
+				      unsigned int off, samsung_gpio_pull_t pull);
 
 /**
- * s3c_gpio_setpull_upown() - Pull configuration for choice of up, down or none
+ * samsung_gpio_setpull_upown() - Pull configuration for choice of up,
+ * down or none
+ *
  * @chip: The gpio chip that is being configured.
  * @off: The offset for the GPIO being configured.
  * @param: pull: The pull mode being requested.
@@ -183,45 +95,46 @@ extern int s3c_gpio_setpull_1down(struct s3c_gpio_chip *chip,
  *	01 = Pull-up resistor connected
  *	10 = Pull-down resistor connected
  */
-extern int s3c_gpio_setpull_updown(struct s3c_gpio_chip *chip,
-				   unsigned int off, s3c_gpio_pull_t pull);
-
+extern int samsung_gpio_setpull_updown(struct samsung_gpio_chip *chip,
+				       unsigned int off, samsung_gpio_pull_t pull);
 
 /**
- * s3c_gpio_getpull_updown() - Get configuration for choice of up, down or none
+ * samsung_gpio_getpull_updown() - Get configuration for choice of up,
+ * down or none
+ *
  * @chip: The gpio chip that the GPIO pin belongs to
  * @off: The offset to the pin to get the configuration of.
  *
- * This helper function reads the state of the pull-{up,down} resistor for the
- * given GPIO in the same case as s3c_gpio_setpull_upown.
+ * This helper function reads the state of the pull-{up,down} resistor
+ * for the given GPIO in the same case as samsung_gpio_setpull_upown.
 */
-extern s3c_gpio_pull_t s3c_gpio_getpull_updown(struct s3c_gpio_chip *chip,
-					       unsigned int off);
+extern samsung_gpio_pull_t samsung_gpio_getpull_updown(struct samsung_gpio_chip *chip,
+						       unsigned int off);
 
 /**
- * s3c_gpio_getpull_1up() - Get configuration for choice of up or none
+ * s3c24xx_gpio_getpull_1up() - Get configuration for choice of up or none
  * @chip: The gpio chip that the GPIO pin belongs to
  * @off: The offset to the pin to get the configuration of.
  *
  * This helper function reads the state of the pull-up resistor for the
- * given GPIO in the same case as s3c_gpio_setpull_1up.
+ * given GPIO in the same case as s3c24xx_gpio_setpull_1up.
 */
-extern s3c_gpio_pull_t s3c_gpio_getpull_1up(struct s3c_gpio_chip *chip,
-					    unsigned int off);
+extern samsung_gpio_pull_t s3c24xx_gpio_getpull_1up(struct samsung_gpio_chip *chip,
+						    unsigned int off);
 
 /**
- * s3c_gpio_getpull_1down() - Get configuration for choice of down or none
+ * s3c24xx_gpio_getpull_1down() - Get configuration for choice of down or none
  * @chip: The gpio chip that the GPIO pin belongs to
  * @off: The offset to the pin to get the configuration of.
  *
  * This helper function reads the state of the pull-down resistor for the
- * given GPIO in the same case as s3c_gpio_setpull_1down.
+ * given GPIO in the same case as s3c24xx_gpio_setpull_1down.
 */
-extern s3c_gpio_pull_t s3c_gpio_getpull_1down(struct s3c_gpio_chip *chip,
-					    unsigned int off);
+extern samsung_gpio_pull_t s3c24xx_gpio_getpull_1down(struct samsung_gpio_chip *chip,
+						      unsigned int off);
 
 /**
- * s3c_gpio_setpull_s3c2443() - Pull configuration for s3c2443.
+ * s3c2443_gpio_setpull() - Pull configuration for s3c2443.
  * @chip: The gpio chip that is being configured.
  * @off: The offset for the GPIO being configured.
  * @param: pull: The pull mode being requested.
@@ -233,19 +146,18 @@ extern s3c_gpio_pull_t s3c_gpio_getpull_1down(struct s3c_gpio_chip *chip,
  *	10 = Pull-down resistor connected
  *	x1 = No pull up resistor
  */
-extern int s3c_gpio_setpull_s3c2443(struct s3c_gpio_chip *chip,
-				    unsigned int off, s3c_gpio_pull_t pull);
+extern int s3c2443_gpio_setpull(struct samsung_gpio_chip *chip,
+				unsigned int off, samsung_gpio_pull_t pull);
 
 /**
- * s3c_gpio_getpull_s3c2443() - Get configuration for s3c2443 pull resistors
+ * s3c2443_gpio_getpull() - Get configuration for s3c2443 pull resistors
  * @chip: The gpio chip that the GPIO pin belongs to.
  * @off: The offset to the pin to get the configuration of.
  *
  * This helper function reads the state of the pull-{up,down} resistor for the
- * given GPIO in the same case as s3c_gpio_setpull_upown.
+ * given GPIO in the same case as samsung_gpio_setpull_upown.
 */
-extern s3c_gpio_pull_t s3c_gpio_getpull_s3c2443(struct s3c_gpio_chip *chip,
+extern samsung_gpio_pull_t s3c2443_gpio_getpull(struct samsung_gpio_chip *chip,
 						unsigned int off);
 
 #endif /* __PLAT_GPIO_CFG_HELPERS_H */
-
diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg.h b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
index 1762dcb..d48245b 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-cfg.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
@@ -24,14 +24,14 @@
 #ifndef __PLAT_GPIO_CFG_H
 #define __PLAT_GPIO_CFG_H __FILE__
 
-typedef unsigned int __bitwise__ s3c_gpio_pull_t;
+typedef unsigned int __bitwise__ samsung_gpio_pull_t;
 typedef unsigned int __bitwise__ s5p_gpio_drvstr_t;
 
 /* forward declaration if gpio-core.h hasn't been included */
-struct s3c_gpio_chip;
+struct samsung_gpio_chip;
 
 /**
- * struct s3c_gpio_cfg GPIO configuration
+ * struct samsung_gpio_cfg GPIO configuration
  * @cfg_eint: Configuration setting when used for external interrupt source
  * @get_pull: Read the current pull configuration for the GPIO
  * @set_pull: Set the current pull configuraiton for the GPIO
@@ -44,20 +44,20 @@ struct s3c_gpio_chip;
  * per-bank configuration information that other systems such as the
  * external interrupt code will need.
  *
- * @sa s3c_gpio_cfgpin
+ * @sa samsung_gpio_cfgpin
  * @sa s3c_gpio_getcfg
  * @sa s3c_gpio_setpull
  * @sa s3c_gpio_getpull
  */
-struct s3c_gpio_cfg {
+struct samsung_gpio_cfg {
 	unsigned int	cfg_eint;
 
-	s3c_gpio_pull_t	(*get_pull)(struct s3c_gpio_chip *chip, unsigned offs);
-	int		(*set_pull)(struct s3c_gpio_chip *chip, unsigned offs,
-				    s3c_gpio_pull_t pull);
+	samsung_gpio_pull_t	(*get_pull)(struct samsung_gpio_chip *chip, unsigned offs);
+	int		(*set_pull)(struct samsung_gpio_chip *chip, unsigned offs,
+				    samsung_gpio_pull_t pull);
 
-	unsigned (*get_config)(struct s3c_gpio_chip *chip, unsigned offs);
-	int	 (*set_config)(struct s3c_gpio_chip *chip, unsigned offs,
+	unsigned (*get_config)(struct samsung_gpio_chip *chip, unsigned offs);
+	int	 (*set_config)(struct samsung_gpio_chip *chip, unsigned offs,
 			       unsigned config);
 };
 
@@ -69,7 +69,7 @@ struct s3c_gpio_cfg {
 #define S3C_GPIO_OUTPUT	(S3C_GPIO_SPECIAL(1))
 #define S3C_GPIO_SFN(x)	(S3C_GPIO_SPECIAL(x))
 
-#define s3c_gpio_is_cfg_special(_cfg) \
+#define samsung_gpio_is_cfg_special(_cfg) \
 	(((_cfg) & S3C_GPIO_SPECIAL_MARK) == S3C_GPIO_SPECIAL_MARK)
 
 /**
@@ -128,9 +128,9 @@ extern int s3c_gpio_cfgpin_range(unsigned int start, unsigned int nr,
  * up or down settings, and it may be dependent on the chip that is being
  * used to whether the particular mode is available.
  */
-#define S3C_GPIO_PULL_NONE	((__force s3c_gpio_pull_t)0x00)
-#define S3C_GPIO_PULL_DOWN	((__force s3c_gpio_pull_t)0x01)
-#define S3C_GPIO_PULL_UP	((__force s3c_gpio_pull_t)0x02)
+#define S3C_GPIO_PULL_NONE	((__force samsung_gpio_pull_t)0x00)
+#define S3C_GPIO_PULL_DOWN	((__force samsung_gpio_pull_t)0x01)
+#define S3C_GPIO_PULL_UP	((__force samsung_gpio_pull_t)0x02)
 
 /**
  * s3c_gpio_setpull() - set the state of a gpio pin pull resistor
@@ -143,7 +143,7 @@ extern int s3c_gpio_cfgpin_range(unsigned int start, unsigned int nr,
  *
  * @pull is one of S3C_GPIO_PULL_NONE, S3C_GPIO_PULL_DOWN or S3C_GPIO_PULL_UP.
 */
-extern int s3c_gpio_setpull(unsigned int pin, s3c_gpio_pull_t pull);
+extern int s3c_gpio_setpull(unsigned int pin, samsung_gpio_pull_t pull);
 
 /**
  * s3c_gpio_getpull() - get the pull resistor state of a gpio pin
@@ -151,7 +151,7 @@ extern int s3c_gpio_setpull(unsigned int pin, s3c_gpio_pull_t pull);
  *
  * Read the pull resistor value for the specified pin.
 */
-extern s3c_gpio_pull_t s3c_gpio_getpull(unsigned int pin);
+extern samsung_gpio_pull_t s3c_gpio_getpull(unsigned int pin);
 
 /* configure `all` aspects of an gpio */
 
@@ -170,7 +170,7 @@ extern s3c_gpio_pull_t s3c_gpio_getpull(unsigned int pin);
  * @sa s3c_gpio_cfgpin_range
  */
 extern int s3c_gpio_cfgall_range(unsigned int start, unsigned int nr,
-				 unsigned int cfg, s3c_gpio_pull_t pull);
+				 unsigned int cfg, samsung_gpio_pull_t pull);
 
 static inline int s3c_gpio_cfgrange_nopull(unsigned int pin, unsigned int size,
 					   unsigned int cfg)
diff --git a/arch/arm/plat-samsung/include/plat/gpio-core.h b/arch/arm/plat-samsung/include/plat/gpio-core.h
index 8cad4cf..1fe6917 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-core.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-core.h
@@ -25,22 +25,22 @@
  * specific code.
 */
 
-struct s3c_gpio_chip;
+struct samsung_gpio_chip;
 
 /**
- * struct s3c_gpio_pm - power management (suspend/resume) information
+ * struct samsung_gpio_pm - power management (suspend/resume) information
  * @save: Routine to save the state of the GPIO block
  * @resume: Routine to resume the GPIO block.
  */
-struct s3c_gpio_pm {
-	void (*save)(struct s3c_gpio_chip *chip);
-	void (*resume)(struct s3c_gpio_chip *chip);
+struct samsung_gpio_pm {
+	void (*save)(struct samsung_gpio_chip *chip);
+	void (*resume)(struct samsung_gpio_chip *chip);
 };
 
-struct s3c_gpio_cfg;
+struct samsung_gpio_cfg;
 
 /**
- * struct s3c_gpio_chip - wrapper for specific implementation of gpio
+ * struct samsung_gpio_chip - wrapper for specific implementation of gpio
  * @chip: The chip structure to be exported via gpiolib.
  * @base: The base pointer to the gpio configuration registers.
  * @group: The group register number for gpio interrupt support.
@@ -60,10 +60,10 @@ struct s3c_gpio_cfg;
  * CPU cores trying to get one lock for different GPIO banks, where each
  * bank of GPIO has its own register space and configuration registers.
  */
-struct s3c_gpio_chip {
+struct samsung_gpio_chip {
 	struct gpio_chip	chip;
-	struct s3c_gpio_cfg	*config;
-	struct s3c_gpio_pm	*pm;
+	struct samsung_gpio_cfg	*config;
+	struct samsung_gpio_pm	*pm;
 	void __iomem		*base;
 	int			irq_base;
 	int			group;
@@ -73,58 +73,11 @@ struct s3c_gpio_chip {
 #endif
 };
 
-static inline struct s3c_gpio_chip *to_s3c_gpio(struct gpio_chip *gpc)
+static inline struct samsung_gpio_chip *to_samsung_gpio(struct gpio_chip *gpc)
 {
-	return container_of(gpc, struct s3c_gpio_chip, chip);
+	return container_of(gpc, struct samsung_gpio_chip, chip);
 }
 
-/** s3c_gpiolib_add() - add the s3c specific version of a gpio_chip.
- * @chip: The chip to register
- *
- * This is a wrapper to gpiochip_add() that takes our specific gpio chip
- * information and makes the necessary alterations for the platform and
- * notes the information for use with the configuration systems and any
- * other parts of the system.
- */
-extern void s3c_gpiolib_add(struct s3c_gpio_chip *chip);
-
-/* CONFIG_S3C_GPIO_TRACK enables the tracking of the s3c specific gpios
- * for use with the configuration calls, and other parts of the s3c gpiolib
- * support code.
- *
- * Not all s3c support code will need this, as some configurations of cpu
- * may only support one or two different configuration options and have an
- * easy gpio to s3c_gpio_chip mapping function. If this is the case, then
- * the machine support file should provide its own s3c_gpiolib_getchip()
- * and any other necessary functions.
- */
-
-/**
- * samsung_gpiolib_add_4bit_chips - 4bit single register GPIO config.
- * @chip: The gpio chip that is being configured.
- * @nr_chips: The no of chips (gpio ports) for the GPIO being configured.
- *
- * This helper deal with the GPIO cases where the control register has 4 bits
- * of control per GPIO, generally in the form of:
- * 0000 = Input
- * 0001 = Output
- * others = Special functions (dependent on bank)
- *
- * Note, since the code to deal with the case where there are two control
- * registers instead of one, we do not have a separate set of function
- * (samsung_gpiolib_add_4bit2_chips)for each case.
- */
-extern void samsung_gpiolib_add_4bit_chips(struct s3c_gpio_chip *chip,
-					   int nr_chips);
-extern void samsung_gpiolib_add_4bit2_chips(struct s3c_gpio_chip *chip,
-					    int nr_chips);
-extern void samsung_gpiolib_add_2bit_chips(struct s3c_gpio_chip *chip,
-					   int nr_chips);
-
-extern void samsung_gpiolib_add_4bit(struct s3c_gpio_chip *chip);
-extern void samsung_gpiolib_add_4bit2(struct s3c_gpio_chip *chip);
-
-
 /**
  * samsung_gpiolib_to_irq - convert gpio pin to irq number
  * @chip: The gpio chip that the pin belongs to.
@@ -136,36 +89,36 @@ extern void samsung_gpiolib_add_4bit2(struct s3c_gpio_chip *chip);
 extern int samsung_gpiolib_to_irq(struct gpio_chip *chip, unsigned int offset);
 
 /* exported for core SoC support to change */
-extern struct s3c_gpio_cfg s3c24xx_gpiocfg_default;
+extern struct samsung_gpio_cfg s3c24xx_gpiocfg_default;
 
 #ifdef CONFIG_S3C_GPIO_TRACK
-extern struct s3c_gpio_chip *s3c_gpios[S3C_GPIO_END];
+extern struct samsung_gpio_chip *s3c_gpios[S3C_GPIO_END];
 
-static inline struct s3c_gpio_chip *s3c_gpiolib_getchip(unsigned int chip)
+static inline struct samsung_gpio_chip *samsung_gpiolib_getchip(unsigned int chip)
 {
 	return (chip < S3C_GPIO_END) ? s3c_gpios[chip] : NULL;
 }
 #else
-/* machine specific code should provide s3c_gpiolib_getchip */
+/* machine specific code should provide samsung_gpiolib_getchip */
 
 #include <mach/gpio-track.h>
 
-static inline void s3c_gpiolib_track(struct s3c_gpio_chip *chip) { }
+static inline void s3c_gpiolib_track(struct samsung_gpio_chip *chip) { }
 #endif
 
 #ifdef CONFIG_PM
-extern struct s3c_gpio_pm s3c_gpio_pm_1bit;
-extern struct s3c_gpio_pm s3c_gpio_pm_2bit;
-extern struct s3c_gpio_pm s3c_gpio_pm_4bit;
+extern struct samsung_gpio_pm samsung_gpio_pm_1bit;
+extern struct samsung_gpio_pm samsung_gpio_pm_2bit;
+extern struct samsung_gpio_pm samsung_gpio_pm_4bit;
 #define __gpio_pm(x) x
 #else
-#define s3c_gpio_pm_1bit NULL
-#define s3c_gpio_pm_2bit NULL
-#define s3c_gpio_pm_4bit NULL
+#define samsung_gpio_pm_1bit NULL
+#define samsung_gpio_pm_2bit NULL
+#define samsung_gpio_pm_4bit NULL
 #define __gpio_pm(x) NULL
 
 #endif /* CONFIG_PM */
 
 /* locking wrappers to deal with multiple access to the same gpio bank */
-#define s3c_gpio_lock(_oc, _fl) spin_lock_irqsave(&(_oc)->lock, _fl)
-#define s3c_gpio_unlock(_oc, _fl) spin_unlock_irqrestore(&(_oc)->lock, _fl)
+#define samsung_gpio_lock(_oc, _fl) spin_lock_irqsave(&(_oc)->lock, _fl)
+#define samsung_gpio_unlock(_oc, _fl) spin_unlock_irqrestore(&(_oc)->lock, _fl)
diff --git a/arch/arm/plat-samsung/include/plat/gpio-fns.h b/arch/arm/plat-samsung/include/plat/gpio-fns.h
new file mode 100644
index 0000000..bab1392
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/gpio-fns.h
@@ -0,0 +1,98 @@
+/* arch/arm/mach-s3c2410/include/mach/gpio-fns.h
+ *
+ * Copyright (c) 2003-2009 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * S3C2410 - hardware
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __MACH_GPIO_FNS_H
+#define __MACH_GPIO_FNS_H __FILE__
+
+/* These functions are in the to-be-removed category and it is strongly
+ * encouraged not to use these in new code. They will be marked deprecated
+ * very soon.
+ *
+ * Most of the functionality can be either replaced by the gpiocfg calls
+ * for the s3c platform or by the generic GPIOlib API.
+ *
+ * As of 2.6.35-rc, these will be removed, with the few drivers using them
+ * either replaced or given a wrapper until the calls can be removed.
+*/
+
+#include <plat/gpio-cfg.h>
+
+static inline void s3c2410_gpio_cfgpin(unsigned int pin, unsigned int cfg)
+{
+	/* 1:1 mapping between cfgpin and setcfg calls at the moment */
+	s3c_gpio_cfgpin(pin, cfg);
+}
+
+/* external functions for GPIO support
+ *
+ * These allow various different clients to access the same GPIO
+ * registers without conflicting. If your driver only owns the entire
+ * GPIO register, then it is safe to ioremap/__raw_{read|write} to it.
+*/
+
+extern unsigned int s3c2410_gpio_getcfg(unsigned int pin);
+
+/* s3c2410_gpio_getirq
+ *
+ * turn the given pin number into the corresponding IRQ number
+ *
+ * returns:
+ *	< 0 = no interrupt for this pin
+ *	>=0 = interrupt number for the pin
+*/
+
+extern int s3c2410_gpio_getirq(unsigned int pin);
+
+/* s3c2410_gpio_irqfilter
+ *
+ * set the irq filtering on the given pin
+ *
+ * on = 0 => disable filtering
+ *      1 => enable filtering
+ *
+ * config = S3C2410_EINTFLT_PCLK or S3C2410_EINTFLT_EXTCLK orred with
+ *          width of filter (0 through 63)
+ *
+ *
+*/
+
+extern int s3c2410_gpio_irqfilter(unsigned int pin, unsigned int on,
+				  unsigned int config);
+
+/* s3c2410_gpio_pullup
+ *
+ * This call should be replaced with s3c_gpio_setpull().
+ *
+ * As a note, there is currently no distinction between pull-up and pull-down
+ * in the s3c24xx series devices with only an on/off configuration.
+ */
+
+/* s3c2410_gpio_pullup
+ *
+ * configure the pull-up control on the given pin
+ *
+ * to = 1 => disable the pull-up
+ *      0 => enable the pull-up
+ *
+ * eg;
+ *
+ *   s3c2410_gpio_pullup(S3C2410_GPB(0), 0);
+ *   s3c2410_gpio_pullup(S3C2410_GPE(8), 0);
+*/
+
+extern void s3c2410_gpio_pullup(unsigned int pin, unsigned int to);
+
+extern void s3c2410_gpio_setpin(unsigned int pin, unsigned int to);
+
+extern unsigned int s3c2410_gpio_getpin(unsigned int pin);
+
+#endif /* __MACH_GPIO_FNS_H */
diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-samsung/include/plat/pm.h
index f674991..dcf6870 100644
--- a/arch/arm/plat-samsung/include/plat/pm.h
+++ b/arch/arm/plat-samsung/include/plat/pm.h
@@ -165,20 +165,20 @@ extern void s3c_pm_check_store(void);
 extern void s3c_pm_configure_extint(void);
 
 /**
- * s3c_pm_restore_gpios() - restore the state of the gpios after sleep.
+ * samsung_pm_restore_gpios() - restore the state of the gpios after sleep.
  *
  * Restore the state of the GPIO pins after sleep, which may involve ensuring
  * that we do not glitch the state of the pins from that the bootloader's
  * resume code has done.
 */
-extern void s3c_pm_restore_gpios(void);
+extern void samsung_pm_restore_gpios(void);
 
 /**
- * s3c_pm_save_gpios() - save the state of the GPIOs for restoring after sleep.
+ * samsung_pm_save_gpios() - save the state of the GPIOs for restoring after sleep.
  *
- * Save the GPIO states for resotration on resume. See s3c_pm_restore_gpios().
+ * Save the GPIO states for resotration on resume. See samsung_pm_restore_gpios().
  */
-extern void s3c_pm_save_gpios(void);
+extern void samsung_pm_save_gpios(void);
 
 extern void s3c_pm_save_core(void);
 extern void s3c_pm_restore_core(void);
diff --git a/arch/arm/plat-samsung/pm-gpio.c b/arch/arm/plat-samsung/pm-gpio.c
index 9652820..4be016e 100644
--- a/arch/arm/plat-samsung/pm-gpio.c
+++ b/arch/arm/plat-samsung/pm-gpio.c
@@ -28,13 +28,13 @@
 #define OFFS_DAT	(0x04)
 #define OFFS_UP		(0x08)
 
-static void s3c_gpio_pm_1bit_save(struct s3c_gpio_chip *chip)
+static void samsung_gpio_pm_1bit_save(struct samsung_gpio_chip *chip)
 {
 	chip->pm_save[0] = __raw_readl(chip->base + OFFS_CON);
 	chip->pm_save[1] = __raw_readl(chip->base + OFFS_DAT);
 }
 
-static void s3c_gpio_pm_1bit_resume(struct s3c_gpio_chip *chip)
+static void samsung_gpio_pm_1bit_resume(struct samsung_gpio_chip *chip)
 {
 	void __iomem *base = chip->base;
 	u32 old_gpcon = __raw_readl(base + OFFS_CON);
@@ -60,12 +60,12 @@ static void s3c_gpio_pm_1bit_resume(struct s3c_gpio_chip *chip)
 		  chip->chip.label, old_gpcon, gps_gpcon, old_gpdat, gps_gpdat);
 }
 
-struct s3c_gpio_pm s3c_gpio_pm_1bit = {
-	.save	= s3c_gpio_pm_1bit_save,
-	.resume = s3c_gpio_pm_1bit_resume,
+struct samsung_gpio_pm samsung_gpio_pm_1bit = {
+	.save	= samsung_gpio_pm_1bit_save,
+	.resume = samsung_gpio_pm_1bit_resume,
 };
 
-static void s3c_gpio_pm_2bit_save(struct s3c_gpio_chip *chip)
+static void samsung_gpio_pm_2bit_save(struct samsung_gpio_chip *chip)
 {
 	chip->pm_save[0] = __raw_readl(chip->base + OFFS_CON);
 	chip->pm_save[1] = __raw_readl(chip->base + OFFS_DAT);
@@ -95,7 +95,7 @@ static inline int is_out(unsigned long con)
 }
 
 /**
- * s3c_gpio_pm_2bit_resume() - restore the given GPIO bank
+ * samsung_gpio_pm_2bit_resume() - restore the given GPIO bank
  * @chip: The chip information to resume.
  *
  * Restore one of the GPIO banks that was saved during suspend. This is
@@ -121,7 +121,7 @@ static inline int is_out(unsigned long con)
  * [1] this assumes that writing to a pin DAT whilst in SFN will set the
  *     state for when it is next output.
  */
-static void s3c_gpio_pm_2bit_resume(struct s3c_gpio_chip *chip)
+static void samsung_gpio_pm_2bit_resume(struct samsung_gpio_chip *chip)
 {
 	void __iomem *base = chip->base;
 	u32 old_gpcon = __raw_readl(base + OFFS_CON);
@@ -187,13 +187,13 @@ static void s3c_gpio_pm_2bit_resume(struct s3c_gpio_chip *chip)
 		  chip->chip.label, old_gpcon, gps_gpcon, old_gpdat, gps_gpdat);
 }
 
-struct s3c_gpio_pm s3c_gpio_pm_2bit = {
-	.save	= s3c_gpio_pm_2bit_save,
-	.resume = s3c_gpio_pm_2bit_resume,
+struct samsung_gpio_pm samsung_gpio_pm_2bit = {
+	.save	= samsung_gpio_pm_2bit_save,
+	.resume = samsung_gpio_pm_2bit_resume,
 };
 
 #if defined(CONFIG_ARCH_S3C64XX) || defined(CONFIG_PLAT_S5P)
-static void s3c_gpio_pm_4bit_save(struct s3c_gpio_chip *chip)
+static void samsung_gpio_pm_4bit_save(struct samsung_gpio_chip *chip)
 {
 	chip->pm_save[1] = __raw_readl(chip->base + OFFS_CON);
 	chip->pm_save[2] = __raw_readl(chip->base + OFFS_DAT);
@@ -203,7 +203,7 @@ static void s3c_gpio_pm_4bit_save(struct s3c_gpio_chip *chip)
 		chip->pm_save[0] = __raw_readl(chip->base - 4);
 }
 
-static u32 s3c_gpio_pm_4bit_mask(u32 old_gpcon, u32 gps_gpcon)
+static u32 samsung_gpio_pm_4bit_mask(u32 old_gpcon, u32 gps_gpcon)
 {
 	u32 old, new, mask;
 	u32 change_mask = 0x0;
@@ -242,14 +242,14 @@ static u32 s3c_gpio_pm_4bit_mask(u32 old_gpcon, u32 gps_gpcon)
 	return change_mask;
 }
 
-static void s3c_gpio_pm_4bit_con(struct s3c_gpio_chip *chip, int index)
+static void samsung_gpio_pm_4bit_con(struct samsung_gpio_chip *chip, int index)
 {
 	void __iomem *con = chip->base + (index * 4);
 	u32 old_gpcon = __raw_readl(con);
 	u32 gps_gpcon = chip->pm_save[index + 1];
 	u32 gpcon, mask;
 
-	mask = s3c_gpio_pm_4bit_mask(old_gpcon, gps_gpcon);
+	mask = samsung_gpio_pm_4bit_mask(old_gpcon, gps_gpcon);
 
 	gpcon = old_gpcon & ~mask;
 	gpcon |= gps_gpcon & mask;
@@ -257,7 +257,7 @@ static void s3c_gpio_pm_4bit_con(struct s3c_gpio_chip *chip, int index)
 	__raw_writel(gpcon, con);
 }
 
-static void s3c_gpio_pm_4bit_resume(struct s3c_gpio_chip *chip)
+static void samsung_gpio_pm_4bit_resume(struct samsung_gpio_chip *chip)
 {
 	void __iomem *base = chip->base;
 	u32 old_gpcon[2];
@@ -269,10 +269,10 @@ static void s3c_gpio_pm_4bit_resume(struct s3c_gpio_chip *chip)
 	old_gpcon[0] = 0;
 	old_gpcon[1] = __raw_readl(base + OFFS_CON);
 
-	s3c_gpio_pm_4bit_con(chip, 0);
+	samsung_gpio_pm_4bit_con(chip, 0);
 	if (chip->chip.ngpio > 8) {
 		old_gpcon[0] = __raw_readl(base - 4);
-		s3c_gpio_pm_4bit_con(chip, -1);
+		samsung_gpio_pm_4bit_con(chip, -1);
 	}
 
 	/* Now change the configurations that require DAT,CON */
@@ -298,19 +298,19 @@ static void s3c_gpio_pm_4bit_resume(struct s3c_gpio_chip *chip)
 			  old_gpdat, gps_gpdat);
 }
 
-struct s3c_gpio_pm s3c_gpio_pm_4bit = {
-	.save	= s3c_gpio_pm_4bit_save,
-	.resume = s3c_gpio_pm_4bit_resume,
+struct samsung_gpio_pm samsung_gpio_pm_4bit = {
+	.save	= samsung_gpio_pm_4bit_save,
+	.resume = samsung_gpio_pm_4bit_resume,
 };
 #endif /* CONFIG_ARCH_S3C64XX || CONFIG_PLAT_S5P */
 
 /**
- * s3c_pm_save_gpio() - save gpio chip data for suspend
+ * samsung_pm_save_gpio() - save gpio chip data for suspend
  * @ourchip: The chip for suspend.
  */
-static void s3c_pm_save_gpio(struct s3c_gpio_chip *ourchip)
+static void samsung_pm_save_gpio(struct samsung_gpio_chip *ourchip)
 {
-	struct s3c_gpio_pm *pm = ourchip->pm;
+	struct samsung_gpio_pm *pm = ourchip->pm;
 
 	if (pm == NULL || pm->save == NULL)
 		S3C_PMDBG("%s: no pm for %s\n", __func__, ourchip->chip.label);
@@ -319,24 +319,24 @@ static void s3c_pm_save_gpio(struct s3c_gpio_chip *ourchip)
 }
 
 /**
- * s3c_pm_save_gpios() - Save the state of the GPIO banks.
+ * samsung_pm_save_gpios() - Save the state of the GPIO banks.
  *
  * For all the GPIO banks, save the state of each one ready for going
  * into a suspend mode.
  */
-void s3c_pm_save_gpios(void)
+void samsung_pm_save_gpios(void)
 {
-	struct s3c_gpio_chip *ourchip;
+	struct samsung_gpio_chip *ourchip;
 	unsigned int gpio_nr;
 
 	for (gpio_nr = 0; gpio_nr < S3C_GPIO_END;) {
-		ourchip = s3c_gpiolib_getchip(gpio_nr);
+		ourchip = samsung_gpiolib_getchip(gpio_nr);
 		if (!ourchip) {
 			gpio_nr++;
 			continue;
 		}
 
-		s3c_pm_save_gpio(ourchip);
+		samsung_pm_save_gpio(ourchip);
 
 		S3C_PMDBG("%s: save %08x,%08x,%08x,%08x\n",
 			  ourchip->chip.label,
@@ -351,12 +351,12 @@ void s3c_pm_save_gpios(void)
 }
 
 /**
- * s3c_pm_resume_gpio() - restore gpio chip data after suspend
+ * samsung_pm_resume_gpio() - restore gpio chip data after suspend
  * @ourchip: The suspended chip.
  */
-static void s3c_pm_resume_gpio(struct s3c_gpio_chip *ourchip)
+static void samsung_pm_resume_gpio(struct samsung_gpio_chip *ourchip)
 {
-	struct s3c_gpio_pm *pm = ourchip->pm;
+	struct samsung_gpio_pm *pm = ourchip->pm;
 
 	if (pm == NULL || pm->resume == NULL)
 		S3C_PMDBG("%s: no pm for %s\n", __func__, ourchip->chip.label);
@@ -364,19 +364,19 @@ static void s3c_pm_resume_gpio(struct s3c_gpio_chip *ourchip)
 		pm->resume(ourchip);
 }
 
-void s3c_pm_restore_gpios(void)
+void samsung_pm_restore_gpios(void)
 {
-	struct s3c_gpio_chip *ourchip;
+	struct samsung_gpio_chip *ourchip;
 	unsigned int gpio_nr;
 
 	for (gpio_nr = 0; gpio_nr < S3C_GPIO_END;) {
-		ourchip = s3c_gpiolib_getchip(gpio_nr);
+		ourchip = samsung_gpiolib_getchip(gpio_nr);
 		if (!ourchip) {
 			gpio_nr++;
 			continue;
 		}
 
-		s3c_pm_resume_gpio(ourchip);
+		samsung_pm_resume_gpio(ourchip);
 
 		gpio_nr += ourchip->chip.ngpio;
 		gpio_nr += CONFIG_S3C_GPIO_SPACE;
diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index ae6f998..64ab65f 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -268,8 +268,8 @@ static int s3c_pm_enter(suspend_state_t state)
 
 	/* save all necessary core registers not covered by the drivers */
 
-	s3c_pm_save_gpios();
-	s3c_pm_saved_gpios();
+	samsung_pm_save_gpios();
+	samsung_pm_saved_gpios();
 	s3c_pm_save_uarts();
 	s3c_pm_save_core();
 
@@ -306,7 +306,7 @@ static int s3c_pm_enter(suspend_state_t state)
 
 	s3c_pm_restore_core();
 	s3c_pm_restore_uarts();
-	s3c_pm_restore_gpios();
+	samsung_pm_restore_gpios();
 	s3c_pm_restored_gpios();
 
 	s3c_pm_debug_init();
-- 
1.7.1
