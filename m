From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Mon, 15 Aug 2016 22:34:57 +0000
Subject: [PATCH -next] net: phy: Fix return value check in xgmiitorgmii_probe()
Message-ID: <1471300497-15066-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of error, the function of_parse_phandle() returns NULL
pointer not ERR_PTR(). The IS_ERR() test in the return value check
should be replaced with NULL test.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/net/phy/xilinx_gmii2rgmii.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index 8e980ad..cad6e19 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -67,7 +67,7 @@ int xgmiitorgmii_probe(struct mdio_device *mdiodev)
 		return -ENOMEM;
 
 	phy_node = of_parse_phandle(np, "phy-handle", 0);
-	if (IS_ERR(phy_node)) {
+	if (!phy_node) {
 		dev_err(dev, "Couldn't parse phy-handle\n");
 		return -ENODEV;
 	}
