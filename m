From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 11 Apr 2016 10:47:44 +0800
Subject: [PATCH] scatterlist: use sg_dma_len() in sg_set_page()
Message-ID: <1460342864-27891-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The macro sg_dma_len(sg) is commonly used to retrieve length of sg,
which could be 'dma_length' or 'length' field, depending on whether
NEED_SG_DMA_LENGTH is enabled or not.  On the other hand, many driver
code use helper function sg_set_page() to set an sg entry pointing at
a page, with offset and length set up in one call.  But sg_set_page()
does not consider NEED_SG_DMA_LENGTH case and only set up 'length'
field.  This causes problem on platforms like ARM64, where
NEED_SG_DMA_LENGTH is enabled by default, i.e. sg_set_page() sets up
'length' while sg_dma_len(sg) returns 'dma_length' field.

The patch changes sg_set_page() to use sg_dma_len() for sg length setup
as well, so that NEED_SG_DMA_LENGTH case can be handled.

Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
 include/linux/scatterlist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 556ec1ea2574..b0e32ea594c3 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -114,7 +114,7 @@ static inline void sg_set_page(struct scatterlist *sg, struct page *page,
 {
 	sg_assign_page(sg, page);
 	sg->offset = offset;
-	sg->length = len;
+	sg_dma_len(sg) = len;
 }
 
 static inline struct page *sg_page(struct scatterlist *sg)
-- 
1.9.1
