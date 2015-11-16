From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Mon, 16 Nov 2015 12:33:15 +0100
Subject: [PATCH 2/7] phy: mt65xx-usb3: add missing of_node_put
In-Reply-To: <1447673600-8881-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1447673600-8881-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1447673600-8881-3-git-send-email-Julia.Lawall@lip6.fr>
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
 drivers/phy/phy-mt65xx-usb3.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/phy-mt65xx-usb3.c b/drivers/phy/phy-mt65xx-usb3.c
index f30b28b..e427c3b 100644
--- a/drivers/phy/phy-mt65xx-usb3.c
+++ b/drivers/phy/phy-mt65xx-usb3.c
@@ -415,7 +415,7 @@ static int mt65xx_u3phy_probe(struct platform_device *pdev)
 	struct resource *sif_res;
 	struct mt65xx_u3phy *u3phy;
 	struct resource res;
-	int port;
+	int port, retval;
 
 	u3phy = devm_kzalloc(dev, sizeof(*u3phy), GFP_KERNEL);
 	if (!u3phy)
@@ -447,31 +447,34 @@ static int mt65xx_u3phy_probe(struct platform_device *pdev)
 	for_each_child_of_node(np, child_np) {
 		struct mt65xx_phy_instance *instance;
 		struct phy *phy;
-		int retval;
 
 		instance = devm_kzalloc(dev, sizeof(*instance), GFP_KERNEL);
-		if (!instance)
-			return -ENOMEM;
+		if (!instance) {
+			retval = -ENOMEM;
+			goto put_child;
+		}
 
 		u3phy->phys[port] = instance;
 
 		phy = devm_phy_create(dev, child_np, &mt65xx_u3phy_ops);
 		if (IS_ERR(phy)) {
 			dev_err(dev, "failed to create phy\n");
-			return PTR_ERR(phy);
+			retval = PTR_ERR(phy);
+			goto put_child;
 		}
 
 		retval = of_address_to_resource(child_np, 0, &res);
 		if (retval) {
 			dev_err(dev, "failed to get address resource(id-%d)\n",
 				port);
-			return retval;
+			goto put_child;
 		}
 
 		instance->port_base = devm_ioremap_resource(&phy->dev, &res);
 		if (IS_ERR(instance->port_base)) {
 			dev_err(dev, "failed to remap phy regs\n");
-			return PTR_ERR(instance->port_base);
+			retval = PTR_ERR(instance->port_base);
+			goto put_child;
 		}
 
 		instance->phy = phy;
@@ -483,6 +486,9 @@ static int mt65xx_u3phy_probe(struct platform_device *pdev)
 	provider = devm_of_phy_provider_register(dev, mt65xx_phy_xlate);
 
 	return PTR_ERR_OR_ZERO(provider);
+put_child:
+	of_node_put(child_np);
+	return retval;
 }
 
 static const struct of_device_id mt65xx_u3phy_id_table[] = {
