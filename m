From: Steve.Capper@arm.com (Steve Capper)
Date: Tue, 18 Sep 2018 20:30:08 +0000
Subject: Huge page(contiguous bit) slow down
In-Reply-To: <20180918171133.2suapy5le7lfp5gf@armageddon.cambridge.arm.com>
References: <8898674D84E3B24BA3A2D289B872026A69FE8F27@G01JPEXMBKW03>
 <20180918113300.GC16498@arm.com>
 <20180918145832.h24u5tbsqksvmrtq@armageddon.cambridge.arm.com>
 <20180918151625.GG16498@arm.com>
 <20180918160927.hxtipnq6z6qrh7hw@armageddon.cambridge.arm.com>
 <20180918161432.GH16498@arm.com>
 <20180918171133.2suapy5le7lfp5gf@armageddon.cambridge.arm.com>
Message-ID: <20180918202950.7gmymwlpqhzt6mma@capper-debian.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2018 at 06:11:34PM +0100, Catalin Marinas wrote:
> On Tue, Sep 18, 2018 at 05:14:33PM +0100, Will Deacon wrote:
> > On Tue, Sep 18, 2018 at 05:09:28PM +0100, Catalin Marinas wrote:
> > > On Tue, Sep 18, 2018 at 04:16:26PM +0100, Will Deacon wrote:
> > > > On Tue, Sep 18, 2018 at 03:58:32PM +0100, Catalin Marinas wrote:
> > > > > On Tue, Sep 18, 2018 at 12:33:01PM +0100, Will Deacon wrote:
> > > > > > On Tue, Sep 18, 2018 at 03:02:17AM +0000, Zhang, Lei wrote:
> > > > > > > --- a/arch/arm64/mm/hugetlbpage.c
> > > > > > > +++ b/arch/arm64/mm/hugetlbpage.c
> > > > > > > @@ -332,6 +332,9 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
> > > > > > >         if (!pte_cont(pte))
> > > > > > >                 return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
> > > > > > > 
> > > > > > > +       if(pte_same(pte, READ_ONCE(*ptep)))
> > > > > > > +               return 0;
> > > > > > > +
> > > > > > 
> > > > > > This broadly seems to follow the non-contiguous code, but I wonder if we
> > > > > > can then drop the subsequent pte_same() check on this path and always return
> > > > > > 1 when we actually update the entries?
> > > > > 
> > > > > I don't remember why we went for first clearing and then checking
> > > > > pte_same() (maybe Steve knows) but I think we can leave pte_same()
> > > > > outside the get_clear_flush()/set_pte_at() block. This code is executed
> > > > > with the mmap_sem taken, so there shouldn't be any race on the
> > > > > individual ptes.
> > > > 
> > > > I suspect it's just to avoid the additional load of the page-table entry,
> > > > since we still have to use get_clear_flush() even with this change.
> > > > 
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
> 

FWIW, all hugetlb ptes are young so AF should always be set for present
hugetlb pages.

Cheers,
-- 
Steve
