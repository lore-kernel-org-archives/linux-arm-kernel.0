From: zhengxing@rock-chips.com (Xing Zheng)
Date: Mon, 28 Dec 2015 15:22:18 +0800
Subject: [RESEND PATCH v1 1/4] net: ethernet: arc: Probe emac after set RMII
 clock
In-Reply-To: <1451287341-16453-1-git-send-email-zhengxing@rock-chips.com>
References: <1451287341-16453-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1451287341-16453-2-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After enter arc_emac_probe, emac will get_phy_id, phy_poll_reset and
other connecting PHY via mdiobus_read, so we need to set correct
ref clock rate for emac before probe emac.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 drivers/net/ethernet/arc/emac_rockchip.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/arc/emac_rockchip.c b/drivers/net/ethernet/arc/emac_rockchip.c
index c31c740..36e9eb1 100644
--- a/drivers/net/ethernet/arc/emac_rockchip.c
+++ b/drivers/net/ethernet/arc/emac_rockchip.c
@@ -164,10 +164,6 @@ static int emac_rockchip_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = arc_emac_probe(ndev, interface);
-	if (err)
-		goto out_regulator_disable;
-
 	/* write-enable bits */
 	data = GRF_MODE_ENABLE_BIT | GRF_SPEED_ENABLE_BIT;
 
@@ -184,6 +180,13 @@ static int emac_rockchip_probe(struct platform_device *pdev)
 	err = clk_set_rate(priv->refclk, 50000000);
 	if (err)
 		dev_err(dev, "failed to change reference clock rate (%d)\n", err);
+
+	err = arc_emac_probe(ndev, interface);
+	if (err) {
+		dev_err(dev, "failed to probe arc emac (%d)\n", err);
+		goto out_regulator_disable;
+	}
+
 	return 0;
 
 out_regulator_disable:
-- 
1.7.9.5
