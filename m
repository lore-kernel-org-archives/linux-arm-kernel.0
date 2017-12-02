From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sun,  3 Dec 2017 00:56:22 +0530
Subject: [PATCH 10/10] net: ethernet: cpmac: Handle return value of
 platform_get_irq_byname
In-Reply-To: <1512242782-7134-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1512242782-7134-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1512242782-7134-11-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq_byname() can fail here and we must check its return
value

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/net/ethernet/ti/cpmac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpmac.c b/drivers/net/ethernet/ti/cpmac.c
index 9b8a30b..f3acfc0 100644
--- a/drivers/net/ethernet/ti/cpmac.c
+++ b/drivers/net/ethernet/ti/cpmac.c
@@ -1124,6 +1124,10 @@ static int cpmac_probe(struct platform_device *pdev)
 	}
 
 	dev->irq = platform_get_irq_byname(pdev, "irq");
+	if (dev->irq < 0) {
+		rc = dev->irq;
+		goto fail;
+	}
 
 	dev->netdev_ops = &cpmac_netdev_ops;
 	dev->ethtool_ops = &cpmac_ethtool_ops;
-- 
2.7.4
