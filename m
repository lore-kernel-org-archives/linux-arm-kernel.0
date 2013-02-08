From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri,  8 Feb 2013 23:17:45 +0000
Subject: [PATCH 15/17] xgmac: fix printing of hardware version
In-Reply-To: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1360365467-25056-16-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current driver attempts to print netdev_info() before registering the
network device and allowing the name to be set. Change this print to be
after the network deviec has been registered.

Fix the following issue:

calxedaxgmac fff50000.ethernet (unregistered net_device): h/w version is 0x1012

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/net/ethernet/calxeda/xgmac.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/calxeda/xgmac.c b/drivers/net/ethernet/calxeda/xgmac.c
index f7f0290..f91d9b2 100644
--- a/drivers/net/ethernet/calxeda/xgmac.c
+++ b/drivers/net/ethernet/calxeda/xgmac.c
@@ -1715,9 +1715,6 @@ static int xgmac_probe(struct platform_device *pdev)
 		goto err_io;
 	}
 
-	uid = readl(priv->base + XGMAC_VERSION);
-	netdev_info(ndev, "h/w version is 0x%x\n", uid);
-
 	writel(0, priv->base + XGMAC_DMA_INTR_ENA);
 	ndev->irq = platform_get_irq(pdev, 0);
 	if (ndev->irq == -ENXIO) {
@@ -1771,6 +1768,9 @@ static int xgmac_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_reg;
 
+	uid = readl(priv->base + XGMAC_VERSION);
+	netdev_info(ndev, "h/w version is 0x%x\n", uid);
+
 	return 0;
 
 err_reg:
-- 
1.7.10.4
