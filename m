From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 10 Sep 2014 11:50:39 +0800
Subject: [PATCH] regulator: remove unnecessary of_node_get() to parent
Message-ID: <1410321039-26888-1-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These of_node_get() were added to balance refcount decrements inside of
of_find_node_by_name().
See: commit c92f5dd2c42f ("regulator: Add missing of_node_put()")

However of_find_node_by_name() was then replaced by of_get_child_by_name(),
which doesn't call of_node_put() against its input parameter.

So, need to remove these unnecessary of_node_get() calls.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 drivers/regulator/88pm8607.c           | 2 +-
 drivers/regulator/da9052-regulator.c   | 4 ++--
 drivers/regulator/max8907-regulator.c  | 2 +-
 drivers/regulator/max8925-regulator.c  | 2 +-
 drivers/regulator/max8997.c            | 2 +-
 drivers/regulator/palmas-regulator.c   | 1 -
 drivers/regulator/tps65910-regulator.c | 2 +-
 7 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/88pm8607.c b/drivers/regulator/88pm8607.c
index 337634a..6d77dcd 100644
--- a/drivers/regulator/88pm8607.c
+++ b/drivers/regulator/88pm8607.c
@@ -319,7 +319,7 @@ static int pm8607_regulator_dt_init(struct platform_device *pdev,
 				    struct regulator_config *config)
 {
 	struct device_node *nproot, *np;
-	nproot = of_node_get(pdev->dev.parent->of_node);
+	nproot = pdev->dev.parent->of_node;
 	if (!nproot)
 		return -ENODEV;
 	nproot = of_get_child_by_name(nproot, "regulators");
diff --git a/drivers/regulator/da9052-regulator.c b/drivers/regulator/da9052-regulator.c
index fdb6ea8..0003362 100644
--- a/drivers/regulator/da9052-regulator.c
+++ b/drivers/regulator/da9052-regulator.c
@@ -422,9 +422,9 @@ static int da9052_regulator_probe(struct platform_device *pdev)
 		config.init_data = pdata->regulators[pdev->id];
 	} else {
 #ifdef CONFIG_OF
-		struct device_node *nproot, *np;
+		struct device_node *nproot = da9052->dev->of_node;
+		struct device_node *np;
 
-		nproot = of_node_get(da9052->dev->of_node);
 		if (!nproot)
 			return -ENODEV;
 
diff --git a/drivers/regulator/max8907-regulator.c b/drivers/regulator/max8907-regulator.c
index 9623e9e..3426be8 100644
--- a/drivers/regulator/max8907-regulator.c
+++ b/drivers/regulator/max8907-regulator.c
@@ -226,7 +226,7 @@ static int max8907_regulator_parse_dt(struct platform_device *pdev)
 	struct device_node *np, *regulators;
 	int ret;
 
-	np = of_node_get(pdev->dev.parent->of_node);
+	np = pdev->dev.parent->of_node;
 	if (!np)
 		return 0;
 
diff --git a/drivers/regulator/max8925-regulator.c b/drivers/regulator/max8925-regulator.c
index dad2bcd..7770777 100644
--- a/drivers/regulator/max8925-regulator.c
+++ b/drivers/regulator/max8925-regulator.c
@@ -250,7 +250,7 @@ static int max8925_regulator_dt_init(struct platform_device *pdev,
 	struct device_node *nproot, *np;
 	int rcount;
 
-	nproot = of_node_get(pdev->dev.parent->of_node);
+	nproot = pdev->dev.parent->of_node;
 	if (!nproot)
 		return -ENODEV;
 	np = of_get_child_by_name(nproot, "regulators");
diff --git a/drivers/regulator/max8997.c b/drivers/regulator/max8997.c
index 90b4c53..9c31e21 100644
--- a/drivers/regulator/max8997.c
+++ b/drivers/regulator/max8997.c
@@ -917,7 +917,7 @@ static int max8997_pmic_dt_parse_pdata(struct platform_device *pdev,
 	struct max8997_regulator_data *rdata;
 	unsigned int i, dvs_voltage_nr = 1, ret;
 
-	pmic_np = of_node_get(iodev->dev->of_node);
+	pmic_np = iodev->dev->of_node;
 	if (!pmic_np) {
 		dev_err(&pdev->dev, "could not find pmic sub-node\n");
 		return -ENODEV;
diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index a7ce34d..1878e5b 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -1427,7 +1427,6 @@ static void palmas_dt_to_pdata(struct device *dev,
 	u32 prop;
 	int idx, ret;
 
-	node = of_node_get(node);
 	regulators = of_get_child_by_name(node, "regulators");
 	if (!regulators) {
 		dev_info(dev, "regulator node not found\n");
diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator/tps65910-regulator.c
index 2064507..18fc991 100644
--- a/drivers/regulator/tps65910-regulator.c
+++ b/drivers/regulator/tps65910-regulator.c
@@ -1014,7 +1014,7 @@ static struct tps65910_board *tps65910_parse_dt_reg_data(
 	if (!pmic_plat_data)
 		return NULL;
 
-	np = of_node_get(pdev->dev.parent->of_node);
+	np = pdev->dev.parent->of_node;
 	regulators = of_get_child_by_name(np, "regulators");
 	if (!regulators) {
 		dev_err(&pdev->dev, "regulator node not found\n");
-- 
1.9.1
