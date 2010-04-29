From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 29 Apr 2010 13:33:50 -0400
Subject: [PATCH] regulator: make max8925 sharing one driver structure
Message-ID: <mailman.354.1272957708.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove a lot of driver structures in max8925 driver. Make regulators share
one driver structure.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mfd/88pm860x-core.c  |   34 ++++++++++++++--------------
 drivers/regulator/88pm8607.c |   51 ++++++++---------------------------------
 2 files changed, 27 insertions(+), 58 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 6a14d2b..21de38d 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -176,30 +176,30 @@ static struct resource regulator_resources[] = {
 	PM8607_REG_RESOURCE(LDO14, LDO14),
 };

-#define PM8607_REG_DEVS(_name, _id)					\
+#define PM8607_REG_DEVS(_id)						\
 {									\
-	.name		= "88pm8607-" #_name,				\
+	.name		= "88pm860x-regulator",				\
 	.num_resources	= 1,						\
 	.resources	= &regulator_resources[PM8607_ID_##_id],	\
 	.id		= PM8607_ID_##_id,				\
 }

 static struct mfd_cell regulator_devs[] = {
-	PM8607_REG_DEVS(buck1, BUCK1),
-	PM8607_REG_DEVS(buck2, BUCK2),
-	PM8607_REG_DEVS(buck3, BUCK3),
-	PM8607_REG_DEVS(ldo1,  LDO1),
-	PM8607_REG_DEVS(ldo2,  LDO2),
-	PM8607_REG_DEVS(ldo3,  LDO3),
-	PM8607_REG_DEVS(ldo4,  LDO4),
-	PM8607_REG_DEVS(ldo5,  LDO5),
-	PM8607_REG_DEVS(ldo6,  LDO6),
-	PM8607_REG_DEVS(ldo7,  LDO7),
-	PM8607_REG_DEVS(ldo8,  LDO8),
-	PM8607_REG_DEVS(ldo9,  LDO9),
-	PM8607_REG_DEVS(ldo10, LDO10),
-	PM8607_REG_DEVS(ldo12, LDO12),
-	PM8607_REG_DEVS(ldo14, LDO14),
+	PM8607_REG_DEVS(BUCK1),
+	PM8607_REG_DEVS(BUCK2),
+	PM8607_REG_DEVS(BUCK3),
+	PM8607_REG_DEVS(LDO1),
+	PM8607_REG_DEVS(LDO2),
+	PM8607_REG_DEVS(LDO3),
+	PM8607_REG_DEVS(LDO4),
+	PM8607_REG_DEVS(LDO5),
+	PM8607_REG_DEVS(LDO6),
+	PM8607_REG_DEVS(LDO7),
+	PM8607_REG_DEVS(LDO8),
+	PM8607_REG_DEVS(LDO9),
+	PM8607_REG_DEVS(LDO10),
+	PM8607_REG_DEVS(LDO12),
+	PM8607_REG_DEVS(LDO14),
 };

 struct pm860x_irq_data {
diff --git a/drivers/regulator/88pm8607.c b/drivers/regulator/88pm8607.c
index 5fb83e2..121bab4 100644
--- a/drivers/regulator/88pm8607.c
+++ b/drivers/regulator/88pm8607.c
@@ -484,60 +484,29 @@ static int __devexit
pm8607_regulator_remove(struct platform_device *pdev)
 {
 	struct pm8607_regulator_info *info = platform_get_drvdata(pdev);

+	platform_set_drvdata(pdev, NULL);
 	regulator_unregister(info->regulator);
 	return 0;
 }

-#define PM8607_REGULATOR_DRIVER(_name)				\
-{								\
-	.driver		= {					\
-		.name	= "88pm8607-" #_name,			\
-		.owner	= THIS_MODULE,				\
-	},							\
-	.probe		= pm8607_regulator_probe,		\
-	.remove		= __devexit_p(pm8607_regulator_remove),	\
-}
-
-static struct platform_driver pm8607_regulator_driver[] = {
-	PM8607_REGULATOR_DRIVER(buck1),
-	PM8607_REGULATOR_DRIVER(buck2),
-	PM8607_REGULATOR_DRIVER(buck3),
-	PM8607_REGULATOR_DRIVER(ldo1),
-	PM8607_REGULATOR_DRIVER(ldo2),
-	PM8607_REGULATOR_DRIVER(ldo3),
-	PM8607_REGULATOR_DRIVER(ldo4),
-	PM8607_REGULATOR_DRIVER(ldo5),
-	PM8607_REGULATOR_DRIVER(ldo6),
-	PM8607_REGULATOR_DRIVER(ldo7),
-	PM8607_REGULATOR_DRIVER(ldo8),
-	PM8607_REGULATOR_DRIVER(ldo9),
-	PM8607_REGULATOR_DRIVER(ldo10),
-	PM8607_REGULATOR_DRIVER(ldo12),
-	PM8607_REGULATOR_DRIVER(ldo14),
+static struct platform_driver pm8607_regulator_driver = {
+	.driver		= {
+		.name	= "88pm860x-regulator",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= pm8607_regulator_probe,
+	.remove		= __devexit_p(pm8607_regulator_remove),
 };

 static int __init pm8607_regulator_init(void)
 {
-	int i, count, ret;
-
-	count = ARRAY_SIZE(pm8607_regulator_driver);
-	for (i = 0; i < count; i++) {
-		ret = platform_driver_register(&pm8607_regulator_driver[i]);
-		if (ret != 0)
-			pr_err("Failed to register regulator driver: %d\n",
-				ret);
-	}
-	return 0;
+	return platform_driver_register(&pm8607_regulator_driver);
 }
 subsys_initcall(pm8607_regulator_init);

 static void __exit pm8607_regulator_exit(void)
 {
-	int i, count;
-
-	count = ARRAY_SIZE(pm8607_regulator_driver);
-	for (i = 0; i < count; i++)
-		platform_driver_unregister(&pm8607_regulator_driver[i]);
+	platform_driver_unregister(&pm8607_regulator_driver);
 }
 module_exit(pm8607_regulator_exit);

-- 
1.5.6.5
