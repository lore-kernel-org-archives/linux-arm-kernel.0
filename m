From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Fri, 18 May 2012 11:18:17 +0900
Subject: [PATCH 2/2] gpio/exynos: Add support for Exynos4x12 SoC
In-Reply-To: <1337307497-15777-1-git-send-email-jy0922.shim@samsung.com>
References: <1337307497-15777-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <1337307497-15777-2-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos4x12 GPIO part1 and part2 layouts are different with that of
Exynos4210. So, it needs to support gpios for Exynos4x12 SoC. This
doesn't support GPVx Exynos4x12 GPIO part4 yet.

In the Exynos4x12 GPIO part1 and part2, the interval of base register
offset is 0x20 but GPF0, GPJ0, GPK0 and GPM0 ignore the 0x20 interval
and have new value. The interrupt reg offset also is about GPF0 and GPK0
too. Refer the below layout.

- Exynos4x12 GPIO Part1
GPIO    Base offset     Interrupt reg offset
GPA0    0x000           0x00
GPA1    0x020           0x04
GPB     0x040           0x08
GPC0    0x060           0x0C
GPC1    0x080           0x10
GPD0    0x0A0           0x14
GPD1    0x0C0           0x18
        ...
GPF0    0x180           0x30
GPF1    0x1A0           0x34
GPF2    0x1C0           0x38
GPF3    0x1E0           0x3C
        ...
GPJ0    0x240           0x40
GPJ1    0x260           0x44

- Exynos4x12 GPIO Part2
        ...
GPK0    0x040           0x08
GPK1    0x060           0x0C
GPK2    0x080           0x10
GPK3    0x0A0           0x14
GPL0    0x0C0           0x18
GPL1    0x0E0           0x1C
GPL2    0x100           0x20
GPY0    0x120           x
GPY1    0x140           x
GPY2    0x160           x
GPY3    0x180           x
GPY4    0x1A0           x
GPY5    0x1C0           x
GPY6    0x1E0           x
        ...
GPM0    0x260           0x24
GPM1    0x280           0x28
GPM2    0x2A0           0x2C
GPM3    0x2C0           0x30
GPM4    0x2E0           0x34
GPX0    0xC00           x
GPX1    0xC20           x
GPX2    0xC40           x
GPX3    0xC60           x

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/include/mach/gpio.h |   28 +++-
 arch/arm/mach-exynos/include/mach/irqs.h |    6 -
 drivers/gpio/gpio-samsung.c              |  334 +++++++++++++++++++++++++++---
 3 files changed, 327 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/gpio.h b/arch/arm/mach-exynos/include/mach/gpio.h
index 21c9bf1..2103d14 100644
--- a/arch/arm/mach-exynos/include/mach/gpio.h
+++ b/arch/arm/mach-exynos/include/mach/gpio.h
@@ -26,11 +26,13 @@
 #define EXYNOS4_GPIO_C1_NR	(5)
 #define EXYNOS4_GPIO_D0_NR	(4)
 #define EXYNOS4_GPIO_D1_NR	(4)
+
 #define EXYNOS4210_GPIO_E0_NR	(5)
 #define EXYNOS4210_GPIO_E1_NR	(8)
 #define EXYNOS4210_GPIO_E2_NR	(6)
 #define EXYNOS4210_GPIO_E3_NR	(8)
 #define EXYNOS4210_GPIO_E4_NR	(8)
+
 #define EXYNOS4_GPIO_F0_NR	(8)
 #define EXYNOS4_GPIO_F1_NR	(8)
 #define EXYNOS4_GPIO_F2_NR	(8)
@@ -44,6 +46,13 @@
 #define EXYNOS4_GPIO_L0_NR	(8)
 #define EXYNOS4_GPIO_L1_NR	(3)
 #define EXYNOS4_GPIO_L2_NR	(8)
+
+#define EXYNOS4X12_GPIO_M0_NR	(8)
+#define EXYNOS4X12_GPIO_M1_NR	(7)
+#define EXYNOS4X12_GPIO_M2_NR	(5)
+#define EXYNOS4X12_GPIO_M3_NR	(8)
+#define EXYNOS4X12_GPIO_M4_NR	(8)
+
 #define EXYNOS4_GPIO_X0_NR	(8)
 #define EXYNOS4_GPIO_X1_NR	(8)
 #define EXYNOS4_GPIO_X2_NR	(8)
@@ -67,12 +76,20 @@ enum exynos4_gpio_number {
 	EXYNOS4_GPIO_C1_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_C0),
 	EXYNOS4_GPIO_D0_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_C1),
 	EXYNOS4_GPIO_D1_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_D0),
+
 	EXYNOS4210_GPIO_E0_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_D1),
 	EXYNOS4210_GPIO_E1_START	= EXYNOS_GPIO_NEXT(EXYNOS4210_GPIO_E0),
 	EXYNOS4210_GPIO_E2_START	= EXYNOS_GPIO_NEXT(EXYNOS4210_GPIO_E1),
 	EXYNOS4210_GPIO_E3_START	= EXYNOS_GPIO_NEXT(EXYNOS4210_GPIO_E2),
 	EXYNOS4210_GPIO_E4_START	= EXYNOS_GPIO_NEXT(EXYNOS4210_GPIO_E3),
-	EXYNOS4_GPIO_F0_START	= EXYNOS_GPIO_NEXT(EXYNOS4210_GPIO_E4),
+
+	EXYNOS4X12_GPIO_M0_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_D1),
+	EXYNOS4X12_GPIO_M1_START	= EXYNOS_GPIO_NEXT(EXYNOS4X12_GPIO_M0),
+	EXYNOS4X12_GPIO_M2_START	= EXYNOS_GPIO_NEXT(EXYNOS4X12_GPIO_M1),
+	EXYNOS4X12_GPIO_M3_START	= EXYNOS_GPIO_NEXT(EXYNOS4X12_GPIO_M2),
+	EXYNOS4X12_GPIO_M4_START	= EXYNOS_GPIO_NEXT(EXYNOS4X12_GPIO_M3),
+
+	EXYNOS4_GPIO_F0_START	= EXYNOS_GPIO_NEXT(EXYNOS4X12_GPIO_M4),
 	EXYNOS4_GPIO_F1_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_F0),
 	EXYNOS4_GPIO_F2_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_F1),
 	EXYNOS4_GPIO_F3_START	= EXYNOS_GPIO_NEXT(EXYNOS4_GPIO_F2),
@@ -108,11 +125,13 @@ enum exynos4_gpio_number {
 #define EXYNOS4_GPC1(_nr)	(EXYNOS4_GPIO_C1_START + (_nr))
 #define EXYNOS4_GPD0(_nr)	(EXYNOS4_GPIO_D0_START + (_nr))
 #define EXYNOS4_GPD1(_nr)	(EXYNOS4_GPIO_D1_START + (_nr))
+
 #define EXYNOS4210_GPE0(_nr)	(EXYNOS4210_GPIO_E0_START + (_nr))
 #define EXYNOS4210_GPE1(_nr)	(EXYNOS4210_GPIO_E1_START + (_nr))
 #define EXYNOS4210_GPE2(_nr)	(EXYNOS4210_GPIO_E2_START + (_nr))
 #define EXYNOS4210_GPE3(_nr)	(EXYNOS4210_GPIO_E3_START + (_nr))
 #define EXYNOS4210_GPE4(_nr)	(EXYNOS4210_GPIO_E4_START + (_nr))
+
 #define EXYNOS4_GPF0(_nr)	(EXYNOS4_GPIO_F0_START + (_nr))
 #define EXYNOS4_GPF1(_nr)	(EXYNOS4_GPIO_F1_START + (_nr))
 #define EXYNOS4_GPF2(_nr)	(EXYNOS4_GPIO_F2_START + (_nr))
@@ -126,6 +145,13 @@ enum exynos4_gpio_number {
 #define EXYNOS4_GPL0(_nr)	(EXYNOS4_GPIO_L0_START + (_nr))
 #define EXYNOS4_GPL1(_nr)	(EXYNOS4_GPIO_L1_START + (_nr))
 #define EXYNOS4_GPL2(_nr)	(EXYNOS4_GPIO_L2_START + (_nr))
+
+#define EXYNOS4X12_GPM0(_nr)	(EXYNOS4X12_GPIO_M0_START + (_nr))
+#define EXYNOS4X12_GPM1(_nr)	(EXYNOS4X12_GPIO_M1_START + (_nr))
+#define EXYNOS4X12_GPM2(_nr)	(EXYNOS4X12_GPIO_M2_START + (_nr))
+#define EXYNOS4X12_GPM3(_nr)	(EXYNOS4X12_GPIO_M3_START + (_nr))
+#define EXYNOS4X12_GPM4(_nr)	(EXYNOS4X12_GPIO_M4_START + (_nr))
+
 #define EXYNOS4_GPX0(_nr)	(EXYNOS4_GPIO_X0_START + (_nr))
 #define EXYNOS4_GPX1(_nr)	(EXYNOS4_GPIO_X1_START + (_nr))
 #define EXYNOS4_GPX2(_nr)	(EXYNOS4_GPIO_X2_START + (_nr))
diff --git a/arch/arm/mach-exynos/include/mach/irqs.h b/arch/arm/mach-exynos/include/mach/irqs.h
index 561553a..cc6f31a 100644
--- a/arch/arm/mach-exynos/include/mach/irqs.h
+++ b/arch/arm/mach-exynos/include/mach/irqs.h
@@ -167,9 +167,6 @@
 
 #define EXYNOS4_MAX_COMBINER_NR		16
 
-#define EXYNOS4_IRQ_GPIO1_NR_GROUPS	16
-#define EXYNOS4_IRQ_GPIO2_NR_GROUPS	9
-
 /*
  * For Compatibility:
  * the default is for EXYNOS4, and
@@ -231,9 +228,6 @@
 #define IRQ_FIMD0_VSYNC			EXYNOS4_IRQ_FIMD0_VSYNC
 #define IRQ_FIMD0_SYSTEM		EXYNOS4_IRQ_FIMD0_SYSTEM
 
-#define IRQ_GPIO1_NR_GROUPS		EXYNOS4_IRQ_GPIO1_NR_GROUPS
-#define IRQ_GPIO2_NR_GROUPS		EXYNOS4_IRQ_GPIO2_NR_GROUPS
-
 /* For EXYNOS5 SoCs */
 
 #define EXYNOS5_IRQ_MDMA0		IRQ_SPI(33)
diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index eda34e6..d57f93a 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -2126,7 +2126,7 @@ static struct samsung_gpio_chip s5pv210_gpios_4bit[] = {
  */
 
 #ifdef CONFIG_ARCH_EXYNOS4
-static struct samsung_gpio_chip exynos4_gpios_1[] = {
+static struct samsung_gpio_chip exynos4210_gpios_1[] = {
 	{
 		.chip	= {
 			.base	= EXYNOS4_GPA0(0),
@@ -2225,10 +2225,93 @@ static struct samsung_gpio_chip exynos4_gpios_1[] = {
 		},
 	},
 };
-#endif
 
-#ifdef CONFIG_ARCH_EXYNOS4
-static struct samsung_gpio_chip exynos4_gpios_2[] = {
+static struct samsung_gpio_chip exynos4x12_gpios_1[] = {
+	{
+		.chip	= {
+			.base	= EXYNOS4_GPA0(0),
+			.ngpio	= EXYNOS4_GPIO_A0_NR,
+			.label	= "GPA0",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS4_GPA1(0),
+			.ngpio	= EXYNOS4_GPIO_A1_NR,
+			.label	= "GPA1",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS4_GPB(0),
+			.ngpio	= EXYNOS4_GPIO_B_NR,
+			.label	= "GPB",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS4_GPC0(0),
+			.ngpio	= EXYNOS4_GPIO_C0_NR,
+			.label	= "GPC0",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS4_GPC1(0),
+			.ngpio	= EXYNOS4_GPIO_C1_NR,
+			.label	= "GPC1",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS4_GPD0(0),
+			.ngpio	= EXYNOS4_GPIO_D0_NR,
+			.label	= "GPD0",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS4_GPD1(0),
+			.ngpio	= EXYNOS4_GPIO_D1_NR,
+			.label	= "GPD1",
+		},
+	}, {
+		.base	= (void *)0x180,
+		.group	= 12,
+		.chip	= {
+			.base	= EXYNOS4_GPF0(0),
+			.ngpio	= EXYNOS4_GPIO_F0_NR,
+			.label	= "GPF0",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS4_GPF1(0),
+			.ngpio	= EXYNOS4_GPIO_F1_NR,
+			.label	= "GPF1",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS4_GPF2(0),
+			.ngpio	= EXYNOS4_GPIO_F2_NR,
+			.label	= "GPF2",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS4_GPF3(0),
+			.ngpio	= EXYNOS4_GPIO_F3_NR,
+			.label	= "GPF3",
+		},
+	}, {
+		.base	= (void *)0x240,
+		.chip	= {
+			.base	= EXYNOS4_GPJ0(0),
+			.ngpio	= EXYNOS4_GPIO_J0_NR,
+			.label	= "GPJ0",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS4_GPJ1(0),
+			.ngpio	= EXYNOS4_GPIO_J1_NR,
+			.label	= "GPJ1",
+		},
+	},
+};
+
+static struct samsung_gpio_chip exynos4210_gpios_2[] = {
 	{
 		.chip	= {
 			.base	= EXYNOS4_GPJ0(0),
@@ -2333,6 +2416,172 @@ static struct samsung_gpio_chip exynos4_gpios_2[] = {
 			.label	= "GPY6",
 		},
 	}, {
+		.base	= (void *)0xC00,
+		.config	= &samsung_gpio_cfgs[9],
+		.irq_base = IRQ_EINT(0),
+		.chip	= {
+			.base	= EXYNOS4_GPX0(0),
+			.ngpio	= EXYNOS4_GPIO_X0_NR,
+			.label	= "GPX0",
+			.to_irq	= samsung_gpiolib_to_irq,
+		},
+	}, {
+		.config	= &samsung_gpio_cfgs[9],
+		.irq_base = IRQ_EINT(8),
+		.chip	= {
+			.base	= EXYNOS4_GPX1(0),
+			.ngpio	= EXYNOS4_GPIO_X1_NR,
+			.label	= "GPX1",
+			.to_irq	= samsung_gpiolib_to_irq,
+		},
+	}, {
+		.config	= &samsung_gpio_cfgs[9],
+		.irq_base = IRQ_EINT(16),
+		.chip	= {
+			.base	= EXYNOS4_GPX2(0),
+			.ngpio	= EXYNOS4_GPIO_X2_NR,
+			.label	= "GPX2",
+			.to_irq	= samsung_gpiolib_to_irq,
+		},
+	}, {
+		.config	= &samsung_gpio_cfgs[9],
+		.irq_base = IRQ_EINT(24),
+		.chip	= {
+			.base	= EXYNOS4_GPX3(0),
+			.ngpio	= EXYNOS4_GPIO_X3_NR,
+			.label	= "GPX3",
+			.to_irq	= samsung_gpiolib_to_irq,
+		},
+	},
+};
+
+static struct samsung_gpio_chip exynos4x12_gpios_2[] = {
+	{
+		.base	= (void *)0x040,
+		.group	= 20,
+		.chip	= {
+			.base	= EXYNOS4_GPK0(0),
+			.ngpio	= EXYNOS4_GPIO_K0_NR,
+			.label	= "GPK0",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS4_GPK1(0),
+			.ngpio	= EXYNOS4_GPIO_K1_NR,
+			.label	= "GPK1",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS4_GPK2(0),
+			.ngpio	= EXYNOS4_GPIO_K2_NR,
+			.label	= "GPK2",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS4_GPK3(0),
+			.ngpio	= EXYNOS4_GPIO_K3_NR,
+			.label	= "GPK3",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS4_GPL0(0),
+			.ngpio	= EXYNOS4_GPIO_L0_NR,
+			.label	= "GPL0",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS4_GPL1(0),
+			.ngpio	= EXYNOS4_GPIO_L1_NR,
+			.label	= "GPL1",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS4_GPL2(0),
+			.ngpio	= EXYNOS4_GPIO_L2_NR,
+			.label	= "GPL2",
+		},
+	}, {
+		.config	= &samsung_gpio_cfgs[8],
+		.chip	= {
+			.base	= EXYNOS4_GPY0(0),
+			.ngpio	= EXYNOS4_GPIO_Y0_NR,
+			.label	= "GPY0",
+		},
+	}, {
+		.config	= &samsung_gpio_cfgs[8],
+		.chip	= {
+			.base	= EXYNOS4_GPY1(0),
+			.ngpio	= EXYNOS4_GPIO_Y1_NR,
+			.label	= "GPY1",
+		},
+	}, {
+		.config	= &samsung_gpio_cfgs[8],
+		.chip	= {
+			.base	= EXYNOS4_GPY2(0),
+			.ngpio	= EXYNOS4_GPIO_Y2_NR,
+			.label	= "GPY2",
+		},
+	}, {
+		.config	= &samsung_gpio_cfgs[8],
+		.chip	= {
+			.base	= EXYNOS4_GPY3(0),
+			.ngpio	= EXYNOS4_GPIO_Y3_NR,
+			.label	= "GPY3",
+		},
+	}, {
+		.config	= &samsung_gpio_cfgs[8],
+		.chip	= {
+			.base	= EXYNOS4_GPY4(0),
+			.ngpio	= EXYNOS4_GPIO_Y4_NR,
+			.label	= "GPY4",
+		},
+	}, {
+		.config	= &samsung_gpio_cfgs[8],
+		.chip	= {
+			.base	= EXYNOS4_GPY5(0),
+			.ngpio	= EXYNOS4_GPIO_Y5_NR,
+			.label	= "GPY5",
+		},
+	}, {
+		.config	= &samsung_gpio_cfgs[8],
+		.chip	= {
+			.base	= EXYNOS4_GPY6(0),
+			.ngpio	= EXYNOS4_GPIO_Y6_NR,
+			.label	= "GPY6",
+		},
+	}, {
+		.base	= (void *)0x260,
+		.chip	= {
+			.base	= EXYNOS4X12_GPM0(0),
+			.ngpio	= EXYNOS4X12_GPIO_M0_NR,
+			.label	= "GPM0",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS4X12_GPM1(0),
+			.ngpio	= EXYNOS4X12_GPIO_M1_NR,
+			.label	= "GPM1",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS4X12_GPM2(0),
+			.ngpio	= EXYNOS4X12_GPIO_M2_NR,
+			.label	= "GPM2",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS4X12_GPM3(0),
+			.ngpio	= EXYNOS4X12_GPIO_M3_NR,
+			.label	= "GPM3",
+		},
+	}, {
+		.chip	= {
+			.base	= EXYNOS4X12_GPM4(0),
+			.ngpio	= EXYNOS4X12_GPIO_M4_NR,
+			.label	= "GPM4",
+		},
+	}, {
+		.base	= (void *)0xC00,
 		.config	= &samsung_gpio_cfgs[9],
 		.irq_base = IRQ_EINT(0),
 		.chip	= {
@@ -2370,9 +2619,7 @@ static struct samsung_gpio_chip exynos4_gpios_2[] = {
 		},
 	},
 };
-#endif
 
-#ifdef CONFIG_ARCH_EXYNOS4
 static struct samsung_gpio_chip exynos4_gpios_3[] = {
 	{
 		.chip	= {
@@ -2727,7 +2974,7 @@ static __init int samsung_gpiolib_init(void)
 {
 	struct samsung_gpio_chip *chip;
 	int i, nr_chips;
-#if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS5250)
+#if defined(CONFIG_ARCH_EXYNOS4) || defined(CONFIG_SOC_EXYNOS5250)
 	void __iomem *gpio_base1, *gpio_base2, *gpio_base3, *gpio_base4;
 #endif
 	int group = 0;
@@ -2794,9 +3041,12 @@ static __init int samsung_gpiolib_init(void)
 #if defined(CONFIG_CPU_S5PV210) && defined(CONFIG_S5P_GPIO_INT)
 		s5p_register_gpioint_bank(IRQ_GPIOINT, 0, S5P_GPIOINT_GROUP_MAXNR);
 #endif
-	} else if (soc_is_exynos4210()) {
-#ifdef CONFIG_CPU_EXYNOS4210
-		void __iomem *gpx_base;
+	} else if (soc_is_exynos4210() || soc_is_exynos4212() ||
+			soc_is_exynos4412()) {
+#ifdef CONFIG_ARCH_EXYNOS4
+		struct samsung_gpio_chip *chip_p;
+		int offset = 0;
+		int group1 = 0;
 
 		/* gpio part1 */
 		gpio_base1 = ioremap(EXYNOS4_PA_GPIO1, SZ_4K);
@@ -2805,19 +3055,31 @@ static __init int samsung_gpiolib_init(void)
 			goto err_ioremap1;
 		}
 
-		chip = exynos4_gpios_1;
-		nr_chips = ARRAY_SIZE(exynos4_gpios_1);
+		if (soc_is_exynos4210()) {
+			chip = chip_p = exynos4210_gpios_1;
+			nr_chips = ARRAY_SIZE(exynos4210_gpios_1);
+		} else {
+			chip = chip_p = exynos4x12_gpios_1;
+			nr_chips = ARRAY_SIZE(exynos4x12_gpios_1);
+		}
 
 		for (i = 0; i < nr_chips; i++, chip++) {
 			if (!chip->config) {
 				chip->config = &exynos_gpio_cfg;
+				if (chip->group)
+					group = chip->group;
 				chip->group = group++;
 			}
-			exynos_gpiolib_attach_ofnode(chip,
-					EXYNOS4_PA_GPIO1, i * 0x20);
+
+			if (chip->base)
+				offset = (u32)chip->base;
+			chip->base = gpio_base1 + offset;
+			offset += 0x20;
+
+			exynos_gpiolib_attach_ofnode(chip, EXYNOS4_PA_GPIO1, 0);
 		}
-		samsung_gpiolib_add_4bit_chips(exynos4_gpios_1,
-					       nr_chips, gpio_base1);
+		samsung_gpiolib_add_4bit_chips(chip_p, nr_chips, gpio_base1);
+		group1 = group;
 
 		/* gpio part2 */
 		gpio_base2 = ioremap(EXYNOS4_PA_GPIO2, SZ_4K);
@@ -2826,25 +3088,32 @@ static __init int samsung_gpiolib_init(void)
 			goto err_ioremap2;
 		}
 
-		/* need to set base address for gpx */
-		chip = &exynos4_gpios_2[16];
-		gpx_base = gpio_base2 + 0xC00;
-		for (i = 0; i < 4; i++, chip++, gpx_base += 0x20)
-			chip->base = gpx_base;
+		if (soc_is_exynos4210()) {
+			chip = chip_p = exynos4210_gpios_2;
+			nr_chips = ARRAY_SIZE(exynos4210_gpios_2);
+		} else {
+			chip = chip_p = exynos4x12_gpios_2;
+			nr_chips = ARRAY_SIZE(exynos4x12_gpios_2);
+		}
 
-		chip = exynos4_gpios_2;
-		nr_chips = ARRAY_SIZE(exynos4_gpios_2);
+		offset = 0;
 
 		for (i = 0; i < nr_chips; i++, chip++) {
 			if (!chip->config) {
 				chip->config = &exynos_gpio_cfg;
+				if (chip->group)
+					group = chip->group;
 				chip->group = group++;
 			}
-			exynos_gpiolib_attach_ofnode(chip,
-					EXYNOS4_PA_GPIO2, i * 0x20);
+
+			if (chip->base)
+				offset = (u32)chip->base;
+			chip->base = gpio_base2 + offset;
+			offset += 0x20;
+
+			exynos_gpiolib_attach_ofnode(chip, EXYNOS4_PA_GPIO2, 0);
 		}
-		samsung_gpiolib_add_4bit_chips(exynos4_gpios_2,
-					       nr_chips, gpio_base2);
+		samsung_gpiolib_add_4bit_chips(chip_p, nr_chips, gpio_base2);
 
 		/* gpio part3 */
 		gpio_base3 = ioremap(EXYNOS4_PA_GPIO3, SZ_256);
@@ -2867,12 +3136,9 @@ static __init int samsung_gpiolib_init(void)
 		samsung_gpiolib_add_4bit_chips(exynos4_gpios_3,
 					       nr_chips, gpio_base3);
 
-#if defined(CONFIG_CPU_EXYNOS4210) && defined(CONFIG_S5P_GPIO_INT)
-		s5p_register_gpioint_bank(IRQ_GPIO_XA, 0, IRQ_GPIO1_NR_GROUPS);
-		s5p_register_gpioint_bank(IRQ_GPIO_XB, IRQ_GPIO1_NR_GROUPS, IRQ_GPIO2_NR_GROUPS);
-#endif
-
-#endif	/* CONFIG_CPU_EXYNOS4210 */
+		s5p_register_gpioint_bank(IRQ_GPIO_XA, 0, group1);
+		s5p_register_gpioint_bank(IRQ_GPIO_XB, group1, group - group1);
+#endif	/* CONFIG_ARCH_EXYNOS4 */
 	} else if (soc_is_exynos5250()) {
 #ifdef CONFIG_SOC_EXYNOS5250
 		void __iomem *gpx_base;
@@ -2984,7 +3250,7 @@ static __init int samsung_gpiolib_init(void)
 
 	return 0;
 
-#if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS5250)
+#if defined(CONFIG_ARCH_EXYNOS4) || defined(CONFIG_SOC_EXYNOS5250)
 err_ioremap4:
 	iounmap(gpio_base3);
 err_ioremap3:
-- 
1.7.5.4
