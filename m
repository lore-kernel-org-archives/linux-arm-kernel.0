From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Sat, 20 Aug 2016 15:26:55 +0000
Subject: [PATCH -next] net: phy: Add missing of_node_put() in
 xgmiitorgmii_probe()
Message-ID: <1471706815-27723-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This node pointer is returned by of_parse_phandle() with
refcount incremented in this function. of_node_put() on it
before exitting this function.

This is detected by Coccinelle semantic patch.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/net/phy/xilinx_gmii2rgmii.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index cad6e19..4f05e5e 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -75,6 +75,7 @@ int xgmiitorgmii_probe(struct mdio_device *mdiodev)
 	priv->phy_dev = of_phy_find_device(phy_node);
 	if (!priv->phy_dev) {
 		dev_info(dev, "Couldn't find phydev\n");
+		of_node_put(phy_node);
 		return -EPROBE_DEFER;
 	}
