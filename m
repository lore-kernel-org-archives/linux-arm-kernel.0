From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 12 Mar 2015 14:13:44 +0100
Subject: [PATCH RFC 3/3] net: allwinner: emac: Claim our SRAM
In-Reply-To: <1426166024-24922-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1426166024-24922-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1426166024-24922-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SRAM the EMAC is using might not have been mapped accordingly by the
bootloader, preventing the EMAC to work properly.

Ask for that SRAM to be mapped at probe time to make sure that this never
happens.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/net/ethernet/allwinner/sun4i-emac.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
index f3470d96837a..9d0136b1fab8 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -29,6 +29,8 @@
 #include <linux/platform_device.h>
 #include <linux/phy.h>
 
+#include <linux/soc/sunxi/sunxi_sram.h>
+
 #include "sun4i-emac.h"
 
 #define DRV_NAME		"sun4i-emac"
@@ -857,11 +859,15 @@ static int emac_probe(struct platform_device *pdev)
 
 	clk_prepare_enable(db->clk);
 
+	ret = sunxi_sram_claim(SUNXI_SRAM_EMAC, "emac");
+	if (ret)
+		dev_warn(&pdev->dev, "Couldn't map SRAM to device\n");
+
 	db->phy_node = of_parse_phandle(np, "phy", 0);
 	if (!db->phy_node) {
 		dev_err(&pdev->dev, "no associated PHY\n");
 		ret = -ENODEV;
-		goto out;
+		goto out_release_sram;
 	}
 
 	/* Read MAC-address from DT */
@@ -893,7 +899,7 @@ static int emac_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "Registering netdev failed!\n");
 		ret = -ENODEV;
-		goto out;
+		goto out_release_sram;
 	}
 
 	dev_info(&pdev->dev, "%s: at %p, IRQ %d MAC: %pM\n",
@@ -901,6 +907,8 @@ static int emac_probe(struct platform_device *pdev)
 
 	return 0;
 
+out_release_sram:
+	sunxi_sram_release(SUNXI_SRAM_EMAC);
 out:
 	dev_err(db->dev, "not found (%d).\n", ret);
 
@@ -914,6 +922,7 @@ static int emac_remove(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 
 	unregister_netdev(ndev);
+	sunxi_sram_release(SUNXI_SRAM_EMAC);
 	free_netdev(ndev);
 
 	dev_dbg(&pdev->dev, "released and freed device\n");
-- 
2.3.1
