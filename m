From: christopher.lee.bostic@gmail.com (christopher.lee.bostic at gmail.com)
Date: Thu, 12 Jan 2017 16:30:30 -0600
Subject: [PATCH v2 09/18] drivers/fsi: scan slaves & register devices
Message-ID: <1484260230-79608-1-git-send-email-christopher.lee.bostic@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

Now that we have fsi_slave devices, scan each for endpoints, and
register them on the fsi bus.

Includes contributions from Chris Bostic <cbostic@us.ibm.com>

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Chris Bostic <cbostic@us.ibm.com>
---
 drivers/fsi/fsi-core.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/fsi.h    |   4 ++
 2 files changed, 136 insertions(+), 4 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 931bcba..f7ef993 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -23,9 +23,19 @@
 #include "fsi-master.h"
 
 #define FSI_N_SLAVES	4
-#define FSI_SLAVE_CONF_CRC_SHIFT        4
-#define FSI_SLAVE_CONF_CRC_MASK         0x0000000f
-#define FSI_SLAVE_CONF_DATA_BITS        28
+
+#define FSI_SLAVE_CONF_NEXT_MASK	0x80000000
+#define FSI_SLAVE_CONF_SLOTS_MASK	0x00ff0000
+#define FSI_SLAVE_CONF_SLOTS_SHIFT	16
+#define FSI_SLAVE_CONF_VERSION_MASK	0x0000f000
+#define FSI_SLAVE_CONF_VERSION_SHIFT	12
+#define FSI_SLAVE_CONF_TYPE_MASK	0x00000ff0
+#define FSI_SLAVE_CONF_TYPE_SHIFT	4
+#define FSI_SLAVE_CONF_CRC_SHIFT	4
+#define FSI_SLAVE_CONF_CRC_MASK		0x0000000f
+#define FSI_SLAVE_CONF_DATA_BITS	28
+
+static const int engine_page_size = 0x400;
 
 static DEFINE_IDA(master_ida);
 
@@ -38,8 +48,125 @@ struct fsi_slave {
 
 #define to_fsi_slave(d) container_of(d, struct fsi_slave, dev)
 
+/* FSI endpoint-device support */
+
+static void fsi_device_release(struct device *_device)
+{
+	struct fsi_device *device = to_fsi_dev(_device);
+
+	kfree(device);
+}
+
+static struct fsi_device *fsi_create_device(struct fsi_slave *slave)
+{
+	struct fsi_device *dev;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return NULL;
+
+	dev->dev.parent = &slave->dev;
+	dev->dev.bus = &fsi_bus_type;
+	dev->dev.release = fsi_device_release;
+
+	return dev;
+}
+
 /* FSI slave support */
 
+static int fsi_slave_read(struct fsi_slave *slave, uint32_t addr,
+			void *val, size_t size)
+{
+	return slave->master->read(slave->master, slave->link,
+			slave->id, addr, val, size);
+}
+
+static int fsi_slave_scan(struct fsi_slave *slave)
+{
+	uint32_t engine_addr;
+	uint32_t conf;
+	int rc, i;
+
+	/*
+	 * scan engines
+	 *
+	 * We keep the peek mode and slave engines for the core; so start
+	 * at the third slot in the configuration table. We also need to
+	 * skip the chip ID entry at the start of the address space.
+	 */
+	engine_addr = engine_page_size * 3;
+	for (i = 2; i < engine_page_size / sizeof(uint32_t); i++) {
+		uint8_t slots, version, type, crc;
+		struct fsi_device *dev;
+
+		rc = fsi_slave_read(slave, (i + 1) * sizeof(conf),
+				&conf, sizeof(conf));
+		if (rc) {
+			dev_warn(&slave->dev,
+				"error reading slave registers\n");
+			return -1;
+		}
+
+		crc = crc_fsi(0, conf >> FSI_SLAVE_CONF_CRC_SHIFT,
+				FSI_SLAVE_CONF_DATA_BITS);
+		if (crc != (conf & FSI_SLAVE_CONF_CRC_MASK)) {
+			dev_warn(&slave->dev,
+				"crc error in slave register at 0x%04x\n",
+				i);
+			return -1;
+		}
+
+		slots = (conf & FSI_SLAVE_CONF_SLOTS_MASK)
+			>> FSI_SLAVE_CONF_SLOTS_SHIFT;
+		version = (conf & FSI_SLAVE_CONF_VERSION_MASK)
+			>> FSI_SLAVE_CONF_VERSION_SHIFT;
+		type = (conf & FSI_SLAVE_CONF_TYPE_MASK)
+			>> FSI_SLAVE_CONF_TYPE_SHIFT;
+
+		/*
+		 * Unused address areas are marked by a zero type value; this
+		 * skips the defined address areas
+		 */
+		if (type != 0) {
+
+			/* create device */
+			dev = fsi_create_device(slave);
+			if (!dev)
+				return -ENOMEM;
+
+			dev->slave = slave;
+			dev->engine_type = type;
+			dev->version = version;
+			dev->unit = i;
+			dev->addr = engine_addr;
+			dev->size = slots * engine_page_size;
+
+			dev_info(&slave->dev,
+			"engine[%i]: type %x, version %x, addr %x size %x\n",
+					dev->unit, dev->engine_type, version,
+					dev->addr, dev->size);
+
+			device_initialize(&dev->dev);
+			dev_set_name(&dev->dev, "%02x:%02x:%02x:%02x",
+					slave->master->idx, slave->link,
+					slave->id, i - 2);
+
+			rc = device_add(&dev->dev);
+			if (rc) {
+				dev_warn(&slave->dev, "add failed: %d\n", rc);
+				put_device(&dev->dev);
+			}
+		}
+
+		engine_addr += slots * engine_page_size;
+
+		if (!(conf & FSI_SLAVE_CONF_NEXT_MASK))
+			break;
+	}
+
+	return 0;
+}
+
 static void fsi_slave_release(struct device *dev)
 {
 	struct fsi_slave *slave = to_fsi_slave(dev);
@@ -91,7 +218,8 @@ static int fsi_slave_init(struct fsi_master *master,
 		return rc;
 	}
 
-	return rc;
+	fsi_slave_scan(slave);
+	return 0;
 }
 
 /* FSI master support */
diff --git a/include/linux/fsi.h b/include/linux/fsi.h
index 273cbf6..efa55ba 100644
--- a/include/linux/fsi.h
+++ b/include/linux/fsi.h
@@ -21,6 +21,10 @@ struct fsi_device {
 	struct device		dev;
 	u8			engine_type;
 	u8			version;
+	u8			unit;
+	struct fsi_slave	*slave;
+	uint32_t		addr;
+	uint32_t		size;
 };
 
 struct fsi_device_id {
-- 
1.8.2.2
