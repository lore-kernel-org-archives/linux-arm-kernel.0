From: david@lechnology.com (David Lechner)
Date: Fri, 19 Jan 2018 21:20:20 -0600
Subject: [PATCH 2/6] phy: da8xx-usb: Always check for syscon compatible
In-Reply-To: <1516418424-28686-1-git-send-email-david@lechnology.com>
References: <1516418424-28686-1-git-send-email-david@lechnology.com>
Message-ID: <1516418424-28686-3-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This slightly changes the logic for getting the CFGCHIP syscon register.
We now always call syscon_regmap_lookup_by_compatible() even when not
using device tree. This is in preparation for some changes in how the
CFGCHIP syscon regmap is registered on da8xx platforms.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/phy/ti/phy-da8xx-usb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/ti/phy-da8xx-usb.c b/drivers/phy/ti/phy-da8xx-usb.c
index 1b82bff..d463587 100644
--- a/drivers/phy/ti/phy-da8xx-usb.c
+++ b/drivers/phy/ti/phy-da8xx-usb.c
@@ -152,10 +152,8 @@ static int da8xx_usb_phy_probe(struct platform_device *pdev)
 	if (!d_phy)
 		return -ENOMEM;
 
-	if (node)
-		d_phy->regmap = syscon_regmap_lookup_by_compatible(
-							"ti,da830-cfgchip");
-	else
+	d_phy->regmap = syscon_regmap_lookup_by_compatible("ti,da830-cfgchip");
+	if (IS_ERR(d_phy->regmap))
 		d_phy->regmap = syscon_regmap_lookup_by_pdevname("syscon");
 	if (IS_ERR(d_phy->regmap)) {
 		dev_err(dev, "Failed to get syscon\n");
-- 
2.7.4
