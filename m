From: Steve.Capper@arm.com (Steve Capper)
Date: Thu, 20 Sep 2018 16:34:40 +0000
Subject: [PATCH] arm64: hugetlb: Avoid unnecessary clearing in
 huge_ptep_set_access_flags
In-Reply-To: <20180920093900.GB17617@arm.com>
References: <20180919174437.1866-1-steve.capper@arm.com>
 <20180920093900.GB17617@arm.com>
Message-ID: <20180920163257.qyiowkmxm2eqaauh@capper-debian.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 10:39:01AM +0100, Will Deacon wrote:
> Hi Steve,

Hi Will,

>
> On Wed, Sep 19, 2018 at 06:44:37PM +0100, Steve Capper wrote:
> > For contiguous hugetlb, huge_ptep_set_access_flags performs a
> > get_clear_flush (which then flushes the TLBs) even when no change of ptes
> > is necessary.
> >
> > Unfortunately, this behaviour can lead to back-to-back page faults being
> > generated when running with multiple threads that access the same
> > contiguous huge page.
> >
> > Thread 1                     |  Thread 2
> > -----------------------------+------------------------------
> > hugetlb_fault                |
> > huge_ptep_set_access_flags   |
> >   -> invalidate pte range    | hugetlb_fault
> > continue processing          | wait for hugetlb fault mutex
> > release mutex and return     | huge_ptep_set_access_flags
> >                              |   -> invalidate pte range
> > hugetlb_fault
>
> Is this serialised by a mutex of the mmap_sem? (or both?)
>

The serialisation point I was looking at was hugetlb_fault_mutex_hash.
I will make this clearer in the commit log.

> > This patch changes huge_ptep_set_access_flags s.t. we first read the
> > contiguous range of ptes (whilst preserving dirty information); the pte
> > range is only then invalidated where necessary and this prevents further
> > spurious page faults.
> >
> > Fixes: d8bdcff28764 ("arm64: hugetlb: Add break-before-make logic for contiguous entries")
> > Reported-by: Lei Zhang <zhang.lei@jp.fujitsu.com>
> > Signed-off-by: Steve Capper <steve.capper@arm.com>
> >
> > ---
> >
> > I was unable to test this on any hardware as I'm away from the office.
> >
> > Can you please test this Lei Zhang?
> >
> > Cheers,
> > --
> > Steve
> > ---
> >  arch/arm64/mm/hugetlbpage.c | 36 ++++++++++++++++++++++++++++++++----
> >  1 file changed, 32 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> > index 192b3ba07075..76d229eb6ba1 100644
> > --- a/arch/arm64/mm/hugetlbpage.c
> > +++ b/arch/arm64/mm/hugetlbpage.c
> > @@ -131,6 +131,27 @@ static pte_t get_clear_flush(struct mm_struct *mm,
> >  return orig_pte;
> >  }
> >
> > +static pte_t get_contig_pte(pte_t *ptep, unsigned long pgsize,
> > +unsigned long ncontig)
> > +{
> > +unsigned long i;
> > +pte_t orig_pte = huge_ptep_get(ptep);
> > +
> > +for (i = 0; i < ncontig; i++, ptep++) {
> > +pte_t pte = huge_ptep_get(ptep);
> > +
> > +/*
> > + * If HW_AFDBM is enabled, then the HW could turn on
> > + * the dirty bit for any page in the set, so check
> > + * them all.  All hugetlb entries are already young.
>
> Maybe mention that young implies that AF is set?
> Having said that, are you sure that these entries are already young?
> If so, why does hugetlb_fault() call pte_mkyoung() on the pte before
> passing it into huge_ptep_set_access_flags()? Also, since
> huge_ptep_set_access_flags() can only ever relax the permissions for
> an entry, if everything was young then it would imply that the only
> operation it ever does is to set dirty. In which case, we could
> assert pte_dirty(pte) and parts of the current code are redundant.
>
> What's going on here?

I'll scrutinise the young path a bit more. In make_huge_pte a young pte
is created right away, I suspect the call to pte_mkyoung in hugetlb
fault is to prevent the call to huge_ptep_set_access_flags from removing
the young information.

>
> > + */
> > +if (pte_dirty(pte))
> > +orig_pte = pte_mkdirty(orig_pte);
> > +}
> > +
> > +return orig_pte;
> > +}
> > +
> >  /*
> >   * Changing some bits of contiguous entries requires us to follow a
> >   * Break-Before-Make approach, breaking the whole contiguous set
> > @@ -324,7 +345,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
> >         unsigned long addr, pte_t *ptep,
> >         pte_t pte, int dirty)
> >  {
> > -int ncontig, i, changed = 0;
> > +int ncontig, i;
> >  size_t pgsize = 0;
> >  unsigned long pfn = pte_pfn(pte), dpfn;
> >  pgprot_t hugeprot;
> > @@ -336,9 +357,16 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
> >  ncontig = find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
> >  dpfn = pgsize >> PAGE_SHIFT;
> >
> > +orig_pte = get_contig_pte(ptep, pgsize, ncontig);
> > +if (pte_same(orig_pte, pte))
> > +return 0;
>
> Hmm, I don't understand how this solves the other problem we found. Imagine
> we have a contiguous range of ptes [pte0 ... pteN] and we have a CPU that
> doesn't support the contiguous hint and also doesn't support HW_AFDBM.
> Further, imagine that another CPU in the system *does* support HW_AFDBM.
>

:-(

> In this case, it would be possible for the first CPU to take a fault on
> pteN as a result of trying to write to a clean page. If the other CPU had
> already set the dirty bit for pte0, then your get_contig_pte() function
> will return a dirty orig_pte and the pte_same() check will pass for the
> faulting CPU, causing it to get stuck in a recursive fault.
>
> Ideally, we'd solve this by only performing the pte_same() check on the
> pte that is offset by the faulting address, but unfortunately the address
> we get passed here has already been rounded down. That's why I bailed and
> simply tried to check pte_same() on every pte. Really, we just to check
> the access and dirty flags -- another diff below.

Thanks, I understand, apologies for missing that earlier. I'll have
another think about huge_ptep_set_access_flags and will post a V2.

>
> > +/*
> > + * we need to get our orig_pte again as HW DBM may have happened since
> > + * above. get_clear_flush will ultimately cmpxchg with 0 to ensure
>
> s/cmpxchg/xchg/

Gah, thanks :-)

>
> Will
>
> --->8
>
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 192b3ba07075..0b7738d76f14 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -324,7 +324,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>         unsigned long addr, pte_t *ptep,
>         pte_t pte, int dirty)
>  {
> -int ncontig, i, changed = 0;
> +int ncontig, i;
>  size_t pgsize = 0;
>  unsigned long pfn = pte_pfn(pte), dpfn;
>  pgprot_t hugeprot;
> @@ -336,9 +336,20 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  ncontig = find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
>  dpfn = pgsize >> PAGE_SHIFT;
>
> +for (i = 0; i < ncontig; i++) {
> +orig_pte = huge_ptep_get(ptep + i);
> +
> +if (pte_dirty(orig_pte) != pte_dirty(pte))
> +break;
> +
> +if (pte_young(orig_pte) != pte_young(pte))
> +break;
> +}
> +
> +if (i == ncontig)
> +return 0;
> +
>  orig_pte = get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
> -if (!pte_same(orig_pte, pte))
> -changed = 1;
>
>  /* Make sure we don't lose the dirty state */
>  if (pte_dirty(orig_pte))
> @@ -348,7 +359,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
>  set_pte_at(vma->vm_mm, addr, ptep, pfn_pte(pfn, hugeprot));
>
> -return changed;
> +return 1;
>  }
>
>  void huge_ptep_set_wrprotect(struct mm_struct *mm,
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
