From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 27 May 2010 08:33:19 +0200
Subject: [PATCH v2 7/8] net/fec: fix pm to survive to suspend/resume
In-Reply-To: <1274942000-3580-6-git-send-email-eric@eukrea.com>
References: <1274942000-3580-1-git-send-email-eric@eukrea.com>
	<1274942000-3580-2-git-send-email-eric@eukrea.com>
	<1274942000-3580-3-git-send-email-eric@eukrea.com>
	<1274942000-3580-4-git-send-email-eric@eukrea.com>
	<1274942000-3580-5-git-send-email-eric@eukrea.com>
	<1274942000-3580-6-git-send-email-eric@eukrea.com>
Message-ID: <1274942000-3580-7-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* with this patch, if the connection if active before suspend, it
will be active after resume.
* before this patch, it was necessary to close the interface and
reopen it to recover the connection.

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 drivers/net/fec.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/fec.c b/drivers/net/fec.c
index 9b4e8f7..654abaf 100644
--- a/drivers/net/fec.c
+++ b/drivers/net/fec.c
@@ -1971,13 +1971,14 @@ static int
 fec_suspend(struct platform_device *dev, pm_message_t state)
 {
 	struct net_device *ndev = platform_get_drvdata(dev);
-	struct fec_enet_private *fep;
+	struct fec_enet_private *fep = netdev_priv(ndev);
 
 	if (ndev) {
 		fep = netdev_priv(ndev);
 		if (netif_running(ndev)) {
+			netif_stop_queue(ndev);
 			netif_device_detach(ndev);
-			fec_stop(ndev);
+			clk_disable(fep->clk);
 		}
 	}
 	return 0;
@@ -1987,11 +1988,13 @@ static int
 fec_resume(struct platform_device *dev)
 {
 	struct net_device *ndev = platform_get_drvdata(dev);
+	struct fec_enet_private *fep = netdev_priv(ndev);
 
 	if (ndev) {
 		if (netif_running(ndev)) {
-			fec_enet_init(ndev, 0);
+			clk_enable(fep->clk);
 			netif_device_attach(ndev);
+			netif_start_queue(ndev);
 		}
 	}
 	return 0;
-- 
1.6.3.3
