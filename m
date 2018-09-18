From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 18 Sep 2018 17:09:28 +0100
Subject: Huge page(contiguous bit) slow down
In-Reply-To: <20180918151625.GG16498@arm.com>
References: <8898674D84E3B24BA3A2D289B872026A69FE8F27@G01JPEXMBKW03>
 <20180918113300.GC16498@arm.com>
 <20180918145832.h24u5tbsqksvmrtq@armageddon.cambridge.arm.com>
 <20180918151625.GG16498@arm.com>
Message-ID: <20180918160927.hxtipnq6z6qrh7hw@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2018 at 04:16:26PM +0100, Will Deacon wrote:
> On Tue, Sep 18, 2018 at 03:58:32PM +0100, Catalin Marinas wrote:
> > On Tue, Sep 18, 2018 at 12:33:01PM +0100, Will Deacon wrote:
> > > On Tue, Sep 18, 2018 at 03:02:17AM +0000, Zhang, Lei wrote:
> > > > --- a/arch/arm64/mm/hugetlbpage.c
> > > > +++ b/arch/arm64/mm/hugetlbpage.c
> > > > @@ -332,6 +332,9 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
> > > >         if (!pte_cont(pte))
> > > >                 return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
> > > > 
> > > > +       if(pte_same(pte, READ_ONCE(*ptep)))
> > > > +               return 0;
> > > > +
> > > 
> > > This broadly seems to follow the non-contiguous code, but I wonder if we
> > > can then drop the subsequent pte_same() check on this path and always return
> > > 1 when we actually update the entries?
> > 
> > I don't remember why we went for first clearing and then checking
> > pte_same() (maybe Steve knows) but I think we can leave pte_same()
> > outside the get_clear_flush()/set_pte_at() block. This code is executed
> > with the mmap_sem taken, so there shouldn't be any race on the
> > individual ptes.
> 
> I suspect it's just to avoid the additional load of the page-table entry,
> since we still have to use get_clear_flush() even with this change.
> 
> One thing I don't really grok is the interaction between the contiguous
> hint and HW_AFDBM. Is it possible for us to be e.g. halfway through the
> set_pte_at() loop and then for the hardware to perform atomic PTE updates
> for entries later in the loop? If so, we've got a race and need to use
> cmpxchg() like we do for the non-contiguous code.

With the current code, no, since get_clear_flush() sets all of them to
0, so no hardware updates before set_pte_at().

-- 
Catalin
