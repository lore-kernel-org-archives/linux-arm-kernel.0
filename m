From: cuibixuan@huawei.com (Bixuan Cui)
Date: Tue, 17 Oct 2017 20:42:24 +0800
Subject: =?UTF-8?B?44CQQlVH44CRVGhlIGtlcm5lbCBzdGFydCBmYWlsIHdoZW4gZW4=?=
 =?UTF-8?B?YWJsZSBDT05GSUdfQVJNNjRfTFNFX0FUT01JQ1MgYW5kIEtDT1ZfSU5TVFJVTUU=?=
 =?UTF-8?B?TlRfQUxM?=
In-Reply-To: <20171017110210.fz7srr2p5jiawvkg@lakrids.cambridge.arm.com>
References: <59E59B1B.9030206@huawei.com>
 <20171017110210.fz7srr2p5jiawvkg@lakrids.cambridge.arm.com>
Message-ID: <59E5FAB0.5030801@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This is a known issue [1,2] that's being worked on at the moment.
> 
> The problem is that the out-of-line LL/SC atomics are built with a
> special ABI, but KCOV inserts calls to other code that does not follow
> this ABI, resulting in register corruption.
> 
> When I saw this happen, this resulted in cmpxchg() spuriously failing
> somewhere in the page init code, which looks similar to what you're
> seeing.
> 
> The patch at [1] is sufficient to work around this for the time being.
Thank you for your explanation :-D .

Thanks,
Bixuan Cui

> 
> Thanks,
> Mark.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-September/533105.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-October/537018.html
> 
>>
>> After I try kernel v4.13 and it's the same result.
>> I trace the code and find it stop at the end of '__init_single_page(page, pfn, zone, nid)' in memmap_init_zone() of mm/page_alloc.c ?
>>
>> static void __meminit __init_single_page(struct page *page, unsigned long pfn,
>>                                 unsigned long zone, int nid)
>> {
>>         set_page_links(page, zone, nid, pfn);
>>         init_page_count(page);
>>         page_mapcount_reset(page);
>>         page_cpupid_reset_last(page);
>>
>>         INIT_LIST_HEAD(&page->lru);
>>
>> #ifdef WANT_PAGE_VIRTUAL
>>         /* The shift won't overflow because ZONE_NORMAL is below 4G. */
>>         if (!is_highmem_idx(zone))
>>                 set_page_address(page, __va(pfn << PAGE_SHIFT));
>> #endif
>> //      printk("stop here\n");
>> }
>>
>> Anyone can give me advice?
>>
>> Thanks,
>> Bixuan Cui
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> .
> 
