From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Oct 2018 11:50:21 +0000
Subject: [PATCH V3] arm64: Don't flush tlb while clearing the accessed bit
In-Reply-To: <4bac3ba7-a005-213d-5ae4-c0e2ee589d5d@nvidia.com>
References: <1540805158-618-1-git-send-email-amhetre@nvidia.com>
 <20181029105515.GD14127@arm.com>
 <4bac3ba7-a005-213d-5ae4-c0e2ee589d5d@nvidia.com>
Message-ID: <20181030115021.GC18992@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Sorry to be "that person" but please can you use plain text for your mail?
 This is getting really hard to follow.]

On Tue, Oct 30, 2018 at 11:17:34AM +0530, Ashish Mhetre wrote:
> On 29/10/18 4:25 PM, Will Deacon wrote:
>     On Mon, Oct 29, 2018 at 02:55:58PM +0530, Ashish Mhetre wrote:
>         From: Alex Van Brunt <avanbrunt@nvidia.com>
> 
>         Accessed bit is used to age a page and in generic implementation there is
>         flush_tlb while clearing the accessed bit.
>         Flushing a TLB is overhead on ARM64 as access flag faults don't get
>         translation table entries cached into TLB's. Flushing TLB is not necessary
>         for this. Clearing the accessed bit without flushing TLB doesn't cause data
>         corruption on ARM64.
>         In our case with this patch, speed of reading from fast NVMe/SSD through
>         PCIe got improved by 10% ~ 15% and writing got improved by 20% ~ 40%.
>         So for performance optimisation don't flush TLB when clearing the accessed
>         bit on ARM64.
>         x86 made the same optimization even though their TLB invalidate is much
>         faster as it doesn't broadcast to other CPUs.
> 
>     Ok, but they may end up using IPIs so lets avoid these vague performance
>     claims in the log unless they're backed up with numbers.
> 
> By numbers do you mean the actual benchmark values?

What I mean is, if we're going to claim that x86 TLB invalidation "is much
faster" than arm64, I'd prefer that there was some science behind it.
However, I think in this case it's not even relevant, so we can just rewrite
the commit message.

How about the patch below -- does that work for you?

Will

--->8

>From 1443d2dcfd66563127aa1b13d05eac7cd9fd8445 Mon Sep 17 00:00:00 2001
From: Alex Van Brunt <avanbrunt@nvidia.com>
Date: Mon, 29 Oct 2018 14:55:58 +0530
Subject: [PATCH] arm64: mm: Don't wait for completion of TLB invalidation when
 page aging

When transitioning a PTE from young to old as part of page aging, we
can avoid waiting for the TLB invalidation to complete and therefore
drop the subsequent DSB instruction. Whilst this opens up a race with
page reclaim, where a PTE in active use via a stale, young TLB entry
does not update the underlying descriptor, the worst thing that happens
is that the page is reclaimed and then immediately faulted back in.

Given that we have a DSB in our context-switch path, the window for a
spurious reclaim is fairly limited and eliding the barrier claims to
boost NVMe/SSD accesses by over 10% on some platforms.

A similar optimisation was made for x86 in commit b13b1d2d8692 ("x86/mm:
In the PTE swapout page reclaim case clear the accessed bit instead of
flushing the TLB").

Signed-off-by: Alex Van Brunt <avanbrunt@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
[will: rewrote patch]
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/pgtable.h  | 22 ++++++++++++++++++++++
 arch/arm64/include/asm/tlbflush.h | 11 +++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 50b1ef8584c0..5bbb59c81920 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -22,6 +22,7 @@
 #include <asm/memory.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/pgtable-prot.h>
+#include <asm/tlbflush.h>
 
 /*
  * VMALLOC range.
@@ -685,6 +686,27 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 	return __ptep_test_and_clear_young(ptep);
 }
 
+#define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
+static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
+					 unsigned long address, pte_t *ptep)
+{
+	int young = ptep_test_and_clear_young(vma, address, ptep);
+
+	if (young) {
+		/*
+		 * We can elide the trailing DSB here since the worst that can
+		 * happen is that a CPU continues to use the young entry in its
+		 * TLB and we mistakenly reclaim the associated page. The
+		 * window for such an event is bounded by the next
+		 * context-switch, which provides a DSB to complete the TLB
+		 * invalidation.
+		 */
+		flush_tlb_page_nosync(vma, address);
+	}
+
+	return young;
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
 static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index c3c0387aee18..a629a4067aae 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -21,6 +21,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/mm_types.h>
 #include <linux/sched.h>
 #include <asm/cputype.h>
 #include <asm/mmu.h>
@@ -164,14 +165,20 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
 	dsb(ish);
 }
 
-static inline void flush_tlb_page(struct vm_area_struct *vma,
-				  unsigned long uaddr)
+static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
+					 unsigned long uaddr)
 {
 	unsigned long addr = __TLBI_VADDR(uaddr, ASID(vma->vm_mm));
 
 	dsb(ishst);
 	__tlbi(vale1is, addr);
 	__tlbi_user(vale1is, addr);
+}
+
+static inline void flush_tlb_page(struct vm_area_struct *vma,
+				  unsigned long uaddr)
+{
+	flush_tlb_page_nosync(vma, uaddr);
 	dsb(ish);
 }
 
-- 
2.1.4
