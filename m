From: oza.oza@broadcom.com (Oza Pawandeep)
Date: Sat, 25 Mar 2017 11:01:33 +0530
Subject: [RFC PATCH 3/3] of: fix node traversing in of_dma_get_range
In-Reply-To: <1490419893-5073-1-git-send-email-oza.oza@broadcom.com>
References: <1490419893-5073-1-git-send-email-oza.oza@broadcom.com>
Message-ID: <1490419893-5073-3-git-send-email-oza.oza@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

it jumps to the parent node without examining the child node.
also with that, it throws "no dma-ranges found for node"
for pci dma-ranges.

this patch fixes device node traversing for dma-ranges.

Reviewed-by: Anup Patel <anup.patel@broadcom.com>
Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 02b2903..3293d55 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -836,9 +836,6 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 	while (1) {
 		naddr = of_n_addr_cells(node);
 		nsize = of_n_size_cells(node);
-		node = of_get_next_parent(node);
-		if (!node)
-			break;
 
 		ranges = of_get_property(node, "dma-ranges", &len);
 
@@ -852,6 +849,10 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 		 */
 		if (!ranges)
 			break;
+
+		node = of_get_next_parent(node);
+		if (!node)
+			break;
 	}
 
 	if (!ranges) {
-- 
1.9.1
