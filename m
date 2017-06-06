From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Tue,  6 Jun 2017 16:08:52 -0500
Subject: [PATCH v8 17/24] drivers/fsi: Add error handling for slave
In-Reply-To: <20170606210859.80431-1-cbostic@linux.vnet.ibm.com>
References: <20170606210859.80431-1-cbostic@linux.vnet.ibm.com>
Message-ID: <20170606210859.80431-18-cbostic@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

This change implements error handling in the FSI core, by cleaining up
and retrying failed operations, using the SISC, TERM and BREAK
facilities.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
---
 drivers/fsi/fsi-core.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 114 insertions(+), 7 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index db54561..c9ff8d3 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -46,7 +46,9 @@
 /*
  * FSI slave engine control register offsets
  */
-#define FSI_SMODE			0x0	/* R/W: Mode register */
+#define FSI_SMODE		0x0	/* R/W: Mode register */
+#define FSI_SISC		0x8	/* R/W: Interrupt condition */
+#define FSI_SSTAT		0x14	/* R  : Slave status */
 
 /*
  * SMODE fields
@@ -77,10 +79,14 @@ struct fsi_slave {
 #define to_fsi_master(d) container_of(d, struct fsi_master, dev)
 #define to_fsi_slave(d) container_of(d, struct fsi_slave, dev)
 
+static const int slave_retries = 2;
+static int discard_errors;
+
 static int fsi_master_read(struct fsi_master *master, int link,
 		uint8_t slave_id, uint32_t addr, void *val, size_t size);
 static int fsi_master_write(struct fsi_master *master, int link,
 		uint8_t slave_id, uint32_t addr, const void *val, size_t size);
+static int fsi_master_break(struct fsi_master *master, int link);
 
 /*
  * fsi_device_read() / fsi_device_write() / fsi_device_peek()
@@ -173,18 +179,107 @@ static int fsi_slave_calc_addr(struct fsi_slave *slave, uint32_t *addrp,
 	return 0;
 }
 
+int fsi_slave_report_and_clear_errors(struct fsi_slave *slave)
+{
+	struct fsi_master *master = slave->master;
+	uint32_t irq, stat;
+	int rc, link;
+	uint8_t id;
+
+	link = slave->link;
+	id = slave->id;
+
+	rc = fsi_master_read(master, link, id, FSI_SLAVE_BASE + FSI_SISC,
+			&irq, sizeof(irq));
+	if (rc)
+		return rc;
+
+	rc =  fsi_master_read(master, link, id, FSI_SLAVE_BASE + FSI_SSTAT,
+			&stat, sizeof(stat));
+	if (rc)
+		return rc;
+
+	dev_info(&slave->dev, "status: 0x%08x, sisc: 0x%08x\n",
+			be32_to_cpu(stat), be32_to_cpu(irq));
+
+	/* clear interrupts */
+	return fsi_master_write(master, link, id, FSI_SLAVE_BASE + FSI_SISC,
+			&irq, sizeof(irq));
+}
+
+static int fsi_slave_set_smode(struct fsi_master *master, int link, int id);
+
+int fsi_slave_handle_error(struct fsi_slave *slave, bool write, uint32_t addr,
+		size_t size)
+{
+	struct fsi_master *master = slave->master;
+	int rc, link;
+	uint32_t reg;
+	uint8_t id;
+
+	if (discard_errors)
+		return -1;
+
+	link = slave->link;
+	id = slave->id;
+
+	dev_dbg(&slave->dev, "handling error on %s to 0x%08x[%zd]",
+			write ? "write" : "read", addr, size);
+
+	/* try a simple clear of error conditions, which may fail if we've lost
+	 * communication with the slave
+	 */
+	rc = fsi_slave_report_and_clear_errors(slave);
+	if (!rc)
+		return 0;
+
+	/* send a TERM and retry */
+	if (master->term) {
+		rc = master->term(master, link, id);
+		if (!rc) {
+			rc = fsi_master_read(master, link, id, 0,
+					&reg, sizeof(reg));
+			if (!rc)
+				rc = fsi_slave_report_and_clear_errors(slave);
+			if (!rc)
+				return 0;
+		}
+	}
+
+	/* getting serious, reset the slave via BREAK */
+	rc = fsi_master_break(master, link);
+	if (rc)
+		return rc;
+
+	rc = fsi_slave_set_smode(master, link, id);
+	if (rc)
+		return rc;
+
+	return fsi_slave_report_and_clear_errors(slave);
+}
+
 int fsi_slave_read(struct fsi_slave *slave, uint32_t addr,
 			void *val, size_t size)
 {
 	uint8_t id = slave->id;
-	int rc;
+	int rc, err_rc, i;
 
 	rc = fsi_slave_calc_addr(slave, &addr, &id);
 	if (rc)
 		return rc;
 
-	return fsi_master_read(slave->master, slave->link, id,
-			addr, val, size);
+	for (i = 0; i < slave_retries; i++) {
+		rc = fsi_master_read(slave->master, slave->link,
+				id, addr, val, size);
+		if (!rc)
+			break;
+
+		err_rc = fsi_slave_handle_error(slave, false, addr, size);
+		if (err_rc)
+			break;
+	}
+
+	return rc;
 }
 EXPORT_SYMBOL_GPL(fsi_slave_read);
 
@@ -192,14 +287,24 @@ int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
 			const void *val, size_t size)
 {
 	uint8_t id = slave->id;
-	int rc;
+	int rc, err_rc, i;
 
 	rc = fsi_slave_calc_addr(slave, &addr, &id);
 	if (rc)
 		return rc;
 
-	return fsi_master_write(slave->master, slave->link, id,
-			addr, val, size);
+	for (i = 0; i < slave_retries; i++) {
+		rc = fsi_master_write(slave->master, slave->link,
+				id, addr, val, size);
+		if (!rc)
+			break;
+
+		err_rc = fsi_slave_handle_error(slave, true, addr, size);
+		if (err_rc)
+			break;
+	}
+
+	return rc;
 }
 EXPORT_SYMBOL_GPL(fsi_slave_write);
 
@@ -770,3 +875,5 @@ static void fsi_exit(void)
 
 module_init(fsi_init);
 module_exit(fsi_exit);
+module_param(discard_errors, int, 0664);
+MODULE_PARM_DESC(discard_errors, "Don't invoke error handling on bus accesses");
-- 
1.8.2.2
