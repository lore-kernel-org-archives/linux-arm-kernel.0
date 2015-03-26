From: ritesh.list@gmail.com (Ritesh Harjani)
Date: Thu, 26 Mar 2015 10:01:46 +0530
Subject: [PATCH v2] ARM: mm: Do not invoke OOM for higher order IOMMU DMA
 allocations
In-Reply-To: <alpine.DEB.2.10.1503251731350.32157@chino.kir.corp.google.com>
References: <1427095620-20994-1-git-send-email-tfiga@chromium.org>
 <CALk7dXoacMbHKbJZ2UHd0YK9B8rZgATwNpif8cONjGkZj0YTHA@mail.gmail.com>
 <alpine.DEB.2.10.1503251731350.32157@chino.kir.corp.google.com>
Message-ID: <CALk7dXqnax7YeRu3Xp1GwG4TUqSWBfPb6iJ+tgYrbfotMVk9XQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 6:04 AM, David Rientjes <rientjes@google.com> wrote:
> On Thu, 26 Mar 2015, Ritesh Harjani wrote:
>
>> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> > index 83cd5ac..3f1ac51 100644
>> > --- a/arch/arm/mm/dma-mapping.c
>> > +++ b/arch/arm/mm/dma-mapping.c
>> > @@ -1150,13 +1150,28 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
>> >         gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
>> >
>> >         while (count) {
>> > -               int j, order = __fls(count);
>> > +               int j, order;
>> > +
>> > +               for (order = __fls(count); order > 0; --order) {
>> > +                       /*
>> > +                        * We do not want OOM killer to be invoked as long
>> > +                        * as we can fall back to single pages, so we force
>> > +                        * __GFP_NORETRY for orders higher than zero.
>> > +                        */
>> > +                       pages[i] = alloc_pages(gfp | __GFP_NORETRY, order);
>> > +                       if (pages[i])
>> > +                               break;
>> > +               }
>> >
>> > -               pages[i] = alloc_pages(gfp, order);
>> > -               while (!pages[i] && order)
>> > -                       pages[i] = alloc_pages(gfp, --order);
>> > -               if (!pages[i])
>> > -                       goto error;
>> > +               if (!pages[i]) {
>> > +                       /*
>> > +                        * Fall back to single page allocation.
>> > +                        * Might invoke OOM killer as last resort.
>> > +                        */
>> > +                       pages[i] = alloc_pages(gfp, 0);
>> I think down the code in this while loop, i & count is being
>> calculated based on the "order" of allocation in the current
>> iteration.
>> Since value of order will be automatically 0 here if (!pages[i]) is
>> true then, why hard code order to value of 0 here.
>> Comment clearly says what this code is doing right?
>>
>
> Gcc is smart enough to know that order == 0 here, the code generation on
> arm will be the same, so this is only a matter of how the source looks.

Agreed.
> To me, it doesn't make a lot of sense to write it as alloc_pages(gfp,
> order) when order is always equal to 0.  I think it's clearer the way that
> Tomasz wrote it.

Ok
>
>> I know it is just a minor thing. Don't know if it is relevant.
>>
>> > +                       if (!pages[i])
>> > +                               goto error;
>> > +               }
>> >
>> >                 if (order) {
>> >                         split_page(pages[i], order);

Thanks
Ritesh
