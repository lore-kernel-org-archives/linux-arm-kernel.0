From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Mon, 16 Nov 2015 12:33:18 +0100
Subject: [PATCH 5/7] phy: miphy28lp: add missing of_node_put
In-Reply-To: <1447673600-8881-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1447673600-8881-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1447673600-8881-6-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

for_each_child_of_node performs an of_node_get on each iteration,
so a return from the middle of the loop requires an of_node_put.

A simplified version of the semantic patch that finds this problem is as
follows (http://coccinelle.lip6.fr):

// <smpl>
@@
expression root,e;
local idexpression child;
@@

 for_each_child_of_node(root, child) {
   ... when != of_node_put(child)
       when != e = child
(
   return child;
|
*  return ...;
)
   ...
 }
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/phy/phy-miphy28lp.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/phy-miphy28lp.c b/drivers/phy/phy-miphy28lp.c
index c47b56b..3acd2a1 100644
--- a/drivers/phy/phy-miphy28lp.c
+++ b/drivers/phy/phy-miphy28lp.c
@@ -1226,15 +1226,18 @@ static int miphy28lp_probe(struct platform_device *pdev)
 
 		miphy_phy = devm_kzalloc(&pdev->dev, sizeof(*miphy_phy),
 					 GFP_KERNEL);
-		if (!miphy_phy)
-			return -ENOMEM;
+		if (!miphy_phy) {
+			ret = -ENOMEM;
+			goto put_child;
+		}
 
 		miphy_dev->phys[port] = miphy_phy;
 
 		phy = devm_phy_create(&pdev->dev, child, &miphy28lp_ops);
 		if (IS_ERR(phy)) {
 			dev_err(&pdev->dev, "failed to create PHY\n");
-			return PTR_ERR(phy);
+			ret = PTR_ERR(phy);
+			goto put_child;
 		}
 
 		miphy_dev->phys[port]->phy = phy;
@@ -1242,11 +1245,11 @@ static int miphy28lp_probe(struct platform_device *pdev)
 
 		ret = miphy28lp_of_probe(child, miphy_phy);
 		if (ret)
-			return ret;
+			goto put_child;
 
 		ret = miphy28lp_probe_resets(child, miphy_dev->phys[port]);
 		if (ret)
-			return ret;
+			goto put_child;
 
 		phy_set_drvdata(phy, miphy_dev->phys[port]);
 		port++;
@@ -1255,6 +1258,9 @@ static int miphy28lp_probe(struct platform_device *pdev)
 
 	provider = devm_of_phy_provider_register(&pdev->dev, miphy28lp_xlate);
 	return PTR_ERR_OR_ZERO(provider);
+put_child:
+	of_node_put(child);
+	return ret;
 }
 
 static const struct of_device_id miphy28lp_of_match[] = {
