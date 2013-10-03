From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 3 Oct 2013 17:18:00 -0400
Subject: [PATCH v3 6/6] ARM: mm: Change the order of TLB/cache maintenance
 operations.
In-Reply-To: <1380835081-12129-1-git-send-email-santosh.shilimkar@ti.com>
References: <1380835081-12129-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1380835081-12129-7-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sricharan R <r.sricharan@ti.com>

As per the arm ARMv7 manual, the sequence of TLB maintenance
operations after making changes to the translation table is
to clean the dcache first, then invalidate the TLB. With
the current sequence we see cache corruption when the
flush_cache_all is called after tlb_flush_all.

STR rx, [Translation table entry]
; write new entry to the translation table
Clean cache line [Translation table entry]
DSB
; ensures visibility of the data cleaned from the D Cache
Invalidate TLB entry by MVA (and ASID if non-global) [page address]
Invalidate BTC
DSB
; ensure completion of the Invalidate TLB operation
ISB
; ensure table changes visible to instruction fetch

The issue is seen only with LPAE + THUMB BUILT KERNEL + 64BIT patching,
which is little bit weird.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>

Signed-off-by: Sricharan R <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mm/mmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 47c7497..49cba8a 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1280,8 +1280,8 @@ static void __init devicemaps_init(const struct machine_desc *mdesc)
 	 * any write-allocated cache lines in the vector page are written
 	 * back.  After this point, we can start to touch devices again.
 	 */
-	local_flush_tlb_all();
 	flush_cache_all();
+	local_flush_tlb_all();
 }
 
 static void __init kmap_init(void)
-- 
1.7.9.5
