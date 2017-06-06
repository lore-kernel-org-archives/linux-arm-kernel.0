From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Tue,  6 Jun 2017 16:08:42 -0500
Subject: [PATCH v8 07/24] drivers/fsi: Implement slave initialisation
In-Reply-To: <20170606210859.80431-1-cbostic@linux.vnet.ibm.com>
References: <20170606210859.80431-1-cbostic@linux.vnet.ibm.com>
Message-ID: <20170606210859.80431-8-cbostic@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

Implement fsi_slave_init: if we can read a chip ID, create fsi_slave
devices and register with the driver core.

Includes changes from Christopher Bostic <cbostic@linux.vnet.ibm.com>.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/Kconfig    |  1 +
 drivers/fsi/fsi-core.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
index 04c1a0e..e1006c6 100644
--- a/drivers/fsi/Kconfig
+++ b/drivers/fsi/Kconfig
@@ -6,6 +6,7 @@ menu "FSI support"
 
 config FSI
 	tristate "FSI support"
+	select CRC4
 	---help---
 	  FSI - the FRU Support Interface - is a simple bus for low-level
 	  access to POWER-based hardware.
diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 235f17a..9d9adc1 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -13,13 +13,17 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/crc4.h>
 #include <linux/device.h>
 #include <linux/fsi.h>
 #include <linux/idr.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 
 #include "fsi-master.h"
 
+#define FSI_SLAVE_SIZE_23b		0x800000
+
 static DEFINE_IDA(master_ida);
 
 struct fsi_slave {
@@ -90,11 +94,70 @@ static int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
 			addr, val, size);
 }
 
+static void fsi_slave_release(struct device *dev)
+{
+	struct fsi_slave *slave = to_fsi_slave(dev);
+
+	kfree(slave);
+}
+
 static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 {
-	/* todo: initialise slave device, perform engine scan */
+	struct fsi_slave *slave;
+	uint32_t chip_id;
+	uint8_t crc;
+	int rc;
+
+	/* Currently, we only support single slaves on a link, and use the
+	 * full 23-bit address range
+	 */
+	if (id != 0)
+		return -EINVAL;
+
+	rc = fsi_master_read(master, link, id, 0, &chip_id, sizeof(chip_id));
+	if (rc) {
+		dev_dbg(&master->dev, "can't read slave %02x:%02x %d\n",
+				link, id, rc);
+		return -ENODEV;
+	}
+	chip_id = be32_to_cpu(chip_id);
+
+	crc = crc4(0, chip_id, 32);
+	if (crc) {
+		dev_warn(&master->dev, "slave %02x:%02x invalid chip id CRC!\n",
+				link, id);
+		return -EIO;
+	}
+
+	dev_info(&master->dev, "fsi: found chip %08x at %02x:%02x:%02x\n",
+			chip_id, master->idx, link, id);
+
+	/* We can communicate with a slave; create the slave device and
+	 * register.
+	 */
+	slave = kzalloc(sizeof(*slave), GFP_KERNEL);
+	if (!slave)
+		return -ENOMEM;
+
+	slave->master = master;
+	slave->dev.parent = &master->dev;
+	slave->dev.release = fsi_slave_release;
+	slave->link = link;
+	slave->id = id;
+	slave->size = FSI_SLAVE_SIZE_23b;
+
+	dev_set_name(&slave->dev, "slave@%02x:%02x", link, id);
+	rc = device_register(&slave->dev);
+	if (rc < 0) {
+		dev_warn(&master->dev, "failed to create slave device: %d\n",
+				rc);
+		put_device(&slave->dev);
+		return rc;
+	}
+
+	/* todo: perform engine scan */
 
-	return -ENODEV;
+	return rc;
 }
 
 /* FSI master support */
-- 
1.8.2.2
