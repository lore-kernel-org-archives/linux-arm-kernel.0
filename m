From: gerald.schaefer@de.ibm.com (Gerald Schaefer)
Date: Wed, 24 Feb 2016 17:44:46 +0100
Subject: [BUG] random kernel crashes after THP rework on s390 (maybe
 also on PowerPC and ARM)
In-Reply-To: <20160223193345.GC21820@node.shutemov.name>
References: <20160211192223.4b517057@thinkpad>
 <20160211190942.GA10244@node.shutemov.name>
 <20160211205702.24f0d17a@thinkpad>
 <20160212154116.GA15142@node.shutemov.name>
 <56BE00E7.1010303@de.ibm.com> <20160212181640.4eabb85f@thinkpad>
 <20160223103221.GA1418@node.shutemov.name>
 <20160223191907.25719a4d@thinkpad>
 <20160223193345.GC21820@node.shutemov.name>
Message-ID: <20160224174446.76095849@thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Feb 2016 22:33:45 +0300
"Kirill A. Shutemov" <kirill@shutemov.name> wrote:

> On Tue, Feb 23, 2016 at 07:19:07PM +0100, Gerald Schaefer wrote:
> > I'll check with Martin, maybe it is actually trivial, then we can
> > do a quick test it to rule that one out.
> 
> Oh. I found a bug in __split_huge_pmd_locked(). Although, not sure if it's
> _the_ bug.
> 
> pmdp_invalidate() is called for the wrong address :-/
> I guess that can be destructive on the architecture, right?

Thanks, that's it! We can no longer reproduce the crashes and calling
pmdp_invalidate() with a wrong address also perfectly explains the
memory corruption that I found in several dumps: 0x020 was ORed into
pte entries, which didn't make sense, and caused the list corruption
for example. 0x020 it is the invalid bit for pmd entries on s390 and
thus can be explained by this bug when a pte table lies before a pmd
table in memory.

> 
> Could you check this?
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 1c317b85ea7d..4246bc70e55a 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2865,7 +2865,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
>  	pmd_populate(mm, &_pmd, pgtable);
> 
> -	for (i = 0; i < HPAGE_PMD_NR; i++, haddr += PAGE_SIZE) {
> +	for (i = 0; i < HPAGE_PMD_NR; i++) {
>  		pte_t entry, *pte;
>  		/*
>  		 * Note that NUMA hinting access restrictions are not
> @@ -2886,9 +2886,9 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  		}
>  		if (dirty)
>  			SetPageDirty(page + i);
> -		pte = pte_offset_map(&_pmd, haddr);
> +		pte = pte_offset_map(&_pmd, haddr + i * PAGE_SIZE);
>  		BUG_ON(!pte_none(*pte));
> -		set_pte_at(mm, haddr, pte, entry);
> +		set_pte_at(mm, haddr + i * PAGE_SIZE, pte, entry);
>  		atomic_inc(&page[i]._mapcount);
>  		pte_unmap(pte);
>  	}
> @@ -2938,7 +2938,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  	pmd_populate(mm, pmd, pgtable);
> 
>  	if (freeze) {
> -		for (i = 0; i < HPAGE_PMD_NR; i++, haddr += PAGE_SIZE) {
> +		for (i = 0; i < HPAGE_PMD_NR; i++) {
>  			page_remove_rmap(page + i, false);
>  			put_page(page + i);
>  		}
