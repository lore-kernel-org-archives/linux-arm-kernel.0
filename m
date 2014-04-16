From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 16 Apr 2014 12:46:41 +0100
Subject: [PATCH V2 3/5] arm: mm: Make mmu_gather aware of huge pages
In-Reply-To: <1397648803-15961-1-git-send-email-steve.capper@linaro.org>
References: <1397648803-15961-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1397648803-15961-4-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Huge pages on short descriptors are arranged as pairs of 1MB sections.
We need to be careful and ensure that the TLBs for both sections are
flushed when we tlb_add_flush on a HugeTLB page.

This patch extends the tlb flush range to HPAGE_SIZE rather than
PAGE_SIZE when addresses belonging to huge page VMAs are added to
the flush range.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm/include/asm/tlb.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index 0baf7f0..b2498e6 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -81,10 +81,17 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 static inline void tlb_add_flush(struct mmu_gather *tlb, unsigned long addr)
 {
 	if (!tlb->fullmm) {
+		unsigned long size = PAGE_SIZE;
+
 		if (addr < tlb->range_start)
 			tlb->range_start = addr;
-		if (addr + PAGE_SIZE > tlb->range_end)
-			tlb->range_end = addr + PAGE_SIZE;
+
+		if (!config_enabled(CONFIG_ARM_LPAE) && tlb->vma
+				&& is_vm_hugetlb_page(tlb->vma))
+			size = HPAGE_SIZE;
+
+		if (addr + size > tlb->range_end)
+			tlb->range_end = addr + size;
 	}
 }
 
-- 
1.8.1.4
