From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed,  1 Feb 2012 00:50:40 +0900
Subject: [PATCH 2/2] gpio/samsung: add support GPIOlib for EXYNOS5250
In-Reply-To: <1328025040-4751-1-git-send-email-kgene.kim@samsung.com>
References: <1328025040-4751-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1328025040-4751-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sangsu Park <sangsu4u.park@samsung.com>

This patch adds gpio_chips for EXYNOS5250 and replaces
exynos4_xxx() with exynos_xxx() and variables to support
exynos4 and exynos5 together.

Signed-off-by: Sangsu Park <sangsu4u.park@samsung.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/gpio/gpio-samsung.c |  356 +++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 343 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index a766177..f81f567 100644
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
 
@@ -2113,7 +2113,7 @@ static struct samsung_gpio_chip s5pv210_gpios_4bit[] = {
 };
 
 /*
- * Followings are the gpio banks in EXYNOS4210
+ * Followings are the gpio banks in EXYNOS
  *
  * The 'config' member when left to NULL, is initialized to the default
  * structure samsung_gpio_cfgs[3] in the init function below.
@@ -2386,6 +2386,282 @@ static struct samsung_gpio_chip exynos4_gpios_3[] = {
 #endif
 };
 
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
+		.base	= (S5P_VA_GPIO1 + 0xC00),
+		.config	= &samsung_gpio_cfgs[9],
+		.irq_base = IRQ_EINT(0),
+		.chip	= {
+			.base	= EXYNOS5_GPX0(0),
+			.ngpio	= EXYNOS5_GPIO_X0_NR,
+			.label	= "GPX0",
+			.to_irq	= samsung_gpiolib_to_irq,
+		},
+	}, {
+		.base	= (S5P_VA_GPIO1 + 0xC20),
+		.config	= &samsung_gpio_cfgs[9],
+		.irq_base = IRQ_EINT(8),
+		.chip	= {
+			.base	= EXYNOS5_GPX1(0),
+			.ngpio	= EXYNOS5_GPIO_X1_NR,
+			.label	= "GPX1",
+			.to_irq	= samsung_gpiolib_to_irq,
+		},
+	}, {
+		.base	= (S5P_VA_GPIO1 + 0xC40),
+		.config	= &samsung_gpio_cfgs[9],
+		.irq_base = IRQ_EINT(16),
+		.chip	= {
+			.base	= EXYNOS5_GPX2(0),
+			.ngpio	= EXYNOS5_GPIO_X2_NR,
+			.label	= "GPX2",
+			.to_irq	= samsung_gpiolib_to_irq,
+		},
+	}, {
+		.base	= (S5P_VA_GPIO1 + 0xC60),
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
 #if defined(CONFIG_ARCH_EXYNOS4) && defined(CONFIG_OF)
 static int exynos4_gpio_xlate(struct gpio_chip *gc, struct device_node *np,
 			      const void *gpio_spec, u32 *flags)
@@ -2521,7 +2797,7 @@ static __init int samsung_gpiolib_init(void)
 
 		for (i = 0; i < nr_chips; i++, chip++) {
 			if (!chip->config) {
-				chip->config = &exynos4_gpio_cfg;
+				chip->config = &exynos_gpio_cfg;
 				chip->group = group++;
 			}
 #ifdef CONFIG_CPU_EXYNOS4210
@@ -2537,7 +2813,7 @@ static __init int samsung_gpiolib_init(void)
 
 		for (i = 0; i < nr_chips; i++, chip++) {
 			if (!chip->config) {
-				chip->config = &exynos4_gpio_cfg;
+				chip->config = &exynos_gpio_cfg;
 				chip->group = group++;
 			}
 #ifdef CONFIG_CPU_EXYNOS4210
@@ -2553,7 +2829,7 @@ static __init int samsung_gpiolib_init(void)
 
 		for (i = 0; i < nr_chips; i++, chip++) {
 			if (!chip->config) {
-				chip->config = &exynos4_gpio_cfg;
+				chip->config = &exynos_gpio_cfg;
 				chip->group = group++;
 			}
 #ifdef CONFIG_CPU_EXYNOS4210
@@ -2567,6 +2843,60 @@ static __init int samsung_gpiolib_init(void)
 		s5p_register_gpioint_bank(IRQ_GPIO_XA, 0, IRQ_GPIO1_NR_GROUPS);
 		s5p_register_gpioint_bank(IRQ_GPIO_XB, IRQ_GPIO1_NR_GROUPS, IRQ_GPIO2_NR_GROUPS);
 #endif
+	} else if (soc_is_exynos5250()) {
+		group = 0;
+
+		/* gpio part1 */
+		chip = exynos5_gpios_1;
+		nr_chips = ARRAY_SIZE(exynos5_gpios_1);
+
+		for (i = 0; i < nr_chips; i++, chip++) {
+			if (!chip->config) {
+				chip->config = &exynos_gpio_cfg;
+				chip->group = group++;
+			}
+		}
+		samsung_gpiolib_add_4bit_chips(exynos5_gpios_1,
+						nr_chips, S5P_VA_GPIO1);
+
+		/* gpio part2 */
+		chip = exynos5_gpios_2;
+		nr_chips = ARRAY_SIZE(exynos5_gpios_2);
+
+		for (i = 0; i < nr_chips; i++, chip++) {
+			if (!chip->config) {
+				chip->config = &exynos_gpio_cfg;
+				chip->group = group++;
+			}
+		}
+		samsung_gpiolib_add_4bit_chips(exynos5_gpios_2,
+						nr_chips, S5P_VA_GPIO2);
+
+		/* gpio part3 */
+		chip = exynos5_gpios_3;
+		nr_chips = ARRAY_SIZE(exynos5_gpios_3);
+
+		for (i = 0; i < nr_chips; i++, chip++) {
+			if (!chip->config) {
+				chip->config = &exynos_gpio_cfg;
+				chip->group = group++;
+			}
+		}
+		samsung_gpiolib_add_4bit_chips(exynos5_gpios_3,
+						nr_chips, S5P_VA_GPIO3);
+
+		/* gpio part4 */
+		chip = exynos5_gpios_4;
+		nr_chips = ARRAY_SIZE(exynos5_gpios_4);
+
+		for (i = 0; i < nr_chips; i++, chip++) {
+			if (!chip->config) {
+				chip->config = &exynos_gpio_cfg;
+				chip->group = group++;
+			}
+		}
+		samsung_gpiolib_add_4bit_chips(exynos5_gpios_4,
+						nr_chips, S5P_VA_GPIO4);
 	} else {
 		WARN(1, "Unknown SoC in gpio-samsung, no GPIOs added\n");
 		return -ENODEV;
-- 
1.7.4.4
