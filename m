From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 20 Jul 2018 16:56:07 +0200
Subject: [PATCH RESEND 4/7] of: address: Add support for the dma-parent
 property
In-Reply-To: <cover.d2aafc48da035aed80793da89079e5da269b45b4.1532098561.git-series.maxime.ripard@bootlin.com>
References: <cover.d2aafc48da035aed80793da89079e5da269b45b4.1532098561.git-series.maxime.ripard@bootlin.com>
Message-ID: <70c2bc34aef2006e371de70988dc66926a4f4642.1532098561.git-series.maxime.ripard@bootlin.com>
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
 drivers/of/address.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 9e637bf8102c..e4c8207871d1 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -680,10 +680,18 @@ EXPORT_SYMBOL(of_translate_address);
 
 u64 of_translate_dma_address(struct device_node *dev, const __be32 *in_addr)
 {
+	struct of_phandle_args args;
+	struct device_node *parent = NULL;
 	struct device_node *host;
 	u64 ret;
 
-	ret = __of_translate_address(dev, NULL, in_addr, "dma-ranges", &host);
+	ret = of_parse_phandle_with_args(dev, "dma-parent",
+					 "#dma-parent-cells",
+					 0, &args);
+	if (!ret)
+		parent = args.np;
+
+	ret = __of_translate_address(dev, parent, in_addr, "dma-ranges", &host);
 
 	if (host) {
 		of_node_put(host);
@@ -909,11 +917,21 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
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
