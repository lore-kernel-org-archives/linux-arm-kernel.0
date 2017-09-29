From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Fri, 29 Sep 2017 23:44:15 +0200
Subject: [PATCH 5/5] firmware: arm_scpi: remove scpi_remove
In-Reply-To: <c245d2fa-2aa0-fa40-21a7-318e8db3b763@gmail.com>
References: <c245d2fa-2aa0-fa40-21a7-318e8db3b763@gmail.com>
Message-ID: <a661fe23-d11b-35da-36f0-cdfa59587a88@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sysfs_create_groups and of_platform_populate can be replaced with the
device-managed versions what allows us to remove scpi_remove.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/firmware/arm_scpi.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index c91f3241..a71907e6 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -911,16 +911,6 @@ static void scpi_free_channels(void *data)
 		mbox_free_channel(info->channels[i].chan);
 }
 
-static int scpi_remove(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-
-	of_platform_depopulate(dev);
-	sysfs_remove_groups(&dev->kobj, versions_groups);
-
-	return 0;
-}
-
 #define MAX_SCPI_XFERS		10
 static int scpi_alloc_xfer_list(struct device *dev, struct scpi_chan *ch)
 {
@@ -1038,15 +1028,12 @@ static int scpi_probe(struct platform_device *pdev)
 	ret = scpi_init_versions(scpi_info);
 	if (ret) {
 		dev_err(dev, "incorrect or no SCP firmware found\n");
-		scpi_remove(pdev);
 		return ret;
 	}
 
 	ret = scpi_dvfs_populate(dev);
-	if (ret) {
-		scpi_remove(pdev);
+	if (ret)
 		return ret;
-	}
 
 	_dev_info(dev, "SCP Protocol %d.%d Firmware %d.%d.%d version\n",
 		  PROTOCOL_REV_MAJOR(scpi_info->protocol_version),
@@ -1055,11 +1042,11 @@ static int scpi_probe(struct platform_device *pdev)
 		  FW_REV_MINOR(scpi_info->firmware_version),
 		  FW_REV_PATCH(scpi_info->firmware_version));
 
-	ret = sysfs_create_groups(&dev->kobj, versions_groups);
+	ret = devm_device_add_groups(dev, versions_groups);
 	if (ret)
 		dev_err(dev, "unable to create sysfs version group\n");
 
-	return of_platform_populate(dev->of_node, NULL, NULL, dev);
+	return devm_of_platform_populate(dev);
 }
 
 static const struct of_device_id scpi_of_match[] = {
@@ -1076,7 +1063,6 @@ static struct platform_driver scpi_driver = {
 		.of_match_table = scpi_of_match,
 	},
 	.probe = scpi_probe,
-	.remove = scpi_remove,
 };
 module_platform_driver(scpi_driver);
 
-- 
2.14.2
