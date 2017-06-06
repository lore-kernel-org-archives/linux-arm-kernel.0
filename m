From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Tue,  6 Jun 2017 16:08:46 -0500
Subject: [PATCH v8 11/24] drivers/fsi: Add master unscan
In-Reply-To: <20170606210859.80431-1-cbostic@linux.vnet.ibm.com>
References: <20170606210859.80431-1-cbostic@linux.vnet.ibm.com>
Message-ID: <20170606210859.80431-12-cbostic@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow a master to undo a previous scan.  Should a master scan a bus
twice it will need to ensure it doesn't double register any
previously detected device.

Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
----
v7 - Unscan when unregistering master
   - Remove leading '__'s from function names
   - Return fail state for sysfs rescan file
---
 drivers/fsi/fsi-core.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index d7a6e76..fcb0c81 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -71,6 +71,7 @@ struct fsi_slave {
 	uint32_t		size;	/* size of slave address space */
 };
 
+#define to_fsi_master(d) container_of(d, struct fsi_master, dev)
 #define to_fsi_slave(d) container_of(d, struct fsi_slave, dev)
 
 static int fsi_master_read(struct fsi_master *master, int link,
@@ -488,6 +489,40 @@ static int fsi_master_scan(struct fsi_master *master)
 	return 0;
 }
 
+static int fsi_slave_remove_device(struct device *dev, void *arg)
+{
+	device_unregister(dev);
+	return 0;
+}
+
+static int fsi_master_remove_slave(struct device *dev, void *arg)
+{
+	device_for_each_child(dev, NULL, fsi_slave_remove_device);
+	device_unregister(dev);
+	return 0;
+}
+
+static void fsi_master_unscan(struct fsi_master *master)
+{
+	device_for_each_child(&master->dev, NULL, fsi_master_remove_slave);
+}
+
+static ssize_t master_rescan_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct fsi_master *master = to_fsi_master(dev);
+	int rc;
+
+	fsi_master_unscan(master);
+	rc = fsi_master_scan(master);
+	if (rc < 0)
+		return rc;
+
+	return count;
+}
+
+static DEVICE_ATTR(rescan, 0200, NULL, master_rescan_store);
+
 int fsi_master_register(struct fsi_master *master)
 {
 	int rc;
@@ -504,7 +539,15 @@ int fsi_master_register(struct fsi_master *master)
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
@@ -516,6 +559,7 @@ void fsi_master_unregister(struct fsi_master *master)
 		master->idx = -1;
 	}
 
+	fsi_master_unscan(master);
 	device_unregister(&master->dev);
 }
 EXPORT_SYMBOL_GPL(fsi_master_unregister);
-- 
1.8.2.2
