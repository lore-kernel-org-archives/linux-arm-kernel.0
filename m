From: mina86@mina86.com (Michal Nazarewicz)
Date: Mon, 13 Feb 2012 11:38:22 -0800
Subject: [Linaro-mm-sig] [PATCHv21 12/16] mm: trigger page reclaim in
 alloc_contig_range() to stabilise watermarks
In-Reply-To: <CAOCHtYi01NVp1j=MX+0-z7ygW5tJuoswn8eWTQp+0Z5mMGdeQw@mail.gmail.com>
References: <1328895151-5196-1-git-send-email-m.szyprowski@samsung.com>
 <1328895151-5196-13-git-send-email-m.szyprowski@samsung.com>
 <CAOCHtYi01NVp1j=MX+0-z7ygW5tJuoswn8eWTQp+0Z5mMGdeQw@mail.gmail.com>
Message-ID: <op.v9mt58ch3l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Fri, Feb 10, 2012 at 11:32 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> @@ -5637,6 +5642,56 @@ static int __alloc_contig_migrate_range(unsigned long start, unsigned long end)
>>        return ret > 0 ? 0 : ret;
>>  }
>>
>> +/*
>> + * Update zone's cma pages counter used for watermark level calculation.
>> + */
>> +static inline void __update_cma_wmark_pages(struct zone *zone, int count)
>> +{
>> +       unsigned long flags;
>> +       spin_lock_irqsave(&zone->lock, flags);
>> +       zone->min_cma_pages += count;
>> +       spin_unlock_irqrestore(&zone->lock, flags);
>> +       setup_per_zone_wmarks();
>> +}
>> +
>> +/*
>> + * Trigger memory pressure bump to reclaim some pages in order to be able to
>> + * allocate 'count' pages in single page units. Does similar work as
>> + *__alloc_pages_slowpath() function.
>> + */
>> +static int __reclaim_pages(struct zone *zone, gfp_t gfp_mask, int count)
>> +{
>> +       enum zone_type high_zoneidx = gfp_zone(gfp_mask);
>> +       struct zonelist *zonelist = node_zonelist(0, gfp_mask);
>> +       int did_some_progress = 0;
>> +       int order = 1;
>> +       unsigned long watermark;
>> +
>> +       /*
>> +        * Increase level of watermarks to force kswapd do his job
>> +        * to stabilise at new watermark level.
>> +        */
>> +       __modify_min_cma_pages(zone, count);

On Mon, 13 Feb 2012 10:57:58 -0800, Robert Nelson <robertcnelson@gmail.com> wrote:
> Hi Marek,   This ^^^ function doesn't seem to exist in this patchset,
> is it in another set posted to lkml?

This should read __update_cma_wmark_pages().  Sorry for the incorrect patch.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
