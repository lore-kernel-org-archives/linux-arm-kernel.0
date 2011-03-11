From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 11 Mar 2011 16:08:07 -0700
Subject: [PATCH 05/10] smsc911x: use shifted register access
In-Reply-To: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
References: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1299884892-6766-6-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alessandro Rubini <rubini@gnudd.com>

At least one of the boards using this chip needs a shift in
register access. This adds a "shift" field in the platform data
to have the chip working in all cases without special ifdef.
The approach is similaro to the one used in serial_8250 and other
places.  Performance-wise no difference is reported.

Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
---
 drivers/net/smsc911x.c   |   27 ++++++++++++++++++---------
 include/linux/smsc911x.h |    1 +
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/net/smsc911x.c b/drivers/net/smsc911x.c
index 64bfdae..a21c551 100644
--- a/drivers/net/smsc911x.c
+++ b/drivers/net/smsc911x.c
@@ -120,12 +120,15 @@ struct smsc911x_data {
 
 static inline u32 __smsc911x_reg_read(struct smsc911x_data *pdata, u32 reg)
 {
+	void __iomem *addr = pdata->ioaddr;
+	int shift = pdata->config.shift;
+
 	if (pdata->config.flags & SMSC911X_USE_32BIT)
-		return readl(pdata->ioaddr + reg);
+		return readl(addr + (reg << shift));
 
 	if (pdata->config.flags & SMSC911X_USE_16BIT)
-		return ((readw(pdata->ioaddr + reg) & 0xFFFF) |
-			((readw(pdata->ioaddr + reg + 2) & 0xFFFF) << 16));
+		return ((readw(addr + (reg << shift)) & 0xFFFF) |
+			((readw(addr + ((reg + 2) << shift)) & 0xFFFF) << 16));
 
 	BUG();
 	return 0;
@@ -146,14 +149,17 @@ static inline u32 smsc911x_reg_read(struct smsc911x_data *pdata, u32 reg)
 static inline void __smsc911x_reg_write(struct smsc911x_data *pdata, u32 reg,
 					u32 val)
 {
+	void __iomem *addr = pdata->ioaddr;
+	int shift = pdata->config.shift;
+
 	if (pdata->config.flags & SMSC911X_USE_32BIT) {
-		writel(val, pdata->ioaddr + reg);
+		writel(val, addr + (reg << shift));
 		return;
 	}
 
 	if (pdata->config.flags & SMSC911X_USE_16BIT) {
-		writew(val & 0xFFFF, pdata->ioaddr + reg);
-		writew((val >> 16) & 0xFFFF, pdata->ioaddr + reg + 2);
+		writew(val & 0xFFFF, addr + (reg << shift));
+		writew((val >> 16) & 0xFFFF, addr + ((reg + 2) << shift));
 		return;
 	}
 
@@ -187,7 +193,8 @@ smsc911x_tx_writefifo(struct smsc911x_data *pdata, unsigned int *buf,
 	}
 
 	if (pdata->config.flags & SMSC911X_USE_32BIT) {
-		writesl(pdata->ioaddr + TX_DATA_FIFO, buf, wordcount);
+		writesl(pdata->ioaddr + (TX_DATA_FIFO << pdata->config.shift),
+			buf, wordcount);
 		goto out;
 	}
 
@@ -219,7 +226,8 @@ smsc911x_rx_readfifo(struct smsc911x_data *pdata, unsigned int *buf,
 	}
 
 	if (pdata->config.flags & SMSC911X_USE_32BIT) {
-		readsl(pdata->ioaddr + RX_DATA_FIFO, buf, wordcount);
+		readsl(pdata->ioaddr + (RX_DATA_FIFO << pdata->config.shift),
+					buf, wordcount);
 		goto out;
 	}
 
@@ -2003,7 +2011,8 @@ static int __devinit smsc911x_drv_probe(struct platform_device *pdev)
 
 	dev->irq = irq_res->start;
 	irq_flags = irq_res->flags & IRQF_TRIGGER_MASK;
-	pdata->ioaddr = ioremap_nocache(res->start, res_size);
+	pdata->ioaddr = ioremap_nocache(res->start,
+					(res_size << config->shift));
 
 	/* copy config parameters across to pdata */
 	memcpy(&pdata->config, config, sizeof(pdata->config));
diff --git a/include/linux/smsc911x.h b/include/linux/smsc911x.h
index 7144e8a..cff97bc 100644
--- a/include/linux/smsc911x.h
+++ b/include/linux/smsc911x.h
@@ -29,6 +29,7 @@ struct smsc911x_platform_config {
 	unsigned int irq_polarity;
 	unsigned int irq_type;
 	unsigned int flags;
+	unsigned int shift; /* for register access */
 	phy_interface_t phy_interface;
 	unsigned char mac[6];
 };
-- 
1.7.1
