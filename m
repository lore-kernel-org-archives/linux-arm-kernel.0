From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 25 Oct 2009 10:40:02 +0000
Subject: [RFC 06/11] ARM: Avoid duplicated implementation for VIVT cache
	flushing
In-Reply-To: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
References: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <2ba31e0dd84d4ed65105fd274fc74ba68016f121.1256683230.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We had two copies of the wrapper code for VIVT cache flushing - one in
asm/cacheflush.h and one in arch/arm/mm/flush.c.  Reduce this down to
one common copy.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/cacheflush.h |   20 +++++++++++++++-----
 arch/arm/mm/flush.c               |   17 ++++-------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index af0624c..9fd6d3a 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -331,15 +331,15 @@ static inline void outer_flush_range(unsigned long start, unsigned long end)
  * Convert calls to our calling convention.
  */
 #define flush_cache_all()		__cpuc_flush_kern_all()
-#ifndef CONFIG_CPU_CACHE_VIPT
-static inline void flush_cache_mm(struct mm_struct *mm)
+
+static inline void vivt_flush_cache_mm(struct mm_struct *mm)
 {
 	if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm)))
 		__cpuc_flush_user_all();
 }
 
 static inline void
-flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
+vivt_flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
 {
 	if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm)))
 		__cpuc_flush_user_range(start & PAGE_MASK, PAGE_ALIGN(end),
@@ -347,7 +347,7 @@ flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long
 }
 
 static inline void
-flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsigned long pfn)
+vivt_flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsigned long pfn)
 {
 	if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))) {
 		unsigned long addr = user_addr & PAGE_MASK;
@@ -356,7 +356,7 @@ flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsigned l
 }
 
 static inline void
-flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
+vivt_flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
 			 unsigned long uaddr, void *kaddr,
 			 unsigned long len, int write)
 {
@@ -365,6 +365,16 @@ flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
 		__cpuc_coherent_kern_range(addr, addr + len);
 	}
 }
+
+#ifndef CONFIG_CPU_CACHE_VIPT
+#define flush_cache_mm(mm) \
+		vivt_flush_cache_mm(mm)
+#define flush_cache_range(vma,start,end) \
+		vivt_flush_cache_range(vma,start,end)
+#define flush_cache_page(vma,addr,pfn) \
+		vivt_flush_cache_page(vma,addr,pfn)
+#define flush_ptrace_access(vma,page,ua,ka,len,write) \
+		vivt_flush_ptrace_access(vma,page,ua,ka,len,write)
 #else
 extern void flush_cache_mm(struct mm_struct *mm);
 extern void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 82dd2c5..4fa3d4d 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -40,8 +40,7 @@ static void flush_pfn_alias(unsigned long pfn, unsigned long vaddr)
 void flush_cache_mm(struct mm_struct *mm)
 {
 	if (cache_is_vivt()) {
-		if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm)))
-			__cpuc_flush_user_all();
+		vivt_flush_cache_mm(mm);
 		return;
 	}
 
@@ -58,9 +57,7 @@ void flush_cache_mm(struct mm_struct *mm)
 void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
 {
 	if (cache_is_vivt()) {
-		if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm)))
-			__cpuc_flush_user_range(start & PAGE_MASK, PAGE_ALIGN(end),
-						vma->vm_flags);
+		vivt_flush_cache_range(vma, start, end);
 		return;
 	}
 
@@ -77,10 +74,7 @@ void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned
 void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsigned long pfn)
 {
 	if (cache_is_vivt()) {
-		if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))) {
-			unsigned long addr = user_addr & PAGE_MASK;
-			__cpuc_flush_user_range(addr, addr + PAGE_SIZE, vma->vm_flags);
-		}
+		vivt_flush_cache_page(vma, user_addr, pfn);
 		return;
 	}
 
@@ -95,10 +89,7 @@ void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
 			 unsigned long len, int write)
 {
 	if (cache_is_vivt()) {
-		if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))) {
-			unsigned long addr = (unsigned long)kaddr;
-			__cpuc_coherent_kern_range(addr, addr + len);
-		}
+		vivt_flush_ptrace_access(vma, page, uaddr, kaddr, len, write);
 		return;
 	}
 
-- 
1.6.2.5
