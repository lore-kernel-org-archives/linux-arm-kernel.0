From: rob@ti.com (Clark, Rob)
Date: Fri, 27 Jan 2012 08:27:33 -0600
Subject: [Linaro-mm-sig] [PATCH 12/15] drivers: add Contiguous Memory
 Allocator
In-Reply-To: <00de01ccdce1$e7c8a360$b759ea20$%szyprowski@samsung.com>
References: <1327568457-27734-1-git-send-email-m.szyprowski@samsung.com>
 <1327568457-27734-13-git-send-email-m.szyprowski@samsung.com>
 <CADMYwHw1B4RNV_9BqAg_M70da=g69Z3kyo5Cr6izCMwJ9LAtvA@mail.gmail.com>
 <00de01ccdce1$e7c8a360$b759ea20$%szyprowski@samsung.com>
Message-ID: <CAO8GWqnQg-W=TEc+CUc8hs=GrdCa9XCCWcedQx34cqURhNwNwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/1/27 Marek Szyprowski <m.szyprowski@samsung.com>:
> Hi Ohad,
>
> On Friday, January 27, 2012 10:44 AM Ohad Ben-Cohen wrote:
>
>> With v19, I can't seem to allocate big regions anymore (e.g. 101MiB).
>> In particular, this seems to fail:
>>
>> On Thu, Jan 26, 2012 at 11:00 AM, Marek Szyprowski
>> <m.szyprowski@samsung.com> wrote:
>> > +static int cma_activate_area(unsigned long base_pfn, unsigned long count)
>> > +{
>> > + ? ? ? unsigned long pfn = base_pfn;
>> > + ? ? ? unsigned i = count >> pageblock_order;
>> > + ? ? ? struct zone *zone;
>> > +
>> > + ? ? ? WARN_ON_ONCE(!pfn_valid(pfn));
>> > + ? ? ? zone = page_zone(pfn_to_page(pfn));
>> > +
>> > + ? ? ? do {
>> > + ? ? ? ? ? ? ? unsigned j;
>> > + ? ? ? ? ? ? ? base_pfn = pfn;
>> > + ? ? ? ? ? ? ? for (j = pageblock_nr_pages; j; --j, pfn++) {
>> > + ? ? ? ? ? ? ? ? ? ? ? WARN_ON_ONCE(!pfn_valid(pfn));
>> > + ? ? ? ? ? ? ? ? ? ? ? if (page_zone(pfn_to_page(pfn)) != zone)
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? return -EINVAL;
>>
>> The above WARN_ON_ONCE is triggered, and then the conditional is
>> asserted (page_zone() retuns a "Movable" zone, whereas zone is
>> "Normal") and the function fails.
>>
>> This happens to me on OMAP4 with your 3.3-rc1-cma-v19 branch (and a
>> bunch of remoteproc/rpmsg patches).
>>
>> Do big allocations work for you ?
>
> I've tested it with 256MiB on Exynos4 platform. Could you check if the
> problem also appears on 3.2-cma-v19 branch (I've uploaded it a few hours
> ago) and 3.2-cma-v18? Both are available on our public repo:
> git://git.infradead.org/users/kmpark/linux-samsung/
>
> The above code has not been changed since v16, so I'm really surprised
> that it causes problems. Maybe the memory configuration or layout has
> been changed in 3.3-rc1 for OMAP4?

is highmem still an issue?  I remember hitting this WARN_ON_ONCE() but
went away after I switched to a 2g/2g vm split (which avoids highmem)

BR,
-R

> Best regards
> --
> Marek Szyprowski
> Samsung Poland R&D Center
>
>
>
>
> _______________________________________________
> Linaro-mm-sig mailing list
> Linaro-mm-sig at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-mm-sig
