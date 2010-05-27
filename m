From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 27 May 2010 16:19:49 +0200
Subject: [PATCH v3] net/fec: fix pm to survive to suspend/resume
In-Reply-To: <4BFE4B4F.4090405@ru.mvista.com>
References: <4BFE4B4F.4090405@ru.mvista.com>
Message-ID: <1274969989-4280-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* with this patch, if the connection if active before suspend, it
will be active after resume.
* before this patch, it was necessary to close the interface and
reopen it to recover the connection.

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
v3 : fix following Sergei Shtylyov's comments

 drivers/net/fec.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/fec.c b/drivers/net/fec.c
index 9b4e8f7..1521972 100644
--- a/drivers/net/fec.c
+++ b/drivers/net/fec.c
@@ -1974,10 +1974,11 @@ fec_suspend(struct platform_device *dev, pm_message_t state)
 	struct fec_enet_private *fep;
 
 	if (ndev) {
-		fep = netdev_priv(ndev);
 		if (netif_running(ndev)) {
+			fep = netdev_priv(ndev);
+			netif_stop_queue(ndev);
 			netif_device_detach(ndev);
-			fec_stop(ndev);
+			clk_disable(fep->clk);
 		}
 	}
 	return 0;
@@ -1987,11 +1988,14 @@ static int
 fec_resume(struct platform_device *dev)
 {
 	struct net_device *ndev = platform_get_drvdata(dev);
+	struct fec_enet_private *fep;
 
 	if (ndev) {
 		if (netif_running(ndev)) {
-			fec_enet_init(ndev, 0);
+			fep = netdev_priv(ndev);
+			clk_enable(fep->clk);
 			netif_device_attach(ndev);
+			netif_start_queue(ndev);
 		}
 	}
 	return 0;
-- 
1.6.3.3
