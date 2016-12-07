From: christopher.lee.bostic@gmail.com (Chris Bostic)
Date: Tue,  6 Dec 2016 20:09:32 -0600
Subject: [PATCH 09/16] drivers/fsi: Implement slave initialisation
In-Reply-To: <1481076574-54711-1-git-send-email-christopher.lee.bostic@gmail.com>
References: <1481076574-54711-1-git-send-email-christopher.lee.bostic@gmail.com>
Message-ID: <1481076574-54711-3-git-send-email-christopher.lee.bostic@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

Create fsi_slave devices during the master scan.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Chris Bostic <cbostic@us.ibm.com>
---
 drivers/fsi/fsi-core.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index f0832c7..aa4330a 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -16,10 +16,14 @@
 #include <linux/device.h>
 #include <linux/fsi.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 
 #include "fsi-master.h"
 
 #define FSI_N_SLAVES	4
+#define FSI_SLAVE_CONF_CRC_SHIFT        4
+#define FSI_SLAVE_CONF_CRC_MASK         0x0000000f
+#define FSI_SLAVE_CONF_DATA_BITS        28
 
 static atomic_t master_idx = ATOMIC_INIT(-1);
 
@@ -54,12 +58,59 @@ uint8_t fsi_crc4(uint8_t c, uint64_t x, int bits)
 EXPORT_SYMBOL_GPL(fsi_crc4);
 
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
+	crc = fsi_crc4(0, chip_id >> FSI_SLAVE_CONF_CRC_SHIFT,
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
