From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 5 Sep 2012 11:00:54 +0200
Subject: [PATCH 09/10] net/macb: ethtool interface: add register dump feature
In-Reply-To: <cover.1346775479.git.nicolas.ferre@atmel.com>
References: <cover.1346775479.git.nicolas.ferre@atmel.com>
Message-ID: <fcd1c2443a30f23ffcd8de28328c5a382e2a2459.1346775479.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add macb_get_regs() ethtool function and its helper function:
macb_get_regs_len().

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/net/ethernet/cadence/macb.c |   40 +++++++++++++++++++++++++++++++++++
 drivers/net/ethernet/cadence/macb.h |    3 +++
 2 files changed, 43 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cadence/macb.c
index c7c39f1..f31c0a7 100644
--- a/drivers/net/ethernet/cadence/macb.c
+++ b/drivers/net/ethernet/cadence/macb.c
@@ -1321,10 +1321,50 @@ static void macb_get_drvinfo(struct net_device *dev,
 	strcpy(info->bus_info, dev_name(&bp->pdev->dev));
 }
 
+static int macb_get_regs_len(struct net_device *netdev)
+{
+	return MACB_GREGS_LEN * sizeof(u32);
+}
+
+static void macb_get_regs(struct net_device *dev, struct ethtool_regs *regs,
+			  void *p)
+{
+	struct macb *bp = netdev_priv(dev);
+	unsigned int tail, head;
+	u32 *regs_buff = p;
+
+        memset(p, 0, MACB_GREGS_LEN * sizeof(u32));
+	regs->version = MACB_BFEXT(IDNUM, macb_readl(bp, MID));
+
+	tail = macb_tx_ring_wrap(bp->tx_tail);
+	head = macb_tx_ring_wrap(bp->tx_head);
+
+	regs_buff[0]  = macb_readl(bp, NCR);
+	regs_buff[1]  = macb_or_gem_readl(bp, NCFGR);
+	regs_buff[2]  = macb_readl(bp, NSR);
+	regs_buff[3]  = macb_readl(bp, TSR);
+	regs_buff[4]  = macb_readl(bp, RBQP);
+	regs_buff[5]  = macb_readl(bp, TBQP);
+	regs_buff[6]  = macb_readl(bp, RSR);
+	regs_buff[7]  = macb_readl(bp, IMR);
+
+	regs_buff[8]  = tail;
+	regs_buff[9]  = head;
+	regs_buff[10] = macb_tx_dma(bp, tail);
+	regs_buff[11] = macb_tx_dma(bp, head);
+
+	if (macb_is_gem(bp)) {
+		regs_buff[12] = gem_readl(bp, USRIO);
+		regs_buff[13] = gem_readl(bp, DMACFG);
+	}
+}
+
 static const struct ethtool_ops macb_ethtool_ops = {
 	.get_settings		= macb_get_settings,
 	.set_settings		= macb_set_settings,
 	.get_drvinfo		= macb_get_drvinfo,
+	.get_regs_len		= macb_get_regs_len,
+	.get_regs		= macb_get_regs,
 	.get_link		= ethtool_op_get_link,
 	.get_ts_info		= ethtool_op_get_ts_info,
 };
diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 8a4ee2f..d509e88 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -10,6 +10,9 @@
 #ifndef _MACB_H
 #define _MACB_H
 
+
+#define MACB_GREGS_LEN 32
+
 /* MACB register offsets */
 #define MACB_NCR				0x0000
 #define MACB_NCFGR				0x0004
-- 
1.7.10
