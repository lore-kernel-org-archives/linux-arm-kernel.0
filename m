From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Sun, 21 Aug 2016 22:46:15 +0000
Subject: [PATCH -next v2] net: phy: Add missing of_node_put() in
 xgmiitorgmii_probe()
In-Reply-To: <1471706815-27723-1-git-send-email-weiyj.lk@gmail.com>
References: <1471706815-27723-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <1471819575-13389-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This node pointer is returned by of_parse_phandle() with
refcount incremented in this function. of_node_put() on it
before exitting this function.

This is detected by Coccinelle semantic patch.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
v1 -> v2: release it unconditionally as Andrew and David's suggestion
---
 drivers/net/phy/xilinx_gmii2rgmii.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index cad6e19..73b50f3 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -73,6 +73,7 @@ int xgmiitorgmii_probe(struct mdio_device *mdiodev)
 	}
 
 	priv->phy_dev = of_phy_find_device(phy_node);
+	of_node_put(phy_node);
 	if (!priv->phy_dev) {
 		dev_info(dev, "Couldn't find phydev\n");
 		return -EPROBE_DEFER;
