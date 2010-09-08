From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed,  8 Sep 2010 17:12:11 +0900
Subject: [PATCH v2 10/13] ARM: S5P64X0: Move GPIO support files for merge
	S5P64X0
Message-ID: <1283933531-394-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves S5P6440 GPIO support files from mach-s5p6440
into the new mach-s5p64x0 for merge S5P6440 and S5P6450 SocS.
NOTE: Not supported S5P6450 GPIO yet. Will be supported soon.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
Changes since v1:
- Added missing mach-s5p64x0/gpio.c

 arch/arm/mach-s5p6440/include/mach/gpio.h          |   80 -----------
 arch/arm/{mach-s5p6440 => mach-s5p64x0}/gpio.c     |   99 +++++++-------
 arch/arm/mach-s5p64x0/include/mach/gpio.h          |  139 ++++++++++++++++++++
 .../include/mach/regs-gpio.h                       |   28 +++--
 4 files changed, 208 insertions(+), 138 deletions(-)
 delete mode 100644 arch/arm/mach-s5p6440/include/mach/gpio.h
 rename arch/arm/{mach-s5p6440 => mach-s5p64x0}/gpio.c (75%)
 create mode 100644 arch/arm/mach-s5p64x0/include/mach/gpio.h
 rename arch/arm/{mach-s5p6440 => mach-s5p64x0}/include/mach/regs-gpio.h (79%)

diff --git a/arch/arm/mach-s5p6440/include/mach/gpio.h b/arch/arm/mach-s5p6440/include/mach/gpio.h
deleted file mode 100644
index 2178383..0000000
--- a/arch/arm/mach-s5p6440/include/mach/gpio.h
+++ /dev/null
@@ -1,80 +0,0 @@
-/* linux/arch/arm/mach-s5p6440/include/mach/gpio.h
- *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5P6440 - GPIO lib support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_GPIO_H
-#define __ASM_ARCH_GPIO_H __FILE__
-
-#define gpio_get_value	__gpio_get_value
-#define gpio_set_value	__gpio_set_value
-#define gpio_cansleep	__gpio_cansleep
-#define gpio_to_irq	__gpio_to_irq
-
-/* GPIO bank sizes */
-#define S5P6440_GPIO_A_NR	(6)
-#define S5P6440_GPIO_B_NR	(7)
-#define S5P6440_GPIO_C_NR	(8)
-#define S5P6440_GPIO_F_NR	(2)
-#define S5P6440_GPIO_G_NR	(7)
-#define S5P6440_GPIO_H_NR	(10)
-#define S5P6440_GPIO_I_NR	(16)
-#define S5P6440_GPIO_J_NR	(12)
-#define S5P6440_GPIO_N_NR	(16)
-#define S5P6440_GPIO_P_NR	(8)
-#define S5P6440_GPIO_R_NR	(15)
-
-/* GPIO bank numbers */
-
-/* CONFIG_S3C_GPIO_SPACE allows the user to select extra
- * space for debugging purposes so that any accidental
- * change from one gpio bank to another can be caught.
-*/
-#define S5P6440_GPIO_NEXT(__gpio) \
-	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 1)
-
-enum s5p_gpio_number {
-	S5P6440_GPIO_A_START = 0,
-	S5P6440_GPIO_B_START = S5P6440_GPIO_NEXT(S5P6440_GPIO_A),
-	S5P6440_GPIO_C_START = S5P6440_GPIO_NEXT(S5P6440_GPIO_B),
-	S5P6440_GPIO_F_START = S5P6440_GPIO_NEXT(S5P6440_GPIO_C),
-	S5P6440_GPIO_G_START = S5P6440_GPIO_NEXT(S5P6440_GPIO_F),
-	S5P6440_GPIO_H_START = S5P6440_GPIO_NEXT(S5P6440_GPIO_G),
-	S5P6440_GPIO_I_START = S5P6440_GPIO_NEXT(S5P6440_GPIO_H),
-	S5P6440_GPIO_J_START = S5P6440_GPIO_NEXT(S5P6440_GPIO_I),
-	S5P6440_GPIO_N_START = S5P6440_GPIO_NEXT(S5P6440_GPIO_J),
-	S5P6440_GPIO_P_START = S5P6440_GPIO_NEXT(S5P6440_GPIO_N),
-	S5P6440_GPIO_R_START = S5P6440_GPIO_NEXT(S5P6440_GPIO_P),
-};
-
-/* S5P6440 GPIO number definitions. */
-#define S5P6440_GPA(_nr)	(S5P6440_GPIO_A_START + (_nr))
-#define S5P6440_GPB(_nr)	(S5P6440_GPIO_B_START + (_nr))
-#define S5P6440_GPC(_nr)	(S5P6440_GPIO_C_START + (_nr))
-#define S5P6440_GPF(_nr)	(S5P6440_GPIO_F_START + (_nr))
-#define S5P6440_GPG(_nr)	(S5P6440_GPIO_G_START + (_nr))
-#define S5P6440_GPH(_nr)	(S5P6440_GPIO_H_START + (_nr))
-#define S5P6440_GPI(_nr)	(S5P6440_GPIO_I_START + (_nr))
-#define S5P6440_GPJ(_nr)	(S5P6440_GPIO_J_START + (_nr))
-#define S5P6440_GPN(_nr)	(S5P6440_GPIO_N_START + (_nr))
-#define S5P6440_GPP(_nr)	(S5P6440_GPIO_P_START + (_nr))
-#define S5P6440_GPR(_nr)	(S5P6440_GPIO_R_START + (_nr))
-
-/* the end of the S5P6440 specific gpios */
-#define S5P6440_GPIO_END	(S5P6440_GPR(S5P6440_GPIO_R_NR) + 1)
-#define S3C_GPIO_END		S5P6440_GPIO_END
-
-/* define the number of gpios we need to the one after the GPR() range */
-#define ARCH_NR_GPIOS		(S5P6440_GPR(S5P6440_GPIO_R_NR) +	\
-				 CONFIG_SAMSUNG_GPIO_EXTRA + 1)
-
-#include <asm-generic/gpio.h>
-
-#endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-s5p6440/gpio.c b/arch/arm/mach-s5p64x0/gpio.c
similarity index 75%
rename from arch/arm/mach-s5p6440/gpio.c
rename to arch/arm/mach-s5p64x0/gpio.c
index 8bf6e0c..131eefe 100644
--- a/arch/arm/mach-s5p6440/gpio.c
+++ b/arch/arm/mach-s5p64x0/gpio.c
@@ -1,14 +1,14 @@
-/* arch/arm/mach-s5p6440/gpio.c
+/* linux/arch/arm/mach-s5p64x0/gpio.c
  *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- * 		http://www.samsung.com/
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
- * S5P6440 - GPIOlib support
+ * S5P64X0 - GPIOlib support
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
- */
+*/
 
 #include <linux/kernel.h>
 #include <linux/irq.h>
@@ -22,26 +22,29 @@
 #include <plat/gpio-cfg.h>
 #include <plat/gpio-cfg-helpers.h>
 
-/* GPIO bank summary:
-*
-* Bank	GPIOs	Style	SlpCon	ExtInt Group
-* A	6	4Bit	Yes	1
-* B	7	4Bit	Yes	1
-* C	8	4Bit	Yes	2
-* F	2	2Bit	Yes	4 [1]
-* G	7	4Bit	Yes	5
-* H	10	4Bit[2]	Yes	6
-* I	16	2Bit	Yes	None
-* J	12	2Bit	Yes	None
-* N	16	2Bit	No	IRQ_EINT
-* P	8	2Bit	Yes	8
-* R	15	4Bit[2]	Yes	8
-*
-* [1] BANKF pins 14,15 do not form part of the external interrupt sources
-* [2] BANK has two control registers, GPxCON0 and GPxCON1
-*/
+/* To be implemented S5P6450 GPIO */
+
+/*
+ * S5P6440 GPIO bank summary:
+ *
+ * Bank	GPIOs	Style	SlpCon	ExtInt Group
+ * A	6	4Bit	Yes	1
+ * B	7	4Bit	Yes	1
+ * C	8	4Bit	Yes	2
+ * F	2	2Bit	Yes	4 [1]
+ * G	7	4Bit	Yes	5
+ * H	10	4Bit[2]	Yes	6
+ * I	16	2Bit	Yes	None
+ * J	12	2Bit	Yes	None
+ * N	16	2Bit	No	IRQ_EINT
+ * P	8	2Bit	Yes	8
+ * R	15	4Bit[2]	Yes	8
+ *
+ * [1] BANKF pins 14,15 do not form part of the external interrupt sources
+ * [2] BANK has two control registers, GPxCON0 and GPxCON1
+ */
 
-static int s5p6440_gpiolib_rbank_4bit2_input(struct gpio_chip *chip,
+static int s5p64x0_gpiolib_rbank_4bit2_input(struct gpio_chip *chip,
 					     unsigned int offset)
 {
 	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
@@ -77,7 +80,7 @@ static int s5p6440_gpiolib_rbank_4bit2_input(struct gpio_chip *chip,
 	return 0;
 }
 
-static int s5p6440_gpiolib_rbank_4bit2_output(struct gpio_chip *chip,
+static int s5p64x0_gpiolib_rbank_4bit2_output(struct gpio_chip *chip,
 					      unsigned int offset, int value)
 {
 	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
@@ -124,7 +127,7 @@ static int s5p6440_gpiolib_rbank_4bit2_output(struct gpio_chip *chip,
 	return 0;
 }
 
-int s5p6440_gpio_setcfg_4bit_rbank(struct s3c_gpio_chip *chip,
+int s5p64x0_gpio_setcfg_4bit_rbank(struct s3c_gpio_chip *chip,
 				   unsigned int off, unsigned int cfg)
 {
 	void __iomem *reg = chip->base;
@@ -167,14 +170,14 @@ int s5p6440_gpio_setcfg_4bit_rbank(struct s3c_gpio_chip *chip,
 	return 0;
 }
 
-static struct s3c_gpio_cfg s5p6440_gpio_cfgs[] = {
+static struct s3c_gpio_cfg s5p64x0_gpio_cfgs[] = {
 	{
 		.cfg_eint	= 0,
 	}, {
 		.cfg_eint	= 7,
 	}, {
 		.cfg_eint	= 3,
-		.set_config	= s5p6440_gpio_setcfg_4bit_rbank,
+		.set_config	= s5p64x0_gpio_setcfg_4bit_rbank,
 	}, {
 		.cfg_eint	= 0,
 		.set_config	= s3c_gpio_setcfg_s3c24xx,
@@ -193,7 +196,7 @@ static struct s3c_gpio_cfg s5p6440_gpio_cfgs[] = {
 static struct s3c_gpio_chip s5p6440_gpio_4bit[] = {
 	{
 		.base	= S5P6440_GPA_BASE,
-		.config	= &s5p6440_gpio_cfgs[1],
+		.config	= &s5p64x0_gpio_cfgs[1],
 		.chip	= {
 			.base	= S5P6440_GPA(0),
 			.ngpio	= S5P6440_GPIO_A_NR,
@@ -201,7 +204,7 @@ static struct s3c_gpio_chip s5p6440_gpio_4bit[] = {
 		},
 	}, {
 		.base	= S5P6440_GPB_BASE,
-		.config	= &s5p6440_gpio_cfgs[1],
+		.config	= &s5p64x0_gpio_cfgs[1],
 		.chip	= {
 			.base	= S5P6440_GPB(0),
 			.ngpio	= S5P6440_GPIO_B_NR,
@@ -209,7 +212,7 @@ static struct s3c_gpio_chip s5p6440_gpio_4bit[] = {
 		},
 	}, {
 		.base	= S5P6440_GPC_BASE,
-		.config	= &s5p6440_gpio_cfgs[1],
+		.config	= &s5p64x0_gpio_cfgs[1],
 		.chip	= {
 			.base	= S5P6440_GPC(0),
 			.ngpio	= S5P6440_GPIO_C_NR,
@@ -217,7 +220,7 @@ static struct s3c_gpio_chip s5p6440_gpio_4bit[] = {
 		},
 	}, {
 		.base	= S5P6440_GPG_BASE,
-		.config	= &s5p6440_gpio_cfgs[1],
+		.config	= &s5p64x0_gpio_cfgs[1],
 		.chip	= {
 			.base	= S5P6440_GPG(0),
 			.ngpio	= S5P6440_GPIO_G_NR,
@@ -229,7 +232,7 @@ static struct s3c_gpio_chip s5p6440_gpio_4bit[] = {
 static struct s3c_gpio_chip s5p6440_gpio_4bit2[] = {
 	{
 		.base	= S5P6440_GPH_BASE + 0x4,
-		.config	= &s5p6440_gpio_cfgs[1],
+		.config	= &s5p64x0_gpio_cfgs[1],
 		.chip	= {
 			.base	= S5P6440_GPH(0),
 			.ngpio	= S5P6440_GPIO_H_NR,
@@ -238,10 +241,10 @@ static struct s3c_gpio_chip s5p6440_gpio_4bit2[] = {
 	},
 };
 
-static struct s3c_gpio_chip gpio_rbank_4bit2[] = {
+static struct s3c_gpio_chip s5p6440_gpio_rbank_4bit2[] = {
 	{
 		.base	= S5P6440_GPR_BASE + 0x4,
-		.config	= &s5p6440_gpio_cfgs[2],
+		.config	= &s5p64x0_gpio_cfgs[2],
 		.chip	= {
 			.base	= S5P6440_GPR(0),
 			.ngpio	= S5P6440_GPIO_R_NR,
@@ -253,7 +256,7 @@ static struct s3c_gpio_chip gpio_rbank_4bit2[] = {
 static struct s3c_gpio_chip s5p6440_gpio_2bit[] = {
 	{
 		.base	= S5P6440_GPF_BASE,
-		.config	= &s5p6440_gpio_cfgs[5],
+		.config	= &s5p64x0_gpio_cfgs[5],
 		.chip	= {
 			.base	= S5P6440_GPF(0),
 			.ngpio	= S5P6440_GPIO_F_NR,
@@ -261,7 +264,7 @@ static struct s3c_gpio_chip s5p6440_gpio_2bit[] = {
 		},
 	}, {
 		.base	= S5P6440_GPI_BASE,
-		.config	= &s5p6440_gpio_cfgs[3],
+		.config	= &s5p64x0_gpio_cfgs[3],
 		.chip	= {
 			.base	= S5P6440_GPI(0),
 			.ngpio	= S5P6440_GPIO_I_NR,
@@ -269,7 +272,7 @@ static struct s3c_gpio_chip s5p6440_gpio_2bit[] = {
 		},
 	}, {
 		.base	= S5P6440_GPJ_BASE,
-		.config	= &s5p6440_gpio_cfgs[3],
+		.config	= &s5p64x0_gpio_cfgs[3],
 		.chip	= {
 			.base	= S5P6440_GPJ(0),
 			.ngpio	= S5P6440_GPIO_J_NR,
@@ -277,7 +280,7 @@ static struct s3c_gpio_chip s5p6440_gpio_2bit[] = {
 		},
 	}, {
 		.base	= S5P6440_GPN_BASE,
-		.config	= &s5p6440_gpio_cfgs[4],
+		.config	= &s5p64x0_gpio_cfgs[4],
 		.chip	= {
 			.base	= S5P6440_GPN(0),
 			.ngpio	= S5P6440_GPIO_N_NR,
@@ -285,7 +288,7 @@ static struct s3c_gpio_chip s5p6440_gpio_2bit[] = {
 		},
 	}, {
 		.base	= S5P6440_GPP_BASE,
-		.config	= &s5p6440_gpio_cfgs[5],
+		.config	= &s5p64x0_gpio_cfgs[5],
 		.chip	= {
 			.base	= S5P6440_GPP(0),
 			.ngpio	= S5P6440_GPIO_P_NR,
@@ -294,7 +297,7 @@ static struct s3c_gpio_chip s5p6440_gpio_2bit[] = {
 	},
 };
 
-void __init s5p6440_gpiolib_set_cfg(struct s3c_gpio_cfg *chipcfg, int nr_chips)
+void __init s5p64x0_gpiolib_set_cfg(struct s3c_gpio_cfg *chipcfg, int nr_chips)
 {
 	for (; nr_chips > 0; nr_chips--, chipcfg++) {
 		if (!chipcfg->set_config)
@@ -308,13 +311,13 @@ void __init s5p6440_gpiolib_set_cfg(struct s3c_gpio_cfg *chipcfg, int nr_chips)
 	}
 }
 
-static void __init s5p6440_gpio_add_rbank_4bit2(struct s3c_gpio_chip *chip,
+static void __init s5p64x0_gpio_add_rbank_4bit2(struct s3c_gpio_chip *chip,
 						int nr_chips)
 {
 	for (; nr_chips > 0; nr_chips--, chip++) {
-		chip->chip.direction_input = s5p6440_gpiolib_rbank_4bit2_input;
+		chip->chip.direction_input = s5p64x0_gpiolib_rbank_4bit2_input;
 		chip->chip.direction_output =
-					s5p6440_gpiolib_rbank_4bit2_output;
+					s5p64x0_gpiolib_rbank_4bit2_output;
 		s3c_gpiolib_add(chip);
 	}
 }
@@ -324,8 +327,8 @@ static int __init s5p6440_gpiolib_init(void)
 	struct s3c_gpio_chip *chips = s5p6440_gpio_2bit;
 	int nr_chips = ARRAY_SIZE(s5p6440_gpio_2bit);
 
-	s5p6440_gpiolib_set_cfg(s5p6440_gpio_cfgs,
-				ARRAY_SIZE(s5p6440_gpio_cfgs));
+	s5p64x0_gpiolib_set_cfg(s5p64x0_gpio_cfgs,
+				ARRAY_SIZE(s5p64x0_gpio_cfgs));
 
 	for (; nr_chips > 0; nr_chips--, chips++)
 		s3c_gpiolib_add(chips);
@@ -336,8 +339,8 @@ static int __init s5p6440_gpiolib_init(void)
 	samsung_gpiolib_add_4bit2_chips(s5p6440_gpio_4bit2,
 				ARRAY_SIZE(s5p6440_gpio_4bit2));
 
-	s5p6440_gpio_add_rbank_4bit2(gpio_rbank_4bit2,
-				ARRAY_SIZE(gpio_rbank_4bit2));
+	s5p64x0_gpio_add_rbank_4bit2(s5p6440_gpio_rbank_4bit2,
+				ARRAY_SIZE(s5p6440_gpio_rbank_4bit2));
 
 	return 0;
 }
diff --git a/arch/arm/mach-s5p64x0/include/mach/gpio.h b/arch/arm/mach-s5p64x0/include/mach/gpio.h
new file mode 100644
index 0000000..5486c8f
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/include/mach/gpio.h
@@ -0,0 +1,139 @@
+/* linux/arch/arm/mach-s5p64x0/include/mach/gpio.h
+ *
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S5P64X0 - GPIO lib support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_GPIO_H
+#define __ASM_ARCH_GPIO_H __FILE__
+
+#define gpio_get_value	__gpio_get_value
+#define gpio_set_value	__gpio_set_value
+#define gpio_cansleep	__gpio_cansleep
+#define gpio_to_irq	__gpio_to_irq
+
+/* GPIO bank sizes */
+
+#define S5P6440_GPIO_A_NR	(6)
+#define S5P6440_GPIO_B_NR	(7)
+#define S5P6440_GPIO_C_NR	(8)
+#define S5P6440_GPIO_F_NR	(2)
+#define S5P6440_GPIO_G_NR	(7)
+#define S5P6440_GPIO_H_NR	(10)
+#define S5P6440_GPIO_I_NR	(16)
+#define S5P6440_GPIO_J_NR	(12)
+#define S5P6440_GPIO_N_NR	(16)
+#define S5P6440_GPIO_P_NR	(8)
+#define S5P6440_GPIO_R_NR	(15)
+
+#define S5P6450_GPIO_A_NR	(6)
+#define S5P6450_GPIO_B_NR	(7)
+#define S5P6450_GPIO_C_NR	(8)
+#define S5P6450_GPIO_D_NR	(8)
+#define S5P6450_GPIO_F_NR	(2)
+#define S5P6450_GPIO_G_NR	(14)
+#define S5P6450_GPIO_H_NR	(10)
+#define S5P6450_GPIO_I_NR	(16)
+#define S5P6450_GPIO_J_NR	(12)
+#define S5P6450_GPIO_K_NR	(5)
+#define S5P6450_GPIO_N_NR	(16)
+#define S5P6450_GPIO_P_NR	(11)
+#define S5P6450_GPIO_Q_NR	(14)
+#define S5P6450_GPIO_R_NR	(15)
+#define S5P6450_GPIO_S_NR	(8)
+
+/* GPIO bank numbers */
+
+/* CONFIG_S3C_GPIO_SPACE allows the user to select extra
+ * space for debugging purposes so that any accidental
+ * change from one gpio bank to another can be caught.
+*/
+
+#define S5P64X0_GPIO_NEXT(__gpio) \
+	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 1)
+
+enum s5p6440_gpio_number {
+	S5P6440_GPIO_A_START	= 0,
+	S5P6440_GPIO_B_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_A),
+	S5P6440_GPIO_C_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_B),
+	S5P6440_GPIO_F_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_C),
+	S5P6440_GPIO_G_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_F),
+	S5P6440_GPIO_H_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_G),
+	S5P6440_GPIO_I_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_H),
+	S5P6440_GPIO_J_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_I),
+	S5P6440_GPIO_N_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_J),
+	S5P6440_GPIO_P_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_N),
+	S5P6440_GPIO_R_START	= S5P64X0_GPIO_NEXT(S5P6440_GPIO_P),
+};
+
+enum s5p6450_gpio_number {
+	S5P6450_GPIO_A_START	= 0,
+	S5P6450_GPIO_B_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_A),
+	S5P6450_GPIO_C_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_B),
+	S5P6450_GPIO_D_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_C),
+	S5P6450_GPIO_F_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_D),
+	S5P6450_GPIO_G_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_F),
+	S5P6450_GPIO_H_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_G),
+	S5P6450_GPIO_I_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_H),
+	S5P6450_GPIO_J_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_I),
+	S5P6450_GPIO_K_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_J),
+	S5P6450_GPIO_N_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_K),
+	S5P6450_GPIO_P_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_N),
+	S5P6450_GPIO_Q_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_P),
+	S5P6450_GPIO_R_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_Q),
+	S5P6450_GPIO_S_START	= S5P64X0_GPIO_NEXT(S5P6450_GPIO_R),
+};
+
+/* GPIO number definitions */
+
+#define S5P6440_GPA(_nr)	(S5P6440_GPIO_A_START + (_nr))
+#define S5P6440_GPB(_nr)	(S5P6440_GPIO_B_START + (_nr))
+#define S5P6440_GPC(_nr)	(S5P6440_GPIO_C_START + (_nr))
+#define S5P6440_GPF(_nr)	(S5P6440_GPIO_F_START + (_nr))
+#define S5P6440_GPG(_nr)	(S5P6440_GPIO_G_START + (_nr))
+#define S5P6440_GPH(_nr)	(S5P6440_GPIO_H_START + (_nr))
+#define S5P6440_GPI(_nr)	(S5P6440_GPIO_I_START + (_nr))
+#define S5P6440_GPJ(_nr)	(S5P6440_GPIO_J_START + (_nr))
+#define S5P6440_GPN(_nr)	(S5P6440_GPIO_N_START + (_nr))
+#define S5P6440_GPP(_nr)	(S5P6440_GPIO_P_START + (_nr))
+#define S5P6440_GPR(_nr)	(S5P6440_GPIO_R_START + (_nr))
+
+#define S5P6450_GPA(_nr)	(S5P6450_GPIO_A_START + (_nr))
+#define S5P6450_GPB(_nr)	(S5P6450_GPIO_B_START + (_nr))
+#define S5P6450_GPC(_nr)	(S5P6450_GPIO_C_START + (_nr))
+#define S5P6450_GPD(_nr)	(S5P6450_GPIO_D_START + (_nr))
+#define S5P6450_GPF(_nr)	(S5P6450_GPIO_F_START + (_nr))
+#define S5P6450_GPG(_nr)	(S5P6450_GPIO_G_START + (_nr))
+#define S5P6450_GPH(_nr)	(S5P6450_GPIO_H_START + (_nr))
+#define S5P6450_GPI(_nr)	(S5P6450_GPIO_I_START + (_nr))
+#define S5P6450_GPJ(_nr)	(S5P6450_GPIO_J_START + (_nr))
+#define S5P6450_GPK(_nr)	(S5P6450_GPIO_K_START + (_nr))
+#define S5P6450_GPN(_nr)	(S5P6450_GPIO_N_START + (_nr))
+#define S5P6450_GPP(_nr)	(S5P6450_GPIO_P_START + (_nr))
+#define S5P6450_GPQ(_nr)	(S5P6450_GPIO_Q_START + (_nr))
+#define S5P6450_GPR(_nr)	(S5P6450_GPIO_R_START + (_nr))
+#define S5P6450_GPS(_nr)	(S5P6450_GPIO_S_START + (_nr))
+
+/* the end of the S5P64X0 specific gpios */
+
+#define S5P6440_GPIO_END	(S5P6440_GPR(S5P6440_GPIO_R_NR) + 1)
+#define S5P6450_GPIO_END	(S5P6450_GPS(S5P6450_GPIO_S_NR) + 1)
+
+#define S5P64X0_GPIO_END	(S5P6440_GPIO_END > S5P6450_GPIO_END ?	\
+				 S5P6440_GPIO_END : S5P6450_GPIO_END)
+
+#define S3C_GPIO_END		S5P64X0_GPIO_END
+
+/* define the number of gpios we need to the one after the last GPIO range */
+
+#define ARCH_NR_GPIOS		(S5P64X0_GPIO_END + CONFIG_SAMSUNG_GPIO_EXTRA)
+
+#include <asm-generic/gpio.h>
+
+#endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-s5p6440/include/mach/regs-gpio.h b/arch/arm/mach-s5p64x0/include/mach/regs-gpio.h
similarity index 79%
rename from arch/arm/mach-s5p6440/include/mach/regs-gpio.h
rename to arch/arm/mach-s5p64x0/include/mach/regs-gpio.h
index 82ff753..85f448e 100644
--- a/arch/arm/mach-s5p6440/include/mach/regs-gpio.h
+++ b/arch/arm/mach-s5p64x0/include/mach/regs-gpio.h
@@ -1,21 +1,24 @@
-/* linux/arch/arm/mach-s5p6440/include/mach/regs-gpio.h
+/* linux/arch/arm/mach-s5p64x0/include/mach/regs-gpio.h
  *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
- * S5P6440 - GPIO register definitions
+ * S5P64X0 - GPIO register definitions
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
- */
+*/
 
 #ifndef __ASM_ARCH_REGS_GPIO_H
 #define __ASM_ARCH_REGS_GPIO_H __FILE__
 
 #include <mach/map.h>
 
+/* Will be implemented S5P6442 GPIOlib */
+
 /* Base addresses for each of the banks */
+
 #define S5P6440_GPA_BASE		(S5P_VA_GPIO + 0x0000)
 #define S5P6440_GPB_BASE		(S5P_VA_GPIO + 0x0020)
 #define S5P6440_GPC_BASE		(S5P_VA_GPIO + 0x0040)
@@ -27,6 +30,7 @@
 #define S5P6440_GPN_BASE		(S5P_VA_GPIO + 0x0830)
 #define S5P6440_GPP_BASE		(S5P_VA_GPIO + 0x0160)
 #define S5P6440_GPR_BASE		(S5P_VA_GPIO + 0x0290)
+
 #define S5P6440_EINT0CON0		(S5P_VA_GPIO + 0x900)
 #define S5P6440_EINT0FLTCON0		(S5P_VA_GPIO + 0x910)
 #define S5P6440_EINT0FLTCON1		(S5P_VA_GPIO + 0x914)
@@ -34,19 +38,23 @@
 #define S5P6440_EINT0PEND		(S5P_VA_GPIO + 0x924)
 
 /* for LCD */
+
 #define S5P6440_SPCON_LCD_SEL_RGB	(1 << 0)
 #define S5P6440_SPCON_LCD_SEL_MASK	(3 << 0)
 
-/* These set of macros are not really useful for the
- * GPF/GPI/GPJ/GPN/GPP,
- * useful for others set of GPIO's (4 bit)
+/*
+ * These set of macros are not really useful for the
+ * GPF/GPI/GPJ/GPN/GPP, useful for others set of GPIO's (4 bit)
  */
+
 #define S5P6440_GPIO_CONMASK(__gpio)	(0xf << ((__gpio) * 4))
 #define S5P6440_GPIO_INPUT(__gpio)	(0x0 << ((__gpio) * 4))
 #define S5P6440_GPIO_OUTPUT(__gpio)	(0x1 << ((__gpio) * 4))
 
-/* Use these macros for GPF/GPI/GPJ/GPN/GPP set of GPIO (2 bit)
- * */
+/*
+ * Use these macros for GPF/GPI/GPJ/GPN/GPP set of GPIO (2 bit)
+ */
+
 #define S5P6440_GPIO2_CONMASK(__gpio)	(0x3 << ((__gpio) * 2))
 #define S5P6440_GPIO2_INPUT(__gpio)	(0x0 << ((__gpio) * 2))
 #define S5P6440_GPIO2_OUTPUT(__gpio)	(0x1 << ((__gpio) * 2))
-- 
1.6.2.5
