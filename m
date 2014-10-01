From: seanpaul@chromium.org (Sean Paul)
Date: Wed,  1 Oct 2014 11:31:50 -0400
Subject: [PATCH v2] arm64: Use DMA_ERROR_CODE to denote failed allocation
In-Reply-To: <20141001135248.GQ5182@n2100.arm.linux.org.uk>
References: <20141001135248.GQ5182@n2100.arm.linux.org.uk>
Message-ID: <1412177510-26310-1-git-send-email-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces the static assignment of ~0 to dma_handle with
DMA_ERROR_CODE to be consistent with other platforms.

Signed-off-by: Sean Paul <seanpaul@chromium.org>
---

Changes in v2:
	- Removed the check for DMA_ERROR_CODE in __dma_free_noncoherent
	  the function shouldn't be called after failed allocation

 arch/arm64/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 4164c5a..5687dd4 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -125,7 +125,7 @@ static void *__dma_alloc_noncoherent(struct device *dev, size_t size,
 no_map:
 	__dma_free_coherent(dev, size, ptr, *dma_handle, attrs);
 no_mem:
-	*dma_handle = ~0;
+	*dma_handle = DMA_ERROR_CODE;
 	return NULL;
 }
 
-- 
2.1.1
