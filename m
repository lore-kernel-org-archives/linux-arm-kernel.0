From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 14 May 2010 09:40:03 +0100
Subject: [PATCH] ARM: S5P: Dynamicly numbered GPIO interrupt support
Message-ID: <1273826403-28976-1-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for GPIO interrupts where the interrupt number
is dynamically allocated at first request from gpiolib.

This method is employed as the newer SoCs have a large number
of possible interrupt numbers which are very rarely heavily
used. However, the classic code has always registered all
possible interrupts, using a large amount of memory for the
irq_desc[] table.

For example, S5PV210 has 178 possible GPIO interrupt sources
of which few boards actually use any of these. The current
size of a single irq_desc entry is 80 bytes, meaing to fully
support GPIO interrupts on the V210 we use 14240 bytes when
a board may only need a few of these.

NOTE: This code is not tested, and not even booted. it is
offered here as an example and if people think it is a good
idea, I will do the necessary run testing and checking.

not-quite-signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s5pv210/gpiolib.c                |   10 +++++++++-
 arch/arm/mach-s5pv210/include/mach/irqs.h      |    5 ++++-
 arch/arm/plat-s5p/Kconfig                      |    5 +++++
 arch/arm/plat-s5p/Makefile                     |    1 +
 arch/arm/plat-samsung/include/plat/gpio-core.h |    5 +++++
 5 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s5pv210/gpiolib.c b/arch/arm/mach-s5pv210/gpiolib.c
index 99dad92..68972ea 100644
--- a/arch/arm/mach-s5pv210/gpiolib.c
+++ b/arch/arm/mach-s5pv210/gpiolib.c
@@ -237,6 +237,12 @@ static struct s3c_gpio_chip s5pv210_gpio_4bit[] = {
 	},
 };
 
+static int to_gpio_irq_bank(int nr)
+{
+	if (nr >= 17)
+		return nr - 4;
+}
+
 static __init int s5pv210_gpiolib_init(void)
 {
 	struct s3c_gpio_chip *chip = s5pv210_gpio_4bit;
@@ -244,8 +250,10 @@ static __init int s5pv210_gpiolib_init(void)
 	int i = 0;
 
 	for (i = 0; i < nr_chips; i++, chip++) {
-		if (chip->config == NULL)
+		if (chip->config == NULL) {
 			chip->config = &gpio_cfg;
+			s5p_gpio_irq_register(chip, to_gpio_irq_bank(i));
+		}
 		if (chip->base == NULL)
 			chip->base = S5PV210_BANK_BASE(i);
 	}
diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-s5pv210/include/mach/irqs.h
index 1714be2..dca0067 100644
--- a/arch/arm/mach-s5pv210/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
@@ -144,8 +144,11 @@
 #define S5P_EINT_SET2(x)	S5PV210_GPH2(x)
 #define S5P_EINT_SET3(x)	S5PV210_GPH3(x)
 
+#define IRQ_GPIO_BASE		IRQ_EINT(31) + 1
+#define NR_GPIO_IRQS		(24)
+
 /* Set the default NR_IRQS */
 
-#define NR_IRQS 		(IRQ_EINT(31) + 1)
+#define NR_IRQS 		(IRQ_GPIO_BASE + NR_GPIO_IRQS)
 
 #endif /* ASM_ARCH_IRQS_H */
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index 7d1fc40..c6be4c0 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -28,3 +28,8 @@ config S5P_EXT_INT
 	bool
 	help
 	  Use the external interrupts (other than GPIO interrupts.)
+
+config S5P_GPIO_INT
+	bool "Support GPIO based interrupts"
+	help
+	  Enable support for GPIO interrupts
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index 25941a5..826f8a6 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -17,4 +17,5 @@ obj-y				+= cpu.o
 obj-y				+= clock.o
 obj-y				+= irq.o
 obj-$(CONFIG_S5P_EXT_INT)	+= irq-eint.o
+obj-$(CONFIG_S5P_GPIO_INT)	+= irq-gpio.o
 obj-y				+= setup-i2c0.o
diff --git a/arch/arm/plat-samsung/include/plat/gpio-core.h b/arch/arm/plat-samsung/include/plat/gpio-core.h
index 49ff406..8c246ce 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-core.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-core.h
@@ -38,6 +38,7 @@ struct s3c_gpio_pm {
 };
 
 struct s3c_gpio_cfg;
+struct s3c_gpio_irq;	/* irq implementation information */
 
 /**
  * struct s3c_gpio_chip - wrapper for specific implementation of gpio
@@ -53,6 +54,7 @@ struct s3c_gpio_chip {
 	struct gpio_chip	chip;
 	struct s3c_gpio_cfg	*config;
 	struct s3c_gpio_pm	*pm;
+	struct s3c_gpio_irq	*irq;
 	void __iomem		*base;
 #ifdef CONFIG_PM
 	u32			pm_save[4];
@@ -108,6 +110,9 @@ extern void samsung_gpiolib_add_4bit2_chips(struct s3c_gpio_chip *chip,
 extern void samsung_gpiolib_add_4bit(struct s3c_gpio_chip *chip);
 extern void samsung_gpiolib_add_4bit2(struct s3c_gpio_chip *chip);
 
+extern void s5p_gpio_irq_register(struct s3c_gpio_chip *chip,
+				  unsigned int bank_nr);
+
 #ifdef CONFIG_S3C_GPIO_TRACK
 extern struct s3c_gpio_chip *s3c_gpios[S3C_GPIO_END];
 
-- 
1.6.3.3
