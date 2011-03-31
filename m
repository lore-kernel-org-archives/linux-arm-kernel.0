From: hong.xu@atmel.com (Hong Xu)
Date: Thu, 31 Mar 2011 18:33:15 +0800
Subject: [PATCH] MTD: atmel_nand: Fall back to CPU I/O when buffer is in
	vmalloc(ed) region
Message-ID: <1301567595-31075-1-git-send-email-hong.xu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The previous way of dealing with vmalloc(ed) region by walking though the pages can not work well actually.
We just fall back to CPU I/O when the buffer address is higher than `high_memory'.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Hong Xu <hong.xu@atmel.com>
---
 drivers/mtd/nand/atmel_nand.c |   18 ++----------------
 1 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 1b43654..ed0863a 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -209,22 +209,8 @@ static int atmel_nand_dma_op(struct mtd_info *mtd, void *buf, int len,
 	int err = -EIO;
 	enum dma_data_direction dir = is_read ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
 
-	if (buf >= high_memory) {
-		struct page *pg;
-
-		if (((size_t)buf & PAGE_MASK) !=
-		    ((size_t)(buf + len - 1) & PAGE_MASK)) {
-			dev_warn(host->dev, "Buffer not fit in one page\n");
-			goto err_buf;
-		}
-
-		pg = vmalloc_to_page(buf);
-		if (pg == 0) {
-			dev_err(host->dev, "Failed to vmalloc_to_page\n");
-			goto err_buf;
-		}
-		p = page_address(pg) + ((size_t)buf & ~PAGE_MASK);
-	}
+	if (buf >= high_memory)
+		goto err_buf;
 
 	dma_dev = host->dma_chan->device;
 
-- 
1.7.3.3
