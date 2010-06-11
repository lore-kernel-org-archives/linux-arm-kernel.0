From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Fri, 11 Jun 2010 17:33:20 +0900
Subject: [PATCH v2 4/4] ARM: SAMSUNG: Add GPIOlib gpio_to_irq
In-Reply-To: <1276245200-18052-1-git-send-email-jy0922.shim@samsung.com>
References: <1276245200-18052-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <1276245200-18052-4-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to support gpio_to_irq() of GPIOlib for external and gpio
interrupts, then needs adding irq_base member to s3c_gpio_chip struct.
The gpio_to_irq() calls samsung_gpiolib_to_irq function.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pc100/gpiolib.c                |   38 +++++++-----------------
 arch/arm/mach-s5pv210/gpiolib.c                |   10 ++++++
 arch/arm/plat-samsung/gpiolib.c                |    9 +++++
 arch/arm/plat-samsung/include/plat/gpio-core.h |    4 ++
 4 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-s5pc100/gpiolib.c b/arch/arm/mach-s5pc100/gpiolib.c
index 40c3e56..3bcbfc1 100644
--- a/arch/arm/mach-s5pc100/gpiolib.c
+++ b/arch/arm/mach-s5pc100/gpiolib.c
@@ -61,30 +61,6 @@
  * L3	8	4Bit	None
  */
 
-static int s5pc100_gpiolib_to_irq(struct gpio_chip *chip, unsigned int offset)
-{
-	return S5P_IRQ_GPIOINT(chip->base + offset);
-}
-
-static int s5pc100_gpiolib_to_eint(struct gpio_chip *chip, unsigned int offset)
-{
-	int base;
-
-	base = chip->base - S5PC100_GPH0(0);
-	if (base == 0)
-		return IRQ_EINT(offset);
-	base = chip->base - S5PC100_GPH1(0);
-	if (base == 0)
-		return IRQ_EINT(8 + offset);
-	base = chip->base - S5PC100_GPH2(0);
-	if (base == 0)
-		return IRQ_EINT(16 + offset);
-	base = chip->base - S5PC100_GPH3(0);
-	if (base == 0)
-		return IRQ_EINT(24 + offset);
-	return -EINVAL;
-}
-
 static struct s3c_gpio_cfg gpio_cfg = {
 	.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
 	.set_pull	= s3c_gpio_setpull_updown,
@@ -228,34 +204,42 @@ static struct s3c_gpio_chip s5pc100_gpio_chips[] = {
 	}, {
 		.base	= S5PC100_GPH0_BASE,
 		.config	= &gpio_cfg_eint,
+		.irq_base = IRQ_EINT(0),
 		.chip	= {
 			.base	= S5PC100_GPH0(0),
 			.ngpio	= S5PC100_GPIO_H0_NR,
 			.label	= "GPH0",
+			.to_irq = samsung_gpiolib_to_irq,
 		},
 	}, {
 		.base	= S5PC100_GPH1_BASE,
 		.config	= &gpio_cfg_eint,
+		.irq_base = IRQ_EINT(8),
 		.chip	= {
 			.base	= S5PC100_GPH1(0),
 			.ngpio	= S5PC100_GPIO_H1_NR,
 			.label	= "GPH1",
+			.to_irq = samsung_gpiolib_to_irq,
 		},
 	}, {
 		.base	= S5PC100_GPH2_BASE,
 		.config	= &gpio_cfg_eint,
+		.irq_base = IRQ_EINT(16),
 		.chip	= {
 			.base	= S5PC100_GPH2(0),
 			.ngpio	= S5PC100_GPIO_H2_NR,
 			.label	= "GPH2",
+			.to_irq = samsung_gpiolib_to_irq,
 		},
 	}, {
 		.base	= S5PC100_GPH3_BASE,
 		.config	= &gpio_cfg_eint,
+		.irq_base = IRQ_EINT(24),
 		.chip	= {
 			.base	= S5PC100_GPH3(0),
 			.ngpio	= S5PC100_GPIO_H3_NR,
 			.label	= "GPH3",
+			.to_irq = samsung_gpiolib_to_irq,
 		},
 	}, {
 		.base	= S5PC100_GPI_BASE,
@@ -392,10 +376,10 @@ static __init int s5pc100_gpiolib_init(void)
 	for (; nr_chips > 0; nr_chips--, chip++) {
 		if (chip->config == &gpio_cfg) {
 			/* gpio interrupts */
-			chip->chip.to_irq = s5pc100_gpiolib_to_irq;
+			chip->irq_base = S5P_IRQ_GPIOINT(chip->chip.base),
+			chip->chip.to_irq = samsung_gpiolib_to_irq;
 			s5p_gpioint_add(chip, gpioint_group++);
-		} else if (chip->config == &gpio_cfg_eint)
-			chip->chip.to_irq = s5pc100_gpiolib_to_eint;
+		}
 	}
 
 	samsung_gpiolib_add_4bit_chips(s5pc100_gpio_chips,
diff --git a/arch/arm/mach-s5pv210/gpiolib.c b/arch/arm/mach-s5pv210/gpiolib.c
index 16d6747..a4f28f1 100644
--- a/arch/arm/mach-s5pv210/gpiolib.c
+++ b/arch/arm/mach-s5pv210/gpiolib.c
@@ -210,34 +210,42 @@ static struct s3c_gpio_chip s5pv210_gpio_4bit[] = {
 	}, {
 		.base	= (S5P_VA_GPIO + 0xC00),
 		.config	= &gpio_cfg_noint,
+		.irq_base = IRQ_EINT(0),
 		.chip	= {
 			.base	= S5PV210_GPH0(0),
 			.ngpio	= S5PV210_GPIO_H0_NR,
 			.label	= "GPH0",
+			.to_irq = samsung_gpiolib_to_irq,
 		},
 	}, {
 		.base	= (S5P_VA_GPIO + 0xC20),
 		.config	= &gpio_cfg_noint,
+		.irq_base = IRQ_EINT(8),
 		.chip	= {
 			.base	= S5PV210_GPH1(0),
 			.ngpio	= S5PV210_GPIO_H1_NR,
 			.label	= "GPH1",
+			.to_irq = samsung_gpiolib_to_irq,
 		},
 	}, {
 		.base	= (S5P_VA_GPIO + 0xC40),
 		.config	= &gpio_cfg_noint,
+		.irq_base = IRQ_EINT(16),
 		.chip	= {
 			.base	= S5PV210_GPH2(0),
 			.ngpio	= S5PV210_GPIO_H2_NR,
 			.label	= "GPH2",
+			.to_irq = samsung_gpiolib_to_irq,
 		},
 	}, {
 		.base	= (S5P_VA_GPIO + 0xC60),
 		.config	= &gpio_cfg_noint,
+		.irq_base = IRQ_EINT(24),
 		.chip	= {
 			.base	= S5PV210_GPH3(0),
 			.ngpio	= S5PV210_GPIO_H3_NR,
 			.label	= "GPH3",
+			.to_irq = samsung_gpiolib_to_irq,
 		},
 	},
 };
@@ -254,6 +262,8 @@ static __init int s5pv210_gpiolib_init(void)
 			chip->config = &gpio_cfg;
 
 			/* gpio interrupts */
+			chip->irq_base = S5P_IRQ_GPIOINT(chip->chip.base),
+			chip->chip.to_irq = samsung_gpiolib_to_irq;
 			s5p_gpioint_add(chip, gpioint_group++);
 		}
 		if (chip->base == NULL)
diff --git a/arch/arm/plat-samsung/gpiolib.c b/arch/arm/plat-samsung/gpiolib.c
index 8a8ba8b..8cd3091 100644
--- a/arch/arm/plat-samsung/gpiolib.c
+++ b/arch/arm/plat-samsung/gpiolib.c
@@ -197,3 +197,12 @@ void __init samsung_gpiolib_add_4bit2_chips(struct s3c_gpio_chip *chip,
 		s3c_gpiolib_add(chip);
 	}
 }
+
+/* be called from gpio_to_irq() */
+int samsung_gpiolib_to_irq(struct gpio_chip *chip, unsigned int offset)
+{
+	struct s3c_gpio_chip *s3c_chip = container_of(chip,
+			struct s3c_gpio_chip, chip);
+
+	return s3c_chip->irq_base + offset;
+}
diff --git a/arch/arm/plat-samsung/include/plat/gpio-core.h b/arch/arm/plat-samsung/include/plat/gpio-core.h
index 12ec82c..920db6c 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-core.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-core.h
@@ -43,6 +43,7 @@ struct s3c_gpio_cfg;
  * struct s3c_gpio_chip - wrapper for specific implementation of gpio
  * @chip: The chip structure to be exported via gpiolib.
  * @base: The base pointer to the gpio configuration registers.
+ * @irq_base: The base irq number.
  * @config: special function and pull-resistor control information.
  * @lock: Lock for exclusive access to this gpio bank.
  * @pm_save: Save information for suspend/resume support.
@@ -63,6 +64,7 @@ struct s3c_gpio_chip {
 	struct s3c_gpio_cfg	*config;
 	struct s3c_gpio_pm	*pm;
 	void __iomem		*base;
+	int			irq_base;
 	spinlock_t		 lock;
 #ifdef CONFIG_PM
 	u32			pm_save[4];
@@ -118,6 +120,8 @@ extern void samsung_gpiolib_add_4bit2_chips(struct s3c_gpio_chip *chip,
 extern void samsung_gpiolib_add_4bit(struct s3c_gpio_chip *chip);
 extern void samsung_gpiolib_add_4bit2(struct s3c_gpio_chip *chip);
 
+extern int samsung_gpiolib_to_irq(struct gpio_chip *chip, unsigned int offset);
+
 /* exported for core SoC support to change */
 extern struct s3c_gpio_cfg s3c24xx_gpiocfg_default;
 
-- 
1.7.0.4
