From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 20 Feb 2018 19:17:51 +0100
Subject: [PATCH] pinctrl: samsung: Validate alias coming from DT
Message-ID: <20180220181751.20826-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver uses alias from Device Tree as an index of pin controller data
array.  In case of a wrong DTB or an out-of-tree DTB, the alias could be
outside of this data array leading to out-of-bounds access.

Depending on binary and memory layout, this could be handled properly
(showing error like "samsung-pinctrl 3860000.pinctrl: driver data not
available") or could lead to exceptions.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: <stable@vger.kernel.org>
Fixes: 30574f0db1b1 ("pinctrl: add samsung pinctrl and gpiolib driver")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Issue is present since first version of this driver so this should be
backported as far as possible.

Tested on Odroid HC1 (Exynos5422). Tests on S3C24xx, S3C64xx, Exynos
ARM64 and any other chips are highly appreciated.

Linus,
I can take it through samsung/pinctrl tree and later send you again as
pull request... or you can apply it directly as I do not have any other
pinctrl patches queued so far.
---
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c   | 56 +++++++++++++++++++----
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c | 14 +++++-
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c      | 28 ++++++++++--
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c      |  7 ++-
 drivers/pinctrl/samsung/pinctrl-samsung.c      | 61 ++++++++++++++++----------
 drivers/pinctrl/samsung/pinctrl-samsung.h      | 40 ++++++++++-------
 6 files changed, 154 insertions(+), 52 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
index c32399faff57..90c274490181 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
@@ -124,7 +124,7 @@ static const struct samsung_pin_bank_data s5pv210_pin_bank[] __initconst = {
 	EXYNOS_PIN_BANK_EINTW(8, 0xc60, "gph3", 0x0c),
 };
 
-const struct samsung_pin_ctrl s5pv210_pin_ctrl[] __initconst = {
+static const struct samsung_pin_ctrl s5pv210_pin_ctrl[] __initconst = {
 	{
 		/* pin-controller instance 0 data */
 		.pin_banks	= s5pv210_pin_bank,
@@ -137,6 +137,11 @@ const struct samsung_pin_ctrl s5pv210_pin_ctrl[] __initconst = {
 	},
 };
 
+const struct samsung_pinctrl_of_match_data s5pv210_of_data __initconst = {
+	.ctrl		= s5pv210_pin_ctrl,
+	.num_ctrl	= ARRAY_SIZE(s5pv210_pin_ctrl),
+};
+
 /* Pad retention control code for accessing PMU regmap */
 static atomic_t exynos_shared_retention_refcnt;
 
@@ -199,7 +204,7 @@ static const struct samsung_retention_data exynos3250_retention_data __initconst
  * Samsung pinctrl driver data for Exynos3250 SoC. Exynos3250 SoC includes
  * two gpio/pin-mux/pinconfig controllers.
  */
-const struct samsung_pin_ctrl exynos3250_pin_ctrl[] __initconst = {
+static const struct samsung_pin_ctrl exynos3250_pin_ctrl[] __initconst = {
 	{
 		/* pin-controller instance 0 data */
 		.pin_banks	= exynos3250_pin_banks0,
@@ -220,6 +225,11 @@ const struct samsung_pin_ctrl exynos3250_pin_ctrl[] __initconst = {
 	},
 };
 
+const struct samsung_pinctrl_of_match_data exynos3250_of_data __initconst = {
+	.ctrl		= exynos3250_pin_ctrl,
+	.num_ctrl	= ARRAY_SIZE(exynos3250_pin_ctrl),
+};
+
 /* pin banks of exynos4210 pin-controller 0 */
 static const struct samsung_pin_bank_data exynos4210_pin_banks0[] __initconst = {
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
@@ -303,7 +313,7 @@ static const struct samsung_retention_data exynos4_audio_retention_data __initco
  * Samsung pinctrl driver data for Exynos4210 SoC. Exynos4210 SoC includes
  * three gpio/pin-mux/pinconfig controllers.
  */
-const struct samsung_pin_ctrl exynos4210_pin_ctrl[] __initconst = {
+static const struct samsung_pin_ctrl exynos4210_pin_ctrl[] __initconst = {
 	{
 		/* pin-controller instance 0 data */
 		.pin_banks	= exynos4210_pin_banks0,
@@ -329,6 +339,11 @@ const struct samsung_pin_ctrl exynos4210_pin_ctrl[] __initconst = {
 	},
 };
 
+const struct samsung_pinctrl_of_match_data exynos4210_of_data __initconst = {
+	.ctrl		= exynos4210_pin_ctrl,
+	.num_ctrl	= ARRAY_SIZE(exynos4210_pin_ctrl),
+};
+
 /* pin banks of exynos4x12 pin-controller 0 */
 static const struct samsung_pin_bank_data exynos4x12_pin_banks0[] __initconst = {
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
@@ -391,7 +406,7 @@ static const struct samsung_pin_bank_data exynos4x12_pin_banks3[] __initconst =
  * Samsung pinctrl driver data for Exynos4x12 SoC. Exynos4x12 SoC includes
  * four gpio/pin-mux/pinconfig controllers.
  */
-const struct samsung_pin_ctrl exynos4x12_pin_ctrl[] __initconst = {
+static const struct samsung_pin_ctrl exynos4x12_pin_ctrl[] __initconst = {
 	{
 		/* pin-controller instance 0 data */
 		.pin_banks	= exynos4x12_pin_banks0,
@@ -427,6 +442,11 @@ const struct samsung_pin_ctrl exynos4x12_pin_ctrl[] __initconst = {
 	},
 };
 
+const struct samsung_pinctrl_of_match_data exynos4x12_of_data __initconst = {
+	.ctrl		= exynos4x12_pin_ctrl,
+	.num_ctrl	= ARRAY_SIZE(exynos4x12_pin_ctrl),
+};
+
 /* pin banks of exynos5250 pin-controller 0 */
 static const struct samsung_pin_bank_data exynos5250_pin_banks0[] __initconst = {
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
@@ -487,7 +507,7 @@ static const struct samsung_pin_bank_data exynos5250_pin_banks3[] __initconst =
  * Samsung pinctrl driver data for Exynos5250 SoC. Exynos5250 SoC includes
  * four gpio/pin-mux/pinconfig controllers.
  */
-const struct samsung_pin_ctrl exynos5250_pin_ctrl[] __initconst = {
+static const struct samsung_pin_ctrl exynos5250_pin_ctrl[] __initconst = {
 	{
 		/* pin-controller instance 0 data */
 		.pin_banks	= exynos5250_pin_banks0,
@@ -523,6 +543,11 @@ const struct samsung_pin_ctrl exynos5250_pin_ctrl[] __initconst = {
 	},
 };
 
+const struct samsung_pinctrl_of_match_data exynos5250_of_data __initconst = {
+	.ctrl		= exynos5250_pin_ctrl,
+	.num_ctrl	= ARRAY_SIZE(exynos5250_pin_ctrl),
+};
+
 /* pin banks of exynos5260 pin-controller 0 */
 static const struct samsung_pin_bank_data exynos5260_pin_banks0[] __initconst = {
 	EXYNOS_PIN_BANK_EINTG(4, 0x000, "gpa0", 0x00),
@@ -567,7 +592,7 @@ static const struct samsung_pin_bank_data exynos5260_pin_banks2[] __initconst =
  * Samsung pinctrl driver data for Exynos5260 SoC. Exynos5260 SoC includes
  * three gpio/pin-mux/pinconfig controllers.
  */
-const struct samsung_pin_ctrl exynos5260_pin_ctrl[] __initconst = {
+static const struct samsung_pin_ctrl exynos5260_pin_ctrl[] __initconst = {
 	{
 		/* pin-controller instance 0 data */
 		.pin_banks	= exynos5260_pin_banks0,
@@ -587,6 +612,11 @@ const struct samsung_pin_ctrl exynos5260_pin_ctrl[] __initconst = {
 	},
 };
 
+const struct samsung_pinctrl_of_match_data exynos5260_of_data __initconst = {
+	.ctrl		= exynos5260_pin_ctrl,
+	.num_ctrl	= ARRAY_SIZE(exynos5260_pin_ctrl),
+};
+
 /* pin banks of exynos5410 pin-controller 0 */
 static const struct samsung_pin_bank_data exynos5410_pin_banks0[] __initconst = {
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
@@ -657,7 +687,7 @@ static const struct samsung_pin_bank_data exynos5410_pin_banks3[] __initconst =
  * Samsung pinctrl driver data for Exynos5410 SoC. Exynos5410 SoC includes
  * four gpio/pin-mux/pinconfig controllers.
  */
-const struct samsung_pin_ctrl exynos5410_pin_ctrl[] __initconst = {
+static const struct samsung_pin_ctrl exynos5410_pin_ctrl[] __initconst = {
 	{
 		/* pin-controller instance 0 data */
 		.pin_banks	= exynos5410_pin_banks0,
@@ -690,6 +720,11 @@ const struct samsung_pin_ctrl exynos5410_pin_ctrl[] __initconst = {
 	},
 };
 
+const struct samsung_pinctrl_of_match_data exynos5410_of_data __initconst = {
+	.ctrl		= exynos5410_pin_ctrl,
+	.num_ctrl	= ARRAY_SIZE(exynos5410_pin_ctrl),
+};
+
 /* pin banks of exynos5420 pin-controller 0 */
 static const struct samsung_pin_bank_data exynos5420_pin_banks0[] __initconst = {
 	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpy7", 0x00),
@@ -774,7 +809,7 @@ static const struct samsung_retention_data exynos5420_retention_data __initconst
  * Samsung pinctrl driver data for Exynos5420 SoC. Exynos5420 SoC includes
  * four gpio/pin-mux/pinconfig controllers.
  */
-const struct samsung_pin_ctrl exynos5420_pin_ctrl[] __initconst = {
+static const struct samsung_pin_ctrl exynos5420_pin_ctrl[] __initconst = {
 	{
 		/* pin-controller instance 0 data */
 		.pin_banks	= exynos5420_pin_banks0,
@@ -808,3 +843,8 @@ const struct samsung_pin_ctrl exynos5420_pin_ctrl[] __initconst = {
 		.retention_data	= &exynos4_audio_retention_data,
 	},
 };
+
+const struct samsung_pinctrl_of_match_data exynos5420_of_data __initconst = {
+	.ctrl		= exynos5420_pin_ctrl,
+	.num_ctrl	= ARRAY_SIZE(exynos5420_pin_ctrl),
+};
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
index fc8f7833bec0..71c9d1d9f345 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
@@ -175,7 +175,7 @@ static const struct samsung_retention_data exynos5433_fsys_retention_data __init
  * Samsung pinctrl driver data for Exynos5433 SoC. Exynos5433 SoC includes
  * ten gpio/pin-mux/pinconfig controllers.
  */
-const struct samsung_pin_ctrl exynos5433_pin_ctrl[] __initconst = {
+static const struct samsung_pin_ctrl exynos5433_pin_ctrl[] __initconst = {
 	{
 		/* pin-controller instance 0 data */
 		.pin_banks	= exynos5433_pin_banks0,
@@ -260,6 +260,11 @@ const struct samsung_pin_ctrl exynos5433_pin_ctrl[] __initconst = {
 	},
 };
 
+const struct samsung_pinctrl_of_match_data exynos5433_of_data __initconst = {
+	.ctrl		= exynos5433_pin_ctrl,
+	.num_ctrl	= ARRAY_SIZE(exynos5433_pin_ctrl),
+};
+
 /* pin banks of exynos7 pin-controller - ALIVE */
 static const struct samsung_pin_bank_data exynos7_pin_banks0[] __initconst = {
 	EXYNOS_PIN_BANK_EINTW(8, 0x000, "gpa0", 0x00),
@@ -339,7 +344,7 @@ static const struct samsung_pin_bank_data exynos7_pin_banks9[] __initconst = {
 	EXYNOS_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
 };
 
-const struct samsung_pin_ctrl exynos7_pin_ctrl[] __initconst = {
+static const struct samsung_pin_ctrl exynos7_pin_ctrl[] __initconst = {
 	{
 		/* pin-controller instance 0 Alive data */
 		.pin_banks	= exynos7_pin_banks0,
@@ -392,3 +397,8 @@ const struct samsung_pin_ctrl exynos7_pin_ctrl[] __initconst = {
 		.eint_gpio_init = exynos_eint_gpio_init,
 	},
 };
+
+const struct samsung_pinctrl_of_match_data exynos7_of_data __initconst = {
+	.ctrl		= exynos7_pin_ctrl,
+	.num_ctrl	= ARRAY_SIZE(exynos7_pin_ctrl),
+};
diff --git a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
index 10187cb0e9b9..7e824e4d20f4 100644
--- a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
@@ -565,7 +565,7 @@ static const struct samsung_pin_bank_data s3c2412_pin_banks[] __initconst = {
 	PIN_BANK_2BIT(13, 0x080, "gpj"),
 };
 
-const struct samsung_pin_ctrl s3c2412_pin_ctrl[] __initconst = {
+static const struct samsung_pin_ctrl s3c2412_pin_ctrl[] __initconst = {
 	{
 		.pin_banks	= s3c2412_pin_banks,
 		.nr_banks	= ARRAY_SIZE(s3c2412_pin_banks),
@@ -573,6 +573,11 @@ const struct samsung_pin_ctrl s3c2412_pin_ctrl[] __initconst = {
 	},
 };
 
+const struct samsung_pinctrl_of_match_data s3c2412_of_data __initconst = {
+	.ctrl		= s3c2412_pin_ctrl,
+	.num_ctrl	= ARRAY_SIZE(s3c2412_pin_ctrl),
+};
+
 static const struct samsung_pin_bank_data s3c2416_pin_banks[] __initconst = {
 	PIN_BANK_A(27, 0x000, "gpa"),
 	PIN_BANK_2BIT(11, 0x010, "gpb"),
@@ -587,7 +592,7 @@ static const struct samsung_pin_bank_data s3c2416_pin_banks[] __initconst = {
 	PIN_BANK_2BIT(2, 0x100, "gpm"),
 };
 
-const struct samsung_pin_ctrl s3c2416_pin_ctrl[] __initconst = {
+static const struct samsung_pin_ctrl s3c2416_pin_ctrl[] __initconst = {
 	{
 		.pin_banks	= s3c2416_pin_banks,
 		.nr_banks	= ARRAY_SIZE(s3c2416_pin_banks),
@@ -595,6 +600,11 @@ const struct samsung_pin_ctrl s3c2416_pin_ctrl[] __initconst = {
 	},
 };
 
+const struct samsung_pinctrl_of_match_data s3c2416_of_data __initconst = {
+	.ctrl		= s3c2416_pin_ctrl,
+	.num_ctrl	= ARRAY_SIZE(s3c2416_pin_ctrl),
+};
+
 static const struct samsung_pin_bank_data s3c2440_pin_banks[] __initconst = {
 	PIN_BANK_A(25, 0x000, "gpa"),
 	PIN_BANK_2BIT(11, 0x010, "gpb"),
@@ -607,7 +617,7 @@ static const struct samsung_pin_bank_data s3c2440_pin_banks[] __initconst = {
 	PIN_BANK_2BIT(13, 0x0d0, "gpj"),
 };
 
-const struct samsung_pin_ctrl s3c2440_pin_ctrl[] __initconst = {
+static const struct samsung_pin_ctrl s3c2440_pin_ctrl[] __initconst = {
 	{
 		.pin_banks	= s3c2440_pin_banks,
 		.nr_banks	= ARRAY_SIZE(s3c2440_pin_banks),
@@ -615,6 +625,11 @@ const struct samsung_pin_ctrl s3c2440_pin_ctrl[] __initconst = {
 	},
 };
 
+const struct samsung_pinctrl_of_match_data s3c2440_of_data __initconst = {
+	.ctrl		= s3c2440_pin_ctrl,
+	.num_ctrl	= ARRAY_SIZE(s3c2440_pin_ctrl),
+};
+
 static const struct samsung_pin_bank_data s3c2450_pin_banks[] __initconst = {
 	PIN_BANK_A(28, 0x000, "gpa"),
 	PIN_BANK_2BIT(11, 0x010, "gpb"),
@@ -630,10 +645,15 @@ static const struct samsung_pin_bank_data s3c2450_pin_banks[] __initconst = {
 	PIN_BANK_2BIT(2, 0x100, "gpm"),
 };
 
-const struct samsung_pin_ctrl s3c2450_pin_ctrl[] __initconst = {
+static const struct samsung_pin_ctrl s3c2450_pin_ctrl[] __initconst = {
 	{
 		.pin_banks	= s3c2450_pin_banks,
 		.nr_banks	= ARRAY_SIZE(s3c2450_pin_banks),
 		.eint_wkup_init = s3c24xx_eint_init,
 	},
 };
+
+const struct samsung_pinctrl_of_match_data s3c2450_of_data __initconst = {
+	.ctrl		= s3c2450_pin_ctrl,
+	.num_ctrl	= ARRAY_SIZE(s3c2450_pin_ctrl),
+};
diff --git a/drivers/pinctrl/samsung/pinctrl-s3c64xx.c b/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
index 679628ac4b31..288e6567ceb1 100644
--- a/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
@@ -789,7 +789,7 @@ static const struct samsung_pin_bank_data s3c64xx_pin_banks0[] __initconst = {
  * Samsung pinctrl driver data for S3C64xx SoC. S3C64xx SoC includes
  * one gpio/pin-mux/pinconfig controller.
  */
-const struct samsung_pin_ctrl s3c64xx_pin_ctrl[] __initconst = {
+static const struct samsung_pin_ctrl s3c64xx_pin_ctrl[] __initconst = {
 	{
 		/* pin-controller instance 1 data */
 		.pin_banks	= s3c64xx_pin_banks0,
@@ -798,3 +798,8 @@ const struct samsung_pin_ctrl s3c64xx_pin_ctrl[] __initconst = {
 		.eint_wkup_init = s3c64xx_eint_eint0_init,
 	},
 };
+
+const struct samsung_pinctrl_of_match_data s3c64xx_of_data __initconst = {
+	.ctrl		= s3c64xx_pin_ctrl,
+	.num_ctrl	= ARRAY_SIZE(s3c64xx_pin_ctrl),
+};
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index da58e4554137..336e88d7bdb9 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -942,12 +942,33 @@ static int samsung_gpiolib_register(struct platform_device *pdev,
 	return 0;
 }
 
+static const struct samsung_pin_ctrl *
+samsung_pinctrl_get_soc_data_for_of_alias(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	const struct samsung_pinctrl_of_match_data *of_data;
+	int id;
+
+	id = of_alias_get_id(node, "pinctrl");
+	if (id < 0) {
+		dev_err(&pdev->dev, "failed to get alias id\n");
+		return NULL;
+	}
+
+	of_data = of_device_get_match_data(&pdev->dev);
+	if (id >= of_data->num_ctrl) {
+		dev_err(&pdev->dev, "invalid alias id %d\n", id);
+		return NULL;
+	}
+
+	return &(of_data->ctrl[id]);
+}
+
 /* retrieve the soc specific data */
 static const struct samsung_pin_ctrl *
 samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
 			     struct platform_device *pdev)
 {
-	int id;
 	struct device_node *node = pdev->dev.of_node;
 	struct device_node *np;
 	const struct samsung_pin_bank_data *bdata;
@@ -957,13 +978,9 @@ samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
 	void __iomem *virt_base[SAMSUNG_PINCTRL_NUM_RESOURCES];
 	unsigned int i;
 
-	id = of_alias_get_id(node, "pinctrl");
-	if (id < 0) {
-		dev_err(&pdev->dev, "failed to get alias id\n");
+	ctrl = samsung_pinctrl_get_soc_data_for_of_alias(pdev);
+	if (!ctrl)
 		return ERR_PTR(-ENOENT);
-	}
-	ctrl = of_device_get_match_data(&pdev->dev);
-	ctrl += id;
 
 	d->suspend = ctrl->suspend;
 	d->resume = ctrl->resume;
@@ -1188,41 +1205,41 @@ static int __maybe_unused samsung_pinctrl_resume(struct device *dev)
 static const struct of_device_id samsung_pinctrl_dt_match[] = {
 #ifdef CONFIG_PINCTRL_EXYNOS_ARM
 	{ .compatible = "samsung,exynos3250-pinctrl",
-		.data = exynos3250_pin_ctrl },
+		.data = &exynos3250_of_data },
 	{ .compatible = "samsung,exynos4210-pinctrl",
-		.data = exynos4210_pin_ctrl },
+		.data = &exynos4210_of_data },
 	{ .compatible = "samsung,exynos4x12-pinctrl",
-		.data = exynos4x12_pin_ctrl },
+		.data = &exynos4x12_of_data },
 	{ .compatible = "samsung,exynos5250-pinctrl",
-		.data = exynos5250_pin_ctrl },
+		.data = &exynos5250_of_data },
 	{ .compatible = "samsung,exynos5260-pinctrl",
-		.data = exynos5260_pin_ctrl },
+		.data = &exynos5260_of_data },
 	{ .compatible = "samsung,exynos5410-pinctrl",
-		.data = exynos5410_pin_ctrl },
+		.data = &exynos5410_of_data },
 	{ .compatible = "samsung,exynos5420-pinctrl",
-		.data = exynos5420_pin_ctrl },
+		.data = &exynos5420_of_data },
 	{ .compatible = "samsung,s5pv210-pinctrl",
-		.data = s5pv210_pin_ctrl },
+		.data = &s5pv210_of_data },
 #endif
 #ifdef CONFIG_PINCTRL_EXYNOS_ARM64
 	{ .compatible = "samsung,exynos5433-pinctrl",
-		.data = exynos5433_pin_ctrl },
+		.data = &exynos5433_of_data },
 	{ .compatible = "samsung,exynos7-pinctrl",
-		.data = exynos7_pin_ctrl },
+		.data = &exynos7_of_data },
 #endif
 #ifdef CONFIG_PINCTRL_S3C64XX
 	{ .compatible = "samsung,s3c64xx-pinctrl",
-		.data = s3c64xx_pin_ctrl },
+		.data = &s3c64xx_of_data },
 #endif
 #ifdef CONFIG_PINCTRL_S3C24XX
 	{ .compatible = "samsung,s3c2412-pinctrl",
-		.data = s3c2412_pin_ctrl },
+		.data = &s3c2412_of_data },
 	{ .compatible = "samsung,s3c2416-pinctrl",
-		.data = s3c2416_pin_ctrl },
+		.data = &s3c2416_of_data },
 	{ .compatible = "samsung,s3c2440-pinctrl",
-		.data = s3c2440_pin_ctrl },
+		.data = &s3c2440_of_data },
 	{ .compatible = "samsung,s3c2450-pinctrl",
-		.data = s3c2450_pin_ctrl },
+		.data = &s3c2450_of_data },
 #endif
 	{},
 };
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index e204f609823b..f0cda9424dfe 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -281,6 +281,16 @@ struct samsung_pinctrl_drv_data {
 	void (*resume)(struct samsung_pinctrl_drv_data *);
 };
 
+/**
+ * struct samsung_pinctrl_of_match_data: OF match device specific configuration data.
+ * @ctrl: array of pin controller data.
+ * @num_ctrl: size of array @ctrl.
+ */
+struct samsung_pinctrl_of_match_data {
+	const struct samsung_pin_ctrl	*ctrl;
+	unsigned int			num_ctrl;
+};
+
 /**
  * struct samsung_pin_group: represent group of pins of a pinmux function.
  * @name: name of the pin group, used to lookup the group.
@@ -309,20 +319,20 @@ struct samsung_pmx_func {
 };
 
 /* list of all exported SoC specific data */
-extern const struct samsung_pin_ctrl exynos3250_pin_ctrl[];
-extern const struct samsung_pin_ctrl exynos4210_pin_ctrl[];
-extern const struct samsung_pin_ctrl exynos4x12_pin_ctrl[];
-extern const struct samsung_pin_ctrl exynos5250_pin_ctrl[];
-extern const struct samsung_pin_ctrl exynos5260_pin_ctrl[];
-extern const struct samsung_pin_ctrl exynos5410_pin_ctrl[];
-extern const struct samsung_pin_ctrl exynos5420_pin_ctrl[];
-extern const struct samsung_pin_ctrl exynos5433_pin_ctrl[];
-extern const struct samsung_pin_ctrl exynos7_pin_ctrl[];
-extern const struct samsung_pin_ctrl s3c64xx_pin_ctrl[];
-extern const struct samsung_pin_ctrl s3c2412_pin_ctrl[];
-extern const struct samsung_pin_ctrl s3c2416_pin_ctrl[];
-extern const struct samsung_pin_ctrl s3c2440_pin_ctrl[];
-extern const struct samsung_pin_ctrl s3c2450_pin_ctrl[];
-extern const struct samsung_pin_ctrl s5pv210_pin_ctrl[];
+extern const struct samsung_pinctrl_of_match_data exynos3250_of_data;
+extern const struct samsung_pinctrl_of_match_data exynos4210_of_data;
+extern const struct samsung_pinctrl_of_match_data exynos4x12_of_data;
+extern const struct samsung_pinctrl_of_match_data exynos5250_of_data;
+extern const struct samsung_pinctrl_of_match_data exynos5260_of_data;
+extern const struct samsung_pinctrl_of_match_data exynos5410_of_data;
+extern const struct samsung_pinctrl_of_match_data exynos5420_of_data;
+extern const struct samsung_pinctrl_of_match_data exynos5433_of_data;
+extern const struct samsung_pinctrl_of_match_data exynos7_of_data;
+extern const struct samsung_pinctrl_of_match_data s3c64xx_of_data;
+extern const struct samsung_pinctrl_of_match_data s3c2412_of_data;
+extern const struct samsung_pinctrl_of_match_data s3c2416_of_data;
+extern const struct samsung_pinctrl_of_match_data s3c2440_of_data;
+extern const struct samsung_pinctrl_of_match_data s3c2450_of_data;
+extern const struct samsung_pinctrl_of_match_data s5pv210_of_data;
 
 #endif /* __PINCTRL_SAMSUNG_H */
-- 
2.14.1
