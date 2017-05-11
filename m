From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Thu, 11 May 2017 16:00:45 -0500
Subject: [PATCH v7 08/23] drivers/fsi: Set slave SMODE to init communication
In-Reply-To: <20170511210101.78409-1-cbostic@linux.vnet.ibm.com>
References: <20170511210101.78409-1-cbostic@linux.vnet.ibm.com>
Message-ID: <20170511210101.78409-9-cbostic@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set CFAM to appropriate ID so that the controlling master can manage
link memory ranges.  Add slave engine register definitions.

Includes changes from Jeremy Kerr <jk@ozlabs.org>.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-core.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 9d9adc1..04795f2 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -22,6 +22,27 @@
 
 #include "fsi-master.h"
 
+#define FSI_SLAVE_BASE			0x800
+
+/*
+ * FSI slave engine control register offsets
+ */
+#define FSI_SMODE			0x0	/* R/W: Mode register */
+
+/*
+ * SMODE fields
+ */
+#define FSI_SMODE_WSC		0x80000000	/* Warm start done */
+#define FSI_SMODE_ECRC		0x20000000	/* Hw CRC check */
+#define FSI_SMODE_SID_SHIFT	24		/* ID shift */
+#define FSI_SMODE_SID_MASK	3		/* ID Mask */
+#define FSI_SMODE_ED_SHIFT	20		/* Echo delay shift */
+#define FSI_SMODE_ED_MASK	0xf		/* Echo delay mask */
+#define FSI_SMODE_SD_SHIFT	16		/* Send delay shift */
+#define FSI_SMODE_SD_MASK	0xf		/* Send delay mask */
+#define FSI_SMODE_LBCRR_SHIFT	8		/* Clk ratio shift */
+#define FSI_SMODE_LBCRR_MASK	0xf		/* Clk ratio mask */
+
 #define FSI_SLAVE_SIZE_23b		0x800000
 
 static DEFINE_IDA(master_ida);
@@ -94,6 +115,52 @@ static int fsi_slave_write(struct fsi_slave *slave, uint32_t addr,
 			addr, val, size);
 }
 
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
+static const uint32_t fsi_slave_smode(int id)
+{
+	return FSI_SMODE_WSC | FSI_SMODE_ECRC
+		| fsi_smode_sid(id)
+		| fsi_smode_echodly(0xf) | fsi_smode_senddly(0xf)
+		| fsi_smode_lbcrr(0x8);
+}
+
+static int fsi_slave_set_smode(struct fsi_master *master, int link, int id)
+{
+	uint32_t smode;
+
+	/* set our smode register with the slave ID field to 0; this enables
+	 * extended slave addressing
+	 */
+	smode = fsi_slave_smode(id);
+	smode = cpu_to_be32(smode);
+
+	return fsi_master_write(master, link, id, FSI_SLAVE_BASE + FSI_SMODE,
+			&smode, sizeof(smode));
+}
+
 static void fsi_slave_release(struct device *dev)
 {
 	struct fsi_slave *slave = to_fsi_slave(dev);
@@ -132,6 +199,14 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 	dev_info(&master->dev, "fsi: found chip %08x at %02x:%02x:%02x\n",
 			chip_id, master->idx, link, id);
 
+	rc = fsi_slave_set_smode(master, link, id);
+	if (rc) {
+		dev_warn(&master->dev,
+				"can't set smode on slave:%02x:%02x %d\n",
+				link, id, rc);
+		return -ENODEV;
+	}
+
 	/* We can communicate with a slave; create the slave device and
 	 * register.
 	 */
-- 
1.8.2.2
