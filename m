From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 06 Sep 2010 11:12:26 +0200
Subject: [PATCH 5/6] ARM: Samsung: Add common samsung_gpiolib_to_irq function
In-Reply-To: <1283764347-460-1-git-send-email-m.szyprowski@samsung.com>
References: <1283764347-460-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1283764347-460-6-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joonyoung Shim <jy0922.shim@samsung.com>

This patch adds a common callback for gpio_to_irq() for external and
gpio interrupts for Samsung SoCs.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s3c64xx/gpiolib.c                |    8 +----
 arch/arm/mach-s5pc100/gpiolib.c                |   31 ++++++-----------------
 arch/arm/mach-s5pv210/gpiolib.c                |    8 ++++++
 arch/arm/plat-s3c24xx/gpiolib.c                |    8 +----
 arch/arm/plat-s5p/irq-gpioint.c                |    1 +
 arch/arm/plat-samsung/gpiolib.c                |    8 ++++++
 arch/arm/plat-samsung/include/plat/gpio-core.h |   11 ++++++++
 7 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/gpiolib.c b/arch/arm/mach-s3c64xx/gpiolib.c
index 300dee4..fd99a82 100644
--- a/arch/arm/mach-s3c64xx/gpiolib.c
+++ b/arch/arm/mach-s3c64xx/gpiolib.c
@@ -195,11 +195,6 @@ static struct s3c_gpio_cfg gpio_2bit_cfg_eint11 = {
 	.get_pull	= s3c_gpio_getpull_updown,
 };
 
-int s3c64xx_gpio2int_gpn(struct gpio_chip *chip, unsigned pin)
-{
-	return IRQ_EINT(0) + pin;
-}
-
 static struct s3c_gpio_chip gpio_2bit[] = {
 	{
 		.base	= S3C64XX_GPF_BASE,
@@ -227,12 +222,13 @@ static struct s3c_gpio_chip gpio_2bit[] = {
 		},
 	}, {
 		.base	= S3C64XX_GPN_BASE,
+		.irq_base = IRQ_EINT(0),
 		.config	= &gpio_2bit_cfg_eint10,
 		.chip	= {
 			.base	= S3C64XX_GPN(0),
 			.ngpio	= S3C64XX_GPIO_N_NR,
 			.label	= "GPN",
-			.to_irq = s3c64xx_gpio2int_gpn,
+			.to_irq = samsung_gpiolib_to_irq,
 		},
 	}, {
 		.base	= S3C64XX_GPO_BASE,
diff --git a/arch/arm/mach-s5pc100/gpiolib.c b/arch/arm/mach-s5pc100/gpiolib.c
index 5811578..def4ff8 100644
--- a/arch/arm/mach-s5pc100/gpiolib.c
+++ b/arch/arm/mach-s5pc100/gpiolib.c
@@ -61,25 +61,6 @@
  * L3	8	4Bit	None
  */
 
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
@@ -223,38 +204,42 @@ static struct s3c_gpio_chip s5pc100_gpio_chips[] = {
 	}, {
 		.base	= S5PC100_GPH0_BASE,
 		.config	= &gpio_cfg_eint,
+		.irq_base = IRQ_EINT(0),
 		.chip	= {
 			.base	= S5PC100_GPH0(0),
 			.ngpio	= S5PC100_GPIO_H0_NR,
 			.label	= "GPH0",
-			.to_irq = s5pc100_gpiolib_to_eint,
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
-			.to_irq = s5pc100_gpiolib_to_eint,
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
-			.to_irq = s5pc100_gpiolib_to_eint,
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
-			.to_irq = s5pc100_gpiolib_to_eint,
+			.to_irq = samsung_gpiolib_to_irq,
 		},
 	}, {
 		.base	= S5PC100_GPI_BASE,
diff --git a/arch/arm/mach-s5pv210/gpiolib.c b/arch/arm/mach-s5pv210/gpiolib.c
index 29dfb89..ab673ef 100644
--- a/arch/arm/mach-s5pv210/gpiolib.c
+++ b/arch/arm/mach-s5pv210/gpiolib.c
@@ -224,34 +224,42 @@ static struct s3c_gpio_chip s5pv210_gpio_4bit[] = {
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
diff --git a/arch/arm/plat-s3c24xx/gpiolib.c b/arch/arm/plat-s3c24xx/gpiolib.c
index 4c0896f..243b641 100644
--- a/arch/arm/plat-s3c24xx/gpiolib.c
+++ b/arch/arm/plat-s3c24xx/gpiolib.c
@@ -74,11 +74,6 @@ static int s3c24xx_gpiolib_bankf_toirq(struct gpio_chip *chip, unsigned offset)
 	return -EINVAL;
 }
 
-static int s3c24xx_gpiolib_bankg_toirq(struct gpio_chip *chip, unsigned offset)
-{
-	return IRQ_EINT8 + offset;
-}
-
 static struct s3c_gpio_cfg s3c24xx_gpiocfg_banka = {
 	.set_config	= s3c_gpio_setcfg_s3c24xx_a,
 	.get_config	= s3c_gpio_getcfg_s3c24xx_a,
@@ -157,12 +152,13 @@ struct s3c_gpio_chip s3c24xx_gpios[] = {
 	[6] = {
 		.base	= S3C2410_GPGCON,
 		.pm	= __gpio_pm(&s3c_gpio_pm_2bit),
+		.irq_base = IRQ_EINT8,
 		.chip	= {
 			.base			= S3C2410_GPG(0),
 			.owner			= THIS_MODULE,
 			.label			= "GPIOG",
 			.ngpio			= 16,
-			.to_irq			= s3c24xx_gpiolib_bankg_toirq,
+			.to_irq			= samsung_gpiolib_to_irq,
 		},
 	}, {
 		.base	= S3C2410_GPHCON,
diff --git a/arch/arm/plat-s5p/irq-gpioint.c b/arch/arm/plat-s5p/irq-gpioint.c
index 7409ae0..5b735b1 100644
--- a/arch/arm/plat-s5p/irq-gpioint.c
+++ b/arch/arm/plat-s5p/irq-gpioint.c
@@ -235,6 +235,7 @@ int __init s5p_register_gpio_interrupt(int pin)
 	/* register gpio group */
 	ret = s5p_gpioint_add(my_chip);
 	if (ret == 0) {
+		my_chip->chip.to_irq = samsung_gpiolib_to_irq;
 		printk(KERN_INFO "Registered interrupt support for gpio group %d.\n",
 		       group);
 		return my_chip->irq_base + offset;
diff --git a/arch/arm/plat-samsung/gpiolib.c b/arch/arm/plat-samsung/gpiolib.c
index c354089..f2dc389 100644
--- a/arch/arm/plat-samsung/gpiolib.c
+++ b/arch/arm/plat-samsung/gpiolib.c
@@ -197,3 +197,11 @@ void __init samsung_gpiolib_add_4bit2_chips(struct s3c_gpio_chip *chip,
 		s3c_gpiolib_add(chip);
 	}
 }
+
+int samsung_gpiolib_to_irq(struct gpio_chip *chip, unsigned int offset)
+{
+	struct s3c_gpio_chip *s3c_chip = container_of(chip,
+			struct s3c_gpio_chip, chip);
+
+	return s3c_chip->irq_base + offset;
+}
diff --git a/arch/arm/plat-samsung/include/plat/gpio-core.h b/arch/arm/plat-samsung/include/plat/gpio-core.h
index c22c27c..13a22b8 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-core.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-core.h
@@ -122,6 +122,17 @@ extern void samsung_gpiolib_add_4bit2_chips(struct s3c_gpio_chip *chip,
 extern void samsung_gpiolib_add_4bit(struct s3c_gpio_chip *chip);
 extern void samsung_gpiolib_add_4bit2(struct s3c_gpio_chip *chip);
 
+
+/**
+ * samsung_gpiolib_to_irq - convert gpio pin to irq number
+ * @chip: The gpio chip that the pin belongs to.
+ * @offset: The offset of the pin in the chip.
+ *
+ * This helper returns the irq number calculated from the chip->irq_base and
+ * the provided offset.
+ */
+extern int samsung_gpiolib_to_irq(struct gpio_chip *chip, unsigned int offset);
+
 /* exported for core SoC support to change */
 extern struct s3c_gpio_cfg s3c24xx_gpiocfg_default;
 
-- 
1.7.2.2
