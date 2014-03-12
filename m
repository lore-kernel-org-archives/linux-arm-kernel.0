From: will.deacon@arm.com (Will Deacon)
Date: Wed, 12 Mar 2014 16:55:11 +0000
Subject: [RFC PATCH V3 3/6] arm: mm: implement get_user_pages_fast
In-Reply-To: <20140312163200.GJ27965@twins.programming.kicks-ass.net>
References: <1394631623-17883-1-git-send-email-steve.capper@linaro.org>
 <1394631623-17883-4-git-send-email-steve.capper@linaro.org>
 <20140312163200.GJ27965@twins.programming.kicks-ass.net>
Message-ID: <20140312165510.GA9950@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 04:32:00PM +0000, Peter Zijlstra wrote:
> On Wed, Mar 12, 2014 at 01:40:20PM +0000, Steve Capper wrote:
> > +void pmdp_splitting_flush(struct vm_area_struct *vma, unsigned long address,
> > +			  pmd_t *pmdp)
> > +{
> > +	pmd_t pmd = pmd_mksplitting(*pmdp);
> > +	VM_BUG_ON(address & ~PMD_MASK);
> > +	set_pmd_at(vma->vm_mm, address, pmdp, pmd);
> > +
> > +	/* dummy IPI to serialise against fast_gup */
> > +	smp_call_function(thp_splitting_flush_sync, NULL, 1);
> > +}
> 
> do you really need to IPI the entire machine? Wouldn't the mm's TLB
> invalidate mask be sufficient?

Are you thinking of using mm_cpumask(vma->vm_mm)? That's rarely cleared on
ARM, so it tends to identify everywhere the task has ever run, regardless of
TLB state. The reason is that the mask is also used for cache flushing
(which is further overloaded for VIVT and VIPT w/ software maintenance
broadcast).

I had a patch improving this a bit (below) but I didn't manage to see any
significant improvements so I didn't pursue it further. What we probably want
to try is nuking the mask on a h/w broadcast TLBI operation with ARMv7, but
it will mean adding horrible checks to tlbflush.h

Will

--->8

commit fd24d6170839b200cc2916c83847ca46e889f1ca
Author: Will Deacon <will.deacon@arm.com>
Date:   Thu Jul 25 16:38:34 2013 +0100

    ARM: mm: use mm_cpumask to keep track of dirty TLBs on v7
    
    Signed-off-by: Will Deacon <will.deacon@arm.com>

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index def9e570199f..f2a1cb7edfca 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -202,6 +202,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/sched.h>
+#include <asm/smp_plat.h>
 
 struct cpu_tlb_fns {
 	void (*flush_user_range)(unsigned long, unsigned long, struct vm_area_struct *);
@@ -401,6 +402,17 @@ static inline void __flush_tlb_mm(struct mm_struct *mm)
 {
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
+	if (!cache_ops_need_broadcast()) {
+		int cpu = get_cpu();
+		if (cpumask_equal(mm_cpumask(mm), cpumask_of(cpu))) {
+			cpumask_clear_cpu(cpu, mm_cpumask(mm));
+			local_flush_tlb_mm(mm);
+			put_cpu();
+			return;
+		}
+		put_cpu();
+	}
+
 	if (tlb_flag(TLB_WB))
 		dsb(ishst);
 
@@ -459,6 +471,17 @@ __flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 {
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
+	if (!cache_ops_need_broadcast()) {
+		int cpu = get_cpu();
+		if (cpumask_equal(mm_cpumask(vma->vm_mm), cpumask_of(cpu))) {
+			cpumask_clear_cpu(cpu, mm_cpumask(vma->vm_mm));
+			local_flush_tlb_page(vma, uaddr);
+			put_cpu();
+			return;
+		}
+		put_cpu();
+	}
+
 	uaddr = (uaddr & PAGE_MASK) | ASID(vma->vm_mm);
 
 	if (tlb_flag(TLB_WB))
