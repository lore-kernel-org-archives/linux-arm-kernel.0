From: robertcnelson@gmail.com (Robert Nelson)
Date: Mon, 13 Feb 2012 12:57:58 -0600
Subject: [Linaro-mm-sig] [PATCHv21 12/16] mm: trigger page reclaim in
 alloc_contig_range() to stabilise watermarks
In-Reply-To: <1328895151-5196-13-git-send-email-m.szyprowski@samsung.com>
References: <1328895151-5196-1-git-send-email-m.szyprowski@samsung.com>
 <1328895151-5196-13-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAOCHtYi01NVp1j=MX+0-z7ygW5tJuoswn8eWTQp+0Z5mMGdeQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2012 at 11:32 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> alloc_contig_range() performs memory allocation so it also should keep
> track on keeping the correct level of memory watermarks. This commit adds
> a call to *_slowpath style reclaim to grab enough pages to make sure that
> the final collection of contiguous pages from freelists will not starve
> the system.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> CC: Michal Nazarewicz <mina86@mina86.com>
> Tested-by: Rob Clark <rob.clark@linaro.org>
> Tested-by: Ohad Ben-Cohen <ohad@wizery.com>
> Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> ---
> ?include/linux/mmzone.h | ? ?9 +++++++
> ?mm/page_alloc.c ? ? ? ?| ? 62 ++++++++++++++++++++++++++++++++++++++++++++++++
> ?2 files changed, 71 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 82f4fa5..6a6c2cc 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -63,8 +63,10 @@ enum {
>
> ?#ifdef CONFIG_CMA
> ?# ?define is_migrate_cma(migratetype) unlikely((migratetype) == MIGRATE_CMA)
> +# ?define cma_wmark_pages(zone) ? ? ? ?zone->min_cma_pages
> ?#else
> ?# ?define is_migrate_cma(migratetype) false
> +# ?define cma_wmark_pages(zone) 0
> ?#endif
>
> ?#define for_each_migratetype_order(order, type) \
> @@ -371,6 +373,13 @@ struct zone {
> ? ? ? ?/* see spanned/present_pages for more description */
> ? ? ? ?seqlock_t ? ? ? ? ? ? ? span_seqlock;
> ?#endif
> +#ifdef CONFIG_CMA
> + ? ? ? /*
> + ? ? ? ?* CMA needs to increase watermark levels during the allocation
> + ? ? ? ?* process to make sure that the system is not starved.
> + ? ? ? ?*/
> + ? ? ? unsigned long ? ? ? ? ? min_cma_pages;
> +#endif
> ? ? ? ?struct free_area ? ? ? ?free_area[MAX_ORDER];
>
> ?#ifndef CONFIG_SPARSEMEM
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 793c4e4..2fedd36 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5035,6 +5035,11 @@ static void __setup_per_zone_wmarks(void)
>
> ? ? ? ? ? ? ? ?zone->watermark[WMARK_LOW] ?= min_wmark_pages(zone) + (tmp >> 2);
> ? ? ? ? ? ? ? ?zone->watermark[WMARK_HIGH] = min_wmark_pages(zone) + (tmp >> 1);
> +
> + ? ? ? ? ? ? ? zone->watermark[WMARK_MIN] += cma_wmark_pages(zone);
> + ? ? ? ? ? ? ? zone->watermark[WMARK_LOW] += cma_wmark_pages(zone);
> + ? ? ? ? ? ? ? zone->watermark[WMARK_HIGH] += cma_wmark_pages(zone);
> +
> ? ? ? ? ? ? ? ?setup_zone_migrate_reserve(zone);
> ? ? ? ? ? ? ? ?spin_unlock_irqrestore(&zone->lock, flags);
> ? ? ? ?}
> @@ -5637,6 +5642,56 @@ static int __alloc_contig_migrate_range(unsigned long start, unsigned long end)
> ? ? ? ?return ret > 0 ? 0 : ret;
> ?}
>
> +/*
> + * Update zone's cma pages counter used for watermark level calculation.
> + */
> +static inline void __update_cma_wmark_pages(struct zone *zone, int count)
> +{
> + ? ? ? unsigned long flags;
> + ? ? ? spin_lock_irqsave(&zone->lock, flags);
> + ? ? ? zone->min_cma_pages += count;
> + ? ? ? spin_unlock_irqrestore(&zone->lock, flags);
> + ? ? ? setup_per_zone_wmarks();
> +}
> +
> +/*
> + * Trigger memory pressure bump to reclaim some pages in order to be able to
> + * allocate 'count' pages in single page units. Does similar work as
> + *__alloc_pages_slowpath() function.
> + */
> +static int __reclaim_pages(struct zone *zone, gfp_t gfp_mask, int count)
> +{
> + ? ? ? enum zone_type high_zoneidx = gfp_zone(gfp_mask);
> + ? ? ? struct zonelist *zonelist = node_zonelist(0, gfp_mask);
> + ? ? ? int did_some_progress = 0;
> + ? ? ? int order = 1;
> + ? ? ? unsigned long watermark;
> +
> + ? ? ? /*
> + ? ? ? ?* Increase level of watermarks to force kswapd do his job
> + ? ? ? ?* to stabilise at new watermark level.
> + ? ? ? ?*/
> + ? ? ? __modify_min_cma_pages(zone, count);

Hi Marek,   This ^^^ function doesn't seem to exist in this patchset,
is it in another set posted to lkml?

While (build error)testing this patchset on v3.3-rc3 with the
beagle/panda omapdrm driver..

mm/page_alloc.c: In function ?__reclaim_pages?:
mm/page_alloc.c:5674:2: error: implicit declaration of function
?__modify_min_cma_pages? [-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors

make[1]: *** [mm/page_alloc.o] Error 1
make: *** [mm] Error 2
make: *** Waiting for unfinished jobs....

:/KERNEL$ grep -R "modify_min_cma_pages" ./*
./mm/page_alloc.c:      __modify_min_cma_pages(zone, count);
./mm/page_alloc.c:      __modify_min_cma_pages(zone, -count);

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
