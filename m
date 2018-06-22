From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Jun 2018 10:23:31 +0100
Subject: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
In-Reply-To: <5B2CB440.8040705@hisilicon.com>
References: <5B2A6218.3030201@hisilicon.com> <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <20180621091850.GA22505@arm.com> <5B2B7A84.8090309@hisilicon.com>
 <20180621105404.GB22505@arm.com> <5B2CB440.8040705@hisilicon.com>
Message-ID: <20180622092330.GD7601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wei,

On Fri, Jun 22, 2018 at 09:33:04AM +0100, Wei Xu wrote:
> On 2018/6/21 11:54, Will Deacon wrote:
> > On Thu, Jun 21, 2018 at 11:14:28AM +0100, Wei Xu wrote:
> >> On 2018/6/21 10:18, Will Deacon wrote:
> >>> Wei -- does the diff below help at all? Make sure you disable CONFIG_KASAN,
> >>> otherwise your kernel will take an age to boot.
> >>
> >> Yes, amazing! This patch resolved the issue.
> > 
> > Great...
> > 
> >> I have tested 50 times and can not reproduce the issue any more.
> >> Could you please tell more why this patch works?
> > 
> > You might need to ask your CPU design team ;)
> > 
> > Without this patch, the code in idmap_kpti_install_ng_mappings() sets
> > bit 11 in table descriptors so that we can keep track of which parts of
> > the page table we've visited. With this patch, we don't bother tracking
> > and potentially rewalk parts of the page table (which takes a very long
> > time if KASAN is enabled).
> 
> Got it. Thanks!
> 
> > 
> > The architecture documents I've looked at are clear that bit 11 is IGNORED
> > by the CPU, which:
> > 
> >   "Indicates that the architecture guarantees that the bit or field is not
> >    interpreted or modified by hardware."
> > 
> > Please can you double-check that your CPU is indeed ignoring bit 11 in
> > non-leaf (table) descriptors?
> 
> Do the non-leaf(table) descriptors mean the table descriptors
> of the section D4.3.1 "VMSAv8-64 translation table level 0, level 1, and level 2 descriptor formats"
> in the ARM Architecture Reference Manual ARMv8 for ARMv8-A(DDI0487C_a_armv8_arm.pdf)?
> 
> If yes, our hardware does ignore it(not interpret or modify).

Ok, thanks for checking.

> Is there any other possible reason cause this?

Perhaps just writing back the table entries is enough to cause the issue,
although I really can't understand why that would be the case. Can you try
the diff below (without my previous change), please?

Will

--->8

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 5f9a73a4452c..e2a8e88f95a0 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -216,7 +216,7 @@ ENDPROC(idmap_cpu_replace_ttbr1)
 	.endm
 
 	.macro __idmap_kpti_put_pgtable_ent_ng, type
-	orr	\type, \type, #PTE_NG		// Same bit for blocks and pages
+	eor	\type, \type, #PTE_NG		// Same bit for blocks and pages
 	str	\type, [cur_\()\type\()p]	// Update the entry and ensure it
 	dc	civac, cur_\()\type\()p		// is visible to all CPUs.
 	.endm
@@ -298,6 +298,7 @@ skip_pgd:
 	/* PUD */
 walk_puds:
 	.if CONFIG_PGTABLE_LEVELS > 3
+	eor	pgd, pgd, #PTE_NG
 	pte_to_phys	cur_pudp, pgd
 	add	end_pudp, cur_pudp, #(PTRS_PER_PUD * 8)
 do_pud:	__idmap_kpti_get_pgtable_ent	pud
@@ -319,6 +320,7 @@ next_pud:
 	/* PMD */
 walk_pmds:
 	.if CONFIG_PGTABLE_LEVELS > 2
+	eor	pud, pud, #PTE_NG
 	pte_to_phys	cur_pmdp, pud
 	add	end_pmdp, cur_pmdp, #(PTRS_PER_PMD * 8)
 do_pmd:	__idmap_kpti_get_pgtable_ent	pmd
@@ -339,6 +341,7 @@ next_pmd:
 
 	/* PTE */
 walk_ptes:
+	eor	pmd, pmd, #PTE_NG
 	pte_to_phys	cur_ptep, pmd
 	add	end_ptep, cur_ptep, #(PTRS_PER_PTE * 8)
 do_pte:	__idmap_kpti_get_pgtable_ent	pte
