From: christopher.lee.bostic@gmail.com (christopher.lee.bostic at gmail.com)
Date: Thu, 12 Jan 2017 16:24:14 -0600
Subject: [PATCH v2 03/18] drivers/fsi: Add fsi master definition
Message-ID: <1484259854-79127-1-git-send-email-christopher.lee.bostic@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Chris Bostic <cbostic@us.ibm.com>

---

V2 - Change atomic global keeping track of master number to ida
     simple interface.

   - Add valid pointer checks on entry to register and unregister.
---
 drivers/fsi/fsi-core.c   | 28 ++++++++++++++++++++++++++++
 drivers/fsi/fsi-master.h | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 drivers/fsi/fsi-master.h

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 3d55bd5..c7469fe 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -16,6 +16,34 @@
 #include <linux/device.h>
 #include <linux/fsi.h>
 #include <linux/module.h>
+#include <linux/idr.h>
+
+#include "fsi-master.h"
+
+static DEFINE_IDA(master_ida);
+
+/* FSI master support */
+
+int fsi_master_register(struct fsi_master *master)
+{
+	if (!master || !master->dev)
+		return -EINVAL;
+
+	master->idx = ida_simple_get(&master_ida, 0, 0, GFP_KERNEL);
+	get_device(master->dev);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fsi_master_register);
+
+void fsi_master_unregister(struct fsi_master *master)
+{
+	if (!master || !master->dev)
+		return;
+
+	ida_simple_remove(&master_ida, master->idx);
+	put_device(master->dev);
+}
+EXPORT_SYMBOL_GPL(fsi_master_unregister);
 
 /* FSI core & Linux bus type definitions */
 
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
