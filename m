From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Thu, 11 May 2017 16:00:52 -0500
Subject: [PATCH v7 15/23] drivers/fsi: expose direct-access slave API
In-Reply-To: <20170511210101.78409-1-cbostic@linux.vnet.ibm.com>
References: <20170511210101.78409-1-cbostic@linux.vnet.ibm.com>
Message-ID: <20170511210101.78409-16-cbostic@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

Allow drivers to access the slave address ranges.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
---
 drivers/fsi/fsi-core.c | 26 ++++++++++++++++++++------
 include/linux/fsi.h    | 12 ++++++++++++
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 626cc06..d319f67 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -78,10 +78,6 @@ static int fsi_master_read(struct fsi_master *master, int link,
 		uint8_t slave_id, uint32_t addr, void *val, size_t size);
 static int fsi_master_write(struct fsi_master *master, int link,
 		uint8_t slave_id, uint32_t addr, const void *val, size_t size);
-static int fsi_slave_read(struct fsi_slave *slave, uint32_t addr,
-		void *val, size_t size);
-static int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
-		const void *val, size_t size);
 
 /*
  * fsi_device_read() / fsi_device_write() / fsi_device_peek()
@@ -174,7 +170,7 @@ static int fsi_slave_calc_addr(struct fsi_slave *slave, uint32_t *addrp,
 	return 0;
 }
 
-static int fsi_slave_read(struct fsi_slave *slave, uint32_t addr,
+int fsi_slave_read(struct fsi_slave *slave, uint32_t addr,
 			void *val, size_t size)
 {
 	uint8_t id = slave->id;
@@ -188,7 +184,7 @@ static int fsi_slave_read(struct fsi_slave *slave, uint32_t addr,
 			addr, val, size);
 }
 
-static int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
+int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
 			const void *val, size_t size)
 {
 	uint8_t id = slave->id;
@@ -202,6 +198,24 @@ static int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
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
