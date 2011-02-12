From: dilinger@queued.net (Andres Salomon)
Date: Fri, 11 Feb 2011 18:19:21 -0800
Subject: [PATCH 16/17] mc13xxx: mfd_cell is now implicitly available to drivers
Message-ID: <20110211181921.3d561568@queued.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The cell's platform_data is now accessed with a helper function;
change clients to use that, and remove the now-unused data_size.

Note that mfd-core no longer makes a copy of platform_data, but the
mc13xxx-core driver creates the pdata structures on the stack.  In
order to get around that, the various ARM mach types that set the
pdata have been changed to hold the variable in static (global) memory.
Also note that __initdata references in aforementioned pdata structs
have been dropped.

Signed-off-by: Andres Salomon <dilinger@queued.net>
---
 arch/arm/mach-imx/mach-mx27_3ds.c     |    6 +++++-
 arch/arm/mach-imx/mach-pcm038.c       |    6 +++++-
 arch/arm/mach-mx3/mach-mx31_3ds.c     |    6 +++++-
 arch/arm/mach-mx3/mach-mx31moboard.c  |    6 +++++-
 drivers/leds/leds-mc13783.c           |    6 +++---
 drivers/mfd/mc13xxx-core.c            |   18 +++++-------------
 drivers/regulator/mc13783-regulator.c |    6 ++----
 drivers/regulator/mc13892-regulator.c |    6 ++----
 include/linux/mfd/mc13xxx.h           |    3 +--
 9 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 1643315..f223371 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -227,9 +227,13 @@ static struct mc13783_regulator_init_data mx27_3ds_regulators[] = {
 };
 
 /* MC13783 */
-static struct mc13783_platform_data mc13783_pdata __initdata = {
+static struct mc13783_regulator_platform_data mx27_3ds_regs = {
 	.regulators = mx27_3ds_regulators,
 	.num_regulators = ARRAY_SIZE(mx27_3ds_regulators),
+};
+
+static struct mc13783_platform_data mc13783_pdata = {
+	.regulators = &mx27_3ds_regs,
 	.flags  = MC13783_USE_REGULATOR,
 };
 
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index 5056148..4b37494 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -262,9 +262,13 @@ static struct mc13783_regulator_init_data pcm038_regulators[] = {
 	},
 };
 
-static struct mc13783_platform_data pcm038_pmic = {
+static struct mc13783_regulator_platform_data pcm038_pmic_regs = {
 	.regulators = pcm038_regulators,
 	.num_regulators = ARRAY_SIZE(pcm038_regulators),
+};
+
+static struct mc13783_platform_data pcm038_pmic = {
+	.regulators = &pcm038_pmic_regs,
 	.flags = MC13783_USE_ADC | MC13783_USE_REGULATOR |
 		 MC13783_USE_TOUCHSCREEN,
 };
diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 0d65db8..8005788 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -156,9 +156,13 @@ static struct mc13783_regulator_init_data mx31_3ds_regulators[] = {
 };
 
 /* MC13783 */
-static struct mc13783_platform_data mc13783_pdata __initdata = {
+static struct mc13783_regulator_platform_data mx31_3ds_regs = {
 	.regulators = mx31_3ds_regulators,
 	.num_regulators = ARRAY_SIZE(mx31_3ds_regulators),
+};
+
+static struct mc13783_platform_data mc13783_pdata = {
+	.regulators = &mx31_3ds_regs,
 	.flags  = MC13783_USE_REGULATOR | MC13783_USE_TOUCHSCREEN,
 };
 
diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index 1aa8d65..e824d2e 100644
--- a/arch/arm/mach-mx3/mach-mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -267,9 +267,13 @@ static struct mc13783_leds_platform_data moboard_leds = {
 	.tc2_period = MC13783_LED_PERIOD_10MS,
 };
 
-static struct mc13783_platform_data moboard_pmic = {
+static struct mc13783_regulator_platform_data moboard_pmic_regs = {
 	.regulators = moboard_regulators,
 	.num_regulators = ARRAY_SIZE(moboard_regulators),
+};
+
+static struct mc13783_platform_data moboard_pmic = {
+	.regulators = &moboard_pmic_regs,
 	.leds = &moboard_leds,
 	.flags = MC13783_USE_REGULATOR | MC13783_USE_RTC |
 		MC13783_USE_ADC | MC13783_USE_LED,
diff --git a/drivers/leds/leds-mc13783.c b/drivers/leds/leds-mc13783.c
index f05bb08..0d87477 100644
--- a/drivers/leds/leds-mc13783.c
+++ b/drivers/leds/leds-mc13783.c
@@ -183,7 +183,7 @@ static int __devinit mc13783_led_setup(struct mc13783_led *led, int max_current)
 
 static int __devinit mc13783_leds_prepare(struct platform_device *pdev)
 {
-	struct mc13783_leds_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct mc13783_leds_platform_data *pdata = mfd_get_data(pdev);
 	struct mc13783 *dev = dev_get_drvdata(pdev->dev.parent);
 	int ret = 0;
 	int reg = 0;
@@ -264,7 +264,7 @@ out:
 
 static int __devinit mc13783_led_probe(struct platform_device *pdev)
 {
-	struct mc13783_leds_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct mc13783_leds_platform_data *pdata = mfd_get_data(pdev);
 	struct mc13783_led_platform_data *led_cur;
 	struct mc13783_led *led, *led_dat;
 	int ret, i;
@@ -351,7 +351,7 @@ err_free:
 
 static int __devexit mc13783_led_remove(struct platform_device *pdev)
 {
-	struct mc13783_leds_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct mc13783_leds_platform_data *pdata = mfd_get_data(pdev);
 	struct mc13783_led *led = platform_get_drvdata(pdev);
 	struct mc13783 *dev = dev_get_drvdata(pdev->dev.parent);
 	int i;
diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index b9fcaf0..00c5490 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -683,14 +683,13 @@ out:
 EXPORT_SYMBOL_GPL(mc13783_adc_do_conversion);
 
 static int mc13xxx_add_subdevice_pdata(struct mc13xxx *mc13xxx,
-		const char *format, void *pdata, size_t pdata_size)
+		const char *format, void *pdata)
 {
 	char buf[30];
 	const char *name = mc13xxx_get_chipname(mc13xxx);
 
 	struct mfd_cell cell = {
 		.platform_data = pdata,
-		.data_size = pdata_size,
 	};
 
 	/* there is no asnprintf in the kernel :-( */
@@ -706,7 +705,7 @@ static int mc13xxx_add_subdevice_pdata(struct mc13xxx *mc13xxx,
 
 static int mc13xxx_add_subdevice(struct mc13xxx *mc13xxx, const char *format)
 {
-	return mc13xxx_add_subdevice_pdata(mc13xxx, format, NULL, 0);
+	return mc13xxx_add_subdevice_pdata(mc13xxx, format, NULL);
 }
 
 static int mc13xxx_probe(struct spi_device *spi)
@@ -764,13 +763,8 @@ err_revision:
 		mc13xxx_add_subdevice(mc13xxx, "%s-codec");
 
 	if (pdata->flags & MC13XXX_USE_REGULATOR) {
-		struct mc13xxx_regulator_platform_data regulator_pdata = {
-			.num_regulators = pdata->num_regulators,
-			.regulators = pdata->regulators,
-		};
-
 		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-regulator",
-				&regulator_pdata, sizeof(regulator_pdata));
+				pdata->regulators);
 	}
 
 	if (pdata->flags & MC13XXX_USE_RTC)
@@ -779,10 +773,8 @@ err_revision:
 	if (pdata->flags & MC13XXX_USE_TOUCHSCREEN)
 		mc13xxx_add_subdevice(mc13xxx, "%s-ts");
 
-	if (pdata->flags & MC13XXX_USE_LED) {
-		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-led",
-					pdata->leds, sizeof(*pdata->leds));
-	}
+	if (pdata->flags & MC13XXX_USE_LED)
+		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-led", pdata->leds);
 
 	return 0;
 }
diff --git a/drivers/regulator/mc13783-regulator.c b/drivers/regulator/mc13783-regulator.c
index 3e5d0c3..1b7cc16 100644
--- a/drivers/regulator/mc13783-regulator.c
+++ b/drivers/regulator/mc13783-regulator.c
@@ -336,8 +336,7 @@ static int __devinit mc13783_regulator_probe(struct platform_device *pdev)
 {
 	struct mc13xxx_regulator_priv *priv;
 	struct mc13xxx *mc13783 = dev_get_drvdata(pdev->dev.parent);
-	struct mc13783_regulator_platform_data *pdata =
-		dev_get_platdata(&pdev->dev);
+	struct mc13783_regulator_platform_data *pdata = mfd_get_data(pdev);
 	struct mc13783_regulator_init_data *init_data;
 	int i, ret;
 
@@ -381,8 +380,7 @@ err:
 static int __devexit mc13783_regulator_remove(struct platform_device *pdev)
 {
 	struct mc13xxx_regulator_priv *priv = platform_get_drvdata(pdev);
-	struct mc13783_regulator_platform_data *pdata =
-		dev_get_platdata(&pdev->dev);
+	struct mc13783_regulator_platform_data *pdata = mfd_get_data(pdev);
 	int i;
 
 	platform_set_drvdata(pdev, NULL);
diff --git a/drivers/regulator/mc13892-regulator.c b/drivers/regulator/mc13892-regulator.c
index 1b8f739..e23578a 100644
--- a/drivers/regulator/mc13892-regulator.c
+++ b/drivers/regulator/mc13892-regulator.c
@@ -520,8 +520,7 @@ static int __devinit mc13892_regulator_probe(struct platform_device *pdev)
 {
 	struct mc13xxx_regulator_priv *priv;
 	struct mc13xxx *mc13892 = dev_get_drvdata(pdev->dev.parent);
-	struct mc13xxx_regulator_platform_data *pdata =
-		dev_get_platdata(&pdev->dev);
+	struct mc13xxx_regulator_platform_data *pdata = mfd_get_data(pdev);
 	struct mc13xxx_regulator_init_data *init_data;
 	int i, ret;
 	u32 val;
@@ -595,8 +594,7 @@ err_free:
 static int __devexit mc13892_regulator_remove(struct platform_device *pdev)
 {
 	struct mc13xxx_regulator_priv *priv = platform_get_drvdata(pdev);
-	struct mc13xxx_regulator_platform_data *pdata =
-		dev_get_platdata(&pdev->dev);
+	struct mc13xxx_regulator_platform_data *pdata = mfd_get_data(pdev);
 	int i;
 
 	platform_set_drvdata(pdev, NULL);
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index a1d391b..052b133 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -146,8 +146,7 @@ struct mc13xxx_platform_data {
 #define MC13XXX_USE_LED		(1 << 5)
 	unsigned int flags;
 
-	int num_regulators;
-	struct mc13xxx_regulator_init_data *regulators;
+	struct mc13xxx_regulator_platform_data *regulators;
 	struct mc13xxx_leds_platform_data *leds;
 };
 
-- 
1.7.2.3
