From: pasha.tatashin@gmail.com (Pavel Tatashin)
Date: Thu, 16 Aug 2018 21:38:15 -0400
Subject: [RESEND PATCH v10 6/6] mm: page_alloc: reduce unnecessary binary
 search in early_pfn_valid()
In-Reply-To: <c6ed43ee-b09e-1f75-43b3-6cd2808d13f3@microsoft.com>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
 <1530867675-9018-7-git-send-email-hejianet@gmail.com>
 <c6ed43ee-b09e-1f75-43b3-6cd2808d13f3@microsoft.com>
Message-ID: <831be9a1-6401-3af0-b68b-b3e25db806f9@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/16/18 9:35 PM, Pasha Tatashin wrote:
> 
> 
> On 7/6/18 5:01 AM, Jia He wrote:
>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>> where possible") optimized the loop in memmap_init_zone(). But there is
>> still some room for improvement. E.g. in early_pfn_valid(), if pfn and
>> pfn+1 are in the same memblock region, we can record the last returned
>> memblock region index and check whether pfn++ is still in the same
>> region.
>>
>> Currently it only improve the performance on arm/arm64 and will have no
>> impact on other arches.
>>
>> For the performance improvement, after this set, I can see the time
>> overhead of memmap_init() is reduced from 27956us to 13537us in my
>> armv8a server(QDF2400 with 96G memory, pagesize 64k).
> 
> This series would be a lot simpler if patches 4, 5, and 6 were dropped.
> The extra complexity does not make sense to save 0.0001s/T during not.
s/not/boot

> 
> Patches 1-3, look OK, but without patches 4-5 __init_memblock should be
> made local static as I suggested earlier.
s/__init_memblock/early_region_idx
