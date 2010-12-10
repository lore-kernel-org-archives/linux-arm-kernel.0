From: bengt.g.jonsson@stericsson.com (Bengt Jonsson)
Date: Fri, 10 Dec 2010 11:08:40 +0100
Subject: [PATCH 1/9] regulators: Moved define for number of regulators in
	ab8500
In-Reply-To: <1291975728-12525-1-git-send-email-bengt.g.jonsson@stericsson.com>
References: <1291975728-12525-1-git-send-email-bengt.g.jonsson@stericsson.com>
Message-ID: <1291975728-12525-2-git-send-email-bengt.g.jonsson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The define for number of regulators is moved from ab8500-core to
ab8500-regulator so that the regulator driver can be updated
independently of ab8500-core. This also changes the platform
configuration structure of ab8500-core so that it contains a
pointer to the regulator_init_data array plus number of
regulators instead of an fixed size array of pointers to
regulator_init_data.

Signed-off-by: Bengt Jonsson <bengt.g.jonsson@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/regulator/ab8500.c       |    8 +++++++-
 include/linux/mfd/ab8500.h       |    5 ++---
 include/linux/regulator/ab8500.h |   24 +++++++++++++-----------
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index 2f4ec0f..5670775 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -370,6 +370,12 @@ static __devinit int ab8500_regulator_probe(struct platform_device *pdev)
 	}
 	pdata = dev_get_platdata(ab8500->dev);
 
+	/* make sure the platform data has the correct size */
+	if (pdata->num_regulator != ARRAY_SIZE(ab8500_regulator_info)) {
+		dev_err(&pdev->dev, "platform configuration error\n");
+		return -EINVAL;
+	}
+
 	/* register all regulators */
 	for (i = 0; i < ARRAY_SIZE(ab8500_regulator_info); i++) {
 		struct ab8500_regulator_info *info = NULL;
@@ -380,7 +386,7 @@ static __devinit int ab8500_regulator_probe(struct platform_device *pdev)
 		info->ab8500 = ab8500;
 
 		info->regulator = regulator_register(&info->desc, &pdev->dev,
-				pdata->regulator[i], info);
+				&pdata->regulator[i], info);
 		if (IS_ERR(info->regulator)) {
 			err = PTR_ERR(info->regulator);
 			dev_err(&pdev->dev, "failed to register regulator %s\n",
diff --git a/include/linux/mfd/ab8500.h b/include/linux/mfd/ab8500.h
index d63b605..85cf2c2 100644
--- a/include/linux/mfd/ab8500.h
+++ b/include/linux/mfd/ab8500.h
@@ -99,8 +99,6 @@
 #define AB8500_NR_IRQS			104
 #define AB8500_NUM_IRQ_REGS		13
 
-#define AB8500_NUM_REGULATORS   15
-
 /**
  * struct ab8500 - ab8500 internal structure
  * @dev: parent device
@@ -145,7 +143,8 @@ struct regulator_init_data;
 struct ab8500_platform_data {
 	int irq_base;
 	void (*init) (struct ab8500 *);
-	struct regulator_init_data *regulator[AB8500_NUM_REGULATORS];
+	int num_regulator;
+	struct regulator_init_data *regulator;
 };
 
 extern int __devinit ab8500_init(struct ab8500 *ab8500);
diff --git a/include/linux/regulator/ab8500.h b/include/linux/regulator/ab8500.h
index f509877..6a210f1 100644
--- a/include/linux/regulator/ab8500.h
+++ b/include/linux/regulator/ab8500.h
@@ -11,15 +11,17 @@
 #define __LINUX_MFD_AB8500_REGULATOR_H
 
 /* AB8500 regulators */
-#define AB8500_LDO_AUX1         0
-#define AB8500_LDO_AUX2         1
-#define AB8500_LDO_AUX3         2
-#define AB8500_LDO_INTCORE      3
-#define AB8500_LDO_TVOUT        4
-#define AB8500_LDO_AUDIO	5
-#define AB8500_LDO_ANAMIC1      6
-#define AB8500_LDO_ANAMIC2      7
-#define AB8500_LDO_DMIC         8
-#define AB8500_LDO_ANA          9
-
+enum ab8500_regulator_id {
+	AB8500_LDO_AUX1,
+	AB8500_LDO_AUX2,
+	AB8500_LDO_AUX3,
+	AB8500_LDO_INTCORE,
+	AB8500_LDO_TVOUT,
+	AB8500_LDO_AUDIO,
+	AB8500_LDO_ANAMIC1,
+	AB8500_LDO_ANAMIC2,
+	AB8500_LDO_DMIC,
+	AB8500_LDO_ANA,
+	AB8500_NUM_REGULATORS,
+};
 #endif
-- 
1.7.2.2
