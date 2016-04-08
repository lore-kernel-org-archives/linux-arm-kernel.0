From: dianders@chromium.org (Doug Anderson)
Date: Fri, 8 Apr 2016 09:50:43 -0700
Subject: [PATCH v2 1/2] dma/iommu: Add pgsize_bitmap confirmation in
 __iommu_dma_alloc_pages
In-Reply-To: <20160408130733.GD23750@arm.com>
References: <1459146732-15620-1-git-send-email-yong.wu@mediatek.com>
 <20160329170238.GK6745@arm.com>
 <CAD=FV=XdZwg8usj3bjM6W=A0Yk1AFqKFRadpiS-LGLwxVNxp7A@mail.gmail.com>
 <20160408130733.GD23750@arm.com>
Message-ID: <CAD=FV=VbekVUHW3=d0icSgUO1M-1cccwCAZ+s=YSzOtEveCQag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

On Fri, Apr 8, 2016 at 6:07 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Apr 05, 2016 at 10:03:32AM -0700, Doug Anderson wrote:
>> On Tue, Mar 29, 2016 at 10:02 AM, Will Deacon <will.deacon@arm.com> wrote:
>> > On Mon, Mar 28, 2016 at 02:32:11PM +0800, Yong Wu wrote:
>> >> @@ -213,13 +215,16 @@ static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
>> >>               /*
>> >>                * Higher-order allocations are a convenience rather
>> >>                * than a necessity, hence using __GFP_NORETRY until
>> >> -              * falling back to single-page allocations.
>> >> +              * falling back to min size allocations.
>> >>                */
>> >> -             for (order = min_t(unsigned int, order, __fls(count));
>> >> -                  order > 0; order--) {
>> >> -                     page = alloc_pages(gfp | __GFP_NORETRY, order);
>> >> +             for (order = min_t(int, order, __fls(count));
>> >> +                  order >= min_order; order--) {
>> >> +                     page = alloc_pages((order == min_order) ? gfp :
>> >> +                                        gfp | __GFP_NORETRY, order);
>> >>                       if (!page)
>> >>                               continue;
>> >> +                     if (!order)
>> >> +                             break;
>> >
>> > Isn't this handled by the loop condition?
>>
>> He changed the loop condition to be ">= min_order" instead of "> 0",
>> so now we can get here with an order == 0.  This makes sense because
>> when min_order is not 0 you still want to run the code to split the
>> pages and it is sane not to duplicate that below.
>>
>> Maybe I'm misunderstanding, though.  Perhaps you can explain how you
>> think this code should look?
>
> My reading of the code was that we require order >= min_order to enter
> the loop. Given that order doesn't change between the loop header and the
> if (!order) check, then that must mean we can enter the loop body with
> order == 0 and order >= min_order, which means that min_order is allowed
> to be negative. That feels weird.
>
> Am I barking up the wrong tree?

I don't think min_order can be negative.  Certainly we could enter the
loop with order == 0 and min_order == 0, though.


Some examples:

order = 0, min_order = 0
-> Want alloc_pages _without_ __GFP_NORETRY.  OK
-> If alloc_pages fails, return NULL.  OK
-> If alloc pages succeeds, don't need splitting since single page.  OK

order = 1, min_order = 1
-> Want alloc_pages _without_ __GFP_NORETRY.  OK
-> If alloc_pages fails, return NULL.  OK
-> If alloc pages succeeds, DO need splitting.  OK

order = 1, min_order = 0
-> Want alloc_pages with __GFP_NORETRY.  OK
-> If alloc_pages fails, try order = 0.  OK
-> If alloc pages succeeds, DO need splitting.  OK

order = 2, min_order = 1
-> Want alloc_pages with __GFP_NORETRY.  OK
-> If alloc_pages fails, try order = 1.  OK
-> If alloc pages succeeds, DO need splitting.  OK


I think those are all right.  Did I mess up?  You could certainly
structure the loop in a different way but you need to make sure you
handle all of those cases.  If you have an alternate structure that
handles all those, let's consider it.

-Doug
