From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Fri, 29 Sep 2017 23:43:54 +0200
Subject: [PATCH 1/5] firmware: arm_scpi: remove usage of drvdata and don't
 reset scpi_info to null
In-Reply-To: <c245d2fa-2aa0-fa40-21a7-318e8db3b763@gmail.com>
References: <c245d2fa-2aa0-fa40-21a7-318e8db3b763@gmail.com>
Message-ID: <e078f057-9872-9073-876a-1c0c9312f58d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I do not see a benefit in using drvdata as variable scpi_info is
available everywhere anyway.

And setting scpi_info to NULL in scpi_remove isn't needed IMO.
If arm_scpi is built-in, then this code is never used. And if arm_scpi
is built as a module and some other module calls get_scpi_ops() then
due to this dependency scpi_remove is called only after the other
module has been removed. Last but not least users usually store the
result of get_scpi_ops(), therefore setting scpi_info to NULL wouldn't
really help.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/firmware/arm_scpi.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index c5ce096b..c942761e 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -866,8 +866,6 @@ static int scpi_init_versions(struct scpi_drvinfo *info)
 static ssize_t protocol_version_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	struct scpi_drvinfo *scpi_info = dev_get_drvdata(dev);
-
 	return sprintf(buf, "%d.%d\n",
 		       PROTOCOL_REV_MAJOR(scpi_info->protocol_version),
 		       PROTOCOL_REV_MINOR(scpi_info->protocol_version));
@@ -877,8 +875,6 @@ static DEVICE_ATTR_RO(protocol_version);
 static ssize_t firmware_version_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	struct scpi_drvinfo *scpi_info = dev_get_drvdata(dev);
-
 	return sprintf(buf, "%d.%d.%d\n",
 		       FW_REV_MAJOR(scpi_info->firmware_version),
 		       FW_REV_MINOR(scpi_info->firmware_version),
@@ -909,21 +905,17 @@ static int scpi_remove(struct platform_device *pdev)
 {
 	int i;
 	struct device *dev = &pdev->dev;
-	struct scpi_drvinfo *info = platform_get_drvdata(pdev);
-
-	scpi_info = NULL; /* stop exporting SCPI ops through get_scpi_ops */
 
 	of_platform_depopulate(dev);
 	sysfs_remove_groups(&dev->kobj, versions_groups);
-	scpi_free_channels(dev, info->channels, info->num_chans);
-	platform_set_drvdata(pdev, NULL);
+	scpi_free_channels(dev, scpi_info->channels, scpi_info->num_chans);
 
-	for (i = 0; i < MAX_DVFS_DOMAINS && info->dvfs[i]; i++) {
-		kfree(info->dvfs[i]->opps);
-		kfree(info->dvfs[i]);
+	for (i = 0; i < MAX_DVFS_DOMAINS && scpi_info->dvfs[i]; i++) {
+		kfree(scpi_info->dvfs[i]->opps);
+		kfree(scpi_info->dvfs[i]);
 	}
-	devm_kfree(dev, info->channels);
-	devm_kfree(dev, info);
+	devm_kfree(dev, scpi_info->channels);
+	devm_kfree(dev, scpi_info);
 
 	return 0;
 }
@@ -1031,8 +1023,6 @@ static int scpi_probe(struct platform_device *pdev)
 	scpi_info->num_chans = count;
 	scpi_info->commands = scpi_std_commands;
 
-	platform_set_drvdata(pdev, scpi_info);
-
 	if (scpi_info->is_legacy) {
 		/* Replace with legacy variants */
 		scpi_ops.clk_set_val = legacy_scpi_clk_set_val;
-- 
2.14.2
