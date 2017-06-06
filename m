From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Tue,  6 Jun 2017 16:08:44 -0500
Subject: [PATCH v8 09/24] drivers/fsi: scan slaves & register devices
In-Reply-To: <20170606210859.80431-1-cbostic@linux.vnet.ibm.com>
References: <20170606210859.80431-1-cbostic@linux.vnet.ibm.com>
Message-ID: <20170606210859.80431-10-cbostic@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

Now that we have fsi_slave devices, scan each for endpoints, and
register them on the fsi bus.

Includes contributions from Christopher Bostic
<cbostic@linux.vnet.ibm.com>.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-core.c | 128 ++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/fsi.h    |   4 ++
 2 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 04795f2..eac0bc4 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -19,9 +19,23 @@
 #include <linux/idr.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/bitops.h>
 
 #include "fsi-master.h"
 
+#define FSI_SLAVE_CONF_NEXT_MASK	GENMASK(31, 31)
+#define FSI_SLAVE_CONF_SLOTS_MASK	GENMASK(23, 16)
+#define FSI_SLAVE_CONF_SLOTS_SHIFT	16
+#define FSI_SLAVE_CONF_VERSION_MASK	GENMASK(15, 12)
+#define FSI_SLAVE_CONF_VERSION_SHIFT	12
+#define FSI_SLAVE_CONF_TYPE_MASK	GENMASK(11, 4)
+#define FSI_SLAVE_CONF_TYPE_SHIFT	4
+#define FSI_SLAVE_CONF_CRC_SHIFT	4
+#define FSI_SLAVE_CONF_CRC_MASK		GENMASK(3, 0)
+#define FSI_SLAVE_CONF_DATA_BITS	28
+
+static const int engine_page_size = 0x400;
+
 #define FSI_SLAVE_BASE			0x800
 
 /*
@@ -62,6 +76,30 @@ static int fsi_master_read(struct fsi_master *master, int link,
 static int fsi_master_write(struct fsi_master *master, int link,
 		uint8_t slave_id, uint32_t addr, const void *val, size_t size);
 
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
 static int fsi_slave_calc_addr(struct fsi_slave *slave, uint32_t *addrp,
 		uint8_t *idp)
@@ -115,6 +153,91 @@ static int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
 			addr, val, size);
 }
 
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
+		conf = be32_to_cpu(conf);
+
+		crc = crc4(0, conf, 32);
+		if (crc) {
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
+		if (type != 0 && slots != 0) {
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
+			dev_dbg(&slave->dev,
+			"engine[%i]: type %x, version %x, addr %x size %x\n",
+					dev->unit, dev->engine_type, version,
+					dev->addr, dev->size);
+
+			dev_set_name(&dev->dev, "%02x:%02x:%02x:%02x",
+					slave->master->idx, slave->link,
+					slave->id, i - 2);
+
+			rc = device_register(&dev->dev);
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
 /* Encode slave local bus echo delay */
 static inline uint32_t fsi_smode_echodly(int x)
 {
@@ -230,7 +353,10 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 		return rc;
 	}
 
-	/* todo: perform engine scan */
+	rc = fsi_slave_scan(slave);
+	if (rc)
+		dev_dbg(&master->dev, "failed during slave scan with: %d\n",
+				rc);
 
 	return rc;
 }
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
