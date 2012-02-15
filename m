From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 16 Feb 2012 06:37:09 +0900
Subject: [PATCH v2 3/3] gpio/samsung: use ioremap() for EXYNOS4 GPIOlib
In-Reply-To: <1329341829-14403-1-git-send-email-kgene.kim@samsung.com>
References: <1329341829-14403-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1329341829-14403-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sangsu Park <sangsu4u.park@samsung.com>

This patch changes to use ioremap() for EXYNOS4210
so that we can drop the static mapping for EXYNOS
SoCs.

Note: Will be updated for all of Samsung GPIOlibs
to use ioremap() next time.

Signed-off-by: Sangsu Park <sangsu4u.park@samsung.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/common.c |   15 ------------
 drivers/gpio/gpio-samsung.c   |   48 +++++++++++++++++++++++++++++------------
 2 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 63a2b04..618e7f3 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -172,21 +172,6 @@ static struct map_desc exynos4_iodesc[] __initdata = {
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= (unsigned long)S5P_VA_GPIO1,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_GPIO1),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_GPIO2,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_GPIO2),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_GPIO3,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_GPIO3),
-		.length		= SZ_256,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)S5P_VA_DMC0,
 		.pfn		= __phys_to_pfn(EXYNOS4_PA_DMC0),
 		.length		= SZ_4K,
diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index d6cfdee7..4627787 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -2331,7 +2331,6 @@ static struct samsung_gpio_chip exynos4_gpios_2[] = {
 			.label	= "GPY6",
 		},
 	}, {
-		.base	= (S5P_VA_GPIO2 + 0xC00),
 		.config	= &samsung_gpio_cfgs[9],
 		.irq_base = IRQ_EINT(0),
 		.chip	= {
@@ -2341,7 +2340,6 @@ static struct samsung_gpio_chip exynos4_gpios_2[] = {
 			.to_irq	= samsung_gpiolib_to_irq,
 		},
 	}, {
-		.base	= (S5P_VA_GPIO2 + 0xC20),
 		.config	= &samsung_gpio_cfgs[9],
 		.irq_base = IRQ_EINT(8),
 		.chip	= {
@@ -2351,7 +2349,6 @@ static struct samsung_gpio_chip exynos4_gpios_2[] = {
 			.to_irq	= samsung_gpiolib_to_irq,
 		},
 	}, {
-		.base	= (S5P_VA_GPIO2 + 0xC40),
 		.config	= &samsung_gpio_cfgs[9],
 		.irq_base = IRQ_EINT(16),
 		.chip	= {
@@ -2361,7 +2358,6 @@ static struct samsung_gpio_chip exynos4_gpios_2[] = {
 			.to_irq	= samsung_gpiolib_to_irq,
 		},
 	}, {
-		.base	= (S5P_VA_GPIO2 + 0xC60),
 		.config	= &samsung_gpio_cfgs[9],
 		.irq_base = IRQ_EINT(24),
 		.chip	= {
@@ -2789,9 +2785,16 @@ static __init int samsung_gpiolib_init(void)
 		s5p_register_gpioint_bank(IRQ_GPIOINT, 0, S5P_GPIOINT_GROUP_MAXNR);
 #endif
 	} else if (soc_is_exynos4210()) {
-		group = 0;
+#ifdef CONFIG_CPU_EXYNOS4210
+		void __iomem *gpx_base;
 
 		/* gpio part1 */
+		gpio_base1 = ioremap(EXYNOS4_PA_GPIO1, SZ_4K);
+		if (gpio_base1 == NULL) {
+			pr_err("unable to ioremap for gpio_base1\n");
+			goto err_ioremap1;
+		}
+
 		chip = exynos4_gpios_1;
 		nr_chips = ARRAY_SIZE(exynos4_gpios_1);
 
@@ -2800,14 +2803,25 @@ static __init int samsung_gpiolib_init(void)
 				chip->config = &exynos_gpio_cfg;
 				chip->group = group++;
 			}
-#ifdef CONFIG_CPU_EXYNOS4210
 			exynos_gpiolib_attach_ofnode(chip,
 					EXYNOS4_PA_GPIO1, i * 0x20);
-#endif
 		}
-		samsung_gpiolib_add_4bit_chips(exynos4_gpios_1, nr_chips, S5P_VA_GPIO1);
+		samsung_gpiolib_add_4bit_chips(exynos4_gpios_1,
+					       nr_chips, gpio_base1);
 
 		/* gpio part2 */
+		gpio_base2 = ioremap(EXYNOS4_PA_GPIO2, SZ_4K);
+		if (gpio_base2 == NULL) {
+			pr_err("unable to ioremap for gpio_base2\n");
+			goto err_ioremap2;
+		}
+
+		/* need to set base address for gpx */
+		chip = &exynos4_gpios_2[16];
+		gpx_base = gpio_base2 + 0xC00;
+		for (i = 0; i < 4; i++, chip++, gpx_base += 0x20)
+			chip->base = gpx_base;
+
 		chip = exynos4_gpios_2;
 		nr_chips = ARRAY_SIZE(exynos4_gpios_2);
 
@@ -2816,14 +2830,19 @@ static __init int samsung_gpiolib_init(void)
 				chip->config = &exynos_gpio_cfg;
 				chip->group = group++;
 			}
-#ifdef CONFIG_CPU_EXYNOS4210
 			exynos_gpiolib_attach_ofnode(chip,
 					EXYNOS4_PA_GPIO2, i * 0x20);
-#endif
 		}
-		samsung_gpiolib_add_4bit_chips(exynos4_gpios_2, nr_chips, S5P_VA_GPIO2);
+		samsung_gpiolib_add_4bit_chips(exynos4_gpios_2,
+					       nr_chips, gpio_base2);
 
 		/* gpio part3 */
+		gpio_base3 = ioremap(EXYNOS4_PA_GPIO3, SZ_256);
+		if (gpio_base3 == NULL) {
+			pr_err("unable to ioremap for gpio_base3\n");
+			goto err_ioremap3;
+		}
+
 		chip = exynos4_gpios_3;
 		nr_chips = ARRAY_SIZE(exynos4_gpios_3);
 
@@ -2832,17 +2851,18 @@ static __init int samsung_gpiolib_init(void)
 				chip->config = &exynos_gpio_cfg;
 				chip->group = group++;
 			}
-#ifdef CONFIG_CPU_EXYNOS4210
 			exynos_gpiolib_attach_ofnode(chip,
 					EXYNOS4_PA_GPIO3, i * 0x20);
-#endif
 		}
-		samsung_gpiolib_add_4bit_chips(exynos4_gpios_3, nr_chips, S5P_VA_GPIO3);
+		samsung_gpiolib_add_4bit_chips(exynos4_gpios_3,
+					       nr_chips, gpio_base3);
 
 #if defined(CONFIG_CPU_EXYNOS4210) && defined(CONFIG_S5P_GPIO_INT)
 		s5p_register_gpioint_bank(IRQ_GPIO_XA, 0, IRQ_GPIO1_NR_GROUPS);
 		s5p_register_gpioint_bank(IRQ_GPIO_XB, IRQ_GPIO1_NR_GROUPS, IRQ_GPIO2_NR_GROUPS);
 #endif
+
+#endif	/* CONFIG_CPU_EXYNOS4210 */
 	} else if (soc_is_exynos5250()) {
 #ifdef CONFIG_SOC_EXYNOS5250
 		void __iomem *gpx_base;
-- 
1.7.4.4
