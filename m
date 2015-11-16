From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Mon, 16 Nov 2015 12:33:14 +0100
Subject: [PATCH 1/7] phy: brcmstb-sata: add missing of_node_put
In-Reply-To: <1447673600-8881-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1447673600-8881-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1447673600-8881-2-git-send-email-Julia.Lawall@lip6.fr>
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
 drivers/phy/phy-brcmstb-sata.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/phy-brcmstb-sata.c b/drivers/phy/phy-brcmstb-sata.c
index 8a2cb16..cd9dba8 100644
--- a/drivers/phy/phy-brcmstb-sata.c
+++ b/drivers/phy/phy-brcmstb-sata.c
@@ -140,7 +140,7 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 	struct brcm_sata_phy *priv;
 	struct resource *res;
 	struct phy_provider *provider;
-	int count = 0;
+	int ret, count = 0;
 
 	if (of_get_child_count(dn) == 0)
 		return -ENODEV;
@@ -163,16 +163,19 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 		if (of_property_read_u32(child, "reg", &id)) {
 			dev_err(dev, "missing reg property in node %s\n",
 					child->name);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto put_child;
 		}
 
 		if (id >= MAX_PORTS) {
 			dev_err(dev, "invalid reg: %u\n", id);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto put_child;
 		}
 		if (priv->phys[id].phy) {
 			dev_err(dev, "already registered port %u\n", id);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto put_child;
 		}
 
 		port = &priv->phys[id];
@@ -182,7 +185,8 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 		port->ssc_en = of_property_read_bool(child, "brcm,enable-ssc");
 		if (IS_ERR(port->phy)) {
 			dev_err(dev, "failed to create PHY\n");
-			return PTR_ERR(port->phy);
+			ret = PTR_ERR(port->phy);
+			goto put_child;
 		}
 
 		phy_set_drvdata(port->phy, port);
@@ -198,6 +202,9 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 	dev_info(dev, "registered %d port(s)\n", count);
 
 	return 0;
+put_child:
+	of_node_put(child);
+	return ret;
 }
 
 static struct platform_driver brcm_sata_phy_driver = {
