From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Mon, 16 Nov 2015 12:33:17 +0100
Subject: [PATCH 4/7] phy: rockchip-usb: add missing of_node_put
In-Reply-To: <1447673600-8881-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1447673600-8881-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1447673600-8881-5-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

for_each_available_child_of_node performs an of_node_get on each iteration,
so a return from the middle of the loop requires an of_node_put.

A simplified version of the semantic patch that finds this problem is as
follows (http://coccinelle.lip6.fr):

// <smpl>
@@
expression root,e;
local idexpression child;
@@

 for_each_available_child_of_node(root, child) {
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
 drivers/phy/phy-rockchip-usb.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/phy-rockchip-usb.c b/drivers/phy/phy-rockchip-usb.c
index 91d6f34..62c43c4 100644
--- a/drivers/phy/phy-rockchip-usb.c
+++ b/drivers/phy/phy-rockchip-usb.c
@@ -108,13 +108,16 @@ static int rockchip_usb_phy_probe(struct platform_device *pdev)
 
 	for_each_available_child_of_node(dev->of_node, child) {
 		rk_phy = devm_kzalloc(dev, sizeof(*rk_phy), GFP_KERNEL);
-		if (!rk_phy)
-			return -ENOMEM;
+		if (!rk_phy) {
+			err = -ENOMEM;
+			goto put_child;
+		}
 
 		if (of_property_read_u32(child, "reg", &reg_offset)) {
 			dev_err(dev, "missing reg property in node %s\n",
 				child->name);
-			return -EINVAL;
+			err = -EINVAL;
+			goto put_child;
 		}
 
 		rk_phy->reg_offset = reg_offset;
@@ -127,18 +130,22 @@ static int rockchip_usb_phy_probe(struct platform_device *pdev)
 		rk_phy->phy = devm_phy_create(dev, child, &ops);
 		if (IS_ERR(rk_phy->phy)) {
 			dev_err(dev, "failed to create PHY\n");
-			return PTR_ERR(rk_phy->phy);
+			err = PTR_ERR(rk_phy->phy);
+			goto put_child;
 		}
 		phy_set_drvdata(rk_phy->phy, rk_phy);
 
 		/* only power up usb phy when it use, so disable it when init*/
 		err = rockchip_usb_phy_power(rk_phy, 1);
 		if (err)
-			return err;
+			goto put_child;
 	}
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 	return PTR_ERR_OR_ZERO(phy_provider);
+put_child:
+	of_node_put(child);
+	return err;
 }
 
 static const struct of_device_id rockchip_usb_phy_dt_ids[] = {
