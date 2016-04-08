From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 8 Apr 2016 17:08:03 +0800
Subject: [PATCH] usb: core: buffer: avoid NULL pointer dereferrence
Message-ID: <1460106483-24793-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NULL pointer dereferrence will happen when class driver
wants to allocate zero length buffer and pool_max[0]
can't be used, so skip reserved pool in this case.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/core/buffer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index 2741566..c8f958b 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -131,7 +131,7 @@ void *hcd_buffer_alloc(
 	}
 
 	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
-		if (size <= pool_max[i])
+		if (pool_max[i] && size <= pool_max[i])
 			return dma_pool_alloc(hcd->pool[i], mem_flags, dma);
 	}
 	return dma_alloc_coherent(hcd->self.controller, size, dma, mem_flags);
@@ -158,7 +158,7 @@ void hcd_buffer_free(
 	}
 
 	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
-		if (size <= pool_max[i]) {
+		if (pool_max[i] && size <= pool_max[i]) {
 			dma_pool_free(hcd->pool[i], addr, dma);
 			return;
 		}
-- 
1.7.9.5
