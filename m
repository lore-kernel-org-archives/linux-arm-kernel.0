From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Mon, 16 Nov 2015 12:33:19 +0100
Subject: [PATCH 6/7] phy: miphy365x: add missing of_node_put
In-Reply-To: <1447673600-8881-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1447673600-8881-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1447673600-8881-7-git-send-email-Julia.Lawall@lip6.fr>
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
 drivers/phy/phy-miphy365x.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/phy-miphy365x.c b/drivers/phy/phy-miphy365x.c
index 00a686a..e661f3b 100644
--- a/drivers/phy/phy-miphy365x.c
+++ b/drivers/phy/phy-miphy365x.c
@@ -566,22 +566,25 @@ static int miphy365x_probe(struct platform_device *pdev)
 
 		miphy_phy = devm_kzalloc(&pdev->dev, sizeof(*miphy_phy),
 					 GFP_KERNEL);
-		if (!miphy_phy)
-			return -ENOMEM;
+		if (!miphy_phy) {
+			ret = -ENOMEM;
+			goto put_child;
+		}
 
 		miphy_dev->phys[port] = miphy_phy;
 
 		phy = devm_phy_create(&pdev->dev, child, &miphy365x_ops);
 		if (IS_ERR(phy)) {
 			dev_err(&pdev->dev, "failed to create PHY\n");
-			return PTR_ERR(phy);
+			ret = PTR_ERR(phy);
+			goto put_child;
 		}
 
 		miphy_dev->phys[port]->phy = phy;
 
 		ret = miphy365x_of_probe(child, miphy_phy);
 		if (ret)
-			return ret;
+			goto put_child;
 
 		phy_set_drvdata(phy, miphy_dev->phys[port]);
 
@@ -591,12 +594,15 @@ static int miphy365x_probe(struct platform_device *pdev)
 					&miphy_phy->ctrlreg);
 		if (ret) {
 			dev_err(&pdev->dev, "No sysconfig offset found\n");
-			return ret;
+			goto put_child;
 		}
 	}
 
 	provider = devm_of_phy_provider_register(&pdev->dev, miphy365x_xlate);
 	return PTR_ERR_OR_ZERO(provider);
+put_child:
+	of_node_put(child);
+	return ret;
 }
 
 static const struct of_device_id miphy365x_of_match[] = {
