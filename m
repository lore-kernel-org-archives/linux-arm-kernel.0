From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Tue,  4 Apr 2017 21:05:55 -0500
Subject: [PATCH v5 11/23] drivers/fsi: Add master unscan
In-Reply-To: <20170405020607.79939-1-cbostic@linux.vnet.ibm.com>
References: <20170405020607.79939-1-cbostic@linux.vnet.ibm.com>
Message-ID: <20170405020607.79939-12-cbostic@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Bostic <cbostic@linux.vnet.ibm.com>

Allow a master to undo a previous scan.  Should a master scan a bus
twice it will need to ensure it doesn't double register any
previously detected device.

Signed-off-by: Chris Bostic <cbostic@linux.vnet.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-core.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 4da0b030..75d2a88 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -69,6 +69,7 @@ struct fsi_slave {
 	uint32_t		size;	/* size of slave address space */
 };
 
+#define to_fsi_master(d) container_of(d, struct fsi_master, dev)
 #define to_fsi_slave(d) container_of(d, struct fsi_slave, dev)
 
 static int fsi_master_read(struct fsi_master *master, int link,
@@ -491,6 +492,37 @@ static int fsi_master_scan(struct fsi_master *master)
 	return 0;
 }
 
+static int __fsi_slave_remove_device(struct device *dev, void *arg)
+{
+	device_unregister(dev);
+	return 0;
+}
+
+static int __fsi_master_remove_slave(struct device *dev, void *arg)
+{
+	device_for_each_child(dev, NULL, __fsi_slave_remove_device);
+	device_unregister(dev);
+	return 0;
+}
+
+static void fsi_master_unscan(struct fsi_master *master)
+{
+	device_for_each_child(&master->dev, NULL, __fsi_master_remove_slave);
+}
+
+static ssize_t master_rescan_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct fsi_master *master = to_fsi_master(dev);
+
+	fsi_master_unscan(master);
+	fsi_master_scan(master);
+
+	return count;
+}
+
+static DEVICE_ATTR(rescan, 0200, NULL, master_rescan_store);
+
 int fsi_master_register(struct fsi_master *master)
 {
 	int rc;
@@ -507,7 +539,15 @@ int fsi_master_register(struct fsi_master *master)
 		return rc;
 	}
 
+	rc = device_create_file(&master->dev, &dev_attr_rescan);
+	if (rc) {
+		device_unregister(&master->dev);
+		ida_simple_remove(&master_ida, master->idx);
+		return rc;
+	}
+
 	fsi_master_scan(master);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fsi_master_register);
-- 
1.8.2.2
