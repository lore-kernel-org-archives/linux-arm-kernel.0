From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 21 Jan 2015 15:43:11 +0900
Subject: [PATCH v3] pinctrl: exynos: Add support for Exynos5433
Message-ID: <1421822591-10536-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds driver data for Exynos5433 SoC. Exynos5433 includes 228 multi-
functional input/output port pins and 135 memory port pins. There are 41 general
port groups and 2 memory port groups.

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Inki Dae <inki.dae@samsung.com>
---
Changes from v2:
- Rebase it on v3.19-rc5

Changes from v1:
- Fix the wrong number of Exynos5433 (four -> ten)
- Divide pinctrl patch from following patch[1]
 [1] https://lkml.org/lkml/2014/12/2/134

 drivers/pinctrl/samsung/pinctrl-exynos.c  | 153 ++++++++++++++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-samsung.c |   2 +
 drivers/pinctrl/samsung/pinctrl-samsung.h |   1 +
 3 files changed, 156 insertions(+)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index becb379..4976441 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -1240,6 +1240,159 @@ const struct samsung_pin_ctrl exynos5420_pin_ctrl[] __initconst = {
 	},
 };
 
+/* pin banks of exynos5433 pin-controller - ALIVE */
+static const struct samsung_pin_bank_data exynos5433_pin_banks0[] = {
+	EXYNOS_PIN_BANK_EINTW(8, 0x000, "gpa0", 0x00),
+	EXYNOS_PIN_BANK_EINTW(8, 0x020, "gpa1", 0x04),
+	EXYNOS_PIN_BANK_EINTW(8, 0x040, "gpa2", 0x08),
+	EXYNOS_PIN_BANK_EINTW(8, 0x060, "gpa3", 0x0c),
+};
+
+/* pin banks of exynos5433 pin-controller - AUD */
+static const struct samsung_pin_bank_data exynos5433_pin_banks1[] = {
+	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
+};
+
+/* pin banks of exynos5433 pin-controller - CPIF */
+static const struct samsung_pin_bank_data exynos5433_pin_banks2[] = {
+	EXYNOS_PIN_BANK_EINTG(2, 0x000, "gpv6", 0x00),
+};
+
+/* pin banks of exynos5433 pin-controller - eSE */
+static const struct samsung_pin_bank_data exynos5433_pin_banks3[] = {
+	EXYNOS_PIN_BANK_EINTG(3, 0x000, "gpj2", 0x00),
+};
+
+/* pin banks of exynos5433 pin-controller - FINGER */
+static const struct samsung_pin_bank_data exynos5433_pin_banks4[] = {
+	EXYNOS_PIN_BANK_EINTG(4, 0x000, "gpd5", 0x00),
+};
+
+/* pin banks of exynos5433 pin-controller - FSYS */
+static const struct samsung_pin_bank_data exynos5433_pin_banks5[] = {
+	EXYNOS_PIN_BANK_EINTG(6, 0x000, "gph1", 0x00),
+	EXYNOS_PIN_BANK_EINTG(7, 0x020, "gpr4", 0x04),
+	EXYNOS_PIN_BANK_EINTG(5, 0x040, "gpr0", 0x08),
+	EXYNOS_PIN_BANK_EINTG(8, 0x060, "gpr1", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(2, 0x080, "gpr2", 0x10),
+	EXYNOS_PIN_BANK_EINTG(8, 0x0a0, "gpr3", 0x14),
+};
+
+/* pin banks of exynos5433 pin-controller - IMEM */
+static const struct samsung_pin_bank_data exynos5433_pin_banks6[] = {
+	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpf0", 0x00),
+};
+
+/* pin banks of exynos5433 pin-controller - NFC */
+static const struct samsung_pin_bank_data exynos5433_pin_banks7[] = {
+	EXYNOS_PIN_BANK_EINTG(3, 0x000, "gpj0", 0x00),
+};
+
+/* pin banks of exynos5433 pin-controller - PERIC */
+static const struct samsung_pin_bank_data exynos5433_pin_banks8[] = {
+	EXYNOS_PIN_BANK_EINTG(6, 0x000, "gpv7", 0x00),
+	EXYNOS_PIN_BANK_EINTG(5, 0x020, "gpb0", 0x04),
+	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpc0", 0x08),
+	EXYNOS_PIN_BANK_EINTG(2, 0x060, "gpc1", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(6, 0x080, "gpc2", 0x10),
+	EXYNOS_PIN_BANK_EINTG(8, 0x0a0, "gpc3", 0x14),
+	EXYNOS_PIN_BANK_EINTG(2, 0x0c0, "gpg0", 0x18),
+	EXYNOS_PIN_BANK_EINTG(4, 0x0e0, "gpd0", 0x1c),
+	EXYNOS_PIN_BANK_EINTG(6, 0x100, "gpd1", 0x20),
+	EXYNOS_PIN_BANK_EINTG(8, 0x120, "gpd2", 0x24),
+	EXYNOS_PIN_BANK_EINTG(5, 0x140, "gpd4", 0x28),
+	EXYNOS_PIN_BANK_EINTG(2, 0x160, "gpd8", 0x2c),
+	EXYNOS_PIN_BANK_EINTG(7, 0x180, "gpd6", 0x30),
+	EXYNOS_PIN_BANK_EINTG(3, 0x1a0, "gpd7", 0x34),
+	EXYNOS_PIN_BANK_EINTG(5, 0x1c0, "gpg1", 0x38),
+	EXYNOS_PIN_BANK_EINTG(2, 0x1e0, "gpg2", 0x3c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x200, "gpg3", 0x40),
+};
+
+/* pin banks of exynos5433 pin-controller - TOUCH */
+static const struct samsung_pin_bank_data exynos5433_pin_banks9[] = {
+	EXYNOS_PIN_BANK_EINTG(3, 0x000, "gpj1", 0x00),
+};
+
+/*
+ * Samsung pinctrl driver data for Exynos5433 SoC. Exynos5433 SoC includes
+ * ten gpio/pin-mux/pinconfig controllers.
+ */
+const struct samsung_pin_ctrl exynos5433_pin_ctrl[] = {
+	{
+		/* pin-controller instance 0 data */
+		.pin_banks	= exynos5433_pin_banks0,
+		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks0),
+		.eint_wkup_init = exynos_eint_wkup_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 1 data */
+		.pin_banks	= exynos5433_pin_banks1,
+		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks1),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 2 data */
+		.pin_banks	= exynos5433_pin_banks2,
+		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks2),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 3 data */
+		.pin_banks	= exynos5433_pin_banks3,
+		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks3),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 4 data */
+		.pin_banks	= exynos5433_pin_banks4,
+		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks4),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 5 data */
+		.pin_banks	= exynos5433_pin_banks5,
+		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks5),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 6 data */
+		.pin_banks	= exynos5433_pin_banks6,
+		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks6),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 7 data */
+		.pin_banks	= exynos5433_pin_banks7,
+		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks7),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 8 data */
+		.pin_banks	= exynos5433_pin_banks8,
+		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks8),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 9 data */
+		.pin_banks	= exynos5433_pin_banks9,
+		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks9),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	},
+};
+
 /* pin banks of exynos7 pin-controller - ALIVE */
 static const struct samsung_pin_bank_data exynos7_pin_banks0[] __initconst = {
 	EXYNOS_PIN_BANK_EINTW(8, 0x000, "gpa0", 0x00),
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index ec580af..ed165ba 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1239,6 +1239,8 @@ static const struct of_device_id samsung_pinctrl_dt_match[] = {
 		.data = (void *)exynos5260_pin_ctrl },
 	{ .compatible = "samsung,exynos5420-pinctrl",
 		.data = (void *)exynos5420_pin_ctrl },
+	{ .compatible = "samsung,exynos5433-pinctrl",
+		.data = (void *)exynos5433_pin_ctrl },
 	{ .compatible = "samsung,s5pv210-pinctrl",
 		.data = (void *)s5pv210_pin_ctrl },
 	{ .compatible = "samsung,exynos7-pinctrl",
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index 1b8c013..c1239ff 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -271,6 +271,7 @@ extern const struct samsung_pin_ctrl exynos4415_pin_ctrl[];
 extern const struct samsung_pin_ctrl exynos5250_pin_ctrl[];
 extern const struct samsung_pin_ctrl exynos5260_pin_ctrl[];
 extern const struct samsung_pin_ctrl exynos5420_pin_ctrl[];
+extern const struct samsung_pin_ctrl exynos5433_pin_ctrl[];
 extern const struct samsung_pin_ctrl exynos7_pin_ctrl[];
 extern const struct samsung_pin_ctrl s3c64xx_pin_ctrl[];
 extern const struct samsung_pin_ctrl s3c2412_pin_ctrl[];
-- 
1.8.5.5
