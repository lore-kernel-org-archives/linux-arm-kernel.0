From: christopher.lee.bostic@gmail.com (christopher.lee.bostic at gmail.com)
Date: Thu, 12 Jan 2017 16:26:26 -0600
Subject: [PATCH v2 05/18] drivers/fsi: Add empty master scan
Message-ID: <1484259986-79248-1-git-send-email-christopher.lee.bostic@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

When a new fsi master is added, we will need to scan its links, and
slaves attached to those links. This change introduces a little shell to
iterate the links, which we will populate with the actual slave scan in
a later change.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Chris Bostic <cbostic@us.ibm.com>
---
 drivers/fsi/fsi-core.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 78d9c558..3160c1c 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -20,6 +20,8 @@
 
 #include "fsi-master.h"
 
+#define FSI_N_SLAVES	4
+
 static DEFINE_IDA(master_ida);
 
 struct fsi_slave {
@@ -31,8 +33,29 @@ struct fsi_slave {
 
 #define to_fsi_slave(d) container_of(d, struct fsi_slave, dev)
 
+/* FSI slave support */
+static int fsi_slave_init(struct fsi_master *master,
+		int link, uint8_t slave_id)
+{
+	/* todo: initialise slave device, perform engine scan */
+
+	return -ENODEV;
+}
+
 /* FSI master support */
 
+static int fsi_master_scan(struct fsi_master *master)
+{
+	int link, slave_id;
+
+	for (link = 0; link < master->n_links; link++)
+		for (slave_id = 0; slave_id < FSI_N_SLAVES; slave_id++)
+			fsi_slave_init(master, link, slave_id);
+
+	return 0;
+
+}
+
 int fsi_master_register(struct fsi_master *master)
 {
 	if (!master || !master->dev)
@@ -40,6 +63,7 @@ int fsi_master_register(struct fsi_master *master)
 
 	master->idx = ida_simple_get(&master_ida, 0, 0, GFP_KERNEL);
 	get_device(master->dev);
+	fsi_master_scan(master);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fsi_master_register);
-- 
1.8.2.2
