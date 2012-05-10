From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 10 May 2012 15:19:35 +0200
Subject: [PATCH] drivers: cma: don't fail if migration returns -EAGAIN
In-Reply-To: <1333462221-3987-1-git-send-email-m.szyprowski@samsung.com>
References: <1333462221-3987-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1336655975-15729-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

alloc_contig_range() function might return -EAGAIN if migrate_pages() call
fails for some temporarily locked pages. Such case should not be fatal
to dma_alloc_from_contiguous(), which should retry allocation like in case
of -EBUSY error.

Reported-by: Haojian Zhuang <haojian.zhuang@gmail.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/base/dma-contiguous.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
index 78efb03..e46e2fb 100644
--- a/drivers/base/dma-contiguous.c
+++ b/drivers/base/dma-contiguous.c
@@ -346,7 +346,7 @@ struct page *dma_alloc_from_contiguous(struct device *dev, int count,
 		if (ret == 0) {
 			bitmap_set(cma->bitmap, pageno, count);
 			break;
-		} else if (ret != -EBUSY) {
+		} else if (ret != -EBUSY && ret != -EAGAIN) {
 			goto error;
 		}
 		pr_debug("%s(): memory range at %p is busy, retrying\n",
-- 
1.7.1.569.g6f426
