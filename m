From: christopher.lee.bostic@gmail.com (christopher.lee.bostic at gmail.com)
Date: Thu, 12 Jan 2017 16:34:09 -0600
Subject: [PATCH v2 13/18] drivers/fsi: Remove all scanned devices during
 master unregister
Message-ID: <1484260449-80182-1-git-send-email-christopher.lee.bostic@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Bostic <cbostic@us.ibm.com>

Master will remove all previously scanned devices during an
unregister operation. This will be necessary should any master
attempt to register more than once.

Signed-off-by: Chris Bostic <cbostic@us.ibm.com>

---

V2 - Remove list heads and explicit master device list management
     int the fsi master and fsi slave structs.  Instead utilize the
     device_for_each_child method already available.
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
