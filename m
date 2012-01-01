From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Sun, 1 Jan 2012 09:49:13 +0200
Subject: [PATCH 01/11] mm: page_alloc: set_migratetype_isolate: drain PCP
 prior to isolating
In-Reply-To: <1325162352-24709-2-git-send-email-m.szyprowski@samsung.com>
References: <1325162352-24709-1-git-send-email-m.szyprowski@samsung.com>
 <1325162352-24709-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAOtvUMeAVgDwRNsDTcG07ChYnAuNgNJjQ+sKALJ79=Ezikos-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2011 at 2:39 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> From: Michal Nazarewicz <mina86@mina86.com>
>
> When set_migratetype_isolate() sets pageblock's migrate type, it does
> not change each page_private data. ?This makes sense, as the function
> has no way of knowing what kind of information page_private stores.
...
>
>
> A side effect is that instead of draining pages from all zones,
> set_migratetype_isolate() now drain only pages from zone pageblock it
> operates on is in.
>
...


>
> +/* Caller must hold zone->lock. */
> +static void __zone_drain_local_pages(void *arg)
> +{
> + ? ? ? struct per_cpu_pages *pcp;
> + ? ? ? struct zone *zone = arg;
> + ? ? ? unsigned long flags;
> +
> + ? ? ? local_irq_save(flags);
> + ? ? ? pcp = &per_cpu_ptr(zone->pageset, smp_processor_id())->pcp;
> + ? ? ? if (pcp->count) {
> + ? ? ? ? ? ? ? /* Caller holds zone->lock, no need to grab it. */
> + ? ? ? ? ? ? ? __free_pcppages_bulk(zone, pcp->count, pcp);
> + ? ? ? ? ? ? ? pcp->count = 0;
> + ? ? ? }
> + ? ? ? local_irq_restore(flags);
> +}
> +
> +/*
> + * Like drain_all_pages() but operates on a single zone. ?Caller must
> + * hold zone->lock.
> + */
> +static void __zone_drain_all_pages(struct zone *zone)
> +{
> + ? ? ? on_each_cpu(__zone_drain_local_pages, zone, 1);
> +}
> +

Please consider whether sending an IPI to all processors in the system
and interrupting them is appropriate here.

You seem to assume that it is probable that each CPU of the possibly
4,096 (MAXSMP on x86) has a per-cpu page
for the specified zone, otherwise you're just interrupting them out of
doing something useful, or save power idle
for nothing.

While that may or may not be a reasonable assumption for the general
drain_all_pages that drains pcps from
all zones, I feel it is less likely to be the right thing once you
limit the drain to a single zone.

Some background on my attempt to reduce "IPI noise" in the system in
this context is probably useful here as
well: https://lkml.org/lkml/2011/11/22/133

Thanks :-)
Gilad



-- 
Gilad Ben-Yossef
Chief Coffee Drinker
gilad at benyossef.com
Israel Cell: +972-52-8260388
US Cell: +1-973-8260388
http://benyossef.com

"Unfortunately, cache misses are an equal opportunity pain provider."
-- Mike Galbraith, LKML
