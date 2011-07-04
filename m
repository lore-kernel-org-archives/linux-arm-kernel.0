From: manjugk@ti.com (Manjunatha GK)
Date: Mon, 4 Jul 2011 19:42:45 +0530
Subject: [PATCH v2] DT: Use helper function to read u32 values
Message-ID: <CAP6yH7cpP7C_h2mJNBqy-UW9_Sg4734j+2dYsK9bdF+99yY3=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use helper function of_property_read_u32() in place of
of_get_property and be32_to_cpup() api's for code optimization.

Compile tested the changes.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
---
 drivers/of/irq.c     |   39 +++++++++++++++++++--------------------
 drivers/of/of_i2c.c  |    8 +++-----
 drivers/of/of_mdio.c |    8 +++-----
 3 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 9f689f1..30cd3b7 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -59,20 +59,19 @@ EXPORT_SYMBOL_GPL(irq_of_parse_and_map);
 struct device_node *of_irq_find_parent(struct device_node *child)
 {
 	struct device_node *p;
-	const __be32 *parp;
+	u32 parp;

 	if (!of_node_get(child))
 		return NULL;

 	do {
-		parp = of_get_property(child, "interrupt-parent", NULL);
-		if (parp == NULL)
+		if (of_property_read_u32(child, "interrupt-parent", &parp))
 			p = of_get_parent(child);
 		else {
 			if (of_irq_workarounds & OF_IMAP_NO_PHANDLE)
 				p = of_node_get(of_irq_dflt_pic);
 			else
-				p = of_find_node_by_phandle(be32_to_cpup(parp));
+				p = of_find_node_by_phandle(parp);
 		}
 		of_node_put(child);
 		child = p;
@@ -100,7 +99,8 @@ int of_irq_map_raw(struct device_node *parent,
const __be32 *intspec,
 		   u32 ointsize, const __be32 *addr, struct of_irq *out_irq)
 {
 	struct device_node *ipar, *tnode, *old = NULL, *newpar = NULL;
-	const __be32 *tmp, *imap, *imask;
+	const __be32 *imap, *imask;
+	u32 tmp;
 	u32 intsize = 1, addrsize, newintsize = 0, newaddrsize = 0;
 	int imaplen, match, i;

@@ -115,9 +115,8 @@ int of_irq_map_raw(struct device_node *parent,
const __be32 *intspec,
 	 * is none, we are nice and just walk up the tree
 	 */
 	do {
-		tmp = of_get_property(ipar, "#interrupt-cells", NULL);
-		if (tmp != NULL) {
-			intsize = be32_to_cpu(*tmp);
+		if (!of_property_read_u32(ipar, "#interrupt-cells", &tmp)) {
+			intsize = tmp;
 			break;
 		}
 		tnode = ipar;
@@ -139,14 +138,14 @@ int of_irq_map_raw(struct device_node *parent,
const __be32 *intspec,
 	 */
 	old = of_node_get(ipar);
 	do {
-		tmp = of_get_property(old, "#address-cells", NULL);
+		i = of_property_read_u32(old, "#address-cells", &tmp);
 		tnode = of_get_parent(old);
 		of_node_put(old);
 		old = tnode;
-	} while (old && tmp == NULL);
+	} while (old && i < 0);
 	of_node_put(old);
 	old = NULL;
-	addrsize = (tmp == NULL) ? 2 : be32_to_cpu(*tmp);
+	addrsize = (i < 0) ? 2 : tmp;

 	pr_debug(" -> addrsize=%d\n", addrsize);

@@ -225,14 +224,14 @@ int of_irq_map_raw(struct device_node *parent,
const __be32 *intspec,
 			/* Get #interrupt-cells and #address-cells of new
 			 * parent
 			 */
-			tmp = of_get_property(newpar, "#interrupt-cells", NULL);
-			if (tmp == NULL) {
+			if (of_property_read_u32(newpar, "#interrupt-cells",
+									&tmp)) {
 				pr_debug(" -> parent lacks #interrupt-cells!\n");
 				goto fail;
 			}
-			newintsize = be32_to_cpu(*tmp);
-			tmp = of_get_property(newpar, "#address-cells", NULL);
-			newaddrsize = (tmp == NULL) ? 0 : be32_to_cpu(*tmp);
+			newintsize = tmp;
+			i = of_property_read_u32(newpar, "#address-cells", &tmp);
+			newaddrsize = (i < 0) ? 0 : tmp;

 			pr_debug(" -> newintsize=%d, newaddrsize=%d\n",
 			    newintsize, newaddrsize);
@@ -284,7 +283,8 @@ EXPORT_SYMBOL_GPL(of_irq_map_raw);
 int of_irq_map_one(struct device_node *device, int index, struct
of_irq *out_irq)
 {
 	struct device_node *p;
-	const __be32 *intspec, *tmp, *addr;
+	const __be32 *intspec, *addr;
+	u32 tmp;
 	u32 intsize, intlen;
 	int res = -EINVAL;

@@ -311,10 +311,9 @@ int of_irq_map_one(struct device_node *device,
int index, struct of_irq *out_irq
 		return -EINVAL;

 	/* Get size of interrupt specifier */
-	tmp = of_get_property(p, "#interrupt-cells", NULL);
-	if (tmp == NULL)
+	if (of_property_read_u32(p, "#interrupt-cells", &tmp))
 		goto out;
-	intsize = be32_to_cpu(*tmp);
+	intsize = tmp;

 	pr_debug(" intsize=%d intlen=%d\n", intsize, intlen);

diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index f37fbeb..371b591 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -32,8 +32,7 @@ void of_i2c_register_devices(struct i2c_adapter *adap)
 	for_each_child_of_node(adap->dev.of_node, node) {
 		struct i2c_board_info info = {};
 		struct dev_archdata dev_ad = {};
-		const __be32 *addr;
-		int len;
+		u32 addr;

 		dev_dbg(&adap->dev, "of_i2c: register %s\n", node->full_name);

@@ -43,14 +42,13 @@ void of_i2c_register_devices(struct i2c_adapter *adap)
 			continue;
 		}

-		addr = of_get_property(node, "reg", &len);
-		if (!addr || (len < sizeof(int))) {
+		if (of_property_read_u32(node, "reg", &addr)) {
 			dev_err(&adap->dev, "of_i2c: invalid reg on %s\n",
 				node->full_name);
 			continue;
 		}

-		info.addr = be32_to_cpup(addr);
+		info.addr = addr;
 		if (info.addr > (1 << 10) - 1) {
 			dev_err(&adap->dev, "of_i2c: invalid addr=%x on %s\n",
 				info.addr, node->full_name);
diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index d35e300..9064b76 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -52,19 +52,17 @@ int of_mdiobus_register(struct mii_bus *mdio,
struct device_node *np)

 	/* Loop over the child nodes and register a phy_device for each one */
 	for_each_child_of_node(np, child) {
-		const __be32 *paddr;
+		u32 paddr;
 		u32 addr;
-		int len;

 		/* A PHY must have a reg property in the range [0-31] */
-		paddr = of_get_property(child, "reg", &len);
-		if (!paddr || len < sizeof(*paddr)) {
+		if (of_property_read_u32(child, "reg", &paddr)) {
 			dev_err(&mdio->dev, "%s has invalid PHY address\n",
 				child->full_name);
 			continue;
 		}

-		addr = be32_to_cpup(paddr);
+		addr = paddr;
 		if (addr >= 32) {
 			dev_err(&mdio->dev, "%s PHY address %i is too large\n",
 				child->full_name, addr);
-- 
1.7.4.1
