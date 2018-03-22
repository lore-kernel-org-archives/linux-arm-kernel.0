From: shashim@codeaurora.org (Shiraz Hashim)
Date: Thu, 22 Mar 2018 17:44:18 +0530
Subject: [PATCH 1/1] arm: dma-mapping: DMA buf may not have cpu virtual addr
Message-ID: <1521720858-9031-1-git-send-email-shashim@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMA buffers may not have cpu virtual addresses when
allocated using DMA_ATTR_NO_KERNEL_MAPPING attribute.
Page address should therefore be looked up while
searching for such dma bufs.

Signed-off-by: Shiraz Hashim <shashim@codeaurora.org>
---
 arch/arm/mm/dma-mapping.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ada8eb2..c85fc0a 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -883,9 +883,10 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		.page = page,
 		.want_vaddr = ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) == 0),
 	};
+	void *addr = (args.want_vaddr) ? cpu_addr : page;
 
-	buf = arm_dma_buffer_find(cpu_addr);
-	if (WARN(!buf, "Freeing invalid buffer %p\n", cpu_addr))
+	buf = arm_dma_buffer_find(addr);
+	if (WARN(!buf, "Freeing invalid buffer %p\n", addr))
 		return;
 
 	buf->allocator->free(&args);
-- 
Shiraz Hashim

QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation
