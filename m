From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 16 Feb 2012 06:37:08 +0900
Subject: [PATCH v2 2/3] gpio/samsung: add support GPIOlib for EXYNOS5250
In-Reply-To: <1329341829-14403-1-git-send-email-kgene.kim@samsung.com>
References: <1329341829-14403-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1329341829-14403-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sangsu Park <sangsu4u.park@samsung.com>

This patch adds gpio_chips for EXYNOS5250 and replaces
exynos4_xxx() with exynos_xxx() and variables to support
exynos4 and exynos5 together.
In addition, use ioreamp() for base address of gpios.

Signed-off-by: Sangsu Park <sangsu4u.park@samsung.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/gpio/gpio-samsung.c             |  439 +++++++++++++++++++++++++++++--
 1 files changed, 411 insertions(+), 28 deletions(-)

diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index 0a79a11..d6cfdee7 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -169,7 +169,7 @@ int s3c24xx_gpio_setpull_1down(struct samsung_gpio_chip *chip,
 	return s3c24xx_gpio_setpull_1(chip, off, pull, S3C_GPIO_PULL_DOWN);
 }
 
-static int exynos4_gpio_setpull(struct samsung_gpio_chip *chip,
+static int exynos_gpio_setpull(struct samsung_gpio_chip *chip,
 				unsigned int off, samsung_gpio_pull_t pull)
 {
 	if (pull == S3C_GPIO_PULL_UP)
@@ -178,7 +178,7 @@ static int exynos4_gpio_setpull(struct samsung_gpio_chip *chip,
 	return samsung_gpio_setpull_updown(chip, off, pull);
 }
 
-static samsung_gpio_pull_t exynos4_gpio_getpull(struct samsung_gpio_chip *chip,
+static samsung_gpio_pull_t exynos_gpio_getpull(struct samsung_gpio_chip *chip,
 						unsigned int off)
 {
 	samsung_gpio_pull_t pull;
@@ -452,9 +452,9 @@ static struct samsung_gpio_cfg s3c24xx_gpiocfg_banka = {
 };
 #endif
 
-static struct samsung_gpio_cfg exynos4_gpio_cfg = {
-	.set_pull	= exynos4_gpio_setpull,
-	.get_pull	= exynos4_gpio_getpull,
+static struct samsung_gpio_cfg exynos_gpio_cfg = {
+	.set_pull	= exynos_gpio_setpull,
+	.get_pull	= exynos_gpio_getpull,
 	.set_config	= samsung_gpio_setcfg_4bit,
 	.get_config	= samsung_gpio_getcfg_4bit,
 };
@@ -502,13 +502,13 @@ static struct samsung_gpio_cfg samsung_gpio_cfgs[] = {
 		.get_config	= samsung_gpio_getcfg_2bit,
 	},
 	[8] = {
-		.set_pull	= exynos4_gpio_setpull,
-		.get_pull	= exynos4_gpio_getpull,
+		.set_pull	= exynos_gpio_setpull,
+		.get_pull	= exynos_gpio_getpull,
 	},
 	[9] = {
 		.cfg_eint	= 0x3,
-		.set_pull	= exynos4_gpio_setpull,
-		.get_pull	= exynos4_gpio_getpull,
+		.set_pull	= exynos_gpio_setpull,
+		.get_pull	= exynos_gpio_getpull,
 	}
 };
 
@@ -2113,10 +2113,10 @@ static struct samsung_gpio_chip s5pv210_gpios_4bit[] = {
 };
 
 /*
- * Followings are the gpio banks in EXYNOS4210
+ * Followings are the gpio banks in EXYNOS SoCs
  *
  * The 'config' member when left to NULL, is initialized to the default
- * structure samsung_gpio_cfgs[3] in the init function below.
+ * structure exynos_gpio_cfg in the init function below.
  *
  * The 'base' member is also initialized in the init function below.
  * Note: The initialization of 'base' member of samsung_gpio_chip structure
@@ -2386,8 +2386,280 @@ static struct samsung_gpio_chip exynos4_gpios_3[] = {
 #endif
 };
 
-#if defined(CONFIG_ARCH_EXYNOS4) && defined(CONFIG_OF)
-static int exynos4_gpio_xlate(struct gpio_chip *gc,
+static struct samsung_gpio_chip exynos5_gpios_1[] = {
+#ifdef CONFIG_ARCH_EXYNOS5
+	{
+		.chip	= {
+			.base	= EXYNOS5_GPA0(0),
+			.ngpio	= EXYNOS5_GPIO_A0_NR,
+			.label	= "GPA0",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPA1(0),
+			.ngpio	= EXYNOS5_GPIO_A1_NR,
+			.label	= "GPA1",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPA2(0),
+			.ngpio	= EXYNOS5_GPIO_A2_NR,
+			.label	= "GPA2",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPB0(0),
+			.ngpio	= EXYNOS5_GPIO_B0_NR,
+			.label	= "GPB0",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPB1(0),
+			.ngpio	= EXYNOS5_GPIO_B1_NR,
+			.label	= "GPB1",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPB2(0),
+			.ngpio	= EXYNOS5_GPIO_B2_NR,
+			.label	= "GPB2",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPB3(0),
+			.ngpio	= EXYNOS5_GPIO_B3_NR,
+			.label	= "GPB3",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPC0(0),
+			.ngpio	= EXYNOS5_GPIO_C0_NR,
+			.label	= "GPC0",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPC1(0),
+			.ngpio	= EXYNOS5_GPIO_C1_NR,
+			.label	= "GPC1",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPC2(0),
+			.ngpio	= EXYNOS5_GPIO_C2_NR,
+			.label	= "GPC2",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPC3(0),
+			.ngpio	= EXYNOS5_GPIO_C3_NR,
+			.label	= "GPC3",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPD0(0),
+			.ngpio	= EXYNOS5_GPIO_D0_NR,
+			.label	= "GPD0",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPD1(0),
+			.ngpio	= EXYNOS5_GPIO_D1_NR,
+			.label	= "GPD1",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPY0(0),
+			.ngpio	= EXYNOS5_GPIO_Y0_NR,
+			.label	= "GPY0",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPY1(0),
+			.ngpio	= EXYNOS5_GPIO_Y1_NR,
+			.label	= "GPY1",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPY2(0),
+			.ngpio	= EXYNOS5_GPIO_Y2_NR,
+			.label	= "GPY2",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPY3(0),
+			.ngpio	= EXYNOS5_GPIO_Y3_NR,
+			.label	= "GPY3",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPY4(0),
+			.ngpio	= EXYNOS5_GPIO_Y4_NR,
+			.label	= "GPY4",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPY5(0),
+			.ngpio	= EXYNOS5_GPIO_Y5_NR,
+			.label	= "GPY5",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPY6(0),
+			.ngpio	= EXYNOS5_GPIO_Y6_NR,
+			.label	= "GPY6",
+		},
+	}, {
+		.config	= &samsung_gpio_cfgs[9],
+		.irq_base = IRQ_EINT(0),
+		.chip	= {
+			.base	= EXYNOS5_GPX0(0),
+			.ngpio	= EXYNOS5_GPIO_X0_NR,
+			.label	= "GPX0",
+			.to_irq	= samsung_gpiolib_to_irq,
+		},
+	}, {
+		.config	= &samsung_gpio_cfgs[9],
+		.irq_base = IRQ_EINT(8),
+		.chip	= {
+			.base	= EXYNOS5_GPX1(0),
+			.ngpio	= EXYNOS5_GPIO_X1_NR,
+			.label	= "GPX1",
+			.to_irq	= samsung_gpiolib_to_irq,
+		},
+	}, {
+		.config	= &samsung_gpio_cfgs[9],
+		.irq_base = IRQ_EINT(16),
+		.chip	= {
+			.base	= EXYNOS5_GPX2(0),
+			.ngpio	= EXYNOS5_GPIO_X2_NR,
+			.label	= "GPX2",
+			.to_irq	= samsung_gpiolib_to_irq,
+		},
+	}, {
+		.config	= &samsung_gpio_cfgs[9],
+		.irq_base = IRQ_EINT(24),
+		.chip	= {
+			.base	= EXYNOS5_GPX3(0),
+			.ngpio	= EXYNOS5_GPIO_X3_NR,
+			.label	= "GPX3",
+			.to_irq	= samsung_gpiolib_to_irq,
+		},
+	},
+#endif
+};
+
+static struct samsung_gpio_chip exynos5_gpios_2[] = {
+#ifdef CONFIG_ARCH_EXYNOS5
+	{
+		.chip	= {
+			.base	= EXYNOS5_GPE0(0),
+			.ngpio	= EXYNOS5_GPIO_E0_NR,
+			.label	= "GPE0",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPE1(0),
+			.ngpio	= EXYNOS5_GPIO_E1_NR,
+			.label	= "GPE1",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPF0(0),
+			.ngpio	= EXYNOS5_GPIO_F0_NR,
+			.label	= "GPF0",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPF1(0),
+			.ngpio	= EXYNOS5_GPIO_F1_NR,
+			.label	= "GPF1",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPG0(0),
+			.ngpio	= EXYNOS5_GPIO_G0_NR,
+			.label	= "GPG0",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPG1(0),
+			.ngpio	= EXYNOS5_GPIO_G1_NR,
+			.label	= "GPG1",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPG2(0),
+			.ngpio	= EXYNOS5_GPIO_G2_NR,
+			.label	= "GPG2",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPH0(0),
+			.ngpio	= EXYNOS5_GPIO_H0_NR,
+			.label	= "GPH0",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPH1(0),
+			.ngpio	= EXYNOS5_GPIO_H1_NR,
+			.label	= "GPH1",
+
+		},
+	},
+#endif
+};
+
+static struct samsung_gpio_chip exynos5_gpios_3[] = {
+#ifdef CONFIG_ARCH_EXYNOS5
+	{
+		.chip	= {
+			.base	= EXYNOS5_GPV0(0),
+			.ngpio	= EXYNOS5_GPIO_V0_NR,
+			.label	= "GPV0",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPV1(0),
+			.ngpio	= EXYNOS5_GPIO_V1_NR,
+			.label	= "GPV1",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPV2(0),
+			.ngpio	= EXYNOS5_GPIO_V2_NR,
+			.label	= "GPV2",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPV3(0),
+			.ngpio	= EXYNOS5_GPIO_V3_NR,
+			.label	= "GPV3",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS5_GPV4(0),
+			.ngpio	= EXYNOS5_GPIO_V4_NR,
+			.label	= "GPV4",
+		},
+	},
+#endif
+};
+
+static struct samsung_gpio_chip exynos5_gpios_4[] = {
+#ifdef CONFIG_ARCH_EXYNOS5
+	{
+		.chip	= {
+			.base	= EXYNOS5_GPZ(0),
+			.ngpio	= EXYNOS5_GPIO_Z_NR,
+			.label	= "GPZ",
+		},
+	},
+#endif
+};
+
+
+#if defined(CONFIG_ARCH_EXYNOS) && defined(CONFIG_OF)
+static int exynos_gpio_xlate(struct gpio_chip *gc,
 			const struct of_phandle_args *gpiospec, u32 *flags)
 {
 	unsigned int pin;
@@ -2413,13 +2685,13 @@ static int exynos4_gpio_xlate(struct gpio_chip *gc,
 	return gpiospec->args[0];
 }
 
-static const struct of_device_id exynos4_gpio_dt_match[] __initdata = {
+static const struct of_device_id exynos_gpio_dt_match[] __initdata = {
 	{ .compatible = "samsung,exynos4-gpio", },
 	{}
 };
 
-static __init void exynos4_gpiolib_attach_ofnode(struct samsung_gpio_chip *chip,
-						 u64 base, u64 offset)
+static __init void exynos_gpiolib_attach_ofnode(struct samsung_gpio_chip *chip,
+						u64 base, u64 offset)
 {
 	struct gpio_chip *gc =  &chip->chip;
 	u64 address;
@@ -2429,28 +2701,29 @@ static __init void exynos4_gpiolib_attach_ofnode(struct samsung_gpio_chip *chip,
 
 	address = chip->base ? base + ((u32)chip->base & 0xfff) : base + offset;
 	gc->of_node = of_find_matching_node_by_address(NULL,
-			exynos4_gpio_dt_match, address);
+			exynos_gpio_dt_match, address);
 	if (!gc->of_node) {
 		pr_info("gpio: device tree node not found for gpio controller"
 			" with base address %08llx\n", address);
 		return;
 	}
 	gc->of_gpio_n_cells = 4;
-	gc->of_xlate = exynos4_gpio_xlate;
+	gc->of_xlate = exynos_gpio_xlate;
 }
-#elif defined(CONFIG_ARCH_EXYNOS4)
-static __init void exynos4_gpiolib_attach_ofnode(struct samsung_gpio_chip *chip,
-						 u64 base, u64 offset)
+#elif defined(CONFIG_ARCH_EXYNOS)
+static __init void exynos_gpiolib_attach_ofnode(struct samsung_gpio_chip *chip,
+						u64 base, u64 offset)
 {
 	return;
 }
-#endif /* defined(CONFIG_ARCH_EXYNOS4) && defined(CONFIG_OF) */
+#endif /* defined(CONFIG_ARCH_EXYNOS) && defined(CONFIG_OF) */
 
 /* TODO: cleanup soc_is_* */
 static __init int samsung_gpiolib_init(void)
 {
 	struct samsung_gpio_chip *chip;
 	int i, nr_chips;
+	void __iomem *gpio_base1, *gpio_base2, *gpio_base3, *gpio_base4;
 	int group = 0;
 
 	samsung_gpiolib_set_cfg(samsung_gpio_cfgs, ARRAY_SIZE(samsung_gpio_cfgs));
@@ -2524,11 +2797,11 @@ static __init int samsung_gpiolib_init(void)
 
 		for (i = 0; i < nr_chips; i++, chip++) {
 			if (!chip->config) {
-				chip->config = &exynos4_gpio_cfg;
+				chip->config = &exynos_gpio_cfg;
 				chip->group = group++;
 			}
 #ifdef CONFIG_CPU_EXYNOS4210
-			exynos4_gpiolib_attach_ofnode(chip,
+			exynos_gpiolib_attach_ofnode(chip,
 					EXYNOS4_PA_GPIO1, i * 0x20);
 #endif
 		}
@@ -2540,11 +2813,11 @@ static __init int samsung_gpiolib_init(void)
 
 		for (i = 0; i < nr_chips; i++, chip++) {
 			if (!chip->config) {
-				chip->config = &exynos4_gpio_cfg;
+				chip->config = &exynos_gpio_cfg;
 				chip->group = group++;
 			}
 #ifdef CONFIG_CPU_EXYNOS4210
-			exynos4_gpiolib_attach_ofnode(chip,
+			exynos_gpiolib_attach_ofnode(chip,
 					EXYNOS4_PA_GPIO2, i * 0x20);
 #endif
 		}
@@ -2556,11 +2829,11 @@ static __init int samsung_gpiolib_init(void)
 
 		for (i = 0; i < nr_chips; i++, chip++) {
 			if (!chip->config) {
-				chip->config = &exynos4_gpio_cfg;
+				chip->config = &exynos_gpio_cfg;
 				chip->group = group++;
 			}
 #ifdef CONFIG_CPU_EXYNOS4210
-			exynos4_gpiolib_attach_ofnode(chip,
+			exynos_gpiolib_attach_ofnode(chip,
 					EXYNOS4_PA_GPIO3, i * 0x20);
 #endif
 		}
@@ -2570,12 +2843,122 @@ static __init int samsung_gpiolib_init(void)
 		s5p_register_gpioint_bank(IRQ_GPIO_XA, 0, IRQ_GPIO1_NR_GROUPS);
 		s5p_register_gpioint_bank(IRQ_GPIO_XB, IRQ_GPIO1_NR_GROUPS, IRQ_GPIO2_NR_GROUPS);
 #endif
+	} else if (soc_is_exynos5250()) {
+#ifdef CONFIG_SOC_EXYNOS5250
+		void __iomem *gpx_base;
+
+		/* gpio part1 */
+		gpio_base1 = ioremap(EXYNOS5_PA_GPIO1, SZ_4K);
+		if (gpio_base1 == NULL) {
+			pr_err("unable to ioremap for gpio_base1\n");
+			goto err_ioremap1;
+		}
+
+		/* need to set base address for gpx */
+		chip = &exynos5_gpios_1[20];
+		gpx_base = gpio_base1 + 0xC00;
+		for (i = 0; i < 4; i++, chip++, gpx_base += 0x20)
+			chip->base = gpx_base;
+
+		chip = exynos5_gpios_1;
+		nr_chips = ARRAY_SIZE(exynos5_gpios_1);
+
+		for (i = 0; i < nr_chips; i++, chip++) {
+			if (!chip->config) {
+				chip->config = &exynos_gpio_cfg;
+				chip->group = group++;
+			}
+			exynos_gpiolib_attach_ofnode(chip,
+					EXYNOS5_PA_GPIO1, i * 0x20);
+		}
+		samsung_gpiolib_add_4bit_chips(exynos5_gpios_1,
+					       nr_chips, gpio_base1);
+
+		/* gpio part2 */
+		gpio_base2 = ioremap(EXYNOS5_PA_GPIO2, SZ_4K);
+		if (gpio_base2 == NULL) {
+			pr_err("unable to ioremap for gpio_base2\n");
+			goto err_ioremap2;
+		}
+
+		chip = exynos5_gpios_2;
+		nr_chips = ARRAY_SIZE(exynos5_gpios_2);
+
+		for (i = 0; i < nr_chips; i++, chip++) {
+			if (!chip->config) {
+				chip->config = &exynos_gpio_cfg;
+				chip->group = group++;
+			}
+			exynos_gpiolib_attach_ofnode(chip,
+					EXYNOS5_PA_GPIO2, i * 0x20);
+		}
+		samsung_gpiolib_add_4bit_chips(exynos5_gpios_2,
+					       nr_chips, gpio_base2);
+
+		/* gpio part3 */
+		gpio_base3 = ioremap(EXYNOS5_PA_GPIO3, SZ_4K);
+		if (gpio_base3 == NULL) {
+			pr_err("unable to ioremap for gpio_base3\n");
+			goto err_ioremap3;
+		}
+
+		/* need to set base address for gpv */
+		exynos5_gpios_3[0].base = gpio_base3;
+		exynos5_gpios_3[1].base = gpio_base3 + 0x20;
+		exynos5_gpios_3[2].base = gpio_base3 + 0x60;
+		exynos5_gpios_3[3].base = gpio_base3 + 0x80;
+		exynos5_gpios_3[4].base = gpio_base3 + 0xC0;
+
+		chip = exynos5_gpios_3;
+		nr_chips = ARRAY_SIZE(exynos5_gpios_3);
+
+		for (i = 0; i < nr_chips; i++, chip++) {
+			if (!chip->config) {
+				chip->config = &exynos_gpio_cfg;
+				chip->group = group++;
+			}
+			exynos_gpiolib_attach_ofnode(chip,
+					EXYNOS5_PA_GPIO3, i * 0x20);
+		}
+		samsung_gpiolib_add_4bit_chips(exynos5_gpios_3,
+					       nr_chips, gpio_base3);
+
+		/* gpio part4 */
+		gpio_base4 = ioremap(EXYNOS5_PA_GPIO4, SZ_4K);
+		if (gpio_base4 == NULL) {
+			pr_err("unable to ioremap for gpio_base4\n");
+			goto err_ioremap4;
+		}
+
+		chip = exynos5_gpios_4;
+		nr_chips = ARRAY_SIZE(exynos5_gpios_4);
+
+		for (i = 0; i < nr_chips; i++, chip++) {
+			if (!chip->config) {
+				chip->config = &exynos_gpio_cfg;
+				chip->group = group++;
+			}
+			exynos_gpiolib_attach_ofnode(chip,
+					EXYNOS5_PA_GPIO4, i * 0x20);
+		}
+		samsung_gpiolib_add_4bit_chips(exynos5_gpios_4,
+					       nr_chips, gpio_base4);
+#endif	/* CONFIG_SOC_EXYNOS5250 */
 	} else {
 		WARN(1, "Unknown SoC in gpio-samsung, no GPIOs added\n");
 		return -ENODEV;
 	}
 
 	return 0;
+
+err_ioremap4:
+	iounmap(gpio_base3);
+err_ioremap3:
+	iounmap(gpio_base2);
+err_ioremap2:
+	iounmap(gpio_base1);
+err_ioremap1:
+	return -ENOMEM;
 }
 core_initcall(samsung_gpiolib_init);
 
-- 
1.7.4.4
