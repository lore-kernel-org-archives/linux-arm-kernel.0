From: mina86@mina86.com (Michal Nazarewicz)
Date: Fri, 03 Feb 2012 16:50:30 +0100
Subject: [PATCH 08/15] mm: mmzone: MIGRATE_CMA migration type added
In-Reply-To: <CAJd=RBByc_wLEJTK66J4eY03CWnCoCRiwAeEYjXCZ5xEZhp3ag@mail.gmail.com>
References: <1328271538-14502-1-git-send-email-m.szyprowski@samsung.com>
 <1328271538-14502-9-git-send-email-m.szyprowski@samsung.com>
 <CAJd=RBByc_wLEJTK66J4eY03CWnCoCRiwAeEYjXCZ5xEZhp3ag@mail.gmail.com>
Message-ID: <op.v830ygma3l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Fri, Feb 3, 2012 at 8:18 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> From: Michal Nazarewicz <mina86@mina86.com>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index d5174c4..a6e7c64 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -45,6 +45,11 @@ static void map_pages(struct list_head *list)
>>        }
>>  }
>>
>> +static inline bool migrate_async_suitable(int migratetype)

On Fri, 03 Feb 2012 15:19:54 +0100, Hillf Danton <dhillf@gmail.com> wrote:
> Just nitpick, since the helper is not directly related to what async means,
> how about migrate_suitable(int migrate_type) ?

I feel current name is better suited since it says that it's OK to scan this
block if it's an asynchronous compaction run.

>> +{
>> +       return is_migrate_cma(migratetype) || migratetype == MIGRATE_MOVABLE;
>> +}
>> +
>>  /*
>>  * Isolate free pages onto a private freelist. Caller must hold zone->lock.
>>  * If @strict is true, will abort returning 0 on any invalid PFNs or non-free
>> @@ -277,7 +282,7 @@ isolate_migratepages_range(struct zone *zone, struct compact_control *cc,
>>                 */
>>                pageblock_nr = low_pfn >> pageblock_order;
>>                if (!cc->sync && last_pageblock_nr != pageblock_nr &&
>> -                               get_pageblock_migratetype(page) != MIGRATE_MOVABLE) {
>> +                   migrate_async_suitable(get_pageblock_migratetype(page))) {
>
> Here compaction looks corrupted if CMA not enabled, Mel?

Damn, yes, this should be !migrate_async_suitable(...).  Sorry about that.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
