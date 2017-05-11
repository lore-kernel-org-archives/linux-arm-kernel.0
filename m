From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Thu, 11 May 2017 16:00:40 -0500
Subject: [PATCH v7 03/23] drivers/fsi: Add empty master scan
In-Reply-To: <20170511210101.78409-1-cbostic@linux.vnet.ibm.com>
References: <20170511210101.78409-1-cbostic@linux.vnet.ibm.com>
Message-ID: <20170511210101.78409-4-cbostic@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

When a new fsi master is added, we will need to scan its links, and
slaves attached to those links. This change introduces a little shell to
iterate the links, which we will populate with the actual slave scan in
a later change.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Chris Bostic <cbostic@linux.vnet.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-core.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 2f19509..e90d45d 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -32,7 +32,25 @@ struct fsi_slave {
 
 #define to_fsi_slave(d) container_of(d, struct fsi_slave, dev)
 
+/* FSI slave support */
+static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
+{
+	/* todo: initialise slave device, perform engine scan */
+
+	return -ENODEV;
+}
+
 /* FSI master support */
+static int fsi_master_scan(struct fsi_master *master)
+{
+	int link;
+
+	for (link = 0; link < master->n_links; link++)
+		fsi_slave_init(master, link, 0);
+
+	return 0;
+}
+
 int fsi_master_register(struct fsi_master *master)
 {
 	int rc;
@@ -44,10 +62,13 @@ int fsi_master_register(struct fsi_master *master)
 	dev_set_name(&master->dev, "fsi%d", master->idx);
 
 	rc = device_register(&master->dev);
-	if (rc)
+	if (rc) {
 		ida_simple_remove(&master_ida, master->idx);
+		return rc;
+	}
 
-	return rc;
+	fsi_master_scan(master);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(fsi_master_register);
 
-- 
1.8.2.2
