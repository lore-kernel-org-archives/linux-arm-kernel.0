From: mina86@mina86.com (Michal Nazarewicz)
Date: Mon, 12 Dec 2011 15:23:02 +0100
Subject: [PATCH 01/11] mm: page_alloc: handle MIGRATE_ISOLATE in
 free_pcppages_bulk()
In-Reply-To: <20111212134235.GB3277@csn.ul.ie>
References: <1321634598-16859-1-git-send-email-m.szyprowski@samsung.com>
 <1321634598-16859-2-git-send-email-m.szyprowski@samsung.com>
 <20111212134235.GB3277@csn.ul.ie>
Message-ID: <op.v6drko0p3l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Fri, Nov 18, 2011 at 05:43:08PM +0100, Marek Szyprowski wrote:
>> From: Michal Nazarewicz <mina86@mina86.com>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 9dd443d..58d1a2e 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -628,6 +628,18 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>>  			page = list_entry(list->prev, struct page, lru);
>>  			/* must delete as __free_one_page list manipulates */
>>  			list_del(&page->lru);
>> +
>> +			/*
>> +			 * When page is isolated in set_migratetype_isolate()
>> +			 * function it's page_private is not changed since the
>> +			 * function has no way of knowing if it can touch it.
>> +			 * This means that when a page is on PCP list, it's
>> +			 * page_private no longer matches the desired migrate
>> +			 * type.
>> +			 */
>> +			if (get_pageblock_migratetype(page) == MIGRATE_ISOLATE)
>> +				set_page_private(page, MIGRATE_ISOLATE);
>> +

On Mon, 12 Dec 2011 14:42:35 +0100, Mel Gorman <mel@csn.ul.ie> wrote:
> How much of a problem is this in practice?

IIRC, this lead to allocation being made from area marked as isolated
or some such.

> [...] I'd go as far to say that it would be preferable to drain the
> per-CPU lists after you set pageblocks MIGRATE_ISOLATE. The IPIs also have
> overhead but it will be incurred for the rare rather than the common case.

I'll look into that.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
