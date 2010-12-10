From: bengt.g.jonsson@stericsson.com (Bengt Jonsson)
Date: Fri, 10 Dec 2010 11:08:42 +0100
Subject: [PATCH 3/9] regulators: Clean out unused code in ab8500 regulators
In-Reply-To: <1291975728-12525-1-git-send-email-bengt.g.jonsson@stericsson.com>
References: <1291975728-12525-1-git-send-email-bengt.g.jonsson@stericsson.com>
Message-ID: <1291975728-12525-4-git-send-email-bengt.g.jonsson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The find_regulator function was unused so it has been removed. The
ab8500 pointer in the regulator info structure was unused and so it
has also been removed.

Signed-off-by: Bengt Jonsson <bengt.g.jonsson@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/regulator/ab8500.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index 4efe3cf..51ff569 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -29,7 +29,6 @@
 /**
  * struct ab8500_regulator_info - ab8500 regulator information
  * @desc: regulator description
- * @ab8500: ab8500 parent
  * @regulator_dev: regulator device
  * @max_uV: maximum voltage (for variable voltage supplies)
  * @min_uV: minimum voltage (for variable voltage supplies)
@@ -47,7 +46,6 @@
 struct ab8500_regulator_info {
 	struct device		*dev;
 	struct regulator_desc	desc;
-	struct ab8500		*ab8500;
 	struct regulator_dev	*regulator;
 	int max_uV;
 	int min_uV;
@@ -345,19 +343,6 @@ static struct ab8500_regulator_info ab8500_regulator_info[] = {
 	AB8500_FIXED_LDO(ANA,     1200, 0x04,      0x06,     0xc,    0x4),
 };
 
-static inline struct ab8500_regulator_info *find_regulator_info(int id)
-{
-	struct ab8500_regulator_info *info;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(ab8500_regulator_info); i++) {
-		info = &ab8500_regulator_info[i];
-		if (info->desc.id == id)
-			return info;
-	}
-	return NULL;
-}
-
 static __devinit int ab8500_regulator_probe(struct platform_device *pdev)
 {
 	struct ab8500 *ab8500 = dev_get_drvdata(pdev->dev.parent);
@@ -383,7 +368,6 @@ static __devinit int ab8500_regulator_probe(struct platform_device *pdev)
 		/* assign per-regulator data */
 		info = &ab8500_regulator_info[i];
 		info->dev = &pdev->dev;
-		info->ab8500 = ab8500;
 
 		info->regulator = regulator_register(&info->desc, &pdev->dev,
 				&pdata->regulator[i], info);
-- 
1.7.2.2
