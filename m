From: minchan@kernel.org (Minchan Kim)
Date: Mon, 25 Aug 2014 17:18:37 +0900
Subject: [PATCH 0/2] ARM: Remove lowmem limit for default CMA region
In-Reply-To: <53FAED20.60200@samsung.com>
References: <1408610714-16204-1-git-send-email-m.szyprowski@samsung.com>
 <20140825012600.GN17372@bbox> <53FAED20.60200@samsung.com>
Message-ID: <20140825081836.GF32620@bbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 10:00:32AM +0200, Marek Szyprowski wrote:
> Hello,
> 
> On 2014-08-25 03:26, Minchan Kim wrote:
> >Hello,
> >
> >On Thu, Aug 21, 2014 at 10:45:12AM +0200, Marek Szyprowski wrote:
> >>Hello,
> >>
> >>Russell King recently noticed that limiting default CMA region only to
> >>low memory on ARM architecture causes serious memory management issues
> >>with machines having a lot of memory (which is mainly available as high
> >>memory). More information can be found the following thread:
> >>http://thread.gmane.org/gmane.linux.ports.arm.kernel/348441/
> >>
> >>Those two patches removes this limit letting kernel to put default CMA
> >>region into high memory when this is possible (there is enough high
> >>memory available and architecture specific DMA limit fits).
> >Agreed. It should be from the beginning because CMA page is effectly
> >pinned if it is anonymous page and system has no swap.
> 
> Nope. Even without swap, anonymous page can be correctly migrated to other
> location. Migration code doesn't depend on presence of swap.

I could be possible only if the zone has freeable page(ie, free pages
+ shrinkable page like page cache). IOW, if the zone is full with
anon pages, it's efffectively pinned.

> 
> >>This should solve strange OOM issues on systems with lots of RAM
> >>(i.e. >1GiB) and large (>256M) CMA area.
> >I totally agree with the patchset although I didn't review code
> >at all.
> >
> >Another topic:
> >It means it should be a problem still if system has CMA in lowmem
> >by some reason(ex, hardware limit or other purpose of CMA
> >rather than DMA subsystem)?
> >
> >In that case, an idea that just popped in my head is to migrate
> >pages from cma area to highest zone because they are all
> >userspace pages which should be in there but not sure it's worth
> >to implement at this point because how many such cripple platform
> >are.
> >
> >Just for the recording.
> 
> Moving pages between low and high zone is not that easy. If I remember
> correctly you cannot migrate a page from low memory to high zone in
> generic case, although it should be possible to add exception for
> anonymous pages. This will definitely improve poor low memory
> handling in low zone when CMA is enabled.

Yeb, it's possible for anonymous pages but I just wonder it's worth
to add more complexitiy to mm and and you are answering it's worth.
Okay. May I understand your positive feedback means such platform(
ie, DMA works with only lowmem) are still common?

Thanks.

> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo at kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email at kvack.org </a>

-- 
Kind regards,
Minchan Kim
