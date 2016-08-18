From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 18 Aug 2016 12:11:00 +0200
Subject: [PATCH 07/13] scpi: ignore init_versions failure if reported not
 supported
In-Reply-To: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
References: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1471515066-3626-8-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In Amlogic GXBB Legacy SCPI, the LEGACY_SCPI_CMD_SCPI_CAPABILITIES report
as SCPI_ERR_SUPPORT, so do not fail if this command is not supported.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/arm_scpi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 3fe39fe..d3be4c5 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -1111,12 +1111,13 @@ err:
 		ret = scpi_info->ops->init_versions(scpi_info);
 	else
 	ret = scpi_init_versions(scpi_info);
-	if (ret) {
+	if (ret && ret != -EOPNOTSUPP) {
 		dev_err(dev, "incorrect or no SCP firmware found\n");
 		scpi_remove(pdev);
 		return ret;
 	}
 
+	if (ret != -EOPNOTSUPP) {
 	_dev_info(dev, "SCP Protocol %d.%d Firmware %d.%d.%d version\n",
 		  PROTOCOL_REV_MAJOR(scpi_info->protocol_version),
 		  PROTOCOL_REV_MINOR(scpi_info->protocol_version),
@@ -1124,15 +1125,16 @@ err:
 		  FW_REV_MINOR(scpi_info->firmware_version),
 		  FW_REV_PATCH(scpi_info->firmware_version));
 
+		ret = sysfs_create_groups(&dev->kobj, versions_groups);
+		if (ret)
+			dev_err(dev, "unable to create sysfs version group\n");
+	}
+
 	if (scpi_info->ops && scpi_info->ops->scpi_ops)
 		scpi_info->scpi_ops = scpi_info->ops->scpi_ops;
 	else
 		scpi_info->scpi_ops = &scpi_ops;
 
-	ret = sysfs_create_groups(&dev->kobj, versions_groups);
-	if (ret)
-		dev_err(dev, "unable to create sysfs version group\n");
-
 	return of_platform_populate(dev->of_node, NULL, NULL, dev);
 }
 
-- 
1.9.1
