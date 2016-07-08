From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 8 Jul 2016 17:13:48 +0100
Subject: [PATCH 1/1] arm64/hugetlb: clear PG_dcache_clean if the page is
 dirty when munmap
In-Reply-To: <577FC5AA.5010709@huawei.com>
References: <1467893344-8352-1-git-send-email-thunder.leizhen@huawei.com>
 <20160707153741.GC27180@e104818-lin.cambridge.arm.com>
 <577F1FD9.1040205@huawei.com>
 <20160708135447.GB22099@e104818-lin.cambridge.arm.com>
 <577FC5AA.5010709@huawei.com>
Message-ID: <20160708161347.GC22099@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2016 at 11:24:26PM +0800, Leizhen (ThunderTown) wrote:
> On 2016/7/8 21:54, Catalin Marinas wrote:
> > On Fri, Jul 08, 2016 at 11:36:57AM +0800, Leizhen (ThunderTown) wrote:
> >> On 2016/7/7 23:37, Catalin Marinas wrote:
> >>> On Thu, Jul 07, 2016 at 08:09:04PM +0800, Zhen Lei wrote:
> >>>> At present, PG_dcache_clean is only cleared when the related huge page
> >>>> is about to be freed. But sometimes, there maybe a process is in charge
> >>>> to copy binary codes into a shared memory, and notifies other processes
> >>>> to execute base on that. For the first time, there is no problem, because
> >>>> the default value of page->flags is PG_dcache_clean cleared. So the cache
> >>>> will be maintained at the time of set_pte_at for other processes. But if
> >>>> the content of the shared memory have been updated again, there is no
> >>>> cache operations, because the PG_dcache_clean is still set.
> >>>>
> >>>> For example:
> >>>> Process A
> >>>> 	open a hugetlbfs file
> >>>> 	mmap it as a shared memory
> >>>> 	copy some binary codes into it
> >>>> 	munmap
> >>>>
> >>>> Process B
> >>>> 	open the hugetlbfs file
> >>>> 	mmap it as a shared memory, executable
> >>>> 	invoke the functions in the shared memory
> >>>> 	munmap
> >>>>
> >>>> repeat the above steps.
> >>>
> >>> Does this work as you would expect with small pages (and for example
> >>> shared file mmap)? I don't want to have a different behaviour between
> >>> small and huge pages.
> >>
> >> The small pages also have this problem, I will try to fix it too.
[...]
> > If both cases need solving, we might better move the fix in the
> > __sync_icache_dcache() function. Untested:
>
> At first I also want to fix it as below. But I'm not sure which time the PageDirty
> will be cleared, and if two or more processes mmap it as executable, cache operations
> will be duplicated. At present, I really have not found any good place to clear
> PG_dcache_clean. So the below modification may be the best choice, concisely and clearly.
> 
> > ------------8<----------------
> > diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
> > index dbd12ea8ce68..c753fa804165 100644
> > --- a/arch/arm64/mm/flush.c
> > +++ b/arch/arm64/mm/flush.c
> > @@ -75,7 +75,8 @@ void __sync_icache_dcache(pte_t pte, unsigned long addr)
> >  	if (!page_mapping(page))
> >  		return;
> >  
> > -	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
> > +	if (!test_and_set_bit(PG_dcache_clean, &page->flags) ||
> > +	    PageDirty(page))
> >  		sync_icache_aliases(page_address(page),
> >  				    PAGE_SIZE << compound_order(page));
> >  	else if (icache_is_aivivt())
> > ----------------8<---------------------
> > 
> > BTW, can you make your tests (source) available somewhere?
>
> Both cases worked well with this patch.

Now I'm even more confused ;). IIUC, after an msync() in user space we
should flush the pages to disk via write_cache_pages(). This function
calls clear_page_dirty_for_io() after which PageDirty() is no longer
true. I can't tell how a subsequent mmap() can see the written pages as
dirty.

-- 
Catalin
