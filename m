From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Jun 2018 15:43:46 +0100
Subject: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
In-Reply-To: <5B2CFDCD.6040207@hisilicon.com>
References: <20180621091850.GA22505@arm.com> <5B2B7A84.8090309@hisilicon.com>
 <20180621105404.GB22505@arm.com> <5B2CB440.8040705@hisilicon.com>
 <20180622092330.GD7601@arm.com> <5B2CD33B.9020702@hisilicon.com>
 <20180622111614.GA1150@arm.com> <5B2CF723.7010600@hisilicon.com>
 <20180622133133.GA1802@arm.com> <5B2CFDCD.6040207@hisilicon.com>
Message-ID: <20180622144346.GB1802@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 09:46:53PM +0800, Wei Xu wrote:
> On 2018/6/22 21:31, Will Deacon wrote:
> >On Fri, Jun 22, 2018 at 09:18:27PM +0800, Wei Xu wrote:
> >>On 2018/6/22 19:16, Will Deacon wrote:
> >>>On Fri, Jun 22, 2018 at 06:45:15PM +0800, Wei Xu wrote:
> >>>>On 2018/6/22 17:23, Will Deacon wrote:
> >>>>>Perhaps just writing back the table entries is enough to cause the issue,
> >>>>>although I really can't understand why that would be the case. Can you try
> >>>>>the diff below (without my previous change), please?
> >>>>Thanks!
> >>>>But it does not resolve the issue(only apply this patch based on 4.17.0).
> >>>Thanks, that's a useful data point. It means that it still crashes even if
> >>>we write back the same table entries, so it's the fact that we're writing
> >>>them at all which causes the problem, not the value that we write.
> >>>
> >>>Whilst looking at the code, we noticed a missing DMB. On the off-chance
> >>>that it helps, can you try this instead please?
> >>Thanks!
> >>Only apply below patch based on 4.17.0, we still got the crash.
> >Oh well, it was worth a shot (and that's still a fix worth having). Please
> >can you provide the complete disassembly for kpti_install_ng_mappings()
> >(I'm referring to the C function in cpufeature.c) along with a corresponding
> >crash log so that we can correlate the instruction stream with the crash?
> Just let me know if you need more information.

Thanks; the disassembly and log are really helpful.

I have another patch for you to try below. Please can you let me know how
you get on, and sorry for the back-and-forth on this.

Will

--->8

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 5f9a73a4452c..26c5c3fabca8 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -216,9 +216,14 @@ ENDPROC(idmap_cpu_replace_ttbr1)
 	.endm
 
 	.macro __idmap_kpti_put_pgtable_ent_ng, type
-	orr	\type, \type, #PTE_NG		// Same bit for blocks and pages
+	eor	\type, \type, #PTE_NG		// Same bit for blocks and pages
 	str	\type, [cur_\()\type\()p]	// Update the entry and ensure it
+	tbz	\type, #11, 1234f
 	dc	civac, cur_\()\type\()p		// is visible to all CPUs.
+	b	1235f
+	1234:
+	dc	cvac, cur_\()\type\()p
+	1235:
 	.endm
 
 /*
@@ -298,6 +303,7 @@ skip_pgd:
 	/* PUD */
 walk_puds:
 	.if CONFIG_PGTABLE_LEVELS > 3
+	eor	pgd, pgd, #PTE_NG
 	pte_to_phys	cur_pudp, pgd
 	add	end_pudp, cur_pudp, #(PTRS_PER_PUD * 8)
 do_pud:	__idmap_kpti_get_pgtable_ent	pud
@@ -319,6 +325,7 @@ next_pud:
 	/* PMD */
 walk_pmds:
 	.if CONFIG_PGTABLE_LEVELS > 2
+	eor	pud, pud, #PTE_NG
 	pte_to_phys	cur_pmdp, pud
 	add	end_pmdp, cur_pmdp, #(PTRS_PER_PMD * 8)
 do_pmd:	__idmap_kpti_get_pgtable_ent	pmd
@@ -339,6 +346,7 @@ next_pmd:
 
 	/* PTE */
 walk_ptes:
+	eor	pmd, pmd, #PTE_NG
 	pte_to_phys	cur_ptep, pmd
 	add	end_ptep, cur_ptep, #(PTRS_PER_PTE * 8)
 do_pte:	__idmap_kpti_get_pgtable_ent	pte
