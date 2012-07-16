From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Jul 2012 17:23:46 +0100
Subject: [PATCH] ARM: mm: avoid attempting to flush the gate_vma with VIVT
 caches
Message-ID: <1342455826-9425-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vivt_flush_cache_{range,page} functions check that the mm_struct
of the VMA being flushed has been active on the current CPU before
performing the cache maintenance.

The gate_vma has a NULL mm_struct pointer and, as such, will cause a
kernel fault if we try to flush it with the above operations. This
happens during ELF core dumps, which include the gate_vma as it may be
useful for debugging purposes.

This patch adds checks to the VIVT cache flushing functions so that VMAs
with a NULL mm_struct are ignored.

Cc: Uros Bizjak <ubizjak@gmail.com>
Reported-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/cacheflush.h |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 004c1bc..8cf828e 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -215,7 +215,9 @@ static inline void vivt_flush_cache_mm(struct mm_struct *mm)
 static inline void
 vivt_flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
 {
-	if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm)))
+	struct mm_struct *mm = vma->vm_mm;
+
+	if (mm && cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm)))
 		__cpuc_flush_user_range(start & PAGE_MASK, PAGE_ALIGN(end),
 					vma->vm_flags);
 }
@@ -223,7 +225,9 @@ vivt_flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned
 static inline void
 vivt_flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsigned long pfn)
 {
-	if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))) {
+	struct mm_struct *mm = vma->vm_mm;
+
+	if (mm && cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm))) {
 		unsigned long addr = user_addr & PAGE_MASK;
 		__cpuc_flush_user_range(addr, addr + PAGE_SIZE, vma->vm_flags);
 	}
-- 
1.7.4.1
