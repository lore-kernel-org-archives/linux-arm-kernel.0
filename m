From: roel.kluin@gmail.com (Roel Kluin)
Date: Fri, 22 Jan 2010 19:57:05 +0100
Subject: [PATCH] mach-pnx4008/dma.c: clean up duplication in
	pnx4008_dma_split_{head, ll}_entry()
Message-ID: <4B59F501.6010607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It appears unnecessary to duplicate these loops.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 arch/arm/mach-pnx4008/dma.c |  198 +++++++++++++++----------------------------
 1 files changed, 67 insertions(+), 131 deletions(-)

diff --git a/arch/arm/mach-pnx4008/dma.c b/arch/arm/mach-pnx4008/dma.c
index 425f718..d9302d3 100644
--- a/arch/arm/mach-pnx4008/dma.c
+++ b/arch/arm/mach-pnx4008/dma.c
@@ -731,78 +731,46 @@ void pnx4008_dma_split_head_entry(struct pnx4008_dma_config * config,
 	}
 	if (num_entries != 0) {
 		struct pnx4008_dma_ll *ll = NULL;
+		struct pnx4008_dma_ll *ll_old;
+		unsigned long ll_dma_old;
 		config->ch_ctrl &= ~0x7ff;
 		config->ch_ctrl |= new_len;
-		if (!config->is_ll) {
-			config->is_ll = 1;
-			while (num_entries) {
-				if (!ll) {
-					config->ll =
-					    pnx4008_alloc_ll_entry(&config->
-								   ll_dma);
-					ll = config->ll;
-				} else {
-					ll->next =
-					    pnx4008_alloc_ll_entry(&ll->
-								   next_dma);
-					ll = ll->next;
-				}
-
-				if (ctrl->si)
-					ll->src_addr =
-					    config->src_addr +
-					    src_width * new_len * count;
-				else
-					ll->src_addr = config->src_addr;
-				if (ctrl->di)
-					ll->dest_addr =
-					    config->dest_addr +
-					    dest_width * new_len * count;
-				else
-					ll->dest_addr = config->dest_addr;
-				ll->ch_ctrl = config->ch_ctrl & 0x7fffffff;
-				ll->next_dma = 0;
-				ll->next = NULL;
-				num_entries--;
-				count++;
-			}
-		} else {
-			struct pnx4008_dma_ll *ll_old = config->ll;
-			unsigned long ll_dma_old = config->ll_dma;
-			while (num_entries) {
-				if (!ll) {
-					config->ll =
-					    pnx4008_alloc_ll_entry(&config->
-								   ll_dma);
-					ll = config->ll;
-				} else {
-					ll->next =
-					    pnx4008_alloc_ll_entry(&ll->
-								   next_dma);
-					ll = ll->next;
-				}
-
-				if (ctrl->si)
-					ll->src_addr =
-					    config->src_addr +
-					    src_width * new_len * count;
-				else
-					ll->src_addr = config->src_addr;
-				if (ctrl->di)
-					ll->dest_addr =
-					    config->dest_addr +
-					    dest_width * new_len * count;
-				else
-					ll->dest_addr = config->dest_addr;
-				ll->ch_ctrl = config->ch_ctrl & 0x7fffffff;
-				ll->next_dma = 0;
-				ll->next = NULL;
-				num_entries--;
-				count++;
+		if (config->is_ll) {
+			ll_old = config->ll;
+			config->ll_dma;
+		}
+		while (num_entries) {
+			if (!ll) {
+				config->ll = pnx4008_alloc_ll_entry(
+						&config->ll_dma);
+				ll = config->ll;
+			} else {
+				ll->next = pnx4008_alloc_ll_entry(
+						&ll-> next_dma);
+				ll = ll->next;
 			}
+
+			if (ctrl->si)
+				ll->src_addr = config->src_addr +
+					src_width * new_len * count;
+			else
+				ll->src_addr = config->src_addr;
+			if (ctrl->di)
+				ll->dest_addr = config->dest_addr +
+					dest_width * new_len * count;
+			else
+				ll->dest_addr = config->dest_addr;
+			ll->ch_ctrl = config->ch_ctrl & 0x7fffffff;
+			ll->next_dma = 0;
+			ll->next = NULL;
+			num_entries--;
+			count++;
+		}
+		if (config->is_ll) {
 			ll->next_dma = ll_dma_old;
 			ll->next = ll_old;
 		}
+		config->is_ll = 1;
 		/* adjust last length/tc */
 		ll->ch_ctrl = config->ch_ctrl & (~0x7ff);
 		ll->ch_ctrl |= old_len - new_len * (count - 1);
@@ -853,75 +821,43 @@ void pnx4008_dma_split_ll_entry(struct pnx4008_dma_ll * cur_ll,
 	}
 	if (num_entries != 0) {
 		struct pnx4008_dma_ll *ll = NULL;
+		struct pnx4008_dma_ll *ll_old;
+		unsigned long ll_dma_old;
 		cur_ll->ch_ctrl &= ~0x7ff;
 		cur_ll->ch_ctrl |= new_len;
-		if (!cur_ll->next) {
-			while (num_entries) {
-				if (!ll) {
-					cur_ll->next =
-					    pnx4008_alloc_ll_entry(&cur_ll->
-								   next_dma);
-					ll = cur_ll->next;
-				} else {
-					ll->next =
-					    pnx4008_alloc_ll_entry(&ll->
-								   next_dma);
-					ll = ll->next;
-				}
-
-				if (ctrl->si)
-					ll->src_addr =
-					    cur_ll->src_addr +
-					    src_width * new_len * count;
-				else
-					ll->src_addr = cur_ll->src_addr;
-				if (ctrl->di)
-					ll->dest_addr =
-					    cur_ll->dest_addr +
-					    dest_width * new_len * count;
-				else
-					ll->dest_addr = cur_ll->dest_addr;
-				ll->ch_ctrl = cur_ll->ch_ctrl & 0x7fffffff;
-				ll->next_dma = 0;
-				ll->next = NULL;
-				num_entries--;
-				count++;
-			}
-		} else {
-			struct pnx4008_dma_ll *ll_old = cur_ll->next;
-			unsigned long ll_dma_old = cur_ll->next_dma;
-			while (num_entries) {
-				if (!ll) {
-					cur_ll->next =
-					    pnx4008_alloc_ll_entry(&cur_ll->
-								   next_dma);
-					ll = cur_ll->next;
-				} else {
-					ll->next =
-					    pnx4008_alloc_ll_entry(&ll->
-								   next_dma);
-					ll = ll->next;
-				}
-
-				if (ctrl->si)
-					ll->src_addr =
-					    cur_ll->src_addr +
-					    src_width * new_len * count;
-				else
-					ll->src_addr = cur_ll->src_addr;
-				if (ctrl->di)
-					ll->dest_addr =
-					    cur_ll->dest_addr +
-					    dest_width * new_len * count;
-				else
-					ll->dest_addr = cur_ll->dest_addr;
-				ll->ch_ctrl = cur_ll->ch_ctrl & 0x7fffffff;
-				ll->next_dma = 0;
-				ll->next = NULL;
-				num_entries--;
-				count++;
+
+		if (cur_ll->next) {
+			ll_old = cur_ll->next;
+			ll_dma_old = cur_ll->next_dma;
+		}
+		while (num_entries) {
+			if (!ll) {
+				cur_ll->next = pnx4008_alloc_ll_entry(
+						&cur_ll->next_dma);
+				ll = cur_ll->next;
+			} else {
+				ll->next = pnx4008_alloc_ll_entry(
+						&ll->next_dma);
+				ll = ll->next;
 			}
 
+			if (ctrl->si)
+				ll->src_addr = cur_ll->src_addr +
+					src_width * new_len * count;
+			else
+				ll->src_addr = cur_ll->src_addr;
+			if (ctrl->di)
+				ll->dest_addr = cur_ll->dest_addr +
+				    dest_width * new_len * count;
+			else
+				ll->dest_addr = cur_ll->dest_addr;
+			ll->ch_ctrl = cur_ll->ch_ctrl & 0x7fffffff;
+			ll->next_dma = 0;
+			ll->next = NULL;
+			num_entries--;
+			count++;
+		}
+		if (cur_ll->next) {
 			ll->next_dma = ll_dma_old;
 			ll->next = ll_old;
 		}
