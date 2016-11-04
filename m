From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Nov 2016 09:48:14 -0600
Subject: [PATCH 1/2] arm64: hugetlb: remove the wrong pmd check in
 find_num_contig()
In-Reply-To: <20161104025216.GA19810@sha-win-210.asiapac.arm.com>
References: <1478140059-13829-1-git-send-email-shijie.huang@arm.com>
 <1478140059-13829-2-git-send-email-shijie.huang@arm.com>
 <20161104001616.ssjbemliorxi6evl@localhost>
 <20161104025216.GA19810@sha-win-210.asiapac.arm.com>
Message-ID: <20161104154814.hizb5277wp2f3enj@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2016 at 10:52:17AM +0800, Huang Shijie wrote:
> On Thu, Nov 03, 2016 at 06:16:16PM -0600, Catalin Marinas wrote:
> > On Thu, Nov 03, 2016 at 10:27:38AM +0800, Huang Shijie wrote:
> > > diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> > > index 2e49bd2..4811ef1 100644
> > > --- a/arch/arm64/mm/hugetlbpage.c
> > > +++ b/arch/arm64/mm/hugetlbpage.c
> > > @@ -61,10 +61,6 @@ static int find_num_contig(struct mm_struct *mm, unsigned long addr,
> > >  		return 1;
> > >  	}
> > >  	pmd = pmd_offset(pud, addr);
> > > -	if (!pmd_present(*pmd)) {
> > > -		VM_BUG_ON(!pmd_present(*pmd));
> > > -		return 1;
> > > -	}
> > >  	if ((pte_t *)pmd == ptep) {
> > >  		*pgsize = PMD_SIZE;
> > >  		return CONT_PMDS;
> > 
> > BTW, for the !pud_present() and !pgd_present() cases, shouldn't
> > find_num_contig() actually return 0? These are more likely real bugs, so
> > no point in setting the huge pte.
> 
> The kernel will not call the find_num_contig() if the PGD/PUD are empty.
> Please see the code in the hugetlb_fault().
> 
>    ------------------------------------------------------
> 	ptep = huge_pte_offset(mm, address);
> 	if (ptep) {
> 	    ...............................
> 	} else {
> 		ptep = huge_pte_alloc(mm, address, huge_page_size(h));
> 		if (!ptep)
> 			return VM_FAULT_OOM;
> 	}
>    ------------------------------------------------------

Exactly. So what is the reason for returning 1 if !pgd_present()? Would
removing the checks entirely or adding BUG() be a better option?

-- 
Catalin
