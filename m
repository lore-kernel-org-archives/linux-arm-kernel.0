From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 01 Jul 2014 06:32:12 +0900
Subject: [PATCH 02/17] gpio: samsung: remove s5p64x0 related gpio codes
In-Reply-To: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
References: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1404163947-3105-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes gpio codes for s5p6440 and s5p6450 SoCs.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-samsung.c |  446 -------------------------------------------
 1 file changed, 446 deletions(-)

diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index 07105ee..d12945c 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -358,47 +358,6 @@ static unsigned s3c24xx_gpio_getcfg_abank(struct samsung_gpio_chip *chip,
 }
 #endif
 
-#if defined(CONFIG_CPU_S5P6440) || defined(CONFIG_CPU_S5P6450)
-static int s5p64x0_gpio_setcfg_rbank(struct samsung_gpio_chip *chip,
-				     unsigned int off, unsigned int cfg)
-{
-	void __iomem *reg = chip->base;
-	unsigned int shift;
-	u32 con;
-
-	switch (off) {
-	case 0:
-	case 1:
-	case 2:
-	case 3:
-	case 4:
-	case 5:
-		shift = (off & 7) * 4;
-		reg -= 4;
-		break;
-	case 6:
-		shift = ((off + 1) & 7) * 4;
-		reg -= 4;
-		break;
-	default:
-		shift = ((off + 1) & 7) * 4;
-		break;
-	}
-
-	if (samsung_gpio_is_cfg_special(cfg)) {
-		cfg &= 0xf;
-		cfg <<= shift;
-	}
-
-	con = __raw_readl(reg);
-	con &= ~(0xf << shift);
-	con |= cfg;
-	__raw_writel(con, reg);
-
-	return 0;
-}
-#endif
-
 static void __init samsung_gpiolib_set_cfg(struct samsung_gpio_cfg *chipcfg,
 					   int nr_chips)
 {
@@ -426,16 +385,6 @@ static struct samsung_gpio_cfg s3c24xx_gpiocfg_banka = {
 };
 #endif
 
-#if defined(CONFIG_CPU_S5P6440) || defined(CONFIG_CPU_S5P6450)
-static struct samsung_gpio_cfg s5p64x0_gpio_cfg_rbank = {
-	.cfg_eint	= 0x3,
-	.set_config	= s5p64x0_gpio_setcfg_rbank,
-	.get_config	= samsung_gpio_getcfg_4bit,
-	.set_pull	= samsung_gpio_setpull_updown,
-	.get_pull	= samsung_gpio_getpull_updown,
-};
-#endif
-
 static struct samsung_gpio_cfg samsung_gpio_cfgs[] = {
 	[0] = {
 		.cfg_eint	= 0x0,
@@ -708,91 +657,6 @@ static int s3c24xx_gpiolib_banka_output(struct gpio_chip *chip,
 }
 #endif
 
-/* The next set of routines are for the case of s5p64x0 bank r */
-
-static int s5p64x0_gpiolib_rbank_input(struct gpio_chip *chip,
-				       unsigned int offset)
-{
-	struct samsung_gpio_chip *ourchip = to_samsung_gpio(chip);
-	void __iomem *base = ourchip->base;
-	void __iomem *regcon = base;
-	unsigned long con;
-	unsigned long flags;
-
-	switch (offset) {
-	case 6:
-		offset += 1;
-	case 0:
-	case 1:
-	case 2:
-	case 3:
-	case 4:
-	case 5:
-		regcon -= 4;
-		break;
-	default:
-		offset -= 7;
-		break;
-	}
-
-	samsung_gpio_lock(ourchip, flags);
-
-	con = __raw_readl(regcon);
-	con &= ~(0xf << con_4bit_shift(offset));
-	__raw_writel(con, regcon);
-
-	samsung_gpio_unlock(ourchip, flags);
-
-	return 0;
-}
-
-static int s5p64x0_gpiolib_rbank_output(struct gpio_chip *chip,
-					unsigned int offset, int value)
-{
-	struct samsung_gpio_chip *ourchip = to_samsung_gpio(chip);
-	void __iomem *base = ourchip->base;
-	void __iomem *regcon = base;
-	unsigned long con;
-	unsigned long dat;
-	unsigned long flags;
-	unsigned con_offset  = offset;
-
-	switch (con_offset) {
-	case 6:
-		con_offset += 1;
-	case 0:
-	case 1:
-	case 2:
-	case 3:
-	case 4:
-	case 5:
-		regcon -= 4;
-		break;
-	default:
-		con_offset -= 7;
-		break;
-	}
-
-	samsung_gpio_lock(ourchip, flags);
-
-	con = __raw_readl(regcon);
-	con &= ~(0xf << con_4bit_shift(con_offset));
-	con |= 0x1 << con_4bit_shift(con_offset);
-
-	dat = __raw_readl(base + GPIODAT_OFF);
-	if (value)
-		dat |= 1 << offset;
-	else
-		dat &= ~(1 << offset);
-
-	__raw_writel(con, regcon);
-	__raw_writel(dat, base + GPIODAT_OFF);
-
-	samsung_gpio_unlock(ourchip, flags);
-
-	return 0;
-}
-
 static void samsung_gpiolib_set(struct gpio_chip *chip,
 				unsigned offset, int value)
 {
@@ -999,20 +863,6 @@ static void __init samsung_gpiolib_add_4bit2_chips(struct samsung_gpio_chip *chi
 	}
 }
 
-static void __init s5p64x0_gpiolib_add_rbank(struct samsung_gpio_chip *chip,
-					     int nr_chips)
-{
-	for (; nr_chips > 0; nr_chips--, chip++) {
-		chip->chip.direction_input = s5p64x0_gpiolib_rbank_input;
-		chip->chip.direction_output = s5p64x0_gpiolib_rbank_output;
-
-		if (!chip->pm)
-			chip->pm = __gpio_pm(&samsung_gpio_pm_4bit);
-
-		samsung_gpiolib_add(chip);
-	}
-}
-
 int samsung_gpiolib_to_irq(struct gpio_chip *chip, unsigned int offset)
 {
 	struct samsung_gpio_chip *samsung_chip = container_of(chip, struct samsung_gpio_chip, chip);
@@ -1320,284 +1170,6 @@ static struct samsung_gpio_chip s3c64xx_gpios_2bit[] = {
 };
 
 /*
- * S5P6440 GPIO bank summary:
- *
- * Bank	GPIOs	Style	SlpCon	ExtInt Group
- * A	6	4Bit	Yes	1
- * B	7	4Bit	Yes	1
- * C	8	4Bit	Yes	2
- * F	2	2Bit	Yes	4 [1]
- * G	7	4Bit	Yes	5
- * H	10	4Bit[2]	Yes	6
- * I	16	2Bit	Yes	None
- * J	12	2Bit	Yes	None
- * N	16	2Bit	No	IRQ_EINT
- * P	8	2Bit	Yes	8
- * R	15	4Bit[2]	Yes	8
- */
-
-static struct samsung_gpio_chip s5p6440_gpios_4bit[] = {
-#ifdef CONFIG_CPU_S5P6440
-	{
-		.chip	= {
-			.base	= S5P6440_GPA(0),
-			.ngpio	= S5P6440_GPIO_A_NR,
-			.label	= "GPA",
-		},
-	}, {
-		.chip	= {
-			.base	= S5P6440_GPB(0),
-			.ngpio	= S5P6440_GPIO_B_NR,
-			.label	= "GPB",
-		},
-	}, {
-		.chip	= {
-			.base	= S5P6440_GPC(0),
-			.ngpio	= S5P6440_GPIO_C_NR,
-			.label	= "GPC",
-		},
-	}, {
-		.base	= S5P64X0_GPG_BASE,
-		.chip	= {
-			.base	= S5P6440_GPG(0),
-			.ngpio	= S5P6440_GPIO_G_NR,
-			.label	= "GPG",
-		},
-	},
-#endif
-};
-
-static struct samsung_gpio_chip s5p6440_gpios_4bit2[] = {
-#ifdef CONFIG_CPU_S5P6440
-	{
-		.base	= S5P64X0_GPH_BASE + 0x4,
-		.chip	= {
-			.base	= S5P6440_GPH(0),
-			.ngpio	= S5P6440_GPIO_H_NR,
-			.label	= "GPH",
-		},
-	},
-#endif
-};
-
-static struct samsung_gpio_chip s5p6440_gpios_rbank[] = {
-#ifdef CONFIG_CPU_S5P6440
-	{
-		.base	= S5P64X0_GPR_BASE + 0x4,
-		.config	= &s5p64x0_gpio_cfg_rbank,
-		.chip	= {
-			.base	= S5P6440_GPR(0),
-			.ngpio	= S5P6440_GPIO_R_NR,
-			.label	= "GPR",
-		},
-	},
-#endif
-};
-
-static struct samsung_gpio_chip s5p6440_gpios_2bit[] = {
-#ifdef CONFIG_CPU_S5P6440
-	{
-		.base	= S5P64X0_GPF_BASE,
-		.config	= &samsung_gpio_cfgs[6],
-		.chip	= {
-			.base	= S5P6440_GPF(0),
-			.ngpio	= S5P6440_GPIO_F_NR,
-			.label	= "GPF",
-		},
-	}, {
-		.base	= S5P64X0_GPI_BASE,
-		.config	= &samsung_gpio_cfgs[4],
-		.chip	= {
-			.base	= S5P6440_GPI(0),
-			.ngpio	= S5P6440_GPIO_I_NR,
-			.label	= "GPI",
-		},
-	}, {
-		.base	= S5P64X0_GPJ_BASE,
-		.config	= &samsung_gpio_cfgs[4],
-		.chip	= {
-			.base	= S5P6440_GPJ(0),
-			.ngpio	= S5P6440_GPIO_J_NR,
-			.label	= "GPJ",
-		},
-	}, {
-		.base	= S5P64X0_GPN_BASE,
-		.config	= &samsung_gpio_cfgs[5],
-		.chip	= {
-			.base	= S5P6440_GPN(0),
-			.ngpio	= S5P6440_GPIO_N_NR,
-			.label	= "GPN",
-		},
-	}, {
-		.base	= S5P64X0_GPP_BASE,
-		.config	= &samsung_gpio_cfgs[6],
-		.chip	= {
-			.base	= S5P6440_GPP(0),
-			.ngpio	= S5P6440_GPIO_P_NR,
-			.label	= "GPP",
-		},
-	},
-#endif
-};
-
-/*
- * S5P6450 GPIO bank summary:
- *
- * Bank	GPIOs	Style	SlpCon	ExtInt Group
- * A	6	4Bit	Yes	1
- * B	7	4Bit	Yes	1
- * C	8	4Bit	Yes	2
- * D	8	4Bit	Yes	None
- * F	2	2Bit	Yes	None
- * G	14	4Bit[2]	Yes	5
- * H	10	4Bit[2]	Yes	6
- * I	16	2Bit	Yes	None
- * J	12	2Bit	Yes	None
- * K	5	4Bit	Yes	None
- * N	16	2Bit	No	IRQ_EINT
- * P	11	2Bit	Yes	8
- * Q	14	2Bit	Yes	None
- * R	15	4Bit[2]	Yes	None
- * S	8	2Bit	Yes	None
- *
- * [1] BANKF pins 14,15 do not form part of the external interrupt sources
- * [2] BANK has two control registers, GPxCON0 and GPxCON1
- */
-
-static struct samsung_gpio_chip s5p6450_gpios_4bit[] = {
-#ifdef CONFIG_CPU_S5P6450
-	{
-		.chip	= {
-			.base	= S5P6450_GPA(0),
-			.ngpio	= S5P6450_GPIO_A_NR,
-			.label	= "GPA",
-		},
-	}, {
-		.chip	= {
-			.base	= S5P6450_GPB(0),
-			.ngpio	= S5P6450_GPIO_B_NR,
-			.label	= "GPB",
-		},
-	}, {
-		.chip	= {
-			.base	= S5P6450_GPC(0),
-			.ngpio	= S5P6450_GPIO_C_NR,
-			.label	= "GPC",
-		},
-	}, {
-		.chip	= {
-			.base	= S5P6450_GPD(0),
-			.ngpio	= S5P6450_GPIO_D_NR,
-			.label	= "GPD",
-		},
-	}, {
-		.base	= S5P6450_GPK_BASE,
-		.chip	= {
-			.base	= S5P6450_GPK(0),
-			.ngpio	= S5P6450_GPIO_K_NR,
-			.label	= "GPK",
-		},
-	},
-#endif
-};
-
-static struct samsung_gpio_chip s5p6450_gpios_4bit2[] = {
-#ifdef CONFIG_CPU_S5P6450
-	{
-		.base	= S5P64X0_GPG_BASE + 0x4,
-		.chip	= {
-			.base	= S5P6450_GPG(0),
-			.ngpio	= S5P6450_GPIO_G_NR,
-			.label	= "GPG",
-		},
-	}, {
-		.base	= S5P64X0_GPH_BASE + 0x4,
-		.chip	= {
-			.base	= S5P6450_GPH(0),
-			.ngpio	= S5P6450_GPIO_H_NR,
-			.label	= "GPH",
-		},
-	},
-#endif
-};
-
-static struct samsung_gpio_chip s5p6450_gpios_rbank[] = {
-#ifdef CONFIG_CPU_S5P6450
-	{
-		.base	= S5P64X0_GPR_BASE + 0x4,
-		.config	= &s5p64x0_gpio_cfg_rbank,
-		.chip	= {
-			.base	= S5P6450_GPR(0),
-			.ngpio	= S5P6450_GPIO_R_NR,
-			.label	= "GPR",
-		},
-	},
-#endif
-};
-
-static struct samsung_gpio_chip s5p6450_gpios_2bit[] = {
-#ifdef CONFIG_CPU_S5P6450
-	{
-		.base	= S5P64X0_GPF_BASE,
-		.config	= &samsung_gpio_cfgs[6],
-		.chip	= {
-			.base	= S5P6450_GPF(0),
-			.ngpio	= S5P6450_GPIO_F_NR,
-			.label	= "GPF",
-		},
-	}, {
-		.base	= S5P64X0_GPI_BASE,
-		.config	= &samsung_gpio_cfgs[4],
-		.chip	= {
-			.base	= S5P6450_GPI(0),
-			.ngpio	= S5P6450_GPIO_I_NR,
-			.label	= "GPI",
-		},
-	}, {
-		.base	= S5P64X0_GPJ_BASE,
-		.config	= &samsung_gpio_cfgs[4],
-		.chip	= {
-			.base	= S5P6450_GPJ(0),
-			.ngpio	= S5P6450_GPIO_J_NR,
-			.label	= "GPJ",
-		},
-	}, {
-		.base	= S5P64X0_GPN_BASE,
-		.config	= &samsung_gpio_cfgs[5],
-		.chip	= {
-			.base	= S5P6450_GPN(0),
-			.ngpio	= S5P6450_GPIO_N_NR,
-			.label	= "GPN",
-		},
-	}, {
-		.base	= S5P64X0_GPP_BASE,
-		.config	= &samsung_gpio_cfgs[6],
-		.chip	= {
-			.base	= S5P6450_GPP(0),
-			.ngpio	= S5P6450_GPIO_P_NR,
-			.label	= "GPP",
-		},
-	}, {
-		.base	= S5P6450_GPQ_BASE,
-		.config	= &samsung_gpio_cfgs[5],
-		.chip	= {
-			.base	= S5P6450_GPQ(0),
-			.ngpio	= S5P6450_GPIO_Q_NR,
-			.label	= "GPQ",
-		},
-	}, {
-		.base	= S5P6450_GPS_BASE,
-		.config	= &samsung_gpio_cfgs[6],
-		.chip	= {
-			.base	= S5P6450_GPS(0),
-			.ngpio	= S5P6450_GPIO_S_NR,
-			.label	= "GPS",
-		},
-	},
-#endif
-};
-
-/*
  * S5PC100 GPIO bank summary:
  *
  * Bank	GPIOs	Style	INT Type
@@ -2109,24 +1681,6 @@ static __init int samsung_gpiolib_init(void)
 				S3C64XX_VA_GPIO);
 		samsung_gpiolib_add_4bit2_chips(s3c64xx_gpios_4bit2,
 				ARRAY_SIZE(s3c64xx_gpios_4bit2));
-	} else if (soc_is_s5p6440()) {
-		samsung_gpiolib_add_2bit_chips(s5p6440_gpios_2bit,
-				ARRAY_SIZE(s5p6440_gpios_2bit), NULL, 0x0);
-		samsung_gpiolib_add_4bit_chips(s5p6440_gpios_4bit,
-				ARRAY_SIZE(s5p6440_gpios_4bit), S5P_VA_GPIO);
-		samsung_gpiolib_add_4bit2_chips(s5p6440_gpios_4bit2,
-				ARRAY_SIZE(s5p6440_gpios_4bit2));
-		s5p64x0_gpiolib_add_rbank(s5p6440_gpios_rbank,
-				ARRAY_SIZE(s5p6440_gpios_rbank));
-	} else if (soc_is_s5p6450()) {
-		samsung_gpiolib_add_2bit_chips(s5p6450_gpios_2bit,
-				ARRAY_SIZE(s5p6450_gpios_2bit), NULL, 0x0);
-		samsung_gpiolib_add_4bit_chips(s5p6450_gpios_4bit,
-				ARRAY_SIZE(s5p6450_gpios_4bit), S5P_VA_GPIO);
-		samsung_gpiolib_add_4bit2_chips(s5p6450_gpios_4bit2,
-				ARRAY_SIZE(s5p6450_gpios_4bit2));
-		s5p64x0_gpiolib_add_rbank(s5p6450_gpios_rbank,
-				ARRAY_SIZE(s5p6450_gpios_rbank));
 	} else if (soc_is_s5pc100()) {
 		group = 0;
 		chip = s5pc100_gpios_4bit;
-- 
1.7.10.4
