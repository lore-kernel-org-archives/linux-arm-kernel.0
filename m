From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 18 Sep 2018 15:58:32 +0100
Subject: Huge page(contiguous bit) slow down
In-Reply-To: <20180918113300.GC16498@arm.com>
References: <8898674D84E3B24BA3A2D289B872026A69FE8F27@G01JPEXMBKW03>
 <20180918113300.GC16498@arm.com>
Message-ID: <20180918145832.h24u5tbsqksvmrtq@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2018 at 12:33:01PM +0100, Will Deacon wrote:
> On Tue, Sep 18, 2018 at 03:02:17AM +0000, Zhang, Lei wrote:
> > --- a/arch/arm64/mm/hugetlbpage.c
> > +++ b/arch/arm64/mm/hugetlbpage.c
> > @@ -332,6 +332,9 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
> >         if (!pte_cont(pte))
> >                 return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
> > 
> > +       if(pte_same(pte, READ_ONCE(*ptep)))
> > +               return 0;
> > +
> 
> This broadly seems to follow the non-contiguous code, but I wonder if we
> can then drop the subsequent pte_same() check on this path and always return
> 1 when we actually update the entries?

I don't remember why we went for first clearing and then checking
pte_same() (maybe Steve knows) but I think we can leave pte_same()
outside the get_clear_flush()/set_pte_at() block. This code is executed
with the mmap_sem taken, so there shouldn't be any race on the
individual ptes.

-- 
Catalin
