From: minchan.kim@gmail.com (Minchan Kim)
Date: Thu, 28 Oct 2010 08:22:38 +0900
Subject: [RFC][PATCH 0/3] big chunk memory allocator v2
In-Reply-To: <20101026190042.57f30338.kamezawa.hiroyu@jp.fujitsu.com>
References: <20101026190042.57f30338.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <AANLkTim4fFXQKqmFCeR8pvi0SZPXpjDqyOkbV6PYJYkR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 26, 2010 at 7:00 PM, KAMEZAWA Hiroyuki
<kamezawa.hiroyu@jp.fujitsu.com> wrote:
> Hi, here is version 2.
>
> I only did small test and it seems to work (but I think there will be bug...)
> I post this now just because I'll be out of office 10/31-11/15 with ksummit and
> a private trip.
>
> Any comments are welcome but please see the interface is enough for use cases or
> not. ?For example) If MAX_ORDER alignment is too bad, I need to rewrite almost
> all code.

First of all, thanks for the endless your effort to embedded system.
It's time for statkeholders to review this.
Cced some guys. Maybe many people of them have to attend KS.
So I hope SAMSUNG guys review this.

Maybe they can't test this since ARM doesn't support movable zone now.
(I will look into this).
As Kame said, please, review this patch whether this patch have enough
interface and meet
your requirement.
I think this can't meet _all_ of your requirements(ex, latency and
making sure getting big contiguous memory) but I believe it can meet
NOT CRITICAL many cases, I guess.

>
> Now interface is:
>
>
> struct page *__alloc_contig_pages(unsigned long base, unsigned long end,
> ? ? ? ? ? ? ? ? ? ? ? ?unsigned long nr_pages, int align_order,
> ? ? ? ? ? ? ? ? ? ? ? ?int node, gfp_t gfpflag, nodemask_t *mask)
>
> ?* @base: the lowest pfn which caller wants.
> ?* @end: ?the highest pfn which caller wants.
> ?* @nr_pages: the length of a chunk of pages to be allocated.
> ?* @align_order: alignment of start address of returned chunk in order.
> ?* ? Returned' page's order will be aligned to (1 << align_order).If smaller
> ?* ? than MAX_ORDER, it's raised to MAX_ORDER.
> ?* @node: allocate near memory to the node, If -1, current node is used.
> ?* @gfpflag: see include/linux/gfp.h
> ?* @nodemask: allocate memory within the nodemask.
>
> If the caller wants a FIXED address, set end - base == nr_pages.
>
> The patch is based onto the latest mmotm + Bob's 3 patches for fixing
> memory_hotplug.c (they are queued.)
>
> Thanks,
> -Kame
>
>
>
>
>



-- 
Kind regards,
Minchan Kim
