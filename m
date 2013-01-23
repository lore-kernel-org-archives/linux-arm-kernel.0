From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 23 Jan 2013 16:25:49 +0800
Subject: [PATCH 05/10] gpio: pxa: remove gpio_type
In-Reply-To: <1358929554-32265-1-git-send-email-haojian.zhuang@linaro.org>
References: <1358929554-32265-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1358929554-32265-6-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since gpio_type is used to check whether gafr register is valid. So
move it into platform data.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-pxa/pxa25x.c |    1 +
 arch/arm/mach-pxa/pxa27x.c |    1 +
 drivers/gpio/gpio-pxa.c    |   43 ++++++-------------------------------------
 include/linux/gpio-pxa.h   |    1 +
 4 files changed, 9 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 8d77090..90415a6 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -343,6 +343,7 @@ static struct pxa_gpio_platform_data pxa25x_gpio_info __initdata = {
 #ifdef CONFIG_CPU_PXA26x
 	.inverted = 1,
 #endif
+	.gafr = 1,
 	.gpio_set_wake = gpio_set_wake,
 };
 
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 257d936..91ac5d9 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -422,6 +422,7 @@ void __init pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 }
 
 static struct pxa_gpio_platform_data pxa27x_gpio_info __initdata = {
+	.gafr = 1,
 	.gpio_set_wake = gpio_set_wake,
 };
 
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 6d61a69..8b3edc7 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -72,6 +72,7 @@ struct pxa_gpio_chip {
 	void __iomem	*regbase;
 	unsigned int	irq_base;
 	unsigned int	inverted;
+	unsigned int	gafr;
 	char label[10];
 
 	unsigned long	irq_mask;
@@ -87,18 +88,8 @@ struct pxa_gpio_chip {
 #endif
 };
 
-enum {
-	PXA25X_GPIO = 0,
-	PXA26X_GPIO,
-	PXA27X_GPIO,
-	PXA3XX_GPIO,
-	PXA93X_GPIO,
-	MMP_GPIO = 0x10,
-};
-
 static DEFINE_SPINLOCK(gpio_lock);
 static struct pxa_gpio_chip *pxa_gpio_chips;
-static int gpio_type;
 static void __iomem *gpio_reg_base;
 
 #define for_each_gpio_chip(i, c)			\
@@ -114,16 +105,6 @@ static inline struct pxa_gpio_chip *gpio_to_pxachip(unsigned gpio)
 	return &pxa_gpio_chips[gpio_to_bank(gpio)];
 }
 
-static inline int gpio_is_pxa_type(int type)
-{
-	return (type & MMP_GPIO) == 0;
-}
-
-static inline int gpio_is_mmp_type(int type)
-{
-	return (type & MMP_GPIO) != 0;
-}
-
 /* GPIO86/87/88/89 on PXA26x have their direction bits in PXA_GPDR(2 inverted,
  * as well as their Alternate Function value being '1' for GPIO in GAFRx.
  */
@@ -149,10 +130,7 @@ static inline int __gpio_is_occupied(struct pxa_gpio_chip *chip, unsigned gpio)
 	base = gpio_chip_base(&chip->chip);
 	gpdr = readl_relaxed(base + GPDR_OFFSET);
 
-	switch (gpio_type) {
-	case PXA25X_GPIO:
-	case PXA26X_GPIO:
-	case PXA27X_GPIO:
+	if (chip->gafr) {
 		gafr = readl_relaxed(base + GAFR_OFFSET);
 		af = (gafr >> ((gpio & 0xf) * 2)) & 0x3;
 		dir = gpdr & GPIO_bit(gpio);
@@ -161,10 +139,8 @@ static inline int __gpio_is_occupied(struct pxa_gpio_chip *chip, unsigned gpio)
 			ret = (af != 1) || (dir == 0);
 		else
 			ret = (af != 0) || (dir != 0);
-		break;
-	default:
+	} else {
 		ret = gpdr & GPIO_bit(gpio);
-		break;
 	}
 	return ret;
 }
@@ -412,30 +388,23 @@ static int pxa_gpio_nums(void)
 	if (cpu_is_pxa25x()) {
 #ifdef CONFIG_CPU_PXA26x
 		count = 89;
-		gpio_type = PXA26X_GPIO;
 #elif defined(CONFIG_PXA25x)
 		count = 84;
-		gpio_type = PXA26X_GPIO;
 #endif /* CONFIG_CPU_PXA26x */
 	} else if (cpu_is_pxa27x()) {
 		count = 120;
-		gpio_type = PXA27X_GPIO;
 	} else if (cpu_is_pxa93x()) {
 		count = 191;
-		gpio_type = PXA93X_GPIO;
 	} else if (cpu_is_pxa3xx()) {
 		count = 127;
-		gpio_type = PXA3XX_GPIO;
 	}
 #endif /* CONFIG_ARCH_PXA */
 
 #ifdef CONFIG_ARCH_MMP
 	if (cpu_is_pxa168() || cpu_is_pxa910()) {
 		count = 127;
-		gpio_type = MMP_GPIO;
 	} else if (cpu_is_mmp2()) {
 		count = 191;
-		gpio_type = MMP_GPIO;
 	}
 #endif /* CONFIG_ARCH_MMP */
 	return count;
@@ -444,7 +413,7 @@ static int pxa_gpio_nums(void)
 #ifdef CONFIG_OF
 static struct of_device_id pxa_gpio_dt_ids[] = {
 	{ .compatible = "mrvl,pxa-gpio" },
-	{ .compatible = "mrvl,mmp-gpio", .data = (void *)MMP_GPIO },
+	{ .compatible = "mrvl,mmp-gpio" },
 	{}
 };
 
@@ -486,7 +455,6 @@ static int pxa_gpio_probe_dt(struct platform_device *pdev)
 		pdata->inverted = 1;
 	/* set the platform data */
 	pdev->dev.platform_data = pdata;
-	gpio_type = (int)of_id->data;
 
 	next = of_get_next_child(np, NULL);
 	prev = next;
@@ -626,8 +594,9 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 		/* unmask GPIO edge detect for AP side */
 		if (info->ed_mask)
 			writel_relaxed(~0, c->regbase + ED_MASK_OFFSET);
-		/* update for gpio inverted */
+		/* update for gpio inverted & gafr */
 		c->inverted = info->inverted;
+		c->gafr = info->gafr;
 	}
 
 	if (!use_of) {
diff --git a/include/linux/gpio-pxa.h b/include/linux/gpio-pxa.h
index c8d07be5..5a9e003 100644
--- a/include/linux/gpio-pxa.h
+++ b/include/linux/gpio-pxa.h
@@ -17,6 +17,7 @@ extern int pxa_irq_to_gpio(struct irq_data *d);
 
 struct pxa_gpio_platform_data {
 	unsigned ed_mask;	/* not 0 means ed_mask reg is available */
+	unsigned gafr;		/* only valid for PXA25x/PXA26x/PXA27x */
 	unsigned inverted;	/* only valid for PXA26x */
 	int (*gpio_set_wake)(unsigned int gpio, unsigned int on);
 };
-- 
1.7.10.4
