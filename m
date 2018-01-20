From: david@lechnology.com (David Lechner)
Date: Fri, 19 Jan 2018 21:20:21 -0600
Subject: [PATCH 3/6] phy: da8xx-usb: rename clock con_ids
In-Reply-To: <1516418424-28686-1-git-send-email-david@lechnology.com>
References: <1516418424-28686-1-git-send-email-david@lechnology.com>
Message-ID: <1516418424-28686-4-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This renames the clock con_ids in the DA8XX USB PHY driver as well as
the matching names in the mach clock registration code.

This is in preparation for using device tree clocks where these names
will become part of the device tree bindings. The new names more closely
match the names used in the USB clock diagram in the SoC TRM.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/usb-da8xx.c | 12 ++++++------
 drivers/phy/ti/phy-da8xx-usb.c    |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index d480a02..fb31f6e 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -256,14 +256,14 @@ static int usb20_phy_clk_set_parent(struct clk *clk, struct clk *parent)
 }
 
 static struct clk usb20_phy_clk = {
-	.name		= "usb20_phy",
+	.name		= "usb0_clk48",
 	.clk_enable	= usb20_phy_clk_enable,
 	.clk_disable	= usb20_phy_clk_disable,
 	.set_parent	= usb20_phy_clk_set_parent,
 };
 
 static struct clk_lookup usb20_phy_clk_lookup =
-	CLK("da8xx-usb-phy", "usb20_phy", &usb20_phy_clk);
+	CLK("da8xx-usb-phy", "usb0_clk48", &usb20_phy_clk);
 
 /**
  * da8xx_register_usb20_phy_clk - register USB0PHYCLKMUX clock
@@ -320,18 +320,18 @@ static int usb11_phy_clk_set_parent(struct clk *clk, struct clk *parent)
 }
 
 static struct clk usb11_phy_clk = {
-	.name		= "usb11_phy",
+	.name		= "usb1_clk48",
 	.set_parent	= usb11_phy_clk_set_parent,
 };
 
 static struct clk_lookup usb11_phy_clk_lookup =
-	CLK("da8xx-usb-phy", "usb11_phy", &usb11_phy_clk);
+	CLK("da8xx-usb-phy", "usb1_clk48", &usb11_phy_clk);
 
 /**
  * da8xx_register_usb11_phy_clk - register USB1PHYCLKMUX clock
  *
  * @use_usb_refclkin: Selects the parent clock - either "usb_refclkin" if true
- *	or "usb20_phy" if false.
+ *	or "usb0_clk48" if false.
  */
 int __init da8xx_register_usb11_phy_clk(bool use_usb_refclkin)
 {
@@ -341,7 +341,7 @@ int __init da8xx_register_usb11_phy_clk(bool use_usb_refclkin)
 	if (use_usb_refclkin)
 		parent = clk_get(NULL, "usb_refclkin");
 	else
-		parent = clk_get(&da8xx_usb_phy.dev, "usb20_phy");
+		parent = clk_get(&da8xx_usb_phy.dev, "usb0_clk48");
 	if (IS_ERR(parent))
 		return PTR_ERR(parent);
 
diff --git a/drivers/phy/ti/phy-da8xx-usb.c b/drivers/phy/ti/phy-da8xx-usb.c
index d463587..4daa905 100644
--- a/drivers/phy/ti/phy-da8xx-usb.c
+++ b/drivers/phy/ti/phy-da8xx-usb.c
@@ -160,15 +160,15 @@ static int da8xx_usb_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(d_phy->regmap);
 	}
 
-	d_phy->usb11_clk = devm_clk_get(dev, "usb11_phy");
+	d_phy->usb11_clk = devm_clk_get(dev, "usb1_clk48");
 	if (IS_ERR(d_phy->usb11_clk)) {
-		dev_err(dev, "Failed to get usb11_phy clock\n");
+		dev_err(dev, "Failed to get usb1_clk48\n");
 		return PTR_ERR(d_phy->usb11_clk);
 	}
 
-	d_phy->usb20_clk = devm_clk_get(dev, "usb20_phy");
+	d_phy->usb20_clk = devm_clk_get(dev, "usb0_clk48");
 	if (IS_ERR(d_phy->usb20_clk)) {
-		dev_err(dev, "Failed to get usb20_phy clock\n");
+		dev_err(dev, "Failed to get usb0_clk48\n");
 		return PTR_ERR(d_phy->usb20_clk);
 	}
 
-- 
2.7.4
