From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  1 Aug 2018 12:00:20 +0200
Subject: [PATCH 2/5] pinctrl: meson: Add support to set direction with a
 secure monitor call
In-Reply-To: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
References: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1533117623-27856-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic Meson GX and AXG SoCs needs to do a Secure Monitor call to
set the TEST_N pin direction.
This patch adds a "smc" boolean to the bank structure to differentiate
the TEST_N bank and call the Secure Monitor in the _input/_output functions.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/Kconfig         |  1 +
 drivers/pinctrl/meson/pinctrl-meson.c | 31 ++++++++++++++++++++++++++-----
 drivers/pinctrl/meson/pinctrl-meson.h | 10 +++++++++-
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/meson/Kconfig b/drivers/pinctrl/meson/Kconfig
index c80951d..1b90470 100644
--- a/drivers/pinctrl/meson/Kconfig
+++ b/drivers/pinctrl/meson/Kconfig
@@ -8,6 +8,7 @@ menuconfig PINCTRL_MESON
 	select GPIOLIB
 	select OF_GPIO
 	select REGMAP_MMIO
+	select MESON_SM
 
 if PINCTRL_MESON
 
diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 29a458d..8e445aa 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -54,6 +54,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/seq_file.h>
+#include <linux/firmware/meson/meson_sm.h>
 
 #include "../core.h"
 #include "../pinctrl-utils.h"
@@ -99,8 +100,14 @@ static void meson_calc_reg_and_bit(struct meson_bank *bank, unsigned int pin,
 {
 	struct meson_reg_desc *desc = &bank->regs[reg_type];
 
-	*reg = desc->reg * 4;
-	*bit = desc->bit + pin - bank->first;
+	/* TEST_N pin direction needs to be set using a Secure Monitor call */
+	if (reg_type == REG_DIR && bank->smc) {
+		*reg = desc->reg;
+		*bit = desc->bit;
+	} else {
+		*reg = desc->reg * 4;
+		*bit = desc->bit + pin - bank->first;
+	}
 }
 
 static int meson_get_groups_count(struct pinctrl_dev *pcdev)
@@ -342,6 +349,12 @@ static int meson_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 
 	meson_calc_reg_and_bit(bank, gpio, REG_DIR, &reg, &bit);
 
+	/* TEST_N pin direction needs to be set using a Secure Monitor call */
+	if (bank->smc) {
+		u32 smc_ret = 0;
+		return meson_sm_call(reg, &smc_ret, 0, 0, 0, 0, 0);
+	}
+
 	return regmap_update_bits(pc->reg_gpio, reg, BIT(bit), BIT(bit));
 }
 
@@ -358,9 +371,17 @@ static int meson_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
 		return ret;
 
 	meson_calc_reg_and_bit(bank, gpio, REG_DIR, &reg, &bit);
-	ret = regmap_update_bits(pc->reg_gpio, reg, BIT(bit), 0);
-	if (ret)
-		return ret;
+	/* TEST_N pin direction needs to be set using a Secure Monitor call */
+	if (bank->smc) {
+		u32 smc_ret = 0;
+		ret = meson_sm_call(reg, &smc_ret, bit, 0, 0, 0, 0);
+		if (ret)
+			return ret;
+	} else {
+		ret = regmap_update_bits(pc->reg_gpio, reg, BIT(bit), 0);
+		if (ret)
+			return ret;
+	}
 
 	meson_calc_reg_and_bit(bank, gpio, REG_OUT, &reg, &bit);
 	return regmap_update_bits(pc->reg_gpio, reg, BIT(bit),
diff --git a/drivers/pinctrl/meson/pinctrl-meson.h b/drivers/pinctrl/meson/pinctrl-meson.h
index 12a39110..d32e9a9 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.h
+++ b/drivers/pinctrl/meson/pinctrl-meson.h
@@ -92,6 +92,7 @@ struct meson_bank {
 	const char *name;
 	unsigned int first;
 	unsigned int last;
+	bool smc; /* Direction needs to use a Secure Monitor call */
 	int irq_first;
 	int irq_last;
 	struct meson_reg_desc regs[NUM_REG];
@@ -131,11 +132,12 @@ struct meson_pinctrl {
 		.num_groups = ARRAY_SIZE(fn ## _groups),		\
 	}
 
-#define BANK(n, f, l, fi, li, per, peb, pr, pb, dr, db, or, ob, ir, ib)	\
+#define __BANK(n, f, l, sm, fi, li, per, peb, pr, pb, dr, db, or, ob, ir, ib) \
 	{								\
 		.name		= n,					\
 		.first		= f,					\
 		.last		= l,					\
+		.smc		= sm,					\
 		.irq_first	= fi,					\
 		.irq_last	= li,					\
 		.regs = {						\
@@ -147,6 +149,12 @@ struct meson_pinctrl {
 		},							\
 	 }
 
+#define BANK(n, f, l, fi, li, per, peb, pr, pb, dr, db, or, ob, ir, ib) \
+	__BANK(n, f, l, false, fi, li, per, peb, pr, pb, dr, db, or, ob, ir, ib)
+
+#define BANK_SMC(n, f, l, fi, li, per, peb, pr, pb, dr, db, or, ob, ir, ib) \
+	__BANK(n, f, l, true, fi, li, per, peb, pr, pb, dr, db, or, ob, ir, ib)
+
 #define MESON_PIN(x) PINCTRL_PIN(x, #x)
 
 /* Common pmx functions */
-- 
2.7.4
