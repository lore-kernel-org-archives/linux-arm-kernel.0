From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Tue, 5 Dec 2017 23:16:55 +0100
Subject: [PATCH 05/12] firmware: arm_scpi: improve handling of protocol and
 firmware version subfields
In-Reply-To: <99220c79-8b35-2978-11d1-6d101ccb6772@gmail.com>
References: <99220c79-8b35-2978-11d1-6d101ccb6772@gmail.com>
Message-ID: <ddf6ec17-c592-7b6a-16a3-13c7bc2e595c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By using FIELD_GET and proper masks we can avoid quite some shifting
and masking macro magic and make the code better readable.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/firmware/arm_scpi.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 9eeb53b7..63441e40 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -28,6 +28,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/bitmap.h>
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/export.h>
@@ -73,18 +74,12 @@
 #define MAX_DVFS_DOMAINS	8
 #define MAX_DVFS_OPPS		16
 
-#define PROTOCOL_REV_MINOR_BITS	16
-#define PROTOCOL_REV_MINOR_MASK	((1U << PROTOCOL_REV_MINOR_BITS) - 1)
-#define PROTOCOL_REV_MAJOR(x)	((x) >> PROTOCOL_REV_MINOR_BITS)
-#define PROTOCOL_REV_MINOR(x)	((x) & PROTOCOL_REV_MINOR_MASK)
+#define PROTO_REV_MAJOR_MASK	GENMASK(31, 16)
+#define PROTO_REV_MINOR_MASK	GENMASK(15, 0)
 
-#define FW_REV_MAJOR_BITS	24
-#define FW_REV_MINOR_BITS	16
-#define FW_REV_PATCH_MASK	((1U << FW_REV_MINOR_BITS) - 1)
-#define FW_REV_MINOR_MASK	((1U << FW_REV_MAJOR_BITS) - 1)
-#define FW_REV_MAJOR(x)		((x) >> FW_REV_MAJOR_BITS)
-#define FW_REV_MINOR(x)		(((x) & FW_REV_MINOR_MASK) >> FW_REV_MINOR_BITS)
-#define FW_REV_PATCH(x)		((x) & FW_REV_PATCH_MASK)
+#define FW_REV_MAJOR_MASK	GENMASK(31, 24)
+#define FW_REV_MINOR_MASK	GENMASK(23, 16)
+#define FW_REV_PATCH_MASK	GENMASK(15, 0)
 
 #define MAX_RX_TIMEOUT		(msecs_to_jiffies(30))
 
@@ -861,9 +856,9 @@ static ssize_t protocol_version_show(struct device *dev,
 {
 	struct scpi_drvinfo *scpi_info = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d.%d\n",
-		       PROTOCOL_REV_MAJOR(scpi_info->protocol_version),
-		       PROTOCOL_REV_MINOR(scpi_info->protocol_version));
+	return sprintf(buf, "%lu.%lu\n",
+		FIELD_GET(PROTO_REV_MAJOR_MASK, scpi_info->protocol_version),
+		FIELD_GET(PROTO_REV_MINOR_MASK, scpi_info->protocol_version));
 }
 static DEVICE_ATTR_RO(protocol_version);
 
@@ -872,10 +867,10 @@ static ssize_t firmware_version_show(struct device *dev,
 {
 	struct scpi_drvinfo *scpi_info = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d.%d.%d\n",
-		       FW_REV_MAJOR(scpi_info->firmware_version),
-		       FW_REV_MINOR(scpi_info->firmware_version),
-		       FW_REV_PATCH(scpi_info->firmware_version));
+	return sprintf(buf, "%lu.%lu.%lu\n",
+		FIELD_GET(FW_REV_MAJOR_MASK, scpi_info->firmware_version),
+		FIELD_GET(FW_REV_MINOR_MASK, scpi_info->firmware_version),
+		FIELD_GET(FW_REV_PATCH_MASK, scpi_info->firmware_version));
 }
 static DEVICE_ATTR_RO(firmware_version);
 
@@ -1031,12 +1026,12 @@ static int scpi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	_dev_info(dev, "SCP Protocol %d.%d Firmware %d.%d.%d version\n",
-		  PROTOCOL_REV_MAJOR(scpi_info->protocol_version),
-		  PROTOCOL_REV_MINOR(scpi_info->protocol_version),
-		  FW_REV_MAJOR(scpi_info->firmware_version),
-		  FW_REV_MINOR(scpi_info->firmware_version),
-		  FW_REV_PATCH(scpi_info->firmware_version));
+	dev_info(dev, "SCP Protocol %lu.%lu Firmware %lu.%lu.%lu version\n",
+		 FIELD_GET(PROTO_REV_MAJOR_MASK, scpi_info->protocol_version),
+		 FIELD_GET(PROTO_REV_MINOR_MASK, scpi_info->protocol_version),
+		 FIELD_GET(FW_REV_MAJOR_MASK, scpi_info->firmware_version),
+		 FIELD_GET(FW_REV_MINOR_MASK, scpi_info->firmware_version),
+		 FIELD_GET(FW_REV_PATCH_MASK, scpi_info->firmware_version));
 	scpi_info->scpi_ops = &scpi_ops;
 
 	ret = devm_device_add_groups(dev, versions_groups);
-- 
2.15.1
