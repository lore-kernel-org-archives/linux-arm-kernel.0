From: broonie@kernel.org (Mark Brown)
Date: Tue, 25 Apr 2017 16:46:13 +0100
Subject: Applied "regulator: arizona-micsupp: Move pdata into a separate
 structure" to the regulator tree
In-Reply-To: <1492512234-19210-4-git-send-email-rf@opensource.wolfsonmicro.com>
Message-ID: <E1d32fN-0001y7-SI@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: arizona-micsupp: Move pdata into a separate structure

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 22161f3eb65dc29434325736c4d780908fe3bf6a Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Tue, 18 Apr 2017 11:43:49 +0100
Subject: [PATCH] regulator: arizona-micsupp: Move pdata into a separate
 structure

In preparation for sharing this driver with Madera, move the pdata
for the micsupp regulator out of struct arizona_pdata into a dedicated
pdata struct for this driver. As a result the code in
arizona_micsupp_of_get_pdata() can be made independent of struct arizona.

This patch also updates the definition of struct arizona_pdata and
the use of this pdata in mach-crag6410-module.c

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS                               |  1 +
 drivers/regulator/arizona-micsupp.c       | 21 +++++++++++----------
 include/linux/mfd/arizona/pdata.h         |  3 ++-
 include/linux/regulator/arizona-micsupp.h | 21 +++++++++++++++++++++
 4 files changed, 35 insertions(+), 11 deletions(-)
 create mode 100644 include/linux/regulator/arizona-micsupp.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c35e0cea7831..6ed8ef18e7b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13623,6 +13623,7 @@ F:	include/linux/mfd/arizona/
 F:	include/linux/mfd/wm831x/
 F:	include/linux/mfd/wm8350/
 F:	include/linux/mfd/wm8400*
+F:	include/linux/regulator/arizona*
 F:	include/linux/wm97xx.h
 F:	include/sound/wm????.h
 F:	sound/soc/codecs/arizona.?
diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
index 5e38861e71d8..5f8b5a713311 100644
--- a/drivers/regulator/arizona-micsupp.c
+++ b/drivers/regulator/arizona-micsupp.c
@@ -30,6 +30,8 @@
 #include <linux/mfd/arizona/pdata.h>
 #include <linux/mfd/arizona/registers.h>
 
+#include <linux/regulator/arizona-micsupp.h>
+
 struct arizona_micsupp {
 	struct regulator_dev *regulator;
 	struct arizona *arizona;
@@ -199,28 +201,26 @@ static const struct regulator_init_data arizona_micsupp_ext_default = {
 	.num_consumer_supplies = 1,
 };
 
-static int arizona_micsupp_of_get_pdata(struct device *dev,
-					struct arizona *arizona,
+static int arizona_micsupp_of_get_pdata(struct arizona_micsupp_pdata *pdata,
 					struct regulator_config *config,
 					const struct regulator_desc *desc)
 {
-	struct arizona_pdata *pdata = &arizona->pdata;
 	struct arizona_micsupp *micsupp = config->driver_data;
 	struct device_node *np;
 	struct regulator_init_data *init_data;
 
-	np = of_get_child_by_name(arizona->dev->of_node, "micvdd");
+	np = of_get_child_by_name(config->dev->of_node, "micvdd");
 
 	if (np) {
 		config->of_node = np;
 
-		init_data = of_get_regulator_init_data(dev, np, desc);
+		init_data = of_get_regulator_init_data(config->dev, np, desc);
 
 		if (init_data) {
 			init_data->consumer_supplies = &micsupp->supply;
 			init_data->num_consumer_supplies = 1;
 
-			pdata->micvdd = init_data;
+			pdata->init_data = init_data;
 		}
 	}
 
@@ -232,6 +232,7 @@ static int arizona_micsupp_probe(struct platform_device *pdev)
 	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
 	const struct regulator_desc *desc;
 	struct regulator_config config = { };
+	struct arizona_micsupp_pdata *pdata = &arizona->pdata.micvdd;
 	struct arizona_micsupp *micsupp;
 	int ret;
 
@@ -269,15 +270,15 @@ static int arizona_micsupp_probe(struct platform_device *pdev)
 
 	if (IS_ENABLED(CONFIG_OF)) {
 		if (!dev_get_platdata(arizona->dev)) {
-			ret = arizona_micsupp_of_get_pdata(&pdev->dev, arizona,
-							   &config, desc);
+			ret = arizona_micsupp_of_get_pdata(pdata, &config,
+							   desc);
 			if (ret < 0)
 				return ret;
 		}
 	}
 
-	if (arizona->pdata.micvdd)
-		config.init_data = arizona->pdata.micvdd;
+	if (pdata->init_data)
+		config.init_data = pdata->init_data;
 	else
 		config.init_data = &micsupp->init_data;
 
diff --git a/include/linux/mfd/arizona/pdata.h b/include/linux/mfd/arizona/pdata.h
index 64faeeff698c..43e875f9850c 100644
--- a/include/linux/mfd/arizona/pdata.h
+++ b/include/linux/mfd/arizona/pdata.h
@@ -12,6 +12,7 @@
 #define _ARIZONA_PDATA_H
 
 #include <dt-bindings/mfd/arizona.h>
+#include <linux/regulator/arizona-micsupp.h>
 
 #define ARIZONA_GPN_DIR_MASK                     0x8000  /* GPN_DIR */
 #define ARIZONA_GPN_DIR_SHIFT                        15  /* GPN_DIR */
@@ -79,7 +80,7 @@ struct arizona_pdata {
 	int ldoena;     /** GPIO controlling LODENA, if any */
 
 	/** Regulator configuration for MICVDD */
-	struct regulator_init_data *micvdd;
+	struct arizona_micsupp_pdata micvdd;
 
 	/** Regulator configuration for LDO1 */
 	struct regulator_init_data *ldo1;
diff --git a/include/linux/regulator/arizona-micsupp.h b/include/linux/regulator/arizona-micsupp.h
new file mode 100644
index 000000000000..616842619c00
--- /dev/null
+++ b/include/linux/regulator/arizona-micsupp.h
@@ -0,0 +1,21 @@
+/*
+ * Platform data for Arizona micsupp regulator
+ *
+ * Copyright 2017 Cirrus Logic
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef ARIZONA_MICSUPP_H
+#define ARIZONA_MICSUPP_H
+
+struct regulator_init_data;
+
+struct arizona_micsupp_pdata {
+	/** Regulator configuration for micsupp */
+	const struct regulator_init_data *init_data;
+};
+
+#endif
-- 
2.11.0
