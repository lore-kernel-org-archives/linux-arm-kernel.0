From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 Jan 2017 10:19:25 +0000
Subject: [PATCH] arm64: hugetlb: fix the wrong return value for
 huge_ptep_set_access_flags
In-Reply-To: <20170111060044.GA6112@sha-win-210.asiapac.arm.com>
References: <1484114308-6068-1-git-send-email-shijie.huang@arm.com>
 <20170111060044.GA6112@sha-win-210.asiapac.arm.com>
Message-ID: <20170111101924.GA18044@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 02:00:46PM +0800, Huang Shijie wrote:
> On Wed, Jan 11, 2017 at 01:58:28PM +0800, Huang Shijie wrote:
> > In current code, the @changed always returns the last one's
> > status for the huge page with the contiguous bit set.
> > This is really not what we want. Even one of the PTEs is changed,
> > we should tell it to the caller.
> > 
> > This patch fixes this issue.
> > 
> > Fixes: 66b3923a1a0f ("arm64: hugetlb: add support for PTE contiguous bit")
> > Cc: stable at vger.kernel.org
> > Signed-off-by: Huang Shijie <shijie.huang@arm.com>
> > ---
> >  arch/arm64/mm/hugetlbpage.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> > index 964b7549af5c..e25584d72396 100644
> > --- a/arch/arm64/mm/hugetlbpage.c
> > +++ b/arch/arm64/mm/hugetlbpage.c
> > @@ -239,7 +239,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
> >  		ncontig = find_num_contig(vma->vm_mm, addr, cpte,
> >  					  *cpte, &pgsize);
> >  		for (i = 0; i < ncontig; ++i, ++cpte, addr += pgsize) {
> > -			changed = ptep_set_access_flags(vma, addr, cpte,
> > +			changed |= ptep_set_access_flags(vma, addr, cpte,
> >  							pfn_pte(pfn,
> >  								hugeprot),
> >  							dirty);
> > -- 
> > 2.5.5
> > 
> sorry, I missed to remove the disclaimer.

The disclaimer is not the main issue. The patch that ended up on the
list seems to have been corrupted probably by the SMTP server (all tabs
converted to spaces).

-- 
Catalin
