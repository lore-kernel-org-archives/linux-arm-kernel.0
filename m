From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue,  3 Apr 2018 15:29:16 +0200
Subject: [PATCH 3/7] of: address: Add parent pointer to the
 __of_translate_address args
In-Reply-To: <cover.54a07919b9d7fe8d7c90e9f4929648013e641cff.1522761929.git-series.maxime.ripard@bootlin.com>
References: <cover.54a07919b9d7fe8d7c90e9f4929648013e641cff.1522761929.git-series.maxime.ripard@bootlin.com>
Message-ID: <49c86515e35889906ad61400261260a89e315dc1.1522761929.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __of_translate_address function is used to translate the device tree
addresses to physical addresses using the various ranges property to create
the offset.

However, it's shared between the CPU addresses (based on the ranges
property) and the DMA addresses (based on dma-ranges). Since we're going to
add support for a DMA parent node that is not the DT parent node, we need
to change the logic a bit to have an optional parent node that we should
use.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/of/address.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index ce4d3d8b85de..e3267728a0cb 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -562,9 +562,9 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
  * that way, but this is traditionally the way IBM at least do things
  */
 static u64 __of_translate_address(struct device_node *dev,
+				  struct device_node *parent,
 				  const __be32 *in_addr, const char *rprop)
 {
-	struct device_node *parent = NULL;
 	struct of_bus *bus, *pbus;
 	__be32 addr[OF_MAX_ADDR_CELLS];
 	int na, ns, pna, pns;
@@ -575,10 +575,13 @@ static u64 __of_translate_address(struct device_node *dev,
 	/* Increase refcount at current level */
 	of_node_get(dev);
 
-	/* Get parent & match bus type */
-	parent = of_get_parent(dev);
-	if (parent == NULL)
-		goto bail;
+	if (!parent) {
+		/* Get parent & match bus type */
+		parent = of_get_parent(dev);
+		if (parent == NULL)
+			goto bail;
+	}
+
 	bus = of_match_bus(parent);
 
 	/* Count address cells & copy address locally */
@@ -638,13 +641,13 @@ static u64 __of_translate_address(struct device_node *dev,
 
 u64 of_translate_address(struct device_node *dev, const __be32 *in_addr)
 {
-	return __of_translate_address(dev, in_addr, "ranges");
+	return __of_translate_address(dev, NULL, in_addr, "ranges");
 }
 EXPORT_SYMBOL(of_translate_address);
 
 u64 of_translate_dma_address(struct device_node *dev, const __be32 *in_addr)
 {
-	return __of_translate_address(dev, in_addr, "dma-ranges");
+	return __of_translate_address(dev, NULL, in_addr, "dma-ranges");
 }
 EXPORT_SYMBOL(of_translate_dma_address);
 
-- 
git-series 0.9.1
