From: mgorman@techsingularity.net (Mel Gorman)
Date: Thu, 2 Jun 2016 14:52:26 +0100
Subject: [BUG] Page allocation failures with newest kernels
In-Reply-To: <CAPv3WKftqsEXbdU-geAcUKXBSskhA0V72N61a1a+5DfahLK_Dg@mail.gmail.com>
References: <CAPv3WKcVsWBgHHC3UPNcbka2JUmN4CTw1Ym4BR1=1V9=B9av5Q@mail.gmail.com>
 <574D64A0.2070207@arm.com>
 <CAPv3WKdYdwpi3k5eY86qibfprMFwkYOkDwHOsNydp=0sTV3mgg@mail.gmail.com>
 <60e8df74202e40b28a4d53dbc7fd0b22@IL-EXCH02.marvell.com>
 <20160531131520.GI24936@arm.com>
 <CAPv3WKftqsEXbdU-geAcUKXBSskhA0V72N61a1a+5DfahLK_Dg@mail.gmail.com>
Message-ID: <20160602135226.GX2527@techsingularity.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2016 at 07:48:38AM +0200, Marcin Wojtas wrote:
> Hi Will,
> 
> I think I found a right trace. Following one-liner fixes the issue
> beginning from v4.2-rc1 up to v4.4 included:
> 
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -294,7 +294,7 @@ static inline bool
> early_page_uninitialised(unsigned long pfn)
> 
>  static inline bool early_page_nid_uninitialised(unsigned long pfn, int nid)
>  {
> -       return false;
> +       return true;
>  }
> 

How does that make a difference in v4.4 since commit
974a786e63c96a2401a78ddba926f34c128474f1 removed the only
early_page_nid_uninitialised() ? It further doesn't make sense if deferred
memory initialisation is not enabled as the pages will always be
initialised.

> From what I understood, now order-0 allocation keep no reserve at all.

Watermarks should still be preserved. zone_watermark_ok is still there.
What might change is the size of reserves for high-order atomic
allocations only. Fragmentation shouldn't be a factor. I'm missing some
major part of the picture.

-- 
Mel Gorman
SUSE Labs
