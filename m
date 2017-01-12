From: christopher.lee.bostic@gmail.com (christopher.lee.bostic at gmail.com)
Date: Thu, 12 Jan 2017 16:33:30 -0600
Subject: [PATCH v2 12/18] drivers/fsi: Set slave SMODE to init communication
Message-ID: <1484260410-80123-1-git-send-email-christopher.lee.bostic@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Bostic <cbostic@us.ibm.com>

Set CFAM to appropriate ID so that the controlling master
can manage link memory ranges.  Add slave engine register
definitions.

Signed-off-by: Chris Bostic <cbostic@us.ibm.com>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---
 drivers/fsi/fsi-core.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index b2c9274..af7965f 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -36,6 +36,7 @@
 #define FSI_SLAVE_CONF_DATA_BITS	28
 
 #define FSI_PEEK_BASE			0x410
+#define	FSI_SLAVE_BASE			0x800
 
 static const int engine_page_size = 0x400;
 
@@ -55,8 +56,26 @@ static int fsi_slave_read(struct fsi_slave *slave, uint32_t addr,
 static int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
 		const void *val, size_t size);
 
-/* FSI endpoint-device support */
+/*
+ * FSI slave engine control register offsets
+ */
+#define	FSI_SMODE		0x0	/* R/W: Mode register */
+
+/*
+ * SMODE fields
+ */
+#define	FSI_SMODE_WSC		0x80000000	/* Warm start done */
+#define	FSI_SMODE_ECRC		0x20000000	/* Hw CRC check */
+#define	FSI_SMODE_SID_SHIFT	24		/* ID shift */
+#define	FSI_SMODE_SID_MASK	3		/* ID Mask */
+#define	FSI_SMODE_ED_SHIFT	20		/* Echo delay shift */
+#define	FSI_SMODE_ED_MASK	0xf		/* Echo delay mask */
+#define	FSI_SMODE_SD_SHIFT	16		/* Send delay shift */
+#define	FSI_SMODE_SD_MASK	0xf		/* Send delay mask */
+#define	FSI_SMODE_LBCRR_SHIFT	8		/* Clk ratio shift */
+#define	FSI_SMODE_LBCRR_MASK	0xf		/* Clk ratio mask */
 
+/* FSI endpoint-device support */
 int fsi_device_read(struct fsi_device *dev, uint32_t addr, void *val,
 		size_t size)
 {
@@ -114,6 +133,30 @@ static struct fsi_device *fsi_create_device(struct fsi_slave *slave)
 
 /* FSI slave support */
 
+/* Encode slave local bus echo delay */
+static inline uint32_t fsi_smode_echodly(int x)
+{
+	return (x & FSI_SMODE_ED_MASK) << FSI_SMODE_ED_SHIFT;
+}
+
+/* Encode slave local bus send delay */
+static inline uint32_t fsi_smode_senddly(int x)
+{
+	return (x & FSI_SMODE_SD_MASK) << FSI_SMODE_SD_SHIFT;
+}
+
+/* Encode slave local bus clock rate ratio */
+static inline uint32_t fsi_smode_lbcrr(int x)
+{
+	return (x & FSI_SMODE_LBCRR_MASK) << FSI_SMODE_LBCRR_SHIFT;
+}
+
+/* Encode slave ID */
+static inline uint32_t fsi_smode_sid(int x)
+{
+	return (x & FSI_SMODE_SID_MASK) << FSI_SMODE_SID_SHIFT;
+}
+
 static int fsi_slave_read(struct fsi_slave *slave, uint32_t addr,
 			void *val, size_t size)
 {
@@ -221,6 +264,22 @@ static void fsi_slave_release(struct device *dev)
 	kfree(slave);
 }
 
+static uint32_t set_smode_defaults(struct fsi_master *master)
+{
+	return FSI_SMODE_WSC | FSI_SMODE_ECRC
+		| fsi_smode_echodly(0xf) | fsi_smode_senddly(0xf)
+		| fsi_smode_lbcrr(1);
+}
+
+static int fsi_slave_set_smode(struct fsi_master *master, int link, int id)
+{
+	uint32_t smode = set_smode_defaults(master);
+
+	smode |= fsi_smode_sid(id);
+	return master->write(master, link, 3, FSI_SLAVE_BASE + FSI_SMODE,
+				&smode, sizeof(smode));
+}
+
 static int fsi_slave_init(struct fsi_master *master,
 		int link, uint8_t slave_id)
 {
@@ -229,6 +288,21 @@ static int fsi_slave_init(struct fsi_master *master,
 	int rc;
 	uint8_t crc;
 
+	/*
+	 * todo: Due to CFAM hardware issues related to BREAK commands we're
+	 * limited to only one CFAM per link.  Once issues are resolved this
+	 * restriction can be removed.
+	 */
+	if (slave_id > 0)
+		return 0;
+
+	rc = fsi_slave_set_smode(master, link, slave_id);
+	if (rc) {
+		dev_warn(master->dev, "can't set smode on slave:%02x:%02x %d\n",
+				link, slave_id, rc);
+		return -ENODEV;
+	}
+
 	rc = master->read(master, link, slave_id, 0, &chip_id, sizeof(chip_id));
 	if (rc) {
 		dev_warn(master->dev, "can't read slave %02x:%02x: %d\n",
@@ -293,6 +367,7 @@ static int fsi_master_break(struct fsi_master *master, int link)
 static int fsi_master_scan(struct fsi_master *master)
 {
 	int link, slave_id, rc;
+	uint32_t smode;
 
 	for (link = 0; link < master->n_links; link++) {
 		rc = fsi_master_link_enable(master, link);
@@ -308,6 +383,19 @@ static int fsi_master_scan(struct fsi_master *master)
 			continue;
 		}
 
+		/*
+		 * Verify can read slave at default ID location. If fails
+		 * there must be nothing on other end of link
+		 */
+		rc = master->read(master, link, 3, FSI_SLAVE_BASE + FSI_SMODE,
+				&smode, sizeof(smode));
+		if (rc) {
+			dev_dbg(master->dev,
+				"Read link:%d smode default id failed:%d\n",
+				link, rc);
+			continue;
+		}
+
 		for (slave_id = 0; slave_id < FSI_N_SLAVES; slave_id++)
 			fsi_slave_init(master, link, slave_id);
 
-- 
1.8.2.2
