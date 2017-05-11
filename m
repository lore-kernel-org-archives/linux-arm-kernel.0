From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Thu, 11 May 2017 16:00:51 -0500
Subject: [PATCH v7 14/23] drivers/fsi: Add sysfs files for FSI master & slave
 accesses
In-Reply-To: <20170511210101.78409-1-cbostic@linux.vnet.ibm.com>
References: <20170511210101.78409-1-cbostic@linux.vnet.ibm.com>
Message-ID: <20170511210101.78409-15-cbostic@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

This change adds a 'raw' file for reads & writes, and a 'term' file for
the TERM command, and a 'break' file for issuing a BREAK.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
---
 drivers/fsi/fsi-core.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index e9fbd9f..626cc06 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -287,6 +287,95 @@ static int fsi_slave_scan(struct fsi_slave *slave)
 	return 0;
 }
 
+static ssize_t fsi_slave_sysfs_raw_read(struct file *file,
+		struct kobject *kobj, struct bin_attribute *attr, char *buf,
+		loff_t off, size_t count)
+{
+	struct fsi_slave *slave = to_fsi_slave(kobj_to_dev(kobj));
+	size_t total_len, read_len;
+	int rc;
+
+	if (off < 0)
+		return -EINVAL;
+
+	if (off > 0xffffffff || count > 0xffffffff || off + count > 0xffffffff)
+		return -EINVAL;
+
+	for (total_len = 0; total_len < count; total_len += read_len) {
+		read_len = min_t(size_t, count, 4);
+		read_len -= off & 0x3;
+
+		rc = fsi_slave_read(slave, off, buf + total_len, read_len);
+		if (rc)
+			return rc;
+
+		off += read_len;
+	}
+
+	return count;
+}
+
+static ssize_t fsi_slave_sysfs_raw_write(struct file *file,
+		struct kobject *kobj, struct bin_attribute *attr,
+		char *buf, loff_t off, size_t count)
+{
+	struct fsi_slave *slave = to_fsi_slave(kobj_to_dev(kobj));
+	size_t total_len, write_len;
+	int rc;
+
+	if (off < 0)
+		return -EINVAL;
+
+	if (off > 0xffffffff || count > 0xffffffff || off + count > 0xffffffff)
+		return -EINVAL;
+
+	for (total_len = 0; total_len < count; total_len += write_len) {
+		write_len = min_t(size_t, count, 4);
+		write_len -= off & 0x3;
+
+		rc = fsi_slave_write(slave, off, buf + total_len, write_len);
+		if (rc)
+			return rc;
+
+		off += write_len;
+	}
+
+	return count;
+}
+
+static struct bin_attribute fsi_slave_raw_attr = {
+	.attr = {
+		.name = "raw",
+		.mode = 0600,
+	},
+	.size = 0,
+	.read = fsi_slave_sysfs_raw_read,
+	.write = fsi_slave_sysfs_raw_write,
+};
+
+static ssize_t fsi_slave_sysfs_term_write(struct file *file,
+		struct kobject *kobj, struct bin_attribute *attr,
+		char *buf, loff_t off, size_t count)
+{
+	struct fsi_slave *slave = to_fsi_slave(kobj_to_dev(kobj));
+	struct fsi_master *master = slave->master;
+
+	if (!master->term)
+		return -ENODEV;
+
+	master->term(master, slave->link, slave->id);
+	return count;
+}
+
+static struct bin_attribute fsi_slave_term_attr = {
+	.attr = {
+		.name = "term",
+		.mode = 0200,
+	},
+	.size = 0,
+	.write = fsi_slave_sysfs_term_write,
+};
+
 /* Encode slave local bus echo delay */
 static inline uint32_t fsi_smode_echodly(int x)
 {
@@ -402,6 +491,14 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 		return rc;
 	}
 
+	rc = device_create_bin_file(&slave->dev, &fsi_slave_raw_attr);
+	if (rc)
+		dev_warn(&slave->dev, "failed to create raw attr: %d\n", rc);
+
+	rc = device_create_bin_file(&slave->dev, &fsi_slave_term_attr);
+	if (rc)
+		dev_warn(&slave->dev, "failed to create term attr: %d\n", rc);
+
 	rc = fsi_slave_scan(slave);
 	if (rc)
 		dev_dbg(&master->dev, "failed during slave scan with: %d\n",
@@ -523,6 +620,18 @@ static ssize_t master_rescan_store(struct device *dev,
 
 static DEVICE_ATTR(rescan, 0200, NULL, master_rescan_store);
 
+static ssize_t master_break_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct fsi_master *master = to_fsi_master(dev);
+
+	fsi_master_break(master, 0);
+
+	return count;
+}
+
+static DEVICE_ATTR(break, 0200, NULL, master_break_store);
+
 int fsi_master_register(struct fsi_master *master)
 {
 	int rc;
@@ -546,6 +655,13 @@ int fsi_master_register(struct fsi_master *master)
 		return rc;
 	}
 
+	rc = device_create_file(&master->dev, &dev_attr_break);
+	if (rc) {
+		device_unregister(&master->dev);
+		ida_simple_remove(&master_ida, master->idx);
+		return rc;
+	}
+
 	fsi_master_scan(master);
 
 	return 0;
-- 
1.8.2.2
