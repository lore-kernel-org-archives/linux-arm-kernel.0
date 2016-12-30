From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 30 Dec 2016 13:14:18 +0900
Subject: [PATCH v2 1/4] pinctrl: samsung: Fix the width of PINCFG_TYPE_DRV
 bitfields for Exynos5433
In-Reply-To: <20161230041421.24448-1-andi.shyti@samsung.com>
References: <20161230041421.24448-1-andi.shyti@samsung.com>
 <CGME20161230041426epcas1p1f827d3cee8b607d81e9921b412ddf301@epcas1p1.samsung.com>
Message-ID: <20161230041421.24448-2-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chanwoo Choi <cw00.choi@samsung.com>

This patch fixes the wrong width of PINCFG_TYPE_DRV bitfields for Exynos5433
because PINCFG_TYPE_DRV of Exynos5433 has 4bit fields in the *_DRV
registers. Usually, other Exynos have 2bit field for PINCFG_TYPE_DRV.

Fixes: 3c5ecc9ed353 ("pinctrl: exynos: Add support for Exynos5433")
Cc: stable at vger.kernel.org
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c | 91 ++++++++++++++++++--------------
 drivers/pinctrl/samsung/pinctrl-exynos.h | 31 +++++++++++
 2 files changed, 82 insertions(+), 40 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 12f7d1eb65bc..07409fde02b2 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -56,6 +56,17 @@ static const struct samsung_pin_bank_type bank_type_alive = {
 	.reg_offset = { 0x00, 0x04, 0x08, 0x0c, },
 };
 
+/* Exynos5433 has the 4bit widths for PINCFG_TYPE_DRV bitfields. */
+static const struct samsung_pin_bank_type exynos5433_bank_type_off = {
+	.fld_width = { 4, 1, 2, 4, 2, 2, },
+	.reg_offset = { 0x00, 0x04, 0x08, 0x0c, 0x10, 0x14, },
+};
+
+static const struct samsung_pin_bank_type exynos5433_bank_type_alive = {
+	.fld_width = { 4, 1, 2, 4, },
+	.reg_offset = { 0x00, 0x04, 0x08, 0x0c, },
+};
+
 static void exynos_irq_mask(struct irq_data *irqd)
 {
 	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
@@ -1335,82 +1346,82 @@ const struct samsung_pin_ctrl exynos5420_pin_ctrl[] __initconst = {
 
 /* pin banks of exynos5433 pin-controller - ALIVE */
 static const struct samsung_pin_bank_data exynos5433_pin_banks0[] = {
-	EXYNOS_PIN_BANK_EINTW(8, 0x000, "gpa0", 0x00),
-	EXYNOS_PIN_BANK_EINTW(8, 0x020, "gpa1", 0x04),
-	EXYNOS_PIN_BANK_EINTW(8, 0x040, "gpa2", 0x08),
-	EXYNOS_PIN_BANK_EINTW(8, 0x060, "gpa3", 0x0c),
-	EXYNOS_PIN_BANK_EINTW_EXT(8, 0x020, "gpf1", 0x1004, 1),
-	EXYNOS_PIN_BANK_EINTW_EXT(4, 0x040, "gpf2", 0x1008, 1),
-	EXYNOS_PIN_BANK_EINTW_EXT(4, 0x060, "gpf3", 0x100c, 1),
-	EXYNOS_PIN_BANK_EINTW_EXT(8, 0x080, "gpf4", 0x1010, 1),
-	EXYNOS_PIN_BANK_EINTW_EXT(8, 0x0a0, "gpf5", 0x1014, 1),
+	EXYNOS5433_PIN_BANK_EINTW(8, 0x000, "gpa0", 0x00),
+	EXYNOS5433_PIN_BANK_EINTW(8, 0x020, "gpa1", 0x04),
+	EXYNOS5433_PIN_BANK_EINTW(8, 0x040, "gpa2", 0x08),
+	EXYNOS5433_PIN_BANK_EINTW(8, 0x060, "gpa3", 0x0c),
+	EXYNOS5433_PIN_BANK_EINTW_EXT(8, 0x020, "gpf1", 0x1004, 1),
+	EXYNOS5433_PIN_BANK_EINTW_EXT(4, 0x040, "gpf2", 0x1008, 1),
+	EXYNOS5433_PIN_BANK_EINTW_EXT(4, 0x060, "gpf3", 0x100c, 1),
+	EXYNOS5433_PIN_BANK_EINTW_EXT(8, 0x080, "gpf4", 0x1010, 1),
+	EXYNOS5433_PIN_BANK_EINTW_EXT(8, 0x0a0, "gpf5", 0x1014, 1),
 };
 
 /* pin banks of exynos5433 pin-controller - AUD */
 static const struct samsung_pin_bank_data exynos5433_pin_banks1[] = {
-	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
-	EXYNOS_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
+	EXYNOS5433_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
+	EXYNOS5433_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
 };
 
 /* pin banks of exynos5433 pin-controller - CPIF */
 static const struct samsung_pin_bank_data exynos5433_pin_banks2[] = {
-	EXYNOS_PIN_BANK_EINTG(2, 0x000, "gpv6", 0x00),
+	EXYNOS5433_PIN_BANK_EINTG(2, 0x000, "gpv6", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - eSE */
 static const struct samsung_pin_bank_data exynos5433_pin_banks3[] = {
-	EXYNOS_PIN_BANK_EINTG(3, 0x000, "gpj2", 0x00),
+	EXYNOS5433_PIN_BANK_EINTG(3, 0x000, "gpj2", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - FINGER */
 static const struct samsung_pin_bank_data exynos5433_pin_banks4[] = {
-	EXYNOS_PIN_BANK_EINTG(4, 0x000, "gpd5", 0x00),
+	EXYNOS5433_PIN_BANK_EINTG(4, 0x000, "gpd5", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - FSYS */
 static const struct samsung_pin_bank_data exynos5433_pin_banks5[] = {
-	EXYNOS_PIN_BANK_EINTG(6, 0x000, "gph1", 0x00),
-	EXYNOS_PIN_BANK_EINTG(7, 0x020, "gpr4", 0x04),
-	EXYNOS_PIN_BANK_EINTG(5, 0x040, "gpr0", 0x08),
-	EXYNOS_PIN_BANK_EINTG(8, 0x060, "gpr1", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(2, 0x080, "gpr2", 0x10),
-	EXYNOS_PIN_BANK_EINTG(8, 0x0a0, "gpr3", 0x14),
+	EXYNOS5433_PIN_BANK_EINTG(6, 0x000, "gph1", 0x00),
+	EXYNOS5433_PIN_BANK_EINTG(7, 0x020, "gpr4", 0x04),
+	EXYNOS5433_PIN_BANK_EINTG(5, 0x040, "gpr0", 0x08),
+	EXYNOS5433_PIN_BANK_EINTG(8, 0x060, "gpr1", 0x0c),
+	EXYNOS5433_PIN_BANK_EINTG(2, 0x080, "gpr2", 0x10),
+	EXYNOS5433_PIN_BANK_EINTG(8, 0x0a0, "gpr3", 0x14),
 };
 
 /* pin banks of exynos5433 pin-controller - IMEM */
 static const struct samsung_pin_bank_data exynos5433_pin_banks6[] = {
-	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpf0", 0x00),
+	EXYNOS5433_PIN_BANK_EINTG(8, 0x000, "gpf0", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - NFC */
 static const struct samsung_pin_bank_data exynos5433_pin_banks7[] = {
-	EXYNOS_PIN_BANK_EINTG(3, 0x000, "gpj0", 0x00),
+	EXYNOS5433_PIN_BANK_EINTG(3, 0x000, "gpj0", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - PERIC */
 static const struct samsung_pin_bank_data exynos5433_pin_banks8[] = {
-	EXYNOS_PIN_BANK_EINTG(6, 0x000, "gpv7", 0x00),
-	EXYNOS_PIN_BANK_EINTG(5, 0x020, "gpb0", 0x04),
-	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpc0", 0x08),
-	EXYNOS_PIN_BANK_EINTG(2, 0x060, "gpc1", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(6, 0x080, "gpc2", 0x10),
-	EXYNOS_PIN_BANK_EINTG(8, 0x0a0, "gpc3", 0x14),
-	EXYNOS_PIN_BANK_EINTG(2, 0x0c0, "gpg0", 0x18),
-	EXYNOS_PIN_BANK_EINTG(4, 0x0e0, "gpd0", 0x1c),
-	EXYNOS_PIN_BANK_EINTG(6, 0x100, "gpd1", 0x20),
-	EXYNOS_PIN_BANK_EINTG(8, 0x120, "gpd2", 0x24),
-	EXYNOS_PIN_BANK_EINTG(5, 0x140, "gpd4", 0x28),
-	EXYNOS_PIN_BANK_EINTG(2, 0x160, "gpd8", 0x2c),
-	EXYNOS_PIN_BANK_EINTG(7, 0x180, "gpd6", 0x30),
-	EXYNOS_PIN_BANK_EINTG(3, 0x1a0, "gpd7", 0x34),
-	EXYNOS_PIN_BANK_EINTG(5, 0x1c0, "gpg1", 0x38),
-	EXYNOS_PIN_BANK_EINTG(2, 0x1e0, "gpg2", 0x3c),
-	EXYNOS_PIN_BANK_EINTG(8, 0x200, "gpg3", 0x40),
+	EXYNOS5433_PIN_BANK_EINTG(6, 0x000, "gpv7", 0x00),
+	EXYNOS5433_PIN_BANK_EINTG(5, 0x020, "gpb0", 0x04),
+	EXYNOS5433_PIN_BANK_EINTG(8, 0x040, "gpc0", 0x08),
+	EXYNOS5433_PIN_BANK_EINTG(2, 0x060, "gpc1", 0x0c),
+	EXYNOS5433_PIN_BANK_EINTG(6, 0x080, "gpc2", 0x10),
+	EXYNOS5433_PIN_BANK_EINTG(8, 0x0a0, "gpc3", 0x14),
+	EXYNOS5433_PIN_BANK_EINTG(2, 0x0c0, "gpg0", 0x18),
+	EXYNOS5433_PIN_BANK_EINTG(4, 0x0e0, "gpd0", 0x1c),
+	EXYNOS5433_PIN_BANK_EINTG(6, 0x100, "gpd1", 0x20),
+	EXYNOS5433_PIN_BANK_EINTG(8, 0x120, "gpd2", 0x24),
+	EXYNOS5433_PIN_BANK_EINTG(5, 0x140, "gpd4", 0x28),
+	EXYNOS5433_PIN_BANK_EINTG(2, 0x160, "gpd8", 0x2c),
+	EXYNOS5433_PIN_BANK_EINTG(7, 0x180, "gpd6", 0x30),
+	EXYNOS5433_PIN_BANK_EINTG(3, 0x1a0, "gpd7", 0x34),
+	EXYNOS5433_PIN_BANK_EINTG(5, 0x1c0, "gpg1", 0x38),
+	EXYNOS5433_PIN_BANK_EINTG(2, 0x1e0, "gpg2", 0x3c),
+	EXYNOS5433_PIN_BANK_EINTG(8, 0x200, "gpg3", 0x40),
 };
 
 /* pin banks of exynos5433 pin-controller - TOUCH */
 static const struct samsung_pin_bank_data exynos5433_pin_banks9[] = {
-	EXYNOS_PIN_BANK_EINTG(3, 0x000, "gpj1", 0x00),
+	EXYNOS5433_PIN_BANK_EINTG(3, 0x000, "gpj1", 0x00),
 };
 
 /*
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
index 5821525a2c84..a473092fb8d2 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.h
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
@@ -90,6 +90,37 @@
 		.pctl_res_idx   = pctl_idx,             \
 	}						\
 
+#define EXYNOS5433_PIN_BANK_EINTG(pins, reg, id, offs)		\
+	{							\
+		.type		= &exynos5433_bank_type_off,	\
+		.pctl_offset	= reg,				\
+		.nr_pins	= pins,				\
+		.eint_type	= EINT_TYPE_GPIO,		\
+		.eint_offset	= offs,				\
+		.name		= id				\
+	}
+
+#define EXYNOS5433_PIN_BANK_EINTW(pins, reg, id, offs)		\
+	{							\
+		.type		= &exynos5433_bank_type_alive,	\
+		.pctl_offset	= reg,				\
+		.nr_pins	= pins,				\
+		.eint_type	= EINT_TYPE_WKUP,		\
+		.eint_offset	= offs,				\
+		.name		= id				\
+	}
+
+#define EXYNOS5433_PIN_BANK_EINTW_EXT(pins, reg, id, offs, pctl_idx) \
+	{							\
+		.type           = &exynos5433_bank_type_alive,	\
+		.pctl_offset    = reg,				\
+		.nr_pins        = pins,				\
+		.eint_type      = EINT_TYPE_WKUP,		\
+		.eint_offset    = offs,				\
+		.name           = id,				\
+		.pctl_res_idx   = pctl_idx,			\
+	}							\
+
 /**
  * struct exynos_weint_data: irq specific data for all the wakeup interrupts
  * generated by the external wakeup interrupt controller.
-- 
2.11.0
