From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 31 Mar 2016 14:29:43 +0200
Subject: [PATCH 3/4] spi: use sg_alloc_table_from_buf()
In-Reply-To: <1459427384-21374-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459427384-21374-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459427384-21374-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace custom implementation of sg_alloc_table_from_buf() by a call to
sg_alloc_table_from_buf().

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/spi/spi.c | 45 +++++----------------------------------------
 1 file changed, 5 insertions(+), 40 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index de2f2f9..eed461d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -705,49 +705,14 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 		       struct sg_table *sgt, void *buf, size_t len,
 		       enum dma_data_direction dir)
 {
-	const bool vmalloced_buf = is_vmalloc_addr(buf);
-	unsigned int max_seg_size = dma_get_max_seg_size(dev);
-	int desc_len;
-	int sgs;
-	struct page *vm_page;
-	void *sg_buf;
-	size_t min;
-	int i, ret;
-
-	if (vmalloced_buf) {
-		desc_len = min_t(int, max_seg_size, PAGE_SIZE);
-		sgs = DIV_ROUND_UP(len + offset_in_page(buf), desc_len);
-	} else {
-		desc_len = min_t(int, max_seg_size, master->max_dma_len);
-		sgs = DIV_ROUND_UP(len, desc_len);
-	}
+	struct sg_constraints constraints = { };
+	int ret;
 
-	ret = sg_alloc_table(sgt, sgs, GFP_KERNEL);
-	if (ret != 0)
+	constraints.max_segment_size = dma_get_max_seg_size(dev);
+	ret = sg_alloc_table_from_buf(sgt, buf, len, &constraints, GFP_KERNEL);
+	if (ret)
 		return ret;
 
-	for (i = 0; i < sgs; i++) {
-
-		if (vmalloced_buf) {
-			min = min_t(size_t,
-				    len, desc_len - offset_in_page(buf));
-			vm_page = vmalloc_to_page(buf);
-			if (!vm_page) {
-				sg_free_table(sgt);
-				return -ENOMEM;
-			}
-			sg_set_page(&sgt->sgl[i], vm_page,
-				    min, offset_in_page(buf));
-		} else {
-			min = min_t(size_t, len, desc_len);
-			sg_buf = buf;
-			sg_set_buf(&sgt->sgl[i], sg_buf, min);
-		}
-
-		buf += min;
-		len -= min;
-	}
-
 	ret = dma_map_sg(dev, sgt->sgl, sgt->nents, dir);
 	if (!ret)
 		ret = -ENOMEM;
-- 
2.5.0
