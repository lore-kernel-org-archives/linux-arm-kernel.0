From: richard.zhao@linaro.org (Richard Zhao)
Date: Mon, 30 Jan 2012 16:08:12 +0800
Subject: [PATCH 1/1] net: fec: correct phy_name buffer length when init
 phy_name
Message-ID: <1327910892-11251-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the bug that we got wrong phy_name on imx6q sabrelite board.
snprintf used wrong length of phy_name.
phy_name length is MII_BUS_ID_SIZE + 3 rather not MII_BUS_ID_SIZE.
I change it to sizeof(phy_name).

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 drivers/net/ethernet/freescale/fec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.c b/drivers/net/ethernet/freescale/fec.c
index 7b25e9c..1c7aad8 100644
--- a/drivers/net/ethernet/freescale/fec.c
+++ b/drivers/net/ethernet/freescale/fec.c
@@ -990,7 +990,7 @@ static int fec_enet_mii_probe(struct net_device *ndev)
 		phy_id = 0;
 	}
 
-	snprintf(phy_name, MII_BUS_ID_SIZE, PHY_ID_FMT, mdio_bus_id, phy_id);
+	snprintf(phy_name, sizeof(phy_name), PHY_ID_FMT, mdio_bus_id, phy_id);
 	phy_dev = phy_connect(ndev, phy_name, &fec_enet_adjust_link, 0,
 			      fep->phy_interface);
 	if (IS_ERR(phy_dev)) {
-- 
1.7.5.4
