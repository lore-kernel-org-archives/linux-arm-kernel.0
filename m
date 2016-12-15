From: ar@linux.vnet.ibm.com (Andrea Reale)
Date: Thu, 15 Dec 2016 18:31:55 +0000
Subject: [RFC PATCH] Memory hotplug support for arm64 platform
In-Reply-To: <58523AC5.10800@huawei.com>
References: <1481717765-31186-1-git-send-email-m.bielski@virtualopensystems.com>
 <58523598.3080902@huawei.com> <58523AC5.10800@huawei.com>
Message-ID: <20161215183154.GC4806@samekh>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xishi Qiu,

thanks for your comments. 

The short anwser to your question is the following.  As you hinted,
it is related to the way pfn_valid() is implemented in arm64 when
CONFIG_HAVE_ARCH_PFN_VALID is true (default), i.e., just a check for
the NOMAP flags on the corresponding memblocks.

Since arch_add_memory->__add_pages() expects pfn_valid() to return false
when it is first called, we mark corresponding memory blocks with NOMAP;
however, arch_add_memory->__add_pages()->__add_section()->__add_zone()
expects pfn_valid() to return true when, at the end of its body,
it cycles through pages to call SetPageReserved(). Since blocks are
marked with NOMAP, pages will not be reserved there, henceforth we
need to reserve them after we clear the NOMAP flag inside the body of
arch_add_memory. Having pages reserved at the end of arch_add_memory
is a preconditions for the upcoming onlining of memory blocks (see
memory_block_change_state()).

> It's because that in memmap_init_zone() -> early_pfn_valid(), the new page is still
> invalid, so we need to init it after memblock_clear_nomap()
> 
> So why not use __init_single_page() and set_pageblock_migratetype()?

About your comment on memmap_init_zone()->early_pfn_valid(), I think
that that particular check is never executed in the context of memory
hotplug; in fact, just before the call to early_pfn_valid(), the code
will jump to the `not_early` label, because the context == MEMMAP_HOPTLUG.

Now, the question would be: why there's no need for this hack in
implementation for memory hotplug for other architectures (e.g.,
x86)? The answer we have found lies in the following: as said above,
when CONFIG_HAVE_ARCH_PFN_VALID is true (default), the implementation
of pfn_valid for arm64 just checks the NOMAP flag on the memmblocks,
and returns true if corresponding memblock_add_node() has succeeded (it
seems it does not consider the sparse memory model structures created
by arm64_memory_present() and sparse_init()).

On the contrary, the implementation of pfn_valid() for other
architectures is defined in include/linux/mmzone.h. This
implemenation, among other things, checks for the
SECTION_HAS_MEM_MAP flag on section->section_mem_map. Now,
when we go to memory hotplug, this flag is actually set inside
__add_section()->sparse_add_one_section()->sparse_init_one_section(). This
happens before the call to __add_zone(), so that, when it is eventually
invoked, pfn_valid() would return true and pages would be correctly
reserved.  On the contrary, on arm64, it will keep returning false
because of the different implementation of pfn_valid().

Given the above, we believed it was cleaner to go for this little and
well-confined hack rather then possibly changing the logic of pfn_valid.

However, we are very open for discussion and suggestions for improvement.
In particular, any advices on how to effectively modify pfn_valid()
without breaking existing functionalities are very welcome.

Thanks,
Andrea
