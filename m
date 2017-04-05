From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Tue,  4 Apr 2017 21:06:07 -0500
Subject: [PATCH v5 23/23] drivers/fsi: Use asynchronous slave mode
In-Reply-To: <20170405020607.79939-1-cbostic@linux.vnet.ibm.com>
References: <20170405020607.79939-1-cbostic@linux.vnet.ibm.com>
Message-ID: <20170405020607.79939-24-cbostic@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

For slaves that are behind a software-clocked master, we want FSI CFAMs
to run asynchronously to the FSI clock, so set up our slaves to be in
async mode.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Chris Bostic <cbostic@linux.vnet.ibm.com>
---
 drivers/fsi/fsi-core.c        | 22 +++++++++++++++++++++-
 drivers/fsi/fsi-master-gpio.c |  1 +
 drivers/fsi/fsi-master.h      |  2 ++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 747d0e3..a6ed34f 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -47,6 +47,7 @@
 #define FSI_SMODE		0x0	/* R/W: Mode register */
 #define FSI_SISC		0x8	/* R/W: Interrupt condition */
 #define FSI_SSTAT		0x14	/* R  : Slave status */
+#define FSI_LLMODE		0x100	/* R/W: Link layer mode register */
 
 /*
  * SMODE fields
@@ -62,6 +63,11 @@
 #define FSI_SMODE_LBCRR_SHIFT	8		/* Clk ratio shift */
 #define FSI_SMODE_LBCRR_MASK	0xf		/* Clk ratio mask */
 
+/*
+ * LLMODE fields
+ */
+#define FSI_LLMODE_ASYNC	0x1
+
 #define FSI_SLAVE_SIZE_23b		0x800000
 
 static DEFINE_IDA(master_ida);
@@ -560,8 +566,8 @@ static void fsi_slave_release(struct device *dev)
 
 static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 {
+	uint32_t chip_id, llmode;
 	struct fsi_slave *slave;
-	uint32_t chip_id;
 	uint8_t crc;
 	int rc;
 
@@ -597,6 +603,20 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 		return -ENODEV;
 	}
 
+	/* If we're behind a master that doesn't provide a self-running bus
+	 * clock, put the slave into async mode
+	 */
+	if (master->flags & FSI_MASTER_FLAG_SWCLOCK) {
+		llmode = cpu_to_be32(FSI_LLMODE_ASYNC);
+		rc = fsi_master_write(master, link, id,
+				FSI_SLAVE_BASE + FSI_LLMODE,
+				&llmode, sizeof(llmode));
+		if (rc)
+			dev_warn(&master->dev,
+				"can't set llmode on slave:%02x:%02x %d\n",
+				link, id, rc);
+	}
+
 	/* We can communicate with a slave; create the slave device and
 	 * register.
 	 */
diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index 5d9e0b0..d5cce88 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -569,6 +569,7 @@ static int fsi_master_gpio_probe(struct platform_device *pdev)
 	master->gpio_mux = gpio;
 
 	master->master.n_links = 1;
+	master->master.flags = FSI_MASTER_FLAG_SWCLOCK;
 	master->master.read = fsi_master_gpio_read;
 	master->master.write = fsi_master_gpio_write;
 	master->master.term = fsi_master_gpio_term;
diff --git a/drivers/fsi/fsi-master.h b/drivers/fsi/fsi-master.h
index d6a4885..fd39924 100644
--- a/drivers/fsi/fsi-master.h
+++ b/drivers/fsi/fsi-master.h
@@ -19,6 +19,8 @@
 
 #include <linux/device.h>
 
+#define FSI_MASTER_FLAG_SWCLOCK	0x1
+
 struct fsi_master {
 	struct device	dev;
 	int		idx;
-- 
1.8.2.2
