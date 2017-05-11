From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Thu, 11 May 2017 16:00:47 -0500
Subject: [PATCH v7 10/23] drivers/fsi: Add device read/write/peek API
In-Reply-To: <20170511210101.78409-1-cbostic@linux.vnet.ibm.com>
References: <20170511210101.78409-1-cbostic@linux.vnet.ibm.com>
Message-ID: <20170511210101.78409-11-cbostic@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

This change introduces the fsi device API: simple read, write and peek
accessors for the devices' address spaces.

Includes contributions from Christopher Bostic
<cbostic@linux.vnet.ibm.com> and Edward A. James <eajames@us.ibm.com>.

Signed-off-by: Edward A. James <eajames@us.ibm.com>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v7 - Add API details for fsi_device_read/write/peek().
---
 drivers/fsi/fsi-core.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/fsi.h    |  7 ++++++-
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index eac0bc4..d7a6e76 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -34,6 +34,8 @@
 #define FSI_SLAVE_CONF_CRC_MASK		GENMASK(3, 0)
 #define FSI_SLAVE_CONF_DATA_BITS	28
 
+#define FSI_PEEK_BASE			0x410
+
 static const int engine_page_size = 0x400;
 
 #define FSI_SLAVE_BASE			0x800
@@ -75,8 +77,54 @@ static int fsi_master_read(struct fsi_master *master, int link,
 		uint8_t slave_id, uint32_t addr, void *val, size_t size);
 static int fsi_master_write(struct fsi_master *master, int link,
 		uint8_t slave_id, uint32_t addr, const void *val, size_t size);
+static int fsi_slave_read(struct fsi_slave *slave, uint32_t addr,
+		void *val, size_t size);
+static int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
+		const void *val, size_t size);
+
+/*
+ * fsi_device_read() / fsi_device_write() / fsi_device_peek()
+ *
+ * FSI endpoint-device support
+ *
+ * Read / write / peek accessors for a client
+ *
+ * Parameters:
+ * dev:  Structure passed to FSI client device drivers on probe().
+ * addr: FSI address of given device.  Client should pass in its base address
+ *       plus desired offset to access its register space.
+ * val:  For read/peek this is the value read at the specified address. For
+ *       write this is value to write to the specified address.
+ *       The data in val must be FSI bus endian (big endian).
+ * size: Size in bytes of the operation.  Sizes supported are 1, 2 and 4 bytes.
+ *       Addresses must be aligned on size boundaries or an error will result.
+ */
+int fsi_device_read(struct fsi_device *dev, uint32_t addr, void *val,
+		size_t size)
+{
+	if (addr > dev->size || size > dev->size || addr > dev->size - size)
+		return -EINVAL;
 
-/* FSI endpoint-device support */
+	return fsi_slave_read(dev->slave, dev->addr + addr, val, size);
+}
+EXPORT_SYMBOL_GPL(fsi_device_read);
+
+int fsi_device_write(struct fsi_device *dev, uint32_t addr, const void *val,
+		size_t size)
+{
+	if (addr > dev->size || size > dev->size || addr > dev->size - size)
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
 
 static void fsi_device_release(struct device *_device)
 {
diff --git a/include/linux/fsi.h b/include/linux/fsi.h
index efa55ba..66bce48 100644
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
@@ -40,7 +46,6 @@ struct fsi_device_id {
 #define FSI_DEVICE_VERSIONED(t, v) \
 	.engine_type = (t), .version = (v),
 
-
 struct fsi_driver {
 	struct device_driver		drv;
 	const struct fsi_device_id	*id_table;
-- 
1.8.2.2
