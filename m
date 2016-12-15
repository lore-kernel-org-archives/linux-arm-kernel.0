From: qiuxishi@huawei.com (Xishi Qiu)
Date: Thu, 15 Dec 2016 14:40:05 +0800
Subject: [RFC PATCH] Memory hotplug support for arm64 platform
In-Reply-To: <58523598.3080902@huawei.com>
References: <1481717765-31186-1-git-send-email-m.bielski@virtualopensystems.com>
 <58523598.3080902@huawei.com>
Message-ID: <58523AC5.10800@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/12/15 14:18, Xishi Qiu wrote:

> On 2016/12/14 20:16, Maciej Bielski wrote:
> 
>>
>>  
>> -#ifdef CONFIG_MEMORY_HOTREMOVE
>> -int arch_remove_memory(u64 start, u64 size)
>> -{
>> -	unsigned long start_pfn = start >> PAGE_SHIFT;
>> -	unsigned long nr_pages = size >> PAGE_SHIFT;
>> -	struct zone *zone;
>> -	int ret;
>> +		SetPageReserved(pfn_to_page(pfn));
>> +	}
> 
> Hi Maciej,
> 
> Why we need to set reserved here?
> I think the new pages are already reserved in __add_zone() -> memmap_init_zone(), right?
> 

Hi Maciej,

The reason is as follows, right?

It's because that in memmap_init_zone() -> early_pfn_valid(), the new page is still
invalid, so we need to init it after memblock_clear_nomap()

So why not use __init_single_page() and set_pageblock_migratetype()?

> Thanks,
> Xishi Qiu
> 
