From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon,  4 Dec 2017 23:18:22 +0530
Subject: [PATCH 6/7 v2] net: ethernet: smsc: Fix platform_get_irq's error
 checking
In-Reply-To: <1512409703-20881-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1512409703-20881-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1512409703-20881-7-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2:
             commit message was not correct.

 drivers/net/ethernet/smsc/smc911x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/smsc/smc911x.c b/drivers/net/ethernet/smsc/smc911x.c
index 0515744..5e3c7af 100644
--- a/drivers/net/ethernet/smsc/smc911x.c
+++ b/drivers/net/ethernet/smsc/smc911x.c
@@ -2088,6 +2088,11 @@ static int smc911x_drv_probe(struct platform_device *pdev)
 
 	ndev->dma = (unsigned char)-1;
 	ndev->irq = platform_get_irq(pdev, 0);
+	if (ndev->irq <= 0) {
+		ret = ndev->irq ? ndev->irq : -ENODEV;
+		goto release_both;
+	}
+
 	lp = netdev_priv(ndev);
 	lp->netdev = ndev;
 #ifdef SMC_DYNAMIC_BUS_CONFIG
-- 
2.7.4
