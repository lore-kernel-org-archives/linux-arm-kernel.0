From: amhetre@nvidia.com (Ashish Mhetre)
Date: Thu, 25 Oct 2018 21:42:24 +0530
Subject: [PATCH] arm64: Don't flush tlb while clearing the accessed bit
Message-ID: <1540483944-22718-1-git-send-email-amhetre@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alex Van Brunt <avanbrunt@nvidia.com>

Accessed bit is used to age a page and in generic implementation there is
flush_tlb while clearing the accessed bit.
Flushing a TLB is overhead on ARM64 as access flag faults don't get
translation table entries cached into TLB's. Flushing TLB is not necessary
for this. Clearing the accessed bit without flushing TLB doesn't cause data
corruption on ARM64.
In our case with this patch, speed of reading from fast NVMe/SSD through
PCIe got improved by 10% ~ 15% and writing got improved by 20% ~ 40%.
So for performance optimisation don't flush TLB when clearing the accessed
bit on ARM64.
x86 made the same optimization even though their TLB invalidate is much
faster as it doesn't broadcast to other CPUs.

Signed-off-by: Alex Van Brunt <avanbrunt@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 arch/arm64/include/asm/pgtable.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 2ab2031..42931f6 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -652,6 +652,13 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 	return __ptep_test_and_clear_young(ptep);
 }
 
+#define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
+static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
+					 unsigned long address, pte_t *ptep)
+{
+	return ptep_test_and_clear_young(vma, address, ptep);
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
 static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
-- 
2.7.4
