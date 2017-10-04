From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Wed, 4 Oct 2017 21:00:39 +0200
Subject: [PATCH 2/3] firmware: arm_scpi: improve handling of protocol and
 firmware version subfields
In-Reply-To: <16d1cd8c-e124-cc94-ca29-d7cb04ff26d9@gmail.com>
References: <16d1cd8c-e124-cc94-ca29-d7cb04ff26d9@gmail.com>
Message-ID: <54b28f23-d650-5f74-7fb9-499864f57bc3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By using FIELD_GET and proper masks we can avoid quite some shifting
and masking macro magic and make the code better readable.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/firmware/arm_scpi.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 412f1c4c..d305b926 100644
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
 
@@ -867,19 +862,19 @@ static int scpi_init_versions(struct scpi_drvinfo *info)
 static ssize_t protocol_version_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d.%d\n",
-		       PROTOCOL_REV_MAJOR(scpi_info->protocol_version),
-		       PROTOCOL_REV_MINOR(scpi_info->protocol_version));
+	return sprintf(buf, "%lu.%lu\n",
+		FIELD_GET(PROTO_REV_MAJOR_MASK, scpi_info->protocol_version),
+		FIELD_GET(PROTO_REV_MINOR_MASK, scpi_info->protocol_version));
 }
 static DEVICE_ATTR_RO(protocol_version);
 
 static ssize_t firmware_version_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d.%d.%d\n",
-		       FW_REV_MAJOR(scpi_info->firmware_version),
-		       FW_REV_MINOR(scpi_info->firmware_version),
-		       FW_REV_PATCH(scpi_info->firmware_version));
+	return sprintf(buf, "%lu.%lu.%lu\n",
+		     FIELD_GET(FW_REV_MAJOR_MASK, scpi_info->firmware_version),
+		     FIELD_GET(FW_REV_MINOR_MASK, scpi_info->firmware_version),
+		     FIELD_GET(FW_REV_PATCH_MASK, scpi_info->firmware_version));
 }
 static DEVICE_ATTR_RO(firmware_version);
 
@@ -1021,12 +1016,12 @@ static int scpi_probe(struct platform_device *pdev)
 
 	scpi_dvfs_populate(dev);
 
-	_dev_info(dev, "SCP Protocol %d.%d Firmware %d.%d.%d version\n",
-		  PROTOCOL_REV_MAJOR(scpi_info->protocol_version),
-		  PROTOCOL_REV_MINOR(scpi_info->protocol_version),
-		  FW_REV_MAJOR(scpi_info->firmware_version),
-		  FW_REV_MINOR(scpi_info->firmware_version),
-		  FW_REV_PATCH(scpi_info->firmware_version));
+	_dev_info(dev, "SCP Protocol %lu.%lu Firmware %lu.%lu.%lu version\n",
+		  FIELD_GET(PROTO_REV_MAJOR_MASK, scpi_info->protocol_version),
+		  FIELD_GET(PROTO_REV_MINOR_MASK, scpi_info->protocol_version),
+		  FIELD_GET(FW_REV_MAJOR_MASK, scpi_info->firmware_version),
+		  FIELD_GET(FW_REV_MINOR_MASK, scpi_info->firmware_version),
+		  FIELD_GET(FW_REV_PATCH_MASK, scpi_info->firmware_version));
 
 	ret = devm_device_add_groups(dev, versions_groups);
 	if (ret)
-- 
2.14.2
