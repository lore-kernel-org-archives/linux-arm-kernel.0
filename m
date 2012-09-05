From: loic.pallardy-ext@stericsson.com (Loic Pallardy)
Date: Wed, 5 Sep 2012 11:59:13 +0200
Subject: [PATCH 17/17] mfd: db8500-prcmu: activate dbx540-prcmu driver
In-Reply-To: <1346839153-6465-1-git-send-email-loic.pallardy-ext@stericsson.com>
References: <1346839153-6465-1-git-send-email-loic.pallardy-ext@stericsson.com>
Message-ID: <1346839153-6465-18-git-send-email-loic.pallardy-ext@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

db8500-prcmu clean up, removing dbx540 definition from
db8500-prcmu file.

Signed-off-by: Loic Pallardy <loic.pallardy@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/db8500-prcmu.c | 30 ++----------------------------
 drivers/mfd/dbx500-prcmu.c |  6 ++++--
 2 files changed, 6 insertions(+), 30 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index b39441f..164c9d5 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2988,28 +2988,6 @@ static struct mfd_cell db8500_prcmu_devs[] = {
 	},
 };
 
-static struct mfd_cell db9540_prcmu_devs[] = {
-	{
-		.name = "dbx500-prcmu",
-		.platform_data = &db8500_probe_data,
-		.pdata_size = sizeof(db8500_probe_data),
-	},
-	{
-		.name = "db8500-prcmu-regulators",
-		.of_compatible = "stericsson,db8500-prcmu-regulator",
-		.platform_data = &db8500_regulators,
-		.pdata_size = sizeof(db8500_regulators),
-	},
-	{
-		.name = "ab9540-i2c",
-		.of_compatible = "stericsson,ab8500",
-		.num_resources = ARRAY_SIZE(ab8500_resources),
-		.resources = ab8500_resources,
-		.id = AB8500_VERSION_AB9540,
-	},
-};
-
-
 /**
  * prcmu_fw_init - arch init call for the Linux PRCMU fw init logic
  *
@@ -3052,14 +3030,10 @@ static int __devinit db8500_prcmu_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (cpu_is_u8500v20_or_later() && !cpu_is_u9540())
+	if (cpu_is_u8500v20_or_later())
 		db8500_prcmu_config_esram0_deep_sleep(ESRAM0_DEEP_SLEEP_STATE_RET);
 
-	if (cpu_is_u9540())
-			err = mfd_add_devices(&pdev->dev, 0, db9540_prcmu_devs,
-			ARRAY_SIZE(db9540_prcmu_devs), NULL, 0);
-	else
-		err = mfd_add_devices(&pdev->dev, 0, db8500_prcmu_devs,
+	err = mfd_add_devices(&pdev->dev, 0, db8500_prcmu_devs,
 			ARRAY_SIZE(db8500_prcmu_devs), NULL, 0);
 
 	if (err) {
diff --git a/drivers/mfd/dbx500-prcmu.c b/drivers/mfd/dbx500-prcmu.c
index 1823ab7..964804e 100644
--- a/drivers/mfd/dbx500-prcmu.c
+++ b/drivers/mfd/dbx500-prcmu.c
@@ -725,8 +725,10 @@ void __init prcmu_early_init(struct prcmu_tcdm_map *map)
 {
 	int i, ret = 0;
 	struct prcmu_fops_register_data *data;
-
-	data = db8500_prcmu_early_init(map);
+	if (cpu_is_ux540_family())
+		data =  dbx540_prcmu_early_init(map);
+	else
+		data = db8500_prcmu_early_init(map);
 
 	if (data == NULL)
 		return;
-- 
1.7.11.1
