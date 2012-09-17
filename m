From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 17 Sep 2012 10:39:43 +0530
Subject: [PATCH] ARM: dma-mapping: Fix potential memory leak in
 atomic_pool_init()
Message-ID: <1347858583-13338-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When either of __alloc_from_contiguous or __alloc_remap_buffer fails
to provide a valid pointer, allocated memory is freed up and an error
is returned. 'pages' was however not freed before returning error.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/mm/dma-mapping.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 546a3e8..477a2d2 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -367,6 +367,8 @@ static int __init atomic_pool_init(void)
 		       (unsigned)pool->size / 1024);
 		return 0;
 	}
+
+	kfree(pages);
 no_pages:
 	kfree(bitmap);
 no_bitmap:
-- 
1.7.4.1
