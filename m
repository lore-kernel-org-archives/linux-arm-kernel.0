From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed,  1 Dec 2010 08:29:23 +0200
Subject: [PATCH v6] ARM: s3c244x: Fix mess with gpio {set,get}_pull callbacks
In-Reply-To: <000d01cb9118$9136c740$b3a455c0$%kim@samsung.com>
References: <000d01cb9118$9136c740$b3a455c0$%kim@samsung.com>
Message-ID: <1291184963-8412-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the {set,get}_pull callbacks of the s3c24xx_gpiocfg_default structure
are initalized via s3c_gpio_{get,set}pull_1up. This results in a linker
error when only CONFIG_CPU_S3C2442 is selected:

arch/arm/plat-s3c24xx/built-in.o:(.data+0x13f4): undefined reference to
`s3c_gpio_getpull_1up'
arch/arm/plat-s3c24xx/built-in.o:(.data+0x13f8): undefined reference to
`s3c_gpio_setpull_1up'

The s3c2442 has pulldowns instead of pullups compared to the s3c2440.
The method of controlling them is the same though.
So this patch modifies the existing s3c_gpio_{get,set}pull_1up helper functions
to take an additional parameter deciding whether the pin has a pullup or pulldown.
The s3c_gpio_{get,set}pull_1{down,up} functions then wrap that functions passing
either S3C_GPIO_PULL_UP or S3C_GPIO_PULL_DOWN.

Furthermore this patch sets up the s3c24xx_gpiocfg_default.{get,set}_pull fields
in the s3c244{0,2}_map_io function to the new pulldown helper functions.

Based on patch from "Lars-Peter Clausen" <lars@metafoo.de>

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
v2: adapt patch for 2.6.37-rc1
v3: restore default pull callbacks, add default pull callbacks for s3c2442
v4: remove default pull callbacks, set them in per-soc map_io function instead.
v5: fix obvious mistake in setpull_1
v6: fix another obvious mistake in setpull_1
 arch/arm/mach-s3c2440/Kconfig                      |    1 +
 arch/arm/mach-s3c2440/s3c2440.c                    |   11 +++-
 arch/arm/mach-s3c2440/s3c2442.c                    |   14 ++++++
 arch/arm/plat-s3c24xx/cpu.c                        |    8 ++--
 arch/arm/plat-s3c24xx/gpiolib.c                    |    2 -
 arch/arm/plat-s3c24xx/include/plat/s3c244x.h       |    7 +++-
 arch/arm/plat-samsung/gpio-config.c                |   47 +++++++++++++++----
 .../plat-samsung/include/plat/gpio-cfg-helpers.h   |   11 +++++
 8 files changed, 81 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
index ff024a6..478fae0 100644
--- a/arch/arm/mach-s3c2440/Kconfig
+++ b/arch/arm/mach-s3c2440/Kconfig
@@ -18,6 +18,7 @@ config CPU_S3C2440
 config CPU_S3C2442
 	bool
 	select CPU_ARM920T
+	select S3C_GPIO_PULL_DOWN
 	select S3C2410_CLOCK
 	select S3C2410_GPIO
 	select S3C2410_PM if PM
diff --git a/arch/arm/mach-s3c2440/s3c2440.c b/arch/arm/mach-s3c2440/s3c2440.c
index d50f3ae..f7663f7 100644
--- a/arch/arm/mach-s3c2440/s3c2440.c
+++ b/arch/arm/mach-s3c2440/s3c2440.c
@@ -46,9 +46,6 @@ int __init s3c2440_init(void)
 {
 	printk("S3C2440: Initialising architecture\n");
 
-	s3c24xx_gpiocfg_default.set_pull = s3c_gpio_setpull_1up;
-	s3c24xx_gpiocfg_default.get_pull = s3c_gpio_getpull_1up;
-
 	/* change irq for watchdog */
 
 	s3c_device_wdt.resource[1].start = IRQ_S3C2440_WDT;
@@ -58,3 +55,11 @@ int __init s3c2440_init(void)
 
 	return sysdev_register(&s3c2440_sysdev);
 }
+
+void __init s3c2440_map_io(void)
+{
+	s3c244x_map_io();
+
+	s3c24xx_gpiocfg_default.set_pull = s3c_gpio_setpull_1up;
+	s3c24xx_gpiocfg_default.get_pull = s3c_gpio_getpull_1up;
+}
diff --git a/arch/arm/mach-s3c2440/s3c2442.c b/arch/arm/mach-s3c2440/s3c2442.c
index 188ad1e..ecf8135 100644
--- a/arch/arm/mach-s3c2440/s3c2442.c
+++ b/arch/arm/mach-s3c2440/s3c2442.c
@@ -32,6 +32,7 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/mutex.h>
+#include <linux/gpio.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 
@@ -43,6 +44,11 @@
 
 #include <plat/clock.h>
 #include <plat/cpu.h>
+#include <plat/s3c244x.h>
+
+#include <plat/gpio-core.h>
+#include <plat/gpio-cfg.h>
+#include <plat/gpio-cfg-helpers.h>
 
 /* S3C2442 extended clock support */
 
@@ -163,3 +169,11 @@ int __init s3c2442_init(void)
 
 	return sysdev_register(&s3c2442_sysdev);
 }
+
+void __init s3c2442_map_io(void)
+{
+	s3c244x_map_io();
+
+	s3c24xx_gpiocfg_default.set_pull = s3c_gpio_setpull_1down;
+	s3c24xx_gpiocfg_default.get_pull = s3c_gpio_getpull_1down;
+}
diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index 76d0858..4a10c0f 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -88,7 +88,7 @@ static struct cpu_table cpu_ids[] __initdata = {
 	{
 		.idcode		= 0x32440000,
 		.idmask		= 0xffffffff,
-		.map_io		= s3c244x_map_io,
+		.map_io		= s3c2440_map_io,
 		.init_clocks	= s3c244x_init_clocks,
 		.init_uarts	= s3c244x_init_uarts,
 		.init		= s3c2440_init,
@@ -97,7 +97,7 @@ static struct cpu_table cpu_ids[] __initdata = {
 	{
 		.idcode		= 0x32440001,
 		.idmask		= 0xffffffff,
-		.map_io		= s3c244x_map_io,
+		.map_io		= s3c2440_map_io,
 		.init_clocks	= s3c244x_init_clocks,
 		.init_uarts	= s3c244x_init_uarts,
 		.init		= s3c2440_init,
@@ -106,7 +106,7 @@ static struct cpu_table cpu_ids[] __initdata = {
 	{
 		.idcode		= 0x32440aaa,
 		.idmask		= 0xffffffff,
-		.map_io		= s3c244x_map_io,
+		.map_io		= s3c2442_map_io,
 		.init_clocks	= s3c244x_init_clocks,
 		.init_uarts	= s3c244x_init_uarts,
 		.init		= s3c2442_init,
@@ -115,7 +115,7 @@ static struct cpu_table cpu_ids[] __initdata = {
 	{
 		.idcode		= 0x32440aab,
 		.idmask		= 0xffffffff,
-		.map_io		= s3c244x_map_io,
+		.map_io		= s3c2442_map_io,
 		.init_clocks	= s3c244x_init_clocks,
 		.init_uarts	= s3c244x_init_uarts,
 		.init		= s3c2442_init,
diff --git a/arch/arm/plat-s3c24xx/gpiolib.c b/arch/arm/plat-s3c24xx/gpiolib.c
index 24c6f5a..243b641 100644
--- a/arch/arm/plat-s3c24xx/gpiolib.c
+++ b/arch/arm/plat-s3c24xx/gpiolib.c
@@ -82,8 +82,6 @@ static struct s3c_gpio_cfg s3c24xx_gpiocfg_banka = {
 struct s3c_gpio_cfg s3c24xx_gpiocfg_default = {
 	.set_config	= s3c_gpio_setcfg_s3c24xx,
 	.get_config	= s3c_gpio_getcfg_s3c24xx,
-	.set_pull	= s3c_gpio_setpull_1up,
-	.get_pull	= s3c_gpio_getpull_1up,
 };
 
 struct s3c_gpio_chip s3c24xx_gpios[] = {
diff --git a/arch/arm/plat-s3c24xx/include/plat/s3c244x.h b/arch/arm/plat-s3c24xx/include/plat/s3c244x.h
index 307248d..89e8d0a 100644
--- a/arch/arm/plat-s3c24xx/include/plat/s3c244x.h
+++ b/arch/arm/plat-s3c24xx/include/plat/s3c244x.h
@@ -21,17 +21,22 @@ extern void s3c244x_init_clocks(int xtal);
 #else
 #define s3c244x_init_clocks NULL
 #define s3c244x_init_uarts NULL
-#define s3c244x_map_io NULL
 #endif
 
 #ifdef CONFIG_CPU_S3C2440
 extern  int s3c2440_init(void);
+
+extern void s3c2440_map_io(void);
 #else
 #define s3c2440_init NULL
+#define s3c2440_map_io NULL
 #endif
 
 #ifdef CONFIG_CPU_S3C2442
 extern  int s3c2442_init(void);
+
+extern void s3c2442_map_io(void);
 #else
 #define s3c2442_init NULL
+#define s3c2442_map_io NULL
 #endif
diff --git a/arch/arm/plat-samsung/gpio-config.c b/arch/arm/plat-samsung/gpio-config.c
index b732b77..0aa32f2 100644
--- a/arch/arm/plat-samsung/gpio-config.c
+++ b/arch/arm/plat-samsung/gpio-config.c
@@ -280,18 +280,17 @@ s3c_gpio_pull_t s3c_gpio_getpull_updown(struct s3c_gpio_chip *chip,
 }
 #endif
 
-#ifdef CONFIG_S3C_GPIO_PULL_UP
-int s3c_gpio_setpull_1up(struct s3c_gpio_chip *chip,
-			 unsigned int off, s3c_gpio_pull_t pull)
+#if defined(CONFIG_S3C_GPIO_PULL_UP) || defined(CONFIG_S3C_GPIO_PULL_DOWN)
+static int s3c_gpio_setpull_1(struct s3c_gpio_chip *chip,
+			 unsigned int off, s3c_gpio_pull_t pull,
+			 s3c_gpio_pull_t updown)
 {
 	void __iomem *reg = chip->base + 0x08;
 	u32 pup = __raw_readl(reg);
 
-	pup = __raw_readl(reg);
-
-	if (pup == S3C_GPIO_PULL_UP)
+	if (pull == updown)
 		pup &= ~(1 << off);
-	else if (pup == S3C_GPIO_PULL_NONE)
+	else if (pull == S3C_GPIO_PULL_NONE)
 		pup |= (1 << off);
 	else
 		return -EINVAL;
@@ -300,17 +299,45 @@ int s3c_gpio_setpull_1up(struct s3c_gpio_chip *chip,
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
+#endif /* CONFIG_S3C_GPIO_PULL_UP || CONFIG_S3C_GPIO_PULL_DOWN */
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
 #ifdef CONFIG_S5P_GPIO_DRVSTR
 s5p_gpio_drvstr_t s5p_gpio_get_drvstr(unsigned int pin)
 {
diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h b/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
index 8fd65d8..0d2c570 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
@@ -210,6 +210,17 @@ extern s3c_gpio_pull_t s3c_gpio_getpull_1up(struct s3c_gpio_chip *chip,
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
1.7.3.2
