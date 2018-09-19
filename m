From: will.deacon@arm.com (Will Deacon)
Date: Wed, 19 Sep 2018 11:29:37 +0100
Subject: Huge page(contiguous bit) slow down
In-Reply-To: <20180918171133.2suapy5le7lfp5gf@armageddon.cambridge.arm.com>
References: <8898674D84E3B24BA3A2D289B872026A69FE8F27@G01JPEXMBKW03>
 <20180918113300.GC16498@arm.com>
 <20180918145832.h24u5tbsqksvmrtq@armageddon.cambridge.arm.com>
 <20180918151625.GG16498@arm.com>
 <20180918160927.hxtipnq6z6qrh7hw@armageddon.cambridge.arm.com>
 <20180918161432.GH16498@arm.com>
 <20180918171133.2suapy5le7lfp5gf@armageddon.cambridge.arm.com>
Message-ID: <20180919102937.GD25094@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2018 at 06:11:34PM +0100, Catalin Marinas wrote:
> On Tue, Sep 18, 2018 at 05:14:33PM +0100, Will Deacon wrote:
> > On Tue, Sep 18, 2018 at 05:09:28PM +0100, Catalin Marinas wrote:
> > > On Tue, Sep 18, 2018 at 04:16:26PM +0100, Will Deacon wrote:
> > > > One thing I don't really grok is the interaction between the contiguous
> > > > hint and HW_AFDBM. Is it possible for us to be e.g. halfway through the
> > > > set_pte_at() loop and then for the hardware to perform atomic PTE updates
> > > > for entries later in the loop? If so, we've got a race and need to use
> > > > cmpxchg() like we do for the non-contiguous code.
> > > 
> > > With the current code, no, since get_clear_flush() sets all of them to
> > > 0, so no hardware updates before set_pte_at().
> > 
> > The case I'm concerned about is when we've set_pte_at() half of the mapping,
> > though. At this point, a CPU can get a translation via one of the entries
> > that we've put down, and it's not clear to me whether this could establish
> > a contiguous TLB entry which could then result in access/dirty updates to
> > PTEs that we haven't yet written out.
> 
> Ah, I see what you meant. The actual updates are not done based on the
> TLB information but rather the CPU performs a read-modify-write of the
> entry (when an existing TLB entry would give fault; for writes as we
> don't cache the no access flag in the TLB).
> 
> The AF case is simpler as the hardware doesn't cache an AF=0 pte in the
> TLB. For DBM, we could indeed have a contiguous writable+clean (DBM=1,
> AP[2] = 1) entry covering not yet written ptes. The ARM ARM describes
> that the AP[2] bit is updated (cleared) atomically only if the DBM bit
> is set in the pte:
> 
>   If, for a write access, the PE finds that a cached copy of the
>   descriptor in a TLB had the DBM bit set to 1 and the AP[2] or S2AP[1]
>   bit set to the value that forbids writes, then the PE must check that
>   the cached copy is not stale with regard to the descriptor entry in
>   memory, and if necessary perform an atomic read-modify-write update of
>   the descriptor in memory. This applies if the cached copy of the
>   descriptor in a TLB is either:
>   - A stage 1 descriptor in which DBM has the value 1 and AP[2] has the
>     value 1.
>   - A stage 2 descriptor in which DBM has the value 1 and S2AP[1] has
>     the value 0.
> 
> (and there are some further notes in the ARM ARM; I think we don't
> have an issue here)

Thanks for the clarification, I also think we're alright here. The concern
would be if the CPU can, for example, always check the first PTE in the
contiguous range yet perform an atomic update on a different one. I have no
idea why a CPU would do this, so I think the architecture text can just be
interpreted a bit broadly there and I'll see if I can raise a clarification.

However, as you mention off-list, there is a problem with the proposed
solution of using pte_same() only on the first entry of the range. If a
CPU ignores the contiguous hint (as it is permitted to do), then we could
repeatedly fault on a different PTE within the range (for example, if we
are using software dirty-bit) and get stuck.

Something like the diff below might help, but I haven't tested it. What do
you think?

Will

--->8

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 192b3ba07075..edae6774132d 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -324,7 +324,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 			       unsigned long addr, pte_t *ptep,
 			       pte_t pte, int dirty)
 {
-	int ncontig, i, changed = 0;
+	int ncontig, i;
 	size_t pgsize = 0;
 	unsigned long pfn = pte_pfn(pte), dpfn;
 	pgprot_t hugeprot;
@@ -336,9 +336,14 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	ncontig = find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
 	dpfn = pgsize >> PAGE_SHIFT;
 
+	for (i = 0; i < ncontig; i++)
+		if (!pte_same(huge_ptep_get(ptep + i), pte))
+			break;
+
+	if (i == ncontig)
+		return 0;
+
 	orig_pte = get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
-	if (!pte_same(orig_pte, pte))
-		changed = 1;
 
 	/* Make sure we don't lose the dirty state */
 	if (pte_dirty(orig_pte))
@@ -348,7 +353,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
 		set_pte_at(vma->vm_mm, addr, ptep, pfn_pte(pfn, hugeprot));
 
-	return changed;
+	return 1;
 }
 
 void huge_ptep_set_wrprotect(struct mm_struct *mm,
