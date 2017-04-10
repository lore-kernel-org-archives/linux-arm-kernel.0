From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Mon, 10 Apr 2017 14:46:58 -0500
Subject: [PATCH v6 15/23] drivers/fsi: expose direct-access slave API
In-Reply-To: <20170410194706.64280-1-cbostic@linux.vnet.ibm.com>
References: <20170410194706.64280-1-cbostic@linux.vnet.ibm.com>
Message-ID: <20170410194706.64280-16-cbostic@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

Allow drivers to access the slave address ranges.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Chris Bostic <cbostic@linux.vnet.ibm.com>
---
 drivers/fsi/fsi-core.c | 26 ++++++++++++++++++++------
 include/linux/fsi.h    | 12 ++++++++++++
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index f0f0556..f7e55e7 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -76,10 +76,6 @@ static int fsi_master_read(struct fsi_master *master, int link,
 		uint8_t slave_id, uint32_t addr, void *val, size_t size);
 static int fsi_master_write(struct fsi_master *master, int link,
 		uint8_t slave_id, uint32_t addr, const void *val, size_t size);
-static int fsi_slave_read(struct fsi_slave *slave, uint32_t addr,
-		void *val, size_t size);
-static int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
-		const void *val, size_t size);
 
 /* FSI endpoint-device support */
 
@@ -181,7 +177,7 @@ static int fsi_slave_calc_addr(struct fsi_slave *slave, uint32_t *addrp,
 	return 0;
 }
 
-static int fsi_slave_read(struct fsi_slave *slave, uint32_t addr,
+int fsi_slave_read(struct fsi_slave *slave, uint32_t addr,
 			void *val, size_t size)
 {
 	uint8_t id = slave->id;
@@ -195,7 +191,7 @@ static int fsi_slave_read(struct fsi_slave *slave, uint32_t addr,
 			addr, val, size);
 }
 
-static int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
+int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
 			const void *val, size_t size)
 {
 	uint8_t id = slave->id;
@@ -209,6 +205,24 @@ static int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
 			addr, val, size);
 }
 
+extern int fsi_slave_claim_range(struct fsi_slave *slave,
+		uint32_t addr, uint32_t size)
+{
+	if (addr + size < addr)
+		return -EINVAL;
+
+	if (addr + size > slave->size)
+		return -EINVAL;
+
+	/* todo: check for overlapping claims */
+	return 0;
+}
+
+extern void fsi_slave_release_range(struct fsi_slave *slave,
+		uint32_t addr, uint32_t size)
+{
+}
+
 static int fsi_slave_scan(struct fsi_slave *slave)
 {
 	uint32_t engine_addr;
diff --git a/include/linux/fsi.h b/include/linux/fsi.h
index 34f1e9a..141fd38 100644
--- a/include/linux/fsi.h
+++ b/include/linux/fsi.h
@@ -66,6 +66,18 @@ struct fsi_driver {
 		module_driver(__fsi_driver, fsi_driver_register, \
 				fsi_driver_unregister)
 
+/* direct slave API */
+extern int fsi_slave_claim_range(struct fsi_slave *slave,
+		uint32_t addr, uint32_t size);
+extern void fsi_slave_release_range(struct fsi_slave *slave,
+		uint32_t addr, uint32_t size);
+extern int fsi_slave_read(struct fsi_slave *slave, uint32_t addr,
+		void *val, size_t size);
+extern int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
+		const void *val, size_t size);
+
+
+
 extern struct bus_type fsi_bus_type;
 
 #endif /* LINUX_FSI_H */
-- 
1.8.2.2
