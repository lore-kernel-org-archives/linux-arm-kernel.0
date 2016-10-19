From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 19 Oct 2016 12:08:23 +0200
Subject: [PATCH 3/9] pinctrl: meson: update pinctrl data with gpio irq data
In-Reply-To: <1476871709-8359-1-git-send-email-jbrunet@baylibre.com>
References: <1476871709-8359-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1476871709-8359-4-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends meson's pinctrl SoC specific data by adding the gpio
irq base number and the compatible controller for each SoC. This will
allow gpios to request an interrupt on the gpio interrupt controller
using this base irq number the pin offset inbank

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 24 +++++++++++----------
 drivers/pinctrl/meson/pinctrl-meson.h      | 16 +++++++++-----
 drivers/pinctrl/meson/pinctrl-meson8.c     | 22 ++++++++++---------
 drivers/pinctrl/meson/pinctrl-meson8b.c    | 34 +++++++++++++++++++++---------
 4 files changed, 60 insertions(+), 36 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index c3928aa3fefa..ed8a1222de3b 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -715,24 +715,25 @@ static struct meson_pmx_func meson_gxbb_aobus_functions[] = {
 };
 
 static struct meson_bank meson_gxbb_periphs_banks[] = {
-	/*   name    first                      last                    pullen  pull    dir     out     in  */
-	BANK("X",    PIN(GPIOX_0, EE_OFF),	PIN(GPIOX_22, EE_OFF),  4,  0,  4,  0,  12, 0,  13, 0,  14, 0),
-	BANK("Y",    PIN(GPIOY_0, EE_OFF),	PIN(GPIOY_16, EE_OFF),  1,  0,  1,  0,  3,  0,  4,  0,  5,  0),
-	BANK("DV",   PIN(GPIODV_0, EE_OFF),	PIN(GPIODV_29, EE_OFF), 0,  0,  0,  0,  0,  0,  1,  0,  2,  0),
-	BANK("H",    PIN(GPIOH_0, EE_OFF),	PIN(GPIOH_3, EE_OFF),   1, 20,  1, 20,  3, 20,  4, 20,  5, 20),
-	BANK("Z",    PIN(GPIOZ_0, EE_OFF),	PIN(GPIOZ_15, EE_OFF),  3,  0,  3,  0,  9,  0,  10, 0, 11,  0),
-	BANK("CARD", PIN(CARD_0, EE_OFF),	PIN(CARD_6, EE_OFF),    2, 20,  2, 20,  6, 20,  7, 20,  8, 20),
-	BANK("BOOT", PIN(BOOT_0, EE_OFF),	PIN(BOOT_17, EE_OFF),   2,  0,  2,  0,  6,  0,  7,  0,  8,  0),
-	BANK("CLK",  PIN(GPIOCLK_0, EE_OFF),	PIN(GPIOCLK_3, EE_OFF), 3, 28,  3, 28,  9, 28, 10, 28, 11, 28),
+	/*   name    first                      last                    irq       pullen  pull    dir     out     in  */
+	BANK("X",    PIN(GPIOX_0, EE_OFF),	PIN(GPIOX_22, EE_OFF),  106, 128, 4,  0,  4,  0,  12, 0,  13, 0,  14, 0),
+	BANK("Y",    PIN(GPIOY_0, EE_OFF),	PIN(GPIOY_16, EE_OFF),   89, 105, 1,  0,  1,  0,  3,  0,  4,  0,  5,  0),
+	BANK("DV",   PIN(GPIODV_0, EE_OFF),	PIN(GPIODV_29, EE_OFF),  59,  88, 0,  0,  0,  0,  0,  0,  1,  0,  2,  0),
+	BANK("H",    PIN(GPIOH_0, EE_OFF),	PIN(GPIOH_3, EE_OFF),    30,  33, 1, 20,  1, 20,  3, 20,  4, 20,  5, 20),
+	BANK("Z",    PIN(GPIOZ_0, EE_OFF),	PIN(GPIOZ_15, EE_OFF),   14,  29, 3,  0,  3,  0,  9,  0,  10, 0, 11,  0),
+	BANK("CARD", PIN(CARD_0, EE_OFF),	PIN(CARD_6, EE_OFF),     52,  58, 2, 20,  2, 20,  6, 20,  7, 20,  8, 20),
+	BANK("BOOT", PIN(BOOT_0, EE_OFF),	PIN(BOOT_17, EE_OFF),    34,  51, 2,  0,  2,  0,  6,  0,  7,  0,  8,  0),
+	BANK("CLK",  PIN(GPIOCLK_0, EE_OFF),	PIN(GPIOCLK_3, EE_OFF), 129, 132, 3, 28,  3, 28,  9, 28, 10, 28, 11, 28),
 };
 
 static struct meson_bank meson_gxbb_aobus_banks[] = {
-	/*   name    first              last               pullen  pull    dir     out     in  */
-	BANK("AO",   PIN(GPIOAO_0, 0),  PIN(GPIOAO_13, 0), 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
+	/*   name    first              last               irq    pullen  pull    dir     out     in  */
+	BANK("AO",   PIN(GPIOAO_0, 0),  PIN(GPIOAO_13, 0), 0, 13, 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
 };
 
 struct meson_pinctrl_data meson_gxbb_periphs_pinctrl_data = {
 	.name		= "periphs-banks",
+	.irq_compat	= "amlogic,meson-gxbb-gpio-intc",
 	.pin_base	= 14,
 	.pins		= meson_gxbb_periphs_pins,
 	.groups		= meson_gxbb_periphs_groups,
@@ -746,6 +747,7 @@ struct meson_pinctrl_data meson_gxbb_periphs_pinctrl_data = {
 
 struct meson_pinctrl_data meson_gxbb_aobus_pinctrl_data = {
 	.name		= "aobus-banks",
+	.irq_compat	= "amlogic,meson-gxbb-gpio-intc",
 	.pin_base	= 0,
 	.pins		= meson_gxbb_aobus_pins,
 	.groups		= meson_gxbb_aobus_groups,
diff --git a/drivers/pinctrl/meson/pinctrl-meson.h b/drivers/pinctrl/meson/pinctrl-meson.h
index 98b5080650c1..b90d69e366df 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.h
+++ b/drivers/pinctrl/meson/pinctrl-meson.h
@@ -81,6 +81,7 @@ enum meson_reg_type {
  * @name:	bank name
  * @first:	first pin of the bank
  * @last:	last pin of the bank
+ * @irq:	hwirq base number of the bank
  * @regs:	array of register descriptors
  *
  * A bank represents a set of pins controlled by a contiguous set of
@@ -92,11 +93,14 @@ struct meson_bank {
 	const char *name;
 	unsigned int first;
 	unsigned int last;
+	int irq_first;
+	int irq_last;
 	struct meson_reg_desc regs[NUM_REG];
 };
 
 struct meson_pinctrl_data {
 	const char *name;
+	const char *irq_compat;
 	const struct pinctrl_pin_desc *pins;
 	struct meson_pmx_group *groups;
 	struct meson_pmx_func *funcs;
@@ -147,12 +151,14 @@ struct meson_pinctrl {
 		.num_groups = ARRAY_SIZE(fn ## _groups),		\
 	}
 
-#define BANK(n, f, l, per, peb, pr, pb, dr, db, or, ob, ir, ib)		\
+#define BANK(n, f, l, fi, li, per, peb, pr, pb, dr, db, or, ob, ir, ib)	\
 	{								\
-		.name	= n,						\
-		.first	= f,						\
-		.last	= l,						\
-		.regs	= {						\
+		.name		= n,					\
+		.first		= f,					\
+		.last		= l,					\
+		.irq_first	= fi,					\
+		.irq_last	= li,					\
+		.regs = {						\
 			[REG_PULLEN]	= { per, peb },			\
 			[REG_PULL]	= { pr, pb },			\
 			[REG_DIR]	= { dr, db },			\
diff --git a/drivers/pinctrl/meson/pinctrl-meson8.c b/drivers/pinctrl/meson/pinctrl-meson8.c
index 07f1cb21c1b8..eddab1091408 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8.c
@@ -916,23 +916,24 @@ static struct meson_pmx_func meson8_aobus_functions[] = {
 };
 
 static struct meson_bank meson8_cbus_banks[] = {
-	/*   name    first             last                 pullen  pull    dir     out     in  */
-	BANK("X",    PIN(GPIOX_0, 0),  PIN(GPIOX_21, 0),    4,  0,  4,  0,  0,  0,  1,  0,  2,  0),
-	BANK("Y",    PIN(GPIOY_0, 0),  PIN(GPIOY_16, 0),    3,  0,  3,  0,  3,  0,  4,  0,  5,  0),
-	BANK("DV",   PIN(GPIODV_0, 0), PIN(GPIODV_29, 0),   0,  0,  0,  0,  7,  0,  8,  0,  9,  0),
-	BANK("H",    PIN(GPIOH_0, 0),  PIN(GPIOH_9, 0),     1, 16,  1, 16,  9, 19, 10, 19, 11, 19),
-	BANK("Z",    PIN(GPIOZ_0, 0),  PIN(GPIOZ_14, 0),    1,  0,  1,  0,  3, 17,  4, 17,  5, 17),
-	BANK("CARD", PIN(CARD_0, 0),   PIN(CARD_6, 0),      2, 20,  2, 20,  0, 22,  1, 22,  2, 22),
-	BANK("BOOT", PIN(BOOT_0, 0),   PIN(BOOT_18, 0),     2,  0,  2,  0,  9,  0, 10,  0, 11,  0),
+	/*   name    first             last                 irq       pullen  pull    dir     out     in  */
+	BANK("X",    PIN(GPIOX_0, 0),  PIN(GPIOX_21, 0),    112, 133, 4,  0,  4,  0,  0,  0,  1,  0,  2,  0),
+	BANK("Y",    PIN(GPIOY_0, 0),  PIN(GPIOY_16, 0),    95,  111, 3,  0,  3,  0,  3,  0,  4,  0,  5,  0),
+	BANK("DV",   PIN(GPIODV_0, 0), PIN(GPIODV_29, 0),   65,   94, 0,  0,  0,  0,  7,  0,  8,  0,  9,  0),
+	BANK("H",    PIN(GPIOH_0, 0),  PIN(GPIOH_9, 0),     29,   38, 1, 16,  1, 16,  9, 19, 10, 19, 11, 19),
+	BANK("Z",    PIN(GPIOZ_0, 0),  PIN(GPIOZ_14, 0),    14,   28, 1,  0,  1,  0,  3, 17,  4, 17,  5, 17),
+	BANK("CARD", PIN(CARD_0, 0),   PIN(CARD_6, 0),      58,   64, 2, 20,  2, 20,  0, 22,  1, 22,  2, 22),
+	BANK("BOOT", PIN(BOOT_0, 0),   PIN(BOOT_18, 0),     39,   57, 2,  0,  2,  0,  9,  0, 10,  0, 11,  0),
 };
 
 static struct meson_bank meson8_aobus_banks[] = {
-	/*   name    first                  last                      pullen  pull    dir     out     in  */
-	BANK("AO",   PIN(GPIOAO_0, AO_OFF), PIN(GPIO_TEST_N, AO_OFF), 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
+	/*   name    first                  last                      irq    pullen  pull    dir     out     in  */
+	BANK("AO",   PIN(GPIOAO_0, AO_OFF), PIN(GPIO_TEST_N, AO_OFF), 0, 13, 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
 };
 
 struct meson_pinctrl_data meson8_cbus_pinctrl_data = {
 	.name		= "cbus-banks",
+	.irq_compat	= "amlogic,meson8-gpio-intc",
 	.pin_base	= 0,
 	.pins		= meson8_cbus_pins,
 	.groups		= meson8_cbus_groups,
@@ -946,6 +947,7 @@ struct meson_pinctrl_data meson8_cbus_pinctrl_data = {
 
 struct meson_pinctrl_data meson8_aobus_pinctrl_data = {
 	.name		= "ao-bank",
+	.irq_compat	= "amlogic,meson8-gpio-intc",
 	.pin_base	= 120,
 	.pins		= meson8_aobus_pins,
 	.groups		= meson8_aobus_groups,
diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
index 76f077f18193..d7505f492639 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -124,6 +124,12 @@ static const struct pinctrl_pin_desc meson8b_aobus_pins[] = {
 	MESON_PIN(GPIOAO_11, AO_OFF),
 	MESON_PIN(GPIOAO_12, AO_OFF),
 	MESON_PIN(GPIOAO_13, AO_OFF),
+
+	/*
+	 * The following 2 pins are not mentionned in the public datasheet
+	 * According to this datasheet, they can't be used with the gpio
+	 * interrupt controller
+	 */
 	MESON_PIN(GPIO_BSD_EN, AO_OFF),
 	MESON_PIN(GPIO_TEST_N, AO_OFF),
 };
@@ -881,23 +887,30 @@ static struct meson_pmx_func meson8b_aobus_functions[] = {
 };
 
 static struct meson_bank meson8b_cbus_banks[] = {
-	/*   name    first                      last                   pullen  pull    dir     out     in  */
-	BANK("X",    PIN(GPIOX_0, 0),		PIN(GPIOX_21, 0),      4,  0,  4,  0,  0,  0,  1,  0,  2,  0),
-	BANK("Y",    PIN(GPIOY_0, 0),		PIN(GPIOY_14, 0),      3,  0,  3,  0,  3,  0,  4,  0,  5,  0),
-	BANK("DV",   PIN(GPIODV_9, 0),		PIN(GPIODV_29, 0),     0,  0,  0,  0,  7,  0,  8,  0,  9,  0),
-	BANK("H",    PIN(GPIOH_0, 0),		PIN(GPIOH_9, 0),       1, 16,  1, 16,  9, 19, 10, 19, 11, 19),
-	BANK("CARD", PIN(CARD_0, 0),		PIN(CARD_6, 0),        2, 20,  2, 20,  0, 22,  1, 22,  2, 22),
-	BANK("BOOT", PIN(BOOT_0, 0),		PIN(BOOT_18, 0),       2,  0,  2,  0,  9,  0, 10,  0, 11,  0),
-	BANK("DIF",  PIN(DIF_0_P, 0),		PIN(DIF_4_N, 0),       5,  8,  5,  8, 12, 12, 13, 12, 14, 12),
+	/*   name    first                      last                irq      pullen  pull    dir     out     in  */
+	BANK("X",    PIN(GPIOX_0, 0),		PIN(GPIOX_21, 0),   97, 118, 4,  0,  4,  0,  0,  0,  1,  0,  2,  0),
+	BANK("Y",    PIN(GPIOY_0, 0),		PIN(GPIOY_14, 0),   80,  96, 3,  0,  3,  0,  3,  0,  4,  0,  5,  0),
+	BANK("DV",   PIN(GPIODV_9, 0),		PIN(GPIODV_29, 0),  59,  79, 0,  0,  0,  0,  7,  0,  8,  0,  9,  0),
+	BANK("H",    PIN(GPIOH_0, 0),		PIN(GPIOH_9, 0),    14,  23, 1, 16,  1, 16,  9, 19, 10, 19, 11, 19),
+	BANK("CARD", PIN(CARD_0, 0),		PIN(CARD_6, 0),     43,  49, 2, 20,  2, 20,  0, 22,  1, 22,  2, 22),
+	BANK("BOOT", PIN(BOOT_0, 0),		PIN(BOOT_18, 0),    24,  42, 2,  0,  2,  0,  9,  0, 10,  0, 11,  0),
+
+	/*
+	 * The following bank is not mentionned in the public datasheet
+	 * There is no information whether it can be used with the gpio
+	 * interrupt controller
+	 */
+	BANK("DIF",  PIN(DIF_0_P, 0),		PIN(DIF_4_N, 0),    -1,  -1, 5,  8,  5,  8, 12, 12, 13, 12, 14, 12),
 };
 
 static struct meson_bank meson8b_aobus_banks[] = {
-	/*   name    first                  last                      pullen  pull    dir     out     in  */
-	BANK("AO",   PIN(GPIOAO_0, AO_OFF), PIN(GPIO_TEST_N, AO_OFF), 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
+	/*   name    first                  last                      irq    pullen  pull    dir     out     in  */
+	BANK("AO",   PIN(GPIOAO_0, AO_OFF), PIN(GPIO_TEST_N, AO_OFF), 0, 13, 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
 };
 
 struct meson_pinctrl_data meson8b_cbus_pinctrl_data = {
 	.name		= "cbus-banks",
+	.irq_compat	= "amlogic,meson8b-gpio-intc",
 	.pin_base	= 0,
 	.pins		= meson8b_cbus_pins,
 	.groups		= meson8b_cbus_groups,
@@ -911,6 +924,7 @@ struct meson_pinctrl_data meson8b_cbus_pinctrl_data = {
 
 struct meson_pinctrl_data meson8b_aobus_pinctrl_data = {
 	.name		= "aobus-banks",
+	.irq_compat	= "amlogic,meson8b-gpio-intc",
 	.pin_base	= 130,
 	.pins		= meson8b_aobus_pins,
 	.groups		= meson8b_aobus_groups,
-- 
2.7.4
