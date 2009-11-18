From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 18 Nov 2009 14:32:59 +0100
Subject: [PATCH 04/19] ARM: S5PC1XX: prepare common gpiolib code for S5PC110
	sub-platform
In-Reply-To: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
References: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1258551194-16018-5-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

S5PC100 GPIO chip definitions has been hidden under sub-platform #ifdef
CONFIG_CPU_S5PC100. Also a new S5PC1XX_GPHx() macros has been introduced
to cover common external interrupt gpio lines (for common code).

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>


---
 arch/arm/mach-s5pc100/include/mach/gpio.h          |    7 ++++++
 .../include/plat/irqs.h                            |    2 +-
 .../include/plat/regs-gpio.h                       |    2 +-
 arch/arm/plat-s5pc1xx/gpiolib.c                    |   17 ++++++++++-----
 arch/arm/plat-s5pc1xx/irq-eint.c                   |   13 +++++------
 arch/arm/plat-s5pc1xx/irq-gpio.c                   |   22 ++++++++++++-------
 6 files changed, 40 insertions(+), 23 deletions(-)
 rename arch/arm/{plat-s5pc1xx => mach-s5pc100}/include/plat/irqs.h (99%)
 rename arch/arm/{plat-s5pc1xx => mach-s5pc100}/include/plat/regs-gpio.h (98%)

diff --git a/arch/arm/mach-s5pc100/include/mach/gpio.h b/arch/arm/mach-s5pc100/include/mach/gpio.h
index 2c4cbe8..851577c 100644
--- a/arch/arm/mach-s5pc100/include/mach/gpio.h
+++ b/arch/arm/mach-s5pc100/include/mach/gpio.h
@@ -159,4 +159,11 @@ enum s3c_gpio_number {
 /* define the number of gpios we need to the one after the MP04() range */
 #define ARCH_NR_GPIOS		(S5PC100_GPIO_END + 1)
 
+/* Common compatibility defines */
+#define S5PC1XX_GPIO_EINT_SFN	S3C_GPIO_SFN(0x2)
+#define S5PC1XX_GPH0(n)		S5PC100_GPH0(n)
+#define S5PC1XX_GPH1(n)		S5PC100_GPH1(n)
+#define S5PC1XX_GPH2(n)		S5PC100_GPH2(n)
+#define S5PC1XX_GPH3(n)		S5PC100_GPH3(n)
+
 #include <asm-generic/gpio.h>
diff --git a/arch/arm/plat-s5pc1xx/include/plat/irqs.h b/arch/arm/mach-s5pc100/include/plat/irqs.h
similarity index 99%
rename from arch/arm/plat-s5pc1xx/include/plat/irqs.h
rename to arch/arm/mach-s5pc100/include/plat/irqs.h
index ef87363..e34e2ef 100644
--- a/arch/arm/plat-s5pc1xx/include/plat/irqs.h
+++ b/arch/arm/mach-s5pc100/include/plat/irqs.h
@@ -3,7 +3,7 @@
  * Copyright 2009 Samsung Electronics Co.
  *      Byungho Min <bhmin@samsung.com>
  *
- * S5PC1XX - Common IRQ support
+ * S5PC100 - Common IRQ support
  *
  * Based on plat-s3c64xx/include/plat/irqs.h
  */
diff --git a/arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h b/arch/arm/mach-s5pc100/include/plat/regs-gpio.h
similarity index 98%
rename from arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h
rename to arch/arm/mach-s5pc100/include/plat/regs-gpio.h
index 43c7bc8..87e1884 100644
--- a/arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h
+++ b/arch/arm/mach-s5pc100/include/plat/regs-gpio.h
@@ -3,7 +3,7 @@
  * Copyright 2009 Samsung Electronics Co.
  *      Byungho Min <bhmin@samsung.com>
  *
- * S5PC1XX - GPIO register definitions
+ * S5PC100 - GPIO register definitions
  */
 
 #ifndef __ASM_PLAT_S5PC1XX_REGS_GPIO_H
diff --git a/arch/arm/plat-s5pc1xx/gpiolib.c b/arch/arm/plat-s5pc1xx/gpiolib.c
index facb410..60bf31d 100644
--- a/arch/arm/plat-s5pc1xx/gpiolib.c
+++ b/arch/arm/plat-s5pc1xx/gpiolib.c
@@ -138,18 +138,19 @@ static int s5pc1xx_gpiolib_to_eint(struct gpio_chip *chip, unsigned int offset)
 {
 	int base;
 
-	base = chip->base - S5PC100_GPH0(0);
+	base = chip->base - S5PC1XX_GPH0(0);
 	if (base == 0)
 		return IRQ_EINT(offset);
-	base = chip->base - S5PC100_GPH1(0);
+	base = chip->base - S5PC1XX_GPH1(0);
 	if (base == 0)
 		return IRQ_EINT(8 + offset);
-	base = chip->base - S5PC100_GPH2(0);
+	base = chip->base - S5PC1XX_GPH2(0);
 	if (base == 0)
 		return IRQ_EINT(16 + offset);
-	base = chip->base - S5PC100_GPH3(0);
+	base = chip->base - S5PC1XX_GPH3(0);
 	if (base == 0)
 		return IRQ_EINT(24 + offset);
+
 	return -EINVAL;
 }
 
@@ -172,6 +173,7 @@ static struct s3c_gpio_cfg gpio_cfg_noint = {
 	.get_pull	= s3c_gpio_getpull_updown,
 };
 
+#ifdef CONFIG_CPU_S5PC100
 static struct s3c_gpio_chip s5pc100_gpio_chips[] = {
 	{
 		.base	= S5PC100_GPA0_BASE,
@@ -448,6 +450,9 @@ static struct s3c_gpio_chip s5pc100_gpio_chips[] = {
 	},
 };
 
+#define s5pc1xx_gpio_chips s5pc100_gpio_chips
+
+#endif
 /* FIXME move from irq-gpio.c */
 extern struct irq_chip s5pc1xx_gpioint;
 extern void s5pc1xx_irq_gpioint_handler(unsigned int irq, struct irq_desc *desc);
@@ -491,8 +496,8 @@ static __init int s5pc1xx_gpiolib_init(void)
 	struct s3c_gpio_chip *chips;
 	int nr_chips;
 
-		chips = s5pc100_gpio_chips;
-		nr_chips = ARRAY_SIZE(s5pc100_gpio_chips);
+	chips = s5pc1xx_gpio_chips;
+	nr_chips = ARRAY_SIZE(s5pc1xx_gpio_chips);
 
 	s5pc1xx_gpiolib_add(chips, nr_chips, s5pc1xx_gpiolib_link);
 	/* Interrupt */
diff --git a/arch/arm/plat-s5pc1xx/irq-eint.c b/arch/arm/plat-s5pc1xx/irq-eint.c
index 373122f..9e8bc12 100644
--- a/arch/arm/plat-s5pc1xx/irq-eint.c
+++ b/arch/arm/plat-s5pc1xx/irq-eint.c
@@ -105,7 +105,7 @@ static int s3c_irq_eint_set_type(unsigned int irq, unsigned int type)
 {
 	u32 bank = s3c_get_bank(irq);
 	int real = s3c_get_eint(irq);
-	int gpio, shift, sfn;
+	int gpio, shift;
 	u32 ctrl, con = 0;
 
 	switch (type) {
@@ -148,23 +148,22 @@ static int s3c_irq_eint_set_type(unsigned int irq, unsigned int type)
 
 	switch (real) {
 	case 0 ... 7:
-			gpio = S5PC100_GPH0(gpio);
+		gpio = S5PC1XX_GPH0(gpio);
 		break;
 	case 8 ... 15:
-			gpio = S5PC100_GPH1(gpio);
+		gpio = S5PC1XX_GPH1(gpio);
 		break;
 	case 16 ... 23:
-			gpio = S5PC100_GPH2(gpio);
+		gpio = S5PC1XX_GPH2(gpio);
 		break;
 	case 24 ... 31:
-			gpio = S5PC100_GPH3(gpio);
+		gpio = S5PC1XX_GPH3(gpio);
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	sfn = S3C_GPIO_SFN(0x2);
-	s3c_gpio_cfgpin(gpio, sfn);
+	s3c_gpio_cfgpin(gpio, S5PC1XX_GPIO_EINT_SFN);
 
 	return 0;
 }
diff --git a/arch/arm/plat-s5pc1xx/irq-gpio.c b/arch/arm/plat-s5pc1xx/irq-gpio.c
index fecca7a..f5d8dab 100644
--- a/arch/arm/plat-s5pc1xx/irq-gpio.c
+++ b/arch/arm/plat-s5pc1xx/irq-gpio.c
@@ -49,7 +49,9 @@ static int group_to_pend_offset(int group)
 	return group << 2;
 }
 
-static int s5pc1xx_get_start(unsigned int group)
+#ifdef CONFIG_CPU_S5PC100
+
+static int s5pc100_get_start(unsigned int group)
 {
 	switch (group) {
 	case 0: return S5PC100_GPIO_A0_START;
@@ -76,11 +78,10 @@ static int s5pc1xx_get_start(unsigned int group)
 	default:
 		BUG();
 	}
-
 	return -EINVAL;
 }
 
-static int s5pc1xx_get_group(unsigned int irq)
+static int s5pc100_get_group(unsigned int irq)
 {
 	irq -= S3C_IRQ_GPIO(0);
 
@@ -130,10 +131,17 @@ static int s5pc1xx_get_group(unsigned int irq)
 	default:
 		BUG();
 	}
-
 	return -EINVAL;
 }
 
+static int s5pc100_group_end = 21;
+
+#define s5pc1xx_get_group s5pc100_get_group
+#define s5pc1xx_get_start s5pc100_get_start
+#define s5pc1xx_group_end s5pc100_group_end
+
+#endif
+
 static int s5pc1xx_get_offset(unsigned int irq)
 {
 	struct gpio_chip *chip = get_irq_data(irq);
@@ -241,12 +249,10 @@ struct irq_chip s5pc1xx_gpioint = {
 void s5pc1xx_irq_gpioint_handler(unsigned int irq, struct irq_desc *desc)
 {
 	int group, offset, pend_offset, mask_offset;
-	int real_irq, group_end;
+	int real_irq;
 	unsigned int pend, mask;
 
-	group_end = 21;
-
-	for (group = 0; group < group_end; group++) {
+	for (group = 0; group < s5pc1xx_group_end; group++) {
 		pend_offset = group_to_pend_offset(group);
 		pend = __raw_readl(S5PC1XX_GPIOREG(PEND_OFFSET) + pend_offset);
 		if (!pend)
-- 
1.6.4
