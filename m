From: will.deacon@arm.com (Will Deacon)
Date: Wed, 19 Sep 2018 17:05:12 +0100
Subject: Huge page(contiguous bit) slow down
In-Reply-To: <20180919153658.udwxks7p4saqvmt2@capper-debian.cambridge.arm.com>
References: <8898674D84E3B24BA3A2D289B872026A69FE8F27@G01JPEXMBKW03>
 <20180918113300.GC16498@arm.com>
 <20180918145832.h24u5tbsqksvmrtq@armageddon.cambridge.arm.com>
 <20180918151625.GG16498@arm.com>
 <20180918160927.hxtipnq6z6qrh7hw@armageddon.cambridge.arm.com>
 <20180918161432.GH16498@arm.com>
 <20180918171133.2suapy5le7lfp5gf@armageddon.cambridge.arm.com>
 <20180919102937.GD25094@arm.com>
 <20180919153658.udwxks7p4saqvmt2@capper-debian.cambridge.arm.com>
Message-ID: <20180919160511.GE22723@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2018 at 04:37:08PM +0100, Steve Capper wrote:
> On Wed, Sep 19, 2018 at 11:29:37AM +0100, Will Deacon wrote:
> > diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> > index 192b3ba07075..edae6774132d 100644
> > --- a/arch/arm64/mm/hugetlbpage.c
> > +++ b/arch/arm64/mm/hugetlbpage.c
> > @@ -324,7 +324,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
> >  			       unsigned long addr, pte_t *ptep,
> >  			       pte_t pte, int dirty)
> >  {
> > -	int ncontig, i, changed = 0;
> > +	int ncontig, i;
> >  	size_t pgsize = 0;
> >  	unsigned long pfn = pte_pfn(pte), dpfn;
> >  	pgprot_t hugeprot;
> > @@ -336,9 +336,14 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
> >  	ncontig = find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
> >  	dpfn = pgsize >> PAGE_SHIFT;
> >  
> > +	for (i = 0; i < ncontig; i++)
> > +		if (!pte_same(huge_ptep_get(ptep + i), pte))
> > +			break;
> > +
> 
> This comparison will always fail as our pfns will be different. I have a work
> in progress fix (a separate function to go through the contiguous range
> to preserve the dirty information) that I'll test and post shortly.

Ha, yes of course. I forgot about the most useful part of the pte!
I'll take a look at your patch when you post it.

Will
