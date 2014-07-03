From: alcooperx@gmail.com (Al Cooper)
Date: Thu, 3 Jul 2014 13:40:05 -0400
Subject: [PATCH] arm: Make sure memory starting at physical address 0 is
 reserved.
Message-ID: <1404409205-7368-1-git-send-email-alcooperx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some older hardware, like USB OHCI, cannot DMA to physical address
zero. This change makes sure that the first PAGESIZE block of memory
starting at zero is reserved so it can't end up in any free
memory pool.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 arch/arm/mm/init.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 659c75d..17aaa4d 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -324,6 +324,15 @@ void __init arm_memblock_init(const struct machine_desc *mdesc)
 	 */
 	dma_contiguous_reserve(min(arm_dma_limit, arm_lowmem_limit));
 
+	/*
+	 * Some older hardware, like USB OHCI, cannot DMA
+	 * to physical address zero. This makes sure that the
+	 * first PAGESIZE block of memory starting at zero is
+	 * reserved so it can't end up in any free memory pool.
+	 */
+	if (memblock_is_region_memory(0, PAGE_SIZE))
+		memblock_reserve(0, PAGE_SIZE);
+
 	arm_memblock_steal_permitted = false;
 	memblock_dump_all();
 }
-- 
1.9.0.138.g2de3478
