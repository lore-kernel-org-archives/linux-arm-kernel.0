From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 12 Jan 2016 16:17:55 +0100
Subject: [PATCHv2 1/2] remove redundant struct clk NULL checks
In-Reply-To: <1452611876-451-1-git-send-email-LW@KARO-electronics.de>
References: <1452611876-451-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1452611876-451-2-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NULL is a valid argument to clk_enable()/clk_disable(). Remove
redundant checks before calling those functions.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 502da6f..592a7a4 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1874,35 +1874,30 @@ static int fec_enet_clk_enable(struct net_device *ndev, bool enable)
 			}
 			mutex_unlock(&fep->ptp_clk_mutex);
 		}
-		if (fep->clk_ref) {
-			ret = clk_prepare_enable(fep->clk_ref);
-			if (ret)
-				goto failed_clk_ref;
-		}
+
+		ret = clk_prepare_enable(fep->clk_ref);
+		if (ret)
+			goto failed_clk_ref;
 	} else {
 		clk_disable_unprepare(fep->clk_ahb);
-		if (fep->clk_enet_out)
-			clk_disable_unprepare(fep->clk_enet_out);
+		clk_disable_unprepare(fep->clk_enet_out);
 		if (fep->clk_ptp) {
 			mutex_lock(&fep->ptp_clk_mutex);
 			clk_disable_unprepare(fep->clk_ptp);
 			fep->ptp_clk_on = false;
 			mutex_unlock(&fep->ptp_clk_mutex);
 		}
-		if (fep->clk_ref)
-			clk_disable_unprepare(fep->clk_ref);
+		clk_disable_unprepare(fep->clk_ref);
 	}
 
 	return 0;
 
 failed_clk_ref:
-	if (fep->clk_ref)
-		clk_disable_unprepare(fep->clk_ref);
+	clk_disable_unprepare(fep->clk_ref);
 failed_clk_ptp:
-	if (fep->clk_enet_out)
-		clk_disable_unprepare(fep->clk_enet_out);
+	clk_disable_unprepare(fep->clk_enet_out);
 failed_clk_enet_out:
-		clk_disable_unprepare(fep->clk_ahb);
+	clk_disable_unprepare(fep->clk_ahb);
 
 	return ret;
 }
-- 
2.1.4
