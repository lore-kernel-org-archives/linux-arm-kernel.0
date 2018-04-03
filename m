From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue,  3 Apr 2018 15:29:17 +0200
Subject: [PATCH 4/7] of: address: Add support for the dma-parent property
In-Reply-To: <cover.54a07919b9d7fe8d7c90e9f4929648013e641cff.1522761929.git-series.maxime.ripard@bootlin.com>
References: <cover.54a07919b9d7fe8d7c90e9f4929648013e641cff.1522761929.git-series.maxime.ripard@bootlin.com>
Message-ID: <9c1caa06023916ca39d647edd169d37d8ea8d3d7.1522761929.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some SoCs have devices that are using a separate bus from the main bus to
perform DMA.

These buses might have some restrictions and/or different mapping than from
the CPU side, so we'd need to express those using the usual dma-ranges, but
using a different DT node than the node's parent.

Add support for a dma-parent property that links to the DMA bus used by the
device in such a case.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/of/address.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index e3267728a0cb..cc82f825ee03 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -647,7 +647,17 @@ EXPORT_SYMBOL(of_translate_address);
 
 u64 of_translate_dma_address(struct device_node *dev, const __be32 *in_addr)
 {
-	return __of_translate_address(dev, NULL, in_addr, "dma-ranges");
+	struct of_phandle_args args;
+	struct device_node *parent = NULL;
+	int ret;
+
+	ret = of_parse_phandle_with_args(dev, "dma-parent",
+					 "#dma-parent-cells",
+					 0, &args);
+	if (!ret)
+		parent = args.np;
+
+	return __of_translate_address(dev, parent, in_addr, "dma-ranges");
 }
 EXPORT_SYMBOL(of_translate_dma_address);
 
@@ -847,11 +857,21 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 		return -EINVAL;
 
 	while (1) {
+		struct of_phandle_args args;
+
 		naddr = of_n_addr_cells(node);
 		nsize = of_n_size_cells(node);
-		node = of_get_next_parent(node);
-		if (!node)
-			break;
+
+		ret = of_parse_phandle_with_args(node, "dma-parent",
+						 "#dma-parent-cells",
+						 0, &args);
+		if (!ret) {
+			node = args.np;
+		} else {
+			node = of_get_next_parent(node);
+			if (!node)
+				break;
+		}
 
 		ranges = of_get_property(node, "dma-ranges", &len);
 
-- 
git-series 0.9.1
