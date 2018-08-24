From: mhocko@kernel.org (Michal Hocko)
Date: Fri, 24 Aug 2018 13:41:58 +0200
Subject: A crash on ARM64 in move_freepages_block due to uninitialized
 pages in reserved memory
In-Reply-To: <c823eace-8710-9bf5-6e76-d01b139c0859@arm.com>
References: <alpine.LRH.2.02.1808171527220.2385@file01.intranet.prod.int.rdu2.redhat.com>
 <20180821104418.GA16611@dhcp22.suse.cz>
 <e35b7c14-c7ea-412d-2763-c961b74576f3@arm.com>
 <alpine.LRH.2.02.1808220808050.17906@file01.intranet.prod.int.rdu2.redhat.com>
 <c823eace-8710-9bf5-6e76-d01b139c0859@arm.com>
Message-ID: <20180824114158.GJ29735@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 23-08-18 15:06:08, James Morse wrote:
[...]
> My best-guess is that pfn_valid_within() shouldn't be optimised out if
> ARCH_HAS_HOLES_MEMORYMODEL, even if HOLES_IN_ZONE isn't set.
> 
> Does something like this solve the problem?:
> ============================%<============================
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 32699b2dc52a..5e27095a15f4 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1295,7 +1295,7 @@ void memory_present(int nid, unsigned long start, unsigned
> long end);
>   * pfn_valid_within() should be used in this case; we optimise this away
>   * when we have no holes within a MAX_ORDER_NR_PAGES block.
>   */
> -#ifdef CONFIG_HOLES_IN_ZONE
> +#if defined(CONFIG_HOLES_IN_ZONE) || defined(CONFIG_ARCH_HAS_HOLES_MEMORYMODEL)
>  #define pfn_valid_within(pfn) pfn_valid(pfn)
>  #else
>  #define pfn_valid_within(pfn) (1)
> ============================%<============================

This is the first time I hear about CONFIG_ARCH_HAS_HOLES_MEMORYMODEL.
Why it doesn't imply CONFIG_HOLES_IN_ZONE?

> > I analyzed the assembler:
> > PageBuddy in move_freepages returns false
> > Then we call PageLRU, the macro calls PF_HEAD which is compound_page()
> > compound_page reads page->compound_head, it is 0xffffffffffffffff, so it
> > resturns 0xfffffffffffffffe - and accessing this address causes crash
> 
> Thanks!
> That wasn't straightforward to work out without the vmlinux.
> 
> Because you see all-ones, even in KVM, it looks like the struct page is being
> initialized like that deliberately... I haven't found where this might be happening.

It should be

sparse_add_one_section
#ifdef CONFIG_DEBUG_VM
	/*
	 * Poison uninitialized struct pages in order to catch invalid flags
	 * combinations.
	 */
	memset(memmap, PAGE_POISON_PATTERN, sizeof(struct page) * PAGES_PER_SECTION);
#endif

-- 
Michal Hocko
SUSE Labs
