From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sun,  3 Dec 2017 00:56:21 +0530
Subject: [PATCH 09/10] net: ethernet: korina: Handle return value of
 platform_get_irq_byname
In-Reply-To: <1512242782-7134-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1512242782-7134-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1512242782-7134-10-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq_byname() can fail here and we must check its return
value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/net/ethernet/korina.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/korina.c b/drivers/net/ethernet/korina.c
index ae195f8..e778504 100644
--- a/drivers/net/ethernet/korina.c
+++ b/drivers/net/ethernet/korina.c
@@ -1039,7 +1039,16 @@ static int korina_probe(struct platform_device *pdev)
 	memcpy(dev->dev_addr, bif->mac, ETH_ALEN);
 
 	lp->rx_irq = platform_get_irq_byname(pdev, "korina_rx");
+	if (lp->rx_irq < 0) {
+		rc = lp->rx_irq;
+		goto probe_err_out;
+	}
+
 	lp->tx_irq = platform_get_irq_byname(pdev, "korina_tx");
+	if (lp->tx_irq < 0) {
+		rc = lp->tx_irq;
+		goto probe_err_out;
+	}
 
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "korina_regs");
 	dev->base_addr = r->start;
-- 
2.7.4
