From: christopher.lee.bostic@gmail.com (Chris Bostic)
Date: Tue,  6 Dec 2016 20:09:30 -0600
Subject: [PATCH 04/16] drivers/fsi: Add fsi master definition
Message-ID: <1481076574-54711-1-git-send-email-christopher.lee.bostic@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Chris Bostic <cbostic@us.ibm.com>
---
 drivers/fsi/fsi-core.c   | 20 ++++++++++++++++++++
 drivers/fsi/fsi-master.h | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 drivers/fsi/fsi-master.h

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 3d55bd5..ce9428d 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -17,6 +17,26 @@
 #include <linux/fsi.h>
 #include <linux/module.h>
 
+#include "fsi-master.h"
+
+static atomic_t master_idx = ATOMIC_INIT(-1);
+
+/* FSI master support */
+
+int fsi_master_register(struct fsi_master *master)
+{
+	master->idx = atomic_inc_return(&master_idx);
+	get_device(master->dev);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fsi_master_register);
+
+void fsi_master_unregister(struct fsi_master *master)
+{
+	put_device(master->dev);
+}
+EXPORT_SYMBOL_GPL(fsi_master_unregister);
+
 /* FSI core & Linux bus type definitions */
 
 static int fsi_bus_match(struct device *dev, struct device_driver *drv)
diff --git a/drivers/fsi/fsi-master.h b/drivers/fsi/fsi-master.h
new file mode 100644
index 0000000..e75a810
--- /dev/null
+++ b/drivers/fsi/fsi-master.h
@@ -0,0 +1,37 @@
+/*
+ * FSI master definitions. These comprise the core <--> master interface,
+ * to allow the core to interact with the (hardware-specific) masters.
+ *
+ * Copyright (C) IBM Corporation 2016
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef DRIVERS_FSI_MASTER_H
+#define DRIVERS_FSI_MASTER_H
+
+#include <linux/device.h>
+
+struct fsi_master {
+	struct device	*dev;
+	int		idx;
+	int		n_links;
+	int		(*read)(struct fsi_master *, int link,
+				uint8_t slave, uint32_t addr,
+				void *val, size_t size);
+	int		(*write)(struct fsi_master *, int link,
+				uint8_t slave, uint32_t addr,
+				const void *val, size_t size);
+};
+
+extern int fsi_master_register(struct fsi_master *master);
+extern void fsi_master_unregister(struct fsi_master *master);
+
+#endif /* DRIVERS_FSI_MASTER_H */
-- 
1.8.2.2
