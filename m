From: rogerq@ti.com (Roger Quadros)
Date: Thu, 6 Mar 2014 17:31:22 +0200
Subject: [PATCH v3 06/13] phy: ti-pipe3: Don't get 'wkupclk' and 'refclk' for
 SATA PHY
In-Reply-To: <1394116729-28811-7-git-send-email-rogerq@ti.com>
References: <1394116729-28811-7-git-send-email-rogerq@ti.com>
Message-ID: <1394119882-12859-1-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SATA PHY doesn't need 'wkupclk; and 'refclk' so don't
try to get them for SATA PHY.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
v3 - Fixed checkpatch warning

 drivers/phy/phy-ti-pipe3.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/phy-ti-pipe3.c b/drivers/phy/phy-ti-pipe3.c
index f141237..f925f60 100644
--- a/drivers/phy/phy-ti-pipe3.c
+++ b/drivers/phy/phy-ti-pipe3.c
@@ -294,16 +294,21 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 
 	phy->dev		= &pdev->dev;
 
-	phy->wkupclk = devm_clk_get(phy->dev, "wkupclk");
-	if (IS_ERR(phy->wkupclk)) {
-		dev_err(&pdev->dev, "unable to get wkupclk\n");
-		return PTR_ERR(phy->wkupclk);
-	}
+	if (!of_device_is_compatible(node, "ti,phy-pipe3-sata")) {
+		phy->wkupclk = devm_clk_get(phy->dev, "wkupclk");
+		if (IS_ERR(phy->wkupclk)) {
+			dev_err(&pdev->dev, "unable to get wkupclk\n");
+			return PTR_ERR(phy->wkupclk);
+		}
 
-	phy->refclk = devm_clk_get(phy->dev, "refclk");
-	if (IS_ERR(phy->refclk)) {
-		dev_err(&pdev->dev, "unable to get refclk\n");
-		return PTR_ERR(phy->refclk);
+		phy->refclk = devm_clk_get(phy->dev, "refclk");
+		if (IS_ERR(phy->refclk)) {
+			dev_err(&pdev->dev, "unable to get refclk\n");
+			return PTR_ERR(phy->refclk);
+		}
+	} else {
+		phy->wkupclk = ERR_PTR(-ENODEV);
+		phy->refclk = ERR_PTR(-ENODEV);
 	}
 
 	phy->sys_clk = devm_clk_get(phy->dev, "sysclk");
-- 
1.8.3.2
