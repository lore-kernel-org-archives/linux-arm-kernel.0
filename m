From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Oct 2009 15:57:53 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <20090921100751.GF27357@n2100.arm.linux.org.uk>
References: <20090919224022.GA738@n2100.arm.linux.org.uk>
	<1253435940.498.15.camel@pc1117.cambridge.arm.com>
	<20090920093139.GA1704@n2100.arm.linux.org.uk>
	<20090920190227.GB5413@n2100.arm.linux.org.uk>
	<4AB6B0AB.8040307@arm.com> <20090921083109.GC20006@shareable.org>
	<1253522944.1541.3.camel@pc1117.cambridge.arm.com>
	<20090921085425.GC27357@n2100.arm.linux.org.uk>
	<1253526263.1541.32.camel@pc1117.cambridge.arm.com>
	<20090921100751.GF27357@n2100.arm.linux.org.uk>
Message-ID: <20091015145753.GC14817@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2009 at 11:07:51AM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 21, 2009 at 10:44:23AM +0100, Catalin Marinas wrote:
> > We would need to fix this somehow as well. We currently handle the
> > I-cache in update_mmu_cache() when a page is first mapped if it has
> > VM_EXEC set.
> 
> The reason I'm pushing you hard to separate the two issues is that the
> two should be treated separately.  I think we need to consider ensuring
> that freed pages do not have any I-cache lines associated with them,
> rather than waiting for them to be allocated and then dealing with the
> I-cache problem.

Having now benchmarked this (making flush_cache_* always invalidate
the I-cache, so free'd pages are I-cache clean), and to me, the results
quite look promising - please try out this patch.

diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index d0d17b6..b9c1cd4 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -160,8 +160,6 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
 	if (mapping) {
 		if (cache_is_vivt())
 			make_coherent(mapping, vma, addr, pfn);
-		else if (vma->vm_flags & VM_EXEC)
-			__flush_icache_all();
 	}
 }
 
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index b279429..5b739b4 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -20,6 +20,12 @@
 
 #ifdef CONFIG_ARM_ERRATA_411920
 extern void v6_icache_inval_all(void);
+#else
+static inline void v6_icache_inval_all(void)
+{
+	const int zero = 0;
+	asm("mcr	p15, 0, %0, c7, c5, 0" : : "r" (zero) : "cc");
+}
 #endif
 
 #ifdef CONFIG_CPU_CACHE_VIPT
@@ -35,16 +41,10 @@ static void flush_pfn_alias(unsigned long pfn, unsigned long vaddr)
 	flush_tlb_kernel_page(to);
 
 	asm(	"mcrr	p15, 0, %1, %0, c14\n"
-	"	mcr	p15, 0, %2, c7, c10, 4\n"
-#ifndef CONFIG_ARM_ERRATA_411920
-	"	mcr	p15, 0, %2, c7, c5, 0\n"
-#endif
+	"	mcr	p15, 0, %2, c7, c10, 4"
 	    :
 	    : "r" (to), "r" (to + PAGE_SIZE - L1_CACHE_BYTES), "r" (zero)
 	    : "cc");
-#ifdef CONFIG_ARM_ERRATA_411920
-	v6_icache_inval_all();
-#endif
 }
 
 void flush_cache_mm(struct mm_struct *mm)
@@ -57,17 +57,12 @@ void flush_cache_mm(struct mm_struct *mm)
 
 	if (cache_is_vipt_aliasing()) {
 		asm(	"mcr	p15, 0, %0, c7, c14, 0\n"
-		"	mcr	p15, 0, %0, c7, c10, 4\n"
-#ifndef CONFIG_ARM_ERRATA_411920
-		"	mcr	p15, 0, %0, c7, c5, 0\n"
-#endif
+		"	mcr	p15, 0, %0, c7, c10, 4"
 		    :
 		    : "r" (0)
 		    : "cc");
-#ifdef CONFIG_ARM_ERRATA_411920
-		v6_icache_inval_all();
-#endif
 	}
+	v6_icache_inval_all();
 }
 
 void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
@@ -81,17 +76,12 @@ void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned
 
 	if (cache_is_vipt_aliasing()) {
 		asm(	"mcr	p15, 0, %0, c7, c14, 0\n"
-		"	mcr	p15, 0, %0, c7, c10, 4\n"
-#ifndef CONFIG_ARM_ERRATA_411920
-		"	mcr	p15, 0, %0, c7, c5, 0\n"
-#endif
+		"	mcr	p15, 0, %0, c7, c10, 4"
 		    :
 		    : "r" (0)
 		    : "cc");
-#ifdef CONFIG_ARM_ERRATA_411920
-		v6_icache_inval_all();
-#endif
 	}
+	v6_icache_inval_all();
 }
 
 void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsigned long pfn)
@@ -106,6 +96,7 @@ void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsig
 
 	if (cache_is_vipt_aliasing())
 		flush_pfn_alias(pfn, user_addr);
+	v6_icache_inval_all();
 }
 
 void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
@@ -226,8 +217,6 @@ void flush_dcache_page(struct page *page)
 		__flush_dcache_page(mapping, page);
 		if (mapping && cache_is_vivt())
 			__flush_dcache_aliases(mapping, page);
-		else if (mapping)
-			__flush_icache_all();
 	}
 }
 EXPORT_SYMBOL(flush_dcache_page);
