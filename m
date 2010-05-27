From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 27 May 2010 19:53:48 +0200
Subject: [PATCH] net/fec: fix pm to survive to suspend/resume
In-Reply-To: <536177.31761.qm@web51001.mail.re2.yahoo.com>
References: <536177.31761.qm@web51001.mail.re2.yahoo.com>
Message-ID: <1274982828-13082-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* with this patch, if the connection if active before suspend, it
will be active after resume.
* before this patch, it was necessary to close the interface and
reopen it to recover the connection.

Signed-off-by: Eric B?nard <eric@eukrea.com>
Cc: s.hauer at pengutronix.de
Cc: sshtylyov at mvista.com
Cc: linux-arm-kernel at lists.infradead.org
Cc: fabioestevam at yahoo.com
Cc: netdev at vger.kernel.org
---
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
