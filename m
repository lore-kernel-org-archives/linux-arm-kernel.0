From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Sat, 29 May 2010 22:04:50 +0200
Subject: [PATCH v2] net/fec: fix pm to survive to suspend/resume
In-Reply-To: <20100529.001534.57459102.davem@davemloft.net>
References: <20100529.001534.57459102.davem@davemloft.net>
Message-ID: <1275163490-13027-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* in the actual driver, calling fec_stop and fec_enet_init doesn't
allow to have a working network interface at resume (where a
ifconfig down and up is required to recover the interface)
* by using fec_enet_close and fec_enet_open, this patch solves this
problem and handle the case where the link changed between suspend
and resume
* this patch also disable clock at suspend and reenable it at resume

Signed-off-by: Eric B?nard <eric@eukrea.com>
Cc: s.hauer at pengutronix.de
Cc: sshtylyov at mvista.com
Cc: linux-arm-kernel at lists.infradead.org
Cc: fabioestevam at yahoo.com
Cc: davem at davemloft.net
---
 drivers/net/fec.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/fec.c b/drivers/net/fec.c
index 9b4e8f7..40ffdb8 100644
--- a/drivers/net/fec.c
+++ b/drivers/net/fec.c
@@ -1975,10 +1975,9 @@ fec_suspend(struct platform_device *dev, pm_message_t state)
 
 	if (ndev) {
 		fep = netdev_priv(ndev);
-		if (netif_running(ndev)) {
-			netif_device_detach(ndev);
-			fec_stop(ndev);
-		}
+		if (netif_running(ndev))
+			fec_enet_close(ndev);
+		clk_disable(fep->clk);
 	}
 	return 0;
 }
@@ -1987,12 +1986,13 @@ static int
 fec_resume(struct platform_device *dev)
 {
 	struct net_device *ndev = platform_get_drvdata(dev);
+	struct fec_enet_private *fep;
 
 	if (ndev) {
-		if (netif_running(ndev)) {
-			fec_enet_init(ndev, 0);
-			netif_device_attach(ndev);
-		}
+		fep = netdev_priv(ndev);
+		clk_enable(fep->clk);
+		if (netif_running(ndev))
+			fec_enet_open(ndev);
 	}
 	return 0;
 }
-- 
1.6.3.3
