From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Wed,  1 Feb 2017 10:53:54 -0600
Subject: [PATCH v3 14/18] drivers/fsi: Remove all scanned devices during
 master unregister
In-Reply-To: <20170201165358.45415-1-cbostic@linux.vnet.ibm.com>
References: <20170201165358.45415-1-cbostic@linux.vnet.ibm.com>
Message-ID: <20170201165358.45415-15-cbostic@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Bostic <cbostic@us.ibm.com>

Master will remove all previously scanned devices during an
unregister operation. This will be necessary should any master
attempt to register more than once.

Signed-off-by: Chris Bostic <cbostic@us.ibm.com>
---
 drivers/fsi/fsi-core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index af7965f..28b82d1 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -428,12 +428,26 @@ int fsi_master_register(struct fsi_master *master)
 }
 EXPORT_SYMBOL_GPL(fsi_master_register);
 
+static int fsi_slave_device_remove(struct device *dev, void *data)
+{
+	put_device(dev);
+	return 0;
+}
+
+static int fsi_master_slave_remove(struct device *dev, void *data)
+{
+	device_for_each_child(dev, NULL, fsi_slave_device_remove);
+	device_unregister(dev);
+	return 0;
+}
+
 void fsi_master_unregister(struct fsi_master *master)
 {
 	if (!master || !master->dev)
 		return;
 
 	ida_simple_remove(&master_ida, master->idx);
+	device_for_each_child(master->dev, NULL, fsi_master_slave_remove);
 	put_device(master->dev);
 }
 EXPORT_SYMBOL_GPL(fsi_master_unregister);
-- 
1.8.2.2
