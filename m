From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Tue,  6 Jun 2017 16:08:36 -0500
Subject: [PATCH v8 01/24] drivers/fsi: Add fsi master definition
In-Reply-To: <20170606210859.80431-1-cbostic@linux.vnet.ibm.com>
References: <20170606210859.80431-1-cbostic@linux.vnet.ibm.com>
Message-ID: <20170606210859.80431-2-cbostic@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

Add a `struct fsi_master` to represent a FSI master controller.

FSI master drivers register one of these structs to provide
device-specific of the standard operations: read/write/term/break and
link control.

Includes changes from Edward A. James <eajames@us.ibm.com> & Jeremy Kerr
<jk@ozlabs.org>.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Chris Bostic <cbostic@linux.vnet.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-core.c   | 35 +++++++++++++++++++++++++++++++++++
 drivers/fsi/fsi-master.h | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 drivers/fsi/fsi-master.h

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 3d55bd5..ca02913 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -15,8 +15,43 @@
 
 #include <linux/device.h>
 #include <linux/fsi.h>
+#include <linux/idr.h>
 #include <linux/module.h>
 
+#include "fsi-master.h"
+
+static DEFINE_IDA(master_ida);
+
+/* FSI master support */
+int fsi_master_register(struct fsi_master *master)
+{
+	int rc;
+
+	if (!master)
+		return -EINVAL;
+
+	master->idx = ida_simple_get(&master_ida, 0, INT_MAX, GFP_KERNEL);
+	dev_set_name(&master->dev, "fsi%d", master->idx);
+
+	rc = device_register(&master->dev);
+	if (rc)
+		ida_simple_remove(&master_ida, master->idx);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(fsi_master_register);
+
+void fsi_master_unregister(struct fsi_master *master)
+{
+	if (master->idx >= 0) {
+		ida_simple_remove(&master_ida, master->idx);
+		master->idx = -1;
+	}
+
+	device_unregister(&master->dev);
+}
+EXPORT_SYMBOL_GPL(fsi_master_unregister);
+
 /* FSI core & Linux bus type definitions */
 
 static int fsi_bus_match(struct device *dev, struct device_driver *drv)
diff --git a/drivers/fsi/fsi-master.h b/drivers/fsi/fsi-master.h
new file mode 100644
index 0000000..7764b00
--- /dev/null
+++ b/drivers/fsi/fsi-master.h
@@ -0,0 +1,41 @@
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
+	struct device	dev;
+	int		idx;
+	int		n_links;
+	int		flags;
+	int		(*read)(struct fsi_master *, int link, uint8_t id,
+				uint32_t addr, void *val, size_t size);
+	int		(*write)(struct fsi_master *, int link, uint8_t id,
+				uint32_t addr, const void *val, size_t size);
+	int		(*term)(struct fsi_master *, int link, uint8_t id);
+	int		(*send_break)(struct fsi_master *, int link);
+	int		(*link_enable)(struct fsi_master *, int link);
+};
+
+#define dev_to_fsi_master(d) container_of(d, struct fsi_master, dev)
+
+extern int fsi_master_register(struct fsi_master *master);
+extern void fsi_master_unregister(struct fsi_master *master);
+
+#endif /* DRIVERS_FSI_MASTER_H */
-- 
1.8.2.2
