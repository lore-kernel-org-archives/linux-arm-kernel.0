From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 28 Dec 2010 22:55:49 +0800
Subject: [PATCH 04/10] net/fec: improve pm for better suspend/resume
In-Reply-To: <1293548155-16328-1-git-send-email-shawn.guo@freescale.com>
References: <1293548155-16328-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1293548155-16328-5-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following commit made a fix to use fec_enet_open/fec_enet_close
over fec_enet_init/fec_stop for suspend/resume, because fec_enet_init
does not allow to have a working network interface at resume.

  e3fe8558c7fc182972c3d947d88744482111f304
  net/fec: fix pm to survive to suspend/resume

This fix works for i.mx/mxc fec controller, but fails on mx28 fec
which gets a different interrupt logic design. On i.mx fec, interrupt
can be triggered even bit ETHER_EN of ECR register is not set. But
on mx28 fec, ETHER_EN must be set to get interrupt work. Meanwhile,
MII interrupt is mandatory to resume the driver, because MDIO
read/write changed to interrupt mode by commit below.

  97b72e4320a9aaa4a7f1592ee7d2da7e2c9bd349
  fec: use interrupt for MDIO completion indication

fec_restart/fec_stop comes out as the solution working for both
cases.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 drivers/net/fec.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/fec.c b/drivers/net/fec.c
index cd59814..f147508 100644
--- a/drivers/net/fec.c
+++ b/drivers/net/fec.c
@@ -1387,8 +1387,10 @@ fec_suspend(struct device *dev)
 
 	if (ndev) {
 		fep = netdev_priv(ndev);
-		if (netif_running(ndev))
-			fec_enet_close(ndev);
+		if (netif_running(ndev)) {
+			fec_stop(ndev);
+			netif_device_detach(ndev);
+		}
 		clk_disable(fep->clk);
 	}
 	return 0;
@@ -1403,8 +1405,10 @@ fec_resume(struct device *dev)
 	if (ndev) {
 		fep = netdev_priv(ndev);
 		clk_enable(fep->clk);
-		if (netif_running(ndev))
-			fec_enet_open(ndev);
+		if (netif_running(ndev)) {
+			fec_restart(ndev, fep->full_duplex);
+			netif_device_attach(ndev);
+		}
 	}
 	return 0;
 }
-- 
1.7.1
