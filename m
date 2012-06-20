From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Jun 2012 13:56:41 +0100
Subject: [PATCH 05/15] mfd: db8500-prcmu: Register devices using the newly
 DT:ed MFD API
In-Reply-To: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1340197011-5435-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now the MFD API is Device Tree aware we can use it for platform
registration again, even when booting with DT enabled. To aid in
Device Node pointer allocation we provide each cell with the
associative compatible string.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/db8500-prcmu.c       |   14 +++++++-------
 drivers/regulator/db8500-prcmu.c |    6 ------
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 1aa0bb7..e9e576c 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2948,11 +2948,13 @@ static struct regulator_init_data db8500_regulators[DB8500_NUM_REGULATORS] = {
 static struct mfd_cell db8500_prcmu_devs[] = {
 	{
 		.name = "db8500-prcmu-regulators",
+		.of_compatible = "stericsson,db8500-prcmu-regulator",
 		.platform_data = &db8500_regulators,
 		.pdata_size = sizeof(db8500_regulators),
 	},
 	{
 		.name = "cpufreq-u8500",
+		.of_compatible = "stericsson,cpufreq-u8500",
 	},
 };
 
@@ -2990,13 +2992,11 @@ static int __devinit db8500_prcmu_probe(struct platform_device *pdev)
 	if (cpu_is_u8500v20_or_later())
 		prcmu_config_esram0_deep_sleep(ESRAM0_DEEP_SLEEP_STATE_RET);
 
-	if (!np) {
-		err = mfd_add_devices(&pdev->dev, 0, db8500_prcmu_devs,
-				ARRAY_SIZE(db8500_prcmu_devs), NULL, 0);
-		if (err) {
-			pr_err("prcmu: Failed to add subdevices\n");
-			return err;
-		}
+	err = mfd_add_devices(&pdev->dev, 0, db8500_prcmu_devs,
+			ARRAY_SIZE(db8500_prcmu_devs), NULL, 0);
+	if (err) {
+		pr_err("prcmu: Failed to add subdevices\n");
+		return err;
 	}
 
 	pr_info("DB8500 PRCMU initialized\n");
diff --git a/drivers/regulator/db8500-prcmu.c b/drivers/regulator/db8500-prcmu.c
index 9dbb491..359f8d1 100644
--- a/drivers/regulator/db8500-prcmu.c
+++ b/drivers/regulator/db8500-prcmu.c
@@ -547,16 +547,10 @@ static int __exit db8500_regulator_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id db8500_prcmu_regulator_match[] = {
-        { .compatible = "stericsson,db8500-prcmu-regulator", },
-        {}
-};
-
 static struct platform_driver db8500_regulator_driver = {
 	.driver = {
 		.name = "db8500-prcmu-regulators",
 		.owner = THIS_MODULE,
-		.of_match_table = db8500_prcmu_regulator_match,
 	},
 	.probe = db8500_regulator_probe,
 	.remove = __exit_p(db8500_regulator_remove),
-- 
1.7.9.5
