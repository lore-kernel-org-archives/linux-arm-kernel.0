From: mina86@mina86.com (Michal Nazarewicz)
Date: Mon, 30 Jan 2012 14:06:50 +0100
Subject: [PATCH 08/15] mm: mmzone: MIGRATE_CMA migration type added
In-Reply-To: <20120130123542.GL25268@csn.ul.ie>
References: <1327568457-27734-1-git-send-email-m.szyprowski@samsung.com>
 <1327568457-27734-9-git-send-email-m.szyprowski@samsung.com>
 <20120130123542.GL25268@csn.ul.ie>
Message-ID: <op.v8wepotk3l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thu, Jan 26, 2012 at 10:00:50AM +0100, Marek Szyprowski wrote:
>> From: Michal Nazarewicz <mina86@mina86.com>
>> @@ -875,10 +895,15 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
>>   * This array describes the order lists are fallen back to when
>>   * the free lists for the desirable migrate type are depleted
>>   */
>> -static int fallbacks[MIGRATE_TYPES][3] = {
>> +static int fallbacks[MIGRATE_TYPES][4] = {
>>  	[MIGRATE_UNMOVABLE]   = { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE,   MIGRATE_RESERVE },
>>  	[MIGRATE_RECLAIMABLE] = { MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE,   MIGRATE_RESERVE },
>> +#ifdef CONFIG_CMA
>> +	[MIGRATE_MOVABLE]     = { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE, MIGRATE_CMA    , MIGRATE_RESERVE },

On Mon, 30 Jan 2012 13:35:42 +0100, Mel Gorman <mel@csn.ul.ie> wrote:
> This is a curious choice. MIGRATE_CMA is allowed to contain movable
> pages. By using MIGRATE_RECLAIMABLE and MIGRATE_UNMOVABLE for movable
> pages instead of MIGRATE_CMA, you increase the changes that unmovable
> pages will need to use MIGRATE_MOVABLE in the future which impacts
> fragmentation avoidance. I would recommend that you change this to
>
> { MIGRATE_CMA, MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE, MIGRATE_RESERVE }

At the beginning the idea was to try hard not to get pages from MIGRATE_CMA
allocated at all, thus it was put at the end of the fallbacks list, but on
a busy system this probably won't help anyway, so I'll change it per your
suggestion.

>> @@ -1017,11 +1049,14 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype)
>>  			rmv_page_order(page);
>>
>>  			/* Take ownership for orders >= pageblock_order */
>> -			if (current_order >= pageblock_order)
>> +			if (current_order >= pageblock_order &&
>> +			    !is_pageblock_cma(page))
>>  				change_pageblock_range(page, current_order,
>>  							start_migratetype);
>>
>> -			expand(zone, page, order, current_order, area, migratetype);
>> +			expand(zone, page, order, current_order, area,
>> +			       is_migrate_cma(start_migratetype)
>> +			     ? start_migratetype : migratetype);
>>
>
> What is this check meant to be doing?
>
> start_migratetype is determined by allocflags_to_migratetype() and
> that never will be MIGRATE_CMA so is_migrate_cma(start_migratetype)
> should always be false.

Right, thanks!  This should be the other way around, ie.:

+			expand(zone, page, order, current_order, area,
+			       is_migrate_cma(migratetype)
+			     ? migratetype : start_migratetype);

I'll fix this and the calls to is_pageblock_cma().

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
