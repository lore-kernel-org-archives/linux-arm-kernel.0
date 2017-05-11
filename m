From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Thu, 11 May 2017 16:00:42 -0500
Subject: [PATCH v7 05/23] drivers/fsi: Add slave & master read/write APIs
In-Reply-To: <20170511210101.78409-1-cbostic@linux.vnet.ibm.com>
References: <20170511210101.78409-1-cbostic@linux.vnet.ibm.com>
Message-ID: <20170511210101.78409-6-cbostic@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

Introduce functions to perform reads/writes on the slave address space;
these simply pass the request on the slave's master with the correct
link and slave ID.

We implement these on top of similar helpers for the master.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Chris Bostic <cbostic@linux.vnet.ibm.com>
---
 drivers/fsi/fsi-core.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index e90d45d..1ec9790 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -32,7 +32,64 @@ struct fsi_slave {
 
 #define to_fsi_slave(d) container_of(d, struct fsi_slave, dev)
 
+static int fsi_master_read(struct fsi_master *master, int link,
+		uint8_t slave_id, uint32_t addr, void *val, size_t size);
+static int fsi_master_write(struct fsi_master *master, int link,
+		uint8_t slave_id, uint32_t addr, const void *val, size_t size);
+
 /* FSI slave support */
+static int fsi_slave_calc_addr(struct fsi_slave *slave, uint32_t *addrp,
+		uint8_t *idp)
+{
+	uint32_t addr = *addrp;
+	uint8_t id = *idp;
+
+	if (addr > slave->size)
+		return -EINVAL;
+
+	/* For 23 bit addressing, we encode the extra two bits in the slave
+	 * id (and the slave's actual ID needs to be 0).
+	 */
+	if (addr > 0x1fffff) {
+		if (slave->id != 0)
+			return -EINVAL;
+		id = (addr >> 21) & 0x3;
+		addr &= 0x1fffff;
+	}
+
+	*addrp = addr;
+	*idp = id;
+	return 0;
+}
+
+static int fsi_slave_read(struct fsi_slave *slave, uint32_t addr,
+			void *val, size_t size)
+{
+	uint8_t id = slave->id;
+	int rc;
+
+	rc = fsi_slave_calc_addr(slave, &addr, &id);
+	if (rc)
+		return rc;
+
+	return fsi_master_read(slave->master, slave->link, id,
+			addr, val, size);
+}
+
+static int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
+			const void *val, size_t size)
+{
+	uint8_t id = slave->id;
+	int rc;
+
+	rc = fsi_slave_calc_addr(slave, &addr, &id);
+	if (rc)
+		return rc;
+
+	return fsi_master_write(slave->master, slave->link, id,
+			addr, val, size);
+}
+
 static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 {
 	/* todo: initialise slave device, perform engine scan */
@@ -41,6 +98,41 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 }
 
 /* FSI master support */
+static int fsi_check_access(uint32_t addr, size_t size)
+{
+	if (size != 1 && size != 2 && size != 4)
+		return -EINVAL;
+
+	if ((addr & 0x3) != (size & 0x3))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int fsi_master_read(struct fsi_master *master, int link,
+		uint8_t slave_id, uint32_t addr, void *val, size_t size)
+{
+	int rc;
+
+	rc = fsi_check_access(addr, size);
+	if (rc)
+		return rc;
+
+	return master->read(master, link, slave_id, addr, val, size);
+}
+
+static int fsi_master_write(struct fsi_master *master, int link,
+		uint8_t slave_id, uint32_t addr, const void *val, size_t size)
+{
+	int rc;
+
+	rc = fsi_check_access(addr, size);
+	if (rc)
+		return rc;
+
+	return master->write(master, link, slave_id, addr, val, size);
+}
+
 static int fsi_master_scan(struct fsi_master *master)
 {
 	int link;
-- 
1.8.2.2
