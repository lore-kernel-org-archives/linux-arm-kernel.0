From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Fri, 18 Jun 2010 11:29:10 +0200
Subject: [PATCH 1/2] net/fec: clean suspend/resume
Message-ID: <1276853351-20790-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 59d4289b83b11379d867e2f7146904b19cc96404 converted fec to dev_pm_ops but
didn't update the suspend/resume functions thus leading to the following warning :
"initialization from incompatible pointer type" when CONFIG_PM is set.

This patch also fixe a few indentation and style around CONFIG_PM area.

Signed-off-by: Eric B?nard <eric@eukrea.com>
To: netdev at vger.kernel.org
Cc: davem at davemloft.net
Cc: amit.kucheria at canonical.com
Cc: s.hauer at pengutronix.de
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/net/fec.c |   30 ++++++++++++------------------
 1 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/net/fec.c b/drivers/net/fec.c
index a3cae4e..b4afd7a 100644
--- a/drivers/net/fec.c
+++ b/drivers/net/fec.c
@@ -1360,11 +1360,10 @@ fec_drv_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
-
 static int
-fec_suspend(struct platform_device *dev, pm_message_t state)
+fec_suspend(struct device *dev)
 {
-	struct net_device *ndev = platform_get_drvdata(dev);
+	struct net_device *ndev = dev_get_drvdata(dev);
 	struct fec_enet_private *fep;
 
 	if (ndev) {
@@ -1377,9 +1376,9 @@ fec_suspend(struct platform_device *dev, pm_message_t state)
 }
 
 static int
-fec_resume(struct platform_device *dev)
+fec_resume(struct device *dev)
 {
-	struct net_device *ndev = platform_get_drvdata(dev);
+	struct net_device *ndev = dev_get_drvdata(dev);
 	struct fec_enet_private *fep;
 
 	if (ndev) {
@@ -1399,23 +1398,18 @@ static const struct dev_pm_ops fec_pm_ops = {
 	.poweroff	= fec_suspend,
 	.restore	= fec_resume,
 };
-
-#define FEC_PM_OPS (&fec_pm_ops)
-
-#else /* !CONFIG_PM */
-
-#define FEC_PM_OPS NULL
-
-#endif /* !CONFIG_PM */
+#endif
 
 static struct platform_driver fec_driver = {
 	.driver	= {
-		.name    = "fec",
-		.owner	 = THIS_MODULE,
-		.pm		 = FEC_PM_OPS,
+		.name	= "fec",
+		.owner	= THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm	= &fec_pm_ops,
+#endif
 	},
-	.probe   = fec_probe,
-	.remove  = __devexit_p(fec_drv_remove),
+	.probe	= fec_probe,
+	.remove	= __devexit_p(fec_drv_remove),
 };
 
 static int __init
-- 
1.6.3.3
