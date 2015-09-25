From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 25 Sep 2015 13:15:45 +0100
Subject: [PATCH 3/4] dma-debug: Check nents in dma_sync_sg*
In-Reply-To: <cover.1443178314.git.robin.murphy@arm.com>
References: <cover.1443178314.git.robin.murphy@arm.com>
Message-ID: <c725a1746c556d8aa532a53a5f30bb2005a9ddae.1443178314.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Like dma_unmap_sg, dma_sync_sg* should be called with the original
number of entries passed to dma_map_sg, so do the same check in the sync
path as we do in the unmap path.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 lib/dma-debug.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/dma-debug.c b/lib/dma-debug.c
index dace71f..908fb35 100644
--- a/lib/dma-debug.c
+++ b/lib/dma-debug.c
@@ -1249,6 +1249,14 @@ static void check_sync(struct device *dev,
 				dir2name[entry->direction],
 				dir2name[ref->direction]);
 
+	if (ref->sg_call_ents && ref->type == dma_debug_sg &&
+	    ref->sg_call_ents != entry->sg_call_ents) {
+		err_printk(ref->dev, entry, "DMA-API: device driver syncs "
+			   "DMA sg list with different entry count "
+			   "[map count=%d] [sync count=%d]\n",
+			   entry->sg_call_ents, ref->sg_call_ents);
+	}
+
 out:
 	put_hash_bucket(bucket, &flags);
 }
-- 
1.9.1
