From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Tue, 5 Dec 2017 23:16:48 +0100
Subject: [PATCH 03/12] firmware: arm_scpi: make scpi_probe completely
 device-managed
In-Reply-To: <99220c79-8b35-2978-11d1-6d101ccb6772@gmail.com>
References: <99220c79-8b35-2978-11d1-6d101ccb6772@gmail.com>
Message-ID: <58c40520-bc3f-b4d2-a400-c2b6b18e7422@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace two remaining functions in probe with their devm versions.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/firmware/arm_scpi.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 4447738d..a6f6039e 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -901,15 +901,10 @@ static void scpi_free_channels(void *data)
 static int scpi_remove(struct platform_device *pdev)
 {
 	int i;
-	struct device *dev = &pdev->dev;
 	struct scpi_drvinfo *info = platform_get_drvdata(pdev);
 
 	scpi_info = NULL; /* stop exporting SCPI ops through get_scpi_ops */
 
-	of_platform_depopulate(dev);
-	sysfs_remove_groups(&dev->kobj, versions_groups);
-	platform_set_drvdata(pdev, NULL);
-
 	for (i = 0; i < MAX_DVFS_DOMAINS && info->dvfs[i]; i++) {
 		kfree(info->dvfs[i]->opps);
 		kfree(info->dvfs[i]);
@@ -1036,7 +1031,6 @@ static int scpi_probe(struct platform_device *pdev)
 	ret = scpi_init_versions(scpi_info);
 	if (ret) {
 		dev_err(dev, "incorrect or no SCP firmware found\n");
-		scpi_remove(pdev);
 		return ret;
 	}
 
@@ -1048,11 +1042,11 @@ static int scpi_probe(struct platform_device *pdev)
 		  FW_REV_PATCH(scpi_info->firmware_version));
 	scpi_info->scpi_ops = &scpi_ops;
 
-	ret = sysfs_create_groups(&dev->kobj, versions_groups);
+	ret = devm_device_add_groups(dev, versions_groups);
 	if (ret)
 		dev_err(dev, "unable to create sysfs version group\n");
 
-	return of_platform_populate(dev->of_node, NULL, NULL, dev);
+	return devm_of_platform_populate(dev);
 }
 
 static const struct of_device_id scpi_of_match[] = {
-- 
2.15.1
