From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Mon, 16 Nov 2015 12:33:20 +0100
Subject: [PATCH 7/7] phy: cygnus: pcie: add missing of_node_put
In-Reply-To: <1447673600-8881-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1447673600-8881-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1447673600-8881-8-git-send-email-Julia.Lawall@lip6.fr>
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
 drivers/phy/phy-bcm-cygnus-pcie.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/phy-bcm-cygnus-pcie.c b/drivers/phy/phy-bcm-cygnus-pcie.c
index 7ad72b7..082c03f 100644
--- a/drivers/phy/phy-bcm-cygnus-pcie.c
+++ b/drivers/phy/phy-bcm-cygnus-pcie.c
@@ -128,6 +128,7 @@ static int cygnus_pcie_phy_probe(struct platform_device *pdev)
 	struct phy_provider *provider;
 	struct resource *res;
 	unsigned cnt = 0;
+	int ret;
 
 	if (of_get_child_count(node) == 0) {
 		dev_err(dev, "PHY no child node\n");
@@ -154,24 +155,28 @@ static int cygnus_pcie_phy_probe(struct platform_device *pdev)
 		if (of_property_read_u32(child, "reg", &id)) {
 			dev_err(dev, "missing reg property for %s\n",
 				child->name);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto put_child;
 		}
 
 		if (id >= MAX_NUM_PHYS) {
 			dev_err(dev, "invalid PHY id: %u\n", id);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto put_child;
 		}
 
 		if (core->phys[id].phy) {
 			dev_err(dev, "duplicated PHY id: %u\n", id);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto put_child;
 		}
 
 		p = &core->phys[id];
 		p->phy = devm_phy_create(dev, child, &cygnus_pcie_phy_ops);
 		if (IS_ERR(p->phy)) {
 			dev_err(dev, "failed to create PHY\n");
-			return PTR_ERR(p->phy);
+			ret = PTR_ERR(p->phy);
+			goto put_child;
 		}
 
 		p->core = core;
@@ -191,6 +196,9 @@ static int cygnus_pcie_phy_probe(struct platform_device *pdev)
 	dev_dbg(dev, "registered %u PCIe PHY(s)\n", cnt);
 
 	return 0;
+put_child:
+	of_node_put(child);
+	return ret;
 }
 
 static const struct of_device_id cygnus_pcie_phy_match_table[] = {
