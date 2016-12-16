From: qiuxishi@huawei.com (Xishi Qiu)
Date: Fri, 16 Dec 2016 09:31:47 +0800
Subject: [RFC PATCH] Memory hotplug support for arm64 platform
In-Reply-To: <20161215183154.GC4806@samekh>
References: <1481717765-31186-1-git-send-email-m.bielski@virtualopensystems.com>
 <58523598.3080902@huawei.com> <58523AC5.10800@huawei.com>
 <20161215183154.GC4806@samekh>
Message-ID: <58534403.1040800@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/12/16 2:31, Andrea Reale wrote:

> Hi Xishi Qiu,
> 
> thanks for your comments. 
> 
> The short anwser to your question is the following.  As you hinted,
> it is related to the way pfn_valid() is implemented in arm64 when
> CONFIG_HAVE_ARCH_PFN_VALID is true (default), i.e., just a check for
> the NOMAP flags on the corresponding memblocks.
> 
> Since arch_add_memory->__add_pages() expects pfn_valid() to return false
> when it is first called, we mark corresponding memory blocks with NOMAP;
> however, arch_add_memory->__add_pages()->__add_section()->__add_zone()
> expects pfn_valid() to return true when, at the end of its body,
> it cycles through pages to call SetPageReserved(). Since blocks are
> marked with NOMAP, pages will not be reserved there, henceforth we
> need to reserve them after we clear the NOMAP flag inside the body of
> arch_add_memory. Having pages reserved at the end of arch_add_memory
> is a preconditions for the upcoming onlining of memory blocks (see
> memory_block_change_state()).
> 
>> It's because that in memmap_init_zone() -> early_pfn_valid(), the new page is still
>> invalid, so we need to init it after memblock_clear_nomap()
>>
>> So why not use __init_single_page() and set_pageblock_migratetype()?
> 
> About your comment on memmap_init_zone()->early_pfn_valid(), I think
> that that particular check is never executed in the context of memory
> hotplug; in fact, just before the call to early_pfn_valid(), the code
> will jump to the `not_early` label, because the context == MEMMAP_HOPTLUG.
> 

Hi Andrea,

Thanks for your answer, I notice it now. I thought SetPageReserved() was
done in memmap_init_zone(), but the new kernel change this logic now, so
sorry for the noise.

Thanks,
Xishi Qiu
