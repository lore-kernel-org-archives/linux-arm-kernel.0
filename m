From: christopher.lee.bostic@gmail.com (christopher.lee.bostic at gmail.com)
Date: Thu, 12 Jan 2017 16:29:04 -0600
Subject: [PATCH v2 08/18] drivers/fsi: Implement slave initialisation
Message-ID: <1484260144-79428-1-git-send-email-christopher.lee.bostic@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

Create fsi_slave devices during the master scan.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Chris Bostic <cbostic@us.ibm.com>
---
 drivers/fsi/fsi-core.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 5f9f7a9..931bcba 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -17,10 +17,15 @@
 #include <linux/fsi.h>
 #include <linux/module.h>
 #include <linux/idr.h>
+#include <linux/crc-fsi.h>
+#include <linux/slab.h>
 
 #include "fsi-master.h"
 
 #define FSI_N_SLAVES	4
+#define FSI_SLAVE_CONF_CRC_SHIFT        4
+#define FSI_SLAVE_CONF_CRC_MASK         0x0000000f
+#define FSI_SLAVE_CONF_DATA_BITS        28
 
 static DEFINE_IDA(master_ida);
 
@@ -34,12 +39,59 @@ struct fsi_slave {
 #define to_fsi_slave(d) container_of(d, struct fsi_slave, dev)
 
 /* FSI slave support */
+
+static void fsi_slave_release(struct device *dev)
+{
+	struct fsi_slave *slave = to_fsi_slave(dev);
+
+	kfree(slave);
+}
+
 static int fsi_slave_init(struct fsi_master *master,
 		int link, uint8_t slave_id)
 {
-	/* todo: initialise slave device, perform engine scan */
+	struct fsi_slave *slave;
+	uint32_t chip_id;
+	int rc;
+	uint8_t crc;
+
+	rc = master->read(master, link, slave_id, 0, &chip_id, sizeof(chip_id));
+	if (rc) {
+		dev_warn(master->dev, "can't read slave %02x:%02x: %d\n",
+				link, slave_id, rc);
+		return -ENODEV;
+	}
+	crc = crc_fsi(0, chip_id >> FSI_SLAVE_CONF_CRC_SHIFT,
+			FSI_SLAVE_CONF_DATA_BITS);
+	if (crc != (chip_id & FSI_SLAVE_CONF_CRC_MASK)) {
+		dev_warn(master->dev, "slave %02x:%02x invalid chip id CRC!\n",
+				link, slave_id);
+		return -EIO;
+	}
+
+	pr_debug("fsi: found chip %08x at %02x:%02x:%02x\n",
+			master->idx, chip_id, link, slave_id);
+
+	/* we can communicate with a slave; create devices and scan */
+	slave = kzalloc(sizeof(*slave), GFP_KERNEL);
+	if (!slave)
+		return -ENOMEM;
+
+	slave->master = master;
+	slave->id = slave_id;
+	slave->dev.parent = master->dev;
+	slave->dev.release = fsi_slave_release;
+
+	dev_set_name(&slave->dev, "slave@%02x:%02x", link, slave_id);
+	rc = device_register(&slave->dev);
+	if (rc < 0) {
+		dev_warn(master->dev, "failed to create slave device: %d\n",
+				rc);
+		put_device(&slave->dev);
+		return rc;
+	}
 
-	return -ENODEV;
+	return rc;
 }
 
 /* FSI master support */
-- 
1.8.2.2
