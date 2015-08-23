From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 23 Aug 2015 20:31:38 +0200
Subject: [PATCH] net: sun4i-emac: Claim emac sram
Message-ID: <1440354698-11144-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Claim the emac sram ourselves, rather then relying on the bootloader
having mapped the sram to the emac controller during boot.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/net/ethernet/allwinner/sun4i-emac.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
index bab01c84..48ce83e 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -28,6 +28,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/phy.h>
+#include <linux/soc/sunxi/sunxi_sram.h>
 
 #include "sun4i-emac.h"
 
@@ -857,11 +858,17 @@ static int emac_probe(struct platform_device *pdev)
 
 	clk_prepare_enable(db->clk);
 
+	ret = sunxi_sram_claim(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Error couldn't map SRAM to device\n");
+		goto out;
+	}
+
 	db->phy_node = of_parse_phandle(np, "phy", 0);
 	if (!db->phy_node) {
 		dev_err(&pdev->dev, "no associated PHY\n");
 		ret = -ENODEV;
-		goto out;
+		goto out_release_sram;
 	}
 
 	/* Read MAC-address from DT */
@@ -893,7 +900,7 @@ static int emac_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "Registering netdev failed!\n");
 		ret = -ENODEV;
-		goto out;
+		goto out_release_sram;
 	}
 
 	dev_info(&pdev->dev, "%s: at %p, IRQ %d MAC: %pM\n",
@@ -901,6 +908,8 @@ static int emac_probe(struct platform_device *pdev)
 
 	return 0;
 
+out_release_sram:
+	sunxi_sram_release(&pdev->dev);
 out:
 	dev_err(db->dev, "not found (%d).\n", ret);
 
-- 
2.4.3
