From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 30 May 2014 08:07:11 +0200
Subject: [PATCH] CMA: correct unlock target
In-Reply-To: <53874AB5.5010908@codeaurora.org>
References: <1401344958-3790-1-git-send-email-iamjoonsoo.kim@lge.com>
 <5386E313.6070705@samsung.com> <53874AB5.5010908@codeaurora.org>
Message-ID: <5388200F.7000201@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-05-29 16:56, Laura Abbott wrote:
> On 5/29/2014 12:34 AM, Marek Szyprowski wrote:
> > Hello,
> >
> > On 2014-05-29 08:29, Joonsoo Kim wrote:
> >> 'cma: Remove potential deadlock situation' introduces per cma area mutex
> >> for bitmap management. It is good, but there is one mistake. When we
> >> can't find appropriate area in bitmap, we release cma_mutex global lock
> >> rather than cma->lock and this is a bug. So fix it.
> >>
> >> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > Thanks for spotting this issue. I've added it to my tree.
> >
> >> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> >> index 6f6bffc..83969f8 100644
> >> --- a/drivers/base/dma-contiguous.c
> >> +++ b/drivers/base/dma-contiguous.c
> >> @@ -331,7 +331,7 @@ struct page *dma_alloc_from_contiguous(struct device *dev, int count,
> >>           pageno = bitmap_find_next_zero_area(cma->bitmap, cma->count,
> >>                               start, count, mask);
> >>           if (pageno >= cma->count) {
> >> -            mutex_unlock(&cma_mutex);
> >> +            mutex_unlock(&cma->lock);
> >>               break;
> >>           }
> >>           bitmap_set(cma->bitmap, pageno, count);
> >
> > Best regards
>
> Acked-by: Laura Abbott <lauraa@codeaurora.org>
>
> Who actually ended up picking up that patch? I sent it out but didn't realize it had been
> picked up.

I've taken it to my dma-mapping tree some time ago, I think that
I've replied to the original mail with information about taking it.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
