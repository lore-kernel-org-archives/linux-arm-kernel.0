From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 21 Sep 2010 00:00:51 +0200
Subject: [PATCH] ARM: s3c2442: Setup gpio {set,get}_pull callbacks
Message-ID: <1285020052-20020-1-git-send-email-lars@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the {set,get}_pull callbacks of the s3c24xx_gpiocfg_default structure
are not initalized for the s3c2442 cpu type. This results in a NULL-pointer
deref upon calling s3c_gpio_setpull.

The s3c2442 has pulldowns instead of pullups compared to the s3c2440.
The method of controlling them is the same though.
So this patch modifies the existing s3c_gpio_{get,set}pull_1up helper functions
to take an additional parameter deciding whether the pin has a pullup or
pulldown.
The s3c_gpio_{get,set}pull_1{down,up} functions then wrap that functions passing
either S3C_GPIO_PULL_UP or S3C_GPIO_PULL_DOWN.

Furthermore this patch sets up the s3c24xx_gpiocfg_default.{get,set}_pull fields
in the s3c2442 cpu init function to the new pulldown helper functions.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/arm/mach-s3c2440/Kconfig                      |    1 +
 arch/arm/mach-s3c2440/s3c2442.c                    |    7 +++
 arch/arm/plat-samsung/gpio-config.c                |   43 ++++++++++++++++---
 .../plat-samsung/include/plat/gpio-cfg-helpers.h   |   11 +++++
 4 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
index cd8e7de..136ebd0 100644
--- a/arch/arm/mach-s3c2440/Kconfig
+++ b/arch/arm/mach-s3c2440/Kconfig
@@ -20,6 +20,7 @@ config CPU_S3C2442
 	bool
 	depends on ARCH_S3C2410
 	select CPU_ARM920T
+	select S3C_GPIO_PULL_DOWN
 	select S3C2410_CLOCK
 	select S3C2410_GPIO
 	select S3C2410_PM if PM
diff --git a/arch/arm/mach-s3c2440/s3c2442.c b/arch/arm/mach-s3c2440/s3c2442.c
index 188ad1e..0dbc91c 100644
--- a/arch/arm/mach-s3c2440/s3c2442.c
+++ b/arch/arm/mach-s3c2440/s3c2442.c
@@ -32,6 +32,7 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/mutex.h>
+#include <linux/gpio.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 
@@ -44,6 +45,10 @@
 #include <plat/clock.h>
 #include <plat/cpu.h>
 
+#include <plat/gpio-core.h>
+#include <plat/gpio-cfg.h>
+#include <plat/gpio-cfg-helpers.h>
+
 /* S3C2442 extended clock support */
 
 static unsigned long s3c2442_camif_upll_round(struct clk *clk,
@@ -160,6 +165,8 @@ static struct sys_device s3c2442_sysdev = {
 int __init s3c2442_init(void)
 {
 	printk("S3C2442: Initialising architecture\n");
+	s3c24xx_gpiocfg_default.set_pull = s3c_gpio_setpull_1down;
+	s3c24xx_gpiocfg_default.get_pull = s3c_gpio_getpull_1down;
 
 	return sysdev_register(&s3c2442_sysdev);
 }
diff --git a/arch/arm/plat-samsung/gpio-config.c b/arch/arm/plat-samsung/gpio-config.c
index 57b68a5..1abc81e 100644
--- a/arch/arm/plat-samsung/gpio-config.c
+++ b/arch/arm/plat-samsung/gpio-config.c
@@ -230,16 +230,16 @@ s3c_gpio_pull_t s3c_gpio_getpull_updown(struct s3c_gpio_chip *chip,
 }
 #endif
 
-#ifdef CONFIG_S3C_GPIO_PULL_UP
-int s3c_gpio_setpull_1up(struct s3c_gpio_chip *chip,
-			 unsigned int off, s3c_gpio_pull_t pull)
+#if defined(CONFIG_S3C_GPIO_PULL_UP) || defined(CONFIG_S3C_GPIO_PULL_DOWN)
+static int s3c_gpio_setpull_1(struct s3c_gpio_chip *chip,
+			 unsigned int off, s3c_gpio_pull_t pull, s3c_gpio_pull_t updown)
 {
 	void __iomem *reg = chip->base + 0x08;
 	u32 pup = __raw_readl(reg);
 
 	pup = __raw_readl(reg);
 
-	if (pup == S3C_GPIO_PULL_UP)
+	if (pup == updown)
 		pup &= ~(1 << off);
 	else if (pup == S3C_GPIO_PULL_NONE)
 		pup |= (1 << off);
@@ -250,17 +250,46 @@ int s3c_gpio_setpull_1up(struct s3c_gpio_chip *chip,
 	return 0;
 }
 
-s3c_gpio_pull_t s3c_gpio_getpull_1up(struct s3c_gpio_chip *chip,
-				     unsigned int off)
+static s3c_gpio_pull_t s3c_gpio_getpull_1(struct s3c_gpio_chip *chip,
+				     unsigned int off, s3c_gpio_pull_t updown)
 {
 	void __iomem *reg = chip->base + 0x08;
 	u32 pup = __raw_readl(reg);
 
 	pup &= (1 << off);
-	return pup ? S3C_GPIO_PULL_NONE : S3C_GPIO_PULL_UP;
+	return pup ? S3C_GPIO_PULL_NONE : updown;
+}
+#endif /* defined(CONFIG_S3C_GPIO_PULL_UP) || defined(CONFIG_S3C_GPIO_PULL_DOWN) */
+
+#ifdef CONFIG_S3C_GPIO_PULL_UP
+s3c_gpio_pull_t s3c_gpio_getpull_1up(struct s3c_gpio_chip *chip,
+				     unsigned int off)
+{
+	return s3c_gpio_getpull_1(chip, off, S3C_GPIO_PULL_UP);
+}
+
+int s3c_gpio_setpull_1up(struct s3c_gpio_chip *chip,
+			 unsigned int off, s3c_gpio_pull_t pull)
+{
+	return s3c_gpio_setpull_1(chip, off, pull, S3C_GPIO_PULL_UP);
 }
 #endif /* CONFIG_S3C_GPIO_PULL_UP */
 
+#ifdef CONFIG_S3C_GPIO_PULL_DOWN
+s3c_gpio_pull_t s3c_gpio_getpull_1down(struct s3c_gpio_chip *chip,
+				     unsigned int off)
+{
+	return s3c_gpio_getpull_1(chip, off, S3C_GPIO_PULL_DOWN);
+}
+
+int s3c_gpio_setpull_1down(struct s3c_gpio_chip *chip,
+			 unsigned int off, s3c_gpio_pull_t pull)
+{
+	return s3c_gpio_setpull_1(chip, off, pull, S3C_GPIO_PULL_DOWN);
+}
+#endif /* CONFIG_S3C_GPIO_PULL_DOWN */
+
+
 #ifdef CONFIG_S5P_GPIO_DRVSTR
 s5p_gpio_drvstr_t s5p_gpio_get_drvstr(unsigned int pin)
 {
diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h b/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
index 3e21c75..9fd2947 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
@@ -204,6 +204,17 @@ extern s3c_gpio_pull_t s3c_gpio_getpull_1up(struct s3c_gpio_chip *chip,
 					    unsigned int off);
 
 /**
+ * s3c_gpio_getpull_1down() - Get configuration for choice of down or none
+ * @chip: The gpio chip that the GPIO pin belongs to
+ * @off: The offset to the pin to get the configuration of.
+ *
+ * This helper function reads the state of the pull-down resistor for the
+ * given GPIO in the same case as s3c_gpio_setpull_1down.
+*/
+extern s3c_gpio_pull_t s3c_gpio_getpull_1down(struct s3c_gpio_chip *chip,
+					    unsigned int off);
+
+/**
  * s3c_gpio_setpull_s3c2443() - Pull configuration for s3c2443.
  * @chip: The gpio chip that is being configured.
  * @off: The offset for the GPIO being configured.
-- 
1.5.6.5
