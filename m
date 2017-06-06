From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Tue,  6 Jun 2017 16:08:48 -0500
Subject: [PATCH v8 13/24] drivers/fsi: Add client driver register utilities
In-Reply-To: <20170606210859.80431-1-cbostic@linux.vnet.ibm.com>
References: <20170606210859.80431-1-cbostic@linux.vnet.ibm.com>
Message-ID: <20170606210859.80431-14-cbostic@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add driver_register and driver_unregister wrappers for FSI.

Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-core.c | 17 +++++++++++++++++
 include/linux/fsi.h    | 12 ++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index fcb0c81..e9fbd9f 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -586,6 +586,23 @@ static int fsi_bus_match(struct device *dev, struct device_driver *drv)
 	return 0;
 }
 
+int fsi_driver_register(struct fsi_driver *fsi_drv)
+{
+	if (!fsi_drv)
+		return -EINVAL;
+	if (!fsi_drv->id_table)
+		return -EINVAL;
+
+	return driver_register(&fsi_drv->drv);
+}
+EXPORT_SYMBOL_GPL(fsi_driver_register);
+
+void fsi_driver_unregister(struct fsi_driver *fsi_drv)
+{
+	driver_unregister(&fsi_drv->drv);
+}
+EXPORT_SYMBOL_GPL(fsi_driver_unregister);
+
 struct bus_type fsi_bus_type = {
 	.name		= "fsi",
 	.match		= fsi_bus_match,
diff --git a/include/linux/fsi.h b/include/linux/fsi.h
index 66bce48..34f1e9a 100644
--- a/include/linux/fsi.h
+++ b/include/linux/fsi.h
@@ -54,6 +54,18 @@ struct fsi_driver {
 #define to_fsi_dev(devp) container_of(devp, struct fsi_device, dev)
 #define to_fsi_drv(drvp) container_of(drvp, struct fsi_driver, drv)
 
+extern int fsi_driver_register(struct fsi_driver *fsi_drv);
+extern void fsi_driver_unregister(struct fsi_driver *fsi_drv);
+
+/* module_fsi_driver() - Helper macro for drivers that don't do
+ * anything special in module init/exit.  This eliminates a lot of
+ * boilerplate.  Each module may only use this macro once, and
+ * calling it replaces module_init() and module_exit()
+ */
+#define module_fsi_driver(__fsi_driver) \
+		module_driver(__fsi_driver, fsi_driver_register, \
+				fsi_driver_unregister)
+
 extern struct bus_type fsi_bus_type;
 
 #endif /* LINUX_FSI_H */
-- 
1.8.2.2
