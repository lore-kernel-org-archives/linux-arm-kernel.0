From: psandeep.s@gmail.com (Sandeep Patil)
Date: Thu, 8 Mar 2012 13:25:13 -0800
Subject: [Linaro-mm-sig] [PATCHv23 12/16] mm: trigger page reclaim in
 alloc_contig_range() to stabilise watermarks
In-Reply-To: <1329929337-16648-13-git-send-email-m.szyprowski@samsung.com>
References: <1329929337-16648-1-git-send-email-m.szyprowski@samsung.com>
 <1329929337-16648-13-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CA+K6fF5aN7Z3roKOzZe+a87ey4YcLd5Fr1U794wvb+8H3qP2+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static int __reclaim_pages(struct zone *zone, gfp_t gfp_mask, int count)
> +{
> + ? ? ? /*
> + ? ? ? ?* Increase level of watermarks to force kswapd do his job
> + ? ? ? ?* to stabilise at new watermark level.
> + ? ? ? ?*/
> + ? ? ? __update_cma_watermarks(zone, count);
> +
> + ? ? ? /* Obey watermarks as if the page was being allocated */
> + ? ? ? watermark = low_wmark_pages(zone) + count;
> + ? ? ? while (!zone_watermark_ok(zone, 0, watermark, 0, 0)) {

Wouldn't this reclaim (2 * count pages) above low wmark?

You are updating the low wmark first and then adding "count"
for the zone_watermark_ok() check as well ..

Sandeep
