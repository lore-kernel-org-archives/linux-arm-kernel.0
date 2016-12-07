From: christopher.lee.bostic@gmail.com (Chris Bostic)
Date: Tue,  6 Dec 2016 18:14:24 -0600
Subject: [PATCH 03/16] drivers/fsi: add driver to device matches
In-Reply-To: <1481069677-53660-1-git-send-email-christopher.lee.bostic@gmail.com>
References: <1481069677-53660-1-git-send-email-christopher.lee.bostic@gmail.com>
Message-ID: <1481069677-53660-4-git-send-email-christopher.lee.bostic@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

Driver bind to devices based on the engine types & (optional) versions.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Chris Bostic <cbostic@us.ibm.com>
---
 drivers/fsi/fsi-core.c | 21 +++++++++++++++++++++
 include/linux/fsi.h    | 21 +++++++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 3e45306..3d55bd5 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -19,8 +19,29 @@
 
 /* FSI core & Linux bus type definitions */
 
+static int fsi_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct fsi_device *fsi_dev = to_fsi_dev(dev);
+	struct fsi_driver *fsi_drv = to_fsi_drv(drv);
+	const struct fsi_device_id *id;
+
+	if (!fsi_drv->id_table)
+		return 0;
+
+	for (id = fsi_drv->id_table; id->engine_type; id++) {
+		if (id->engine_type != fsi_dev->engine_type)
+			continue;
+		if (id->version == FSI_VERSION_ANY ||
+				id->version == fsi_dev->version)
+			return 1;
+	}
+
+	return 0;
+}
+
 struct bus_type fsi_bus_type = {
 	.name		= "fsi",
+	.match		= fsi_bus_match,
 };
 EXPORT_SYMBOL_GPL(fsi_bus_type);
 
diff --git a/include/linux/fsi.h b/include/linux/fsi.h
index f73886a..273cbf6 100644
--- a/include/linux/fsi.h
+++ b/include/linux/fsi.h
@@ -18,11 +18,28 @@
 #include <linux/device.h>
 
 struct fsi_device {
-	struct device dev;
+	struct device		dev;
+	u8			engine_type;
+	u8			version;
 };
 
+struct fsi_device_id {
+	u8	engine_type;
+	u8	version;
+};
+
+#define FSI_VERSION_ANY		0
+
+#define FSI_DEVICE(t) \
+	.engine_type = (t), .version = FSI_VERSION_ANY,
+
+#define FSI_DEVICE_VERSIONED(t, v) \
+	.engine_type = (t), .version = (v),
+
+
 struct fsi_driver {
-	struct device_driver drv;
+	struct device_driver		drv;
+	const struct fsi_device_id	*id_table;
 };
 
 #define to_fsi_dev(devp) container_of(devp, struct fsi_device, dev)
-- 
1.8.2.2
