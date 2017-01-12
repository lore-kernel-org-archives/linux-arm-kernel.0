From: christopher.lee.bostic@gmail.com (christopher.lee.bostic at gmail.com)
Date: Thu, 12 Jan 2017 16:31:24 -0600
Subject: [PATCH v2 10/18] drivers/fsi: Add device read/write/peek functions
Message-ID: <1484260284-79797-1-git-send-email-christopher.lee.bostic@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

This change introduces the fsi device API: simple read, write and peek
accessors for the devices' address spaces.

Includes contributions from Chris Bostic <cbostic@us.ibm.com>

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Chris Bostic <cbostic@us.ibm.com>

---

V2 - Clean up white space.
---
 drivers/fsi/fsi-core.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fsi.h    |  6 ++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index f7ef993..3119aa1 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -35,6 +35,8 @@
 #define FSI_SLAVE_CONF_CRC_MASK		0x0000000f
 #define FSI_SLAVE_CONF_DATA_BITS	28
 
+#define FSI_PEEK_BASE			0x410
+
 static const int engine_page_size = 0x400;
 
 static DEFINE_IDA(master_ida);
@@ -48,8 +50,46 @@ struct fsi_slave {
 
 #define to_fsi_slave(d) container_of(d, struct fsi_slave, dev)
 
+static int fsi_slave_read(struct fsi_slave *slave, uint32_t addr,
+		void *val, size_t size);
+static int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
+		const void *val, size_t size);
+
 /* FSI endpoint-device support */
 
+int fsi_device_read(struct fsi_device *dev, uint32_t addr, void *val,
+		size_t size)
+{
+	if (addr > dev->size)
+		return -EINVAL;
+
+	if (addr + size > dev->size)
+		return -EINVAL;
+
+	return fsi_slave_read(dev->slave, dev->addr + addr, val, size);
+}
+EXPORT_SYMBOL_GPL(fsi_device_read);
+
+int fsi_device_write(struct fsi_device *dev, uint32_t addr, const void *val,
+		size_t size)
+{
+	if (addr > dev->size)
+		return -EINVAL;
+
+	if (addr + size > dev->size)
+		return -EINVAL;
+
+	return fsi_slave_write(dev->slave, dev->addr + addr, val, size);
+}
+EXPORT_SYMBOL_GPL(fsi_device_write);
+
+int fsi_device_peek(struct fsi_device *dev, void *val)
+{
+	uint32_t addr = FSI_PEEK_BASE + ((dev->unit - 2) * sizeof(uint32_t));
+
+	return fsi_slave_read(dev->slave, addr, val, sizeof(uint32_t));
+}
+
 static void fsi_device_release(struct device *_device)
 {
 	struct fsi_device *device = to_fsi_dev(_device);
@@ -81,6 +121,13 @@ static int fsi_slave_read(struct fsi_slave *slave, uint32_t addr,
 			slave->id, addr, val, size);
 }
 
+static int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
+			const void *val, size_t size)
+{
+	return slave->master->write(slave->master, slave->link,
+			slave->id, addr, val, size);
+}
+
 static int fsi_slave_scan(struct fsi_slave *slave)
 {
 	uint32_t engine_addr;
diff --git a/include/linux/fsi.h b/include/linux/fsi.h
index efa55ba..273945d 100644
--- a/include/linux/fsi.h
+++ b/include/linux/fsi.h
@@ -27,6 +27,12 @@ struct fsi_device {
 	uint32_t		size;
 };
 
+extern int fsi_device_read(struct fsi_device *dev, uint32_t addr,
+		void *val, size_t size);
+extern int fsi_device_write(struct fsi_device *dev, uint32_t addr,
+		const void *val, size_t size);
+extern int fsi_device_peek(struct fsi_device *dev, void *val);
+
 struct fsi_device_id {
 	u8	engine_type;
 	u8	version;
-- 
1.8.2.2
