From: mina86@mina86.com (Michal Nazarewicz)
Date: Mon, 12 Dec 2011 15:35:03 +0100
Subject: [PATCH 03/11] mm: mmzone: introduce zone_pfn_same_memmap()
In-Reply-To: <20111212141953.GD3277@csn.ul.ie>
References: <1321634598-16859-1-git-send-email-m.szyprowski@samsung.com>
 <1321634598-16859-4-git-send-email-m.szyprowski@samsung.com>
 <20111212141953.GD3277@csn.ul.ie>
Message-ID: <op.v6dr4pj43l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Fri, Nov 18, 2011 at 05:43:10PM +0100, Marek Szyprowski wrote:
>> From: Michal Nazarewicz <mina86@mina86.com>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 6afae0e..09c9702 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -111,7 +111,10 @@ skip:
>>
>>  next:
>>  		pfn += isolated;
>> -		page += isolated;
>> +		if (zone_pfn_same_memmap(pfn - isolated, pfn))
>> +			page += isolated;
>> +		else
>> +			page = pfn_to_page(pfn);
>>  	}

On Mon, 12 Dec 2011 15:19:53 +0100, Mel Gorman <mel@csn.ul.ie> wrote:
> Is this necessary?
>
> We are isolating pages, the largest of which is a MAX_ORDER_NR_PAGES
> page.  [...]

This is not true for CMA.

> That said, everywhere else managed to avoid checks like this by always
> scanning in units of pageblocks. Maybe this should be structured
> the same way to guarantee pfn_valid is called at least per pageblock
> (even though only once per MAX_ORDER_NR_PAGES is necessary).

I'll look into that.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
