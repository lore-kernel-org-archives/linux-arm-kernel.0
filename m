From: will.deacon@arm.com (Will Deacon)
Date: Thu, 21 Jun 2018 10:18:51 +0100
Subject: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
In-Reply-To: <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
References: <5B2A6218.3030201@hisilicon.com> <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
Message-ID: <20180621091850.GA22505@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2018 at 09:38:53AM +0100, James Morse wrote:
> On 20/06/18 17:25, Wei Xu wrote:
> > ??? [??? 0.042421] Insufficient stack space to handle exception!
> > ??? [??? 0.042423] ESR: 0x96000046 -- DABT (current EL)
> > ??? [??? 0.043730] FAR: 0xffff0000093a80e0
> > ??? [??? 0.044714] Task stack: [0xffff0000093a8000..0xffff0000093ac000]
> 
> This was a level 2 translation fault on a write, to an address that is within
> the stack....
> 
> 
> > ??? [??? 0.051113] IRQ stack: [0xffff000008000000..0xffff000008004000]
> > ??? [??? 0.057610] Overflow stack: [0xffff80003efce2f0..0xffff80003efcf2f0]
> > ??? [??? 0.064003] CPU: 0 PID: 12 Comm: migration/0 Not tainted
> > 4.17.0-45865-g2b31fe7-dirty #10
> > ??? [??? 0.072201] Hardware name: linux,dummy-virt (DT)
> 
> > ??? [??? 0.076797] pstate: 604003c5 (nZCv DAIF +PAN -UAO)
> > ??? [??? 0.081727] pc : el1_sync+0x0/0xb0
> 
> ... from the vectors.
> 
> 
> > ??? [??? 0.085217] lr : kpti_install_ng_mappings+0x120/0x214
> 
> What I think is happening is: we come out of the kpti idmap with the stack
> unmapped. Shortly after we access the stack, which faults. el1_sync faults as
> well when it tries to push the registers to the stack, and we keep going until
> we overflow the stack.
> 
> I can't reproduce this with kvmtool or qemu in the model.

Hmm, one thing that occurs to me is that the kpti_install_ng_mappings()
code leaves the nG bit set in table entries, which is actually IGNORED in
the architecture.

Wei -- does the diff below help at all? Make sure you disable CONFIG_KASAN,
otherwise your kernel will take an age to boot.

Will

--->8

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 5f9a73a4452c..70d9e98467ca 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -272,8 +272,8 @@ ENTRY(idmap_kpti_install_ng_mappings)
 	add	end_pgdp, cur_pgdp, #(PTRS_PER_PGD * 8)
 do_pgd:	__idmap_kpti_get_pgtable_ent	pgd
 	tbnz	pgd, #1, walk_puds
-next_pgd:
 	__idmap_kpti_put_pgtable_ent_ng	pgd
+next_pgd:
 skip_pgd:
 	add	cur_pgdp, cur_pgdp, #8
 	cmp	cur_pgdp, end_pgdp
@@ -302,8 +302,8 @@ walk_puds:
 	add	end_pudp, cur_pudp, #(PTRS_PER_PUD * 8)
 do_pud:	__idmap_kpti_get_pgtable_ent	pud
 	tbnz	pud, #1, walk_pmds
-next_pud:
 	__idmap_kpti_put_pgtable_ent_ng	pud
+next_pud:
 skip_pud:
 	add	cur_pudp, cur_pudp, 8
 	cmp	cur_pudp, end_pudp
@@ -323,8 +323,8 @@ walk_pmds:
 	add	end_pmdp, cur_pmdp, #(PTRS_PER_PMD * 8)
 do_pmd:	__idmap_kpti_get_pgtable_ent	pmd
 	tbnz	pmd, #1, walk_ptes
-next_pmd:
 	__idmap_kpti_put_pgtable_ent_ng	pmd
+next_pmd:
 skip_pmd:
 	add	cur_pmdp, cur_pmdp, #8
 	cmp	cur_pmdp, end_pmdp
