From: cyndis@kapsi.fi (Mikko Perttunen)
Date: Thu, 20 Apr 2017 13:14:04 +0300
Subject: [PATCH] [RFC] gpu: host1x: shut up warning about DMA API misuse
In-Reply-To: <CAK8P3a1Xs5XjQ+cPPUEtBE7kC6hs_6ZKKs1kHd608kaO70f6Fg@mail.gmail.com>
References: <20170419182413.866327-1-arnd@arndb.de>
 <8df7c5a9-c71c-4ee9-9bc2-9c861cf9796c@kapsi.fi>
 <CAK8P3a3JJrA_4Zur47ngWmR7VeKBopJLNZCaqOPzzmnFoV3=Ew@mail.gmail.com>
 <46945c47-2e4e-270d-b551-b207c538e5cb@kapsi.fi>
 <CAK8P3a1Xs5XjQ+cPPUEtBE7kC6hs_6ZKKs1kHd608kaO70f6Fg@mail.gmail.com>
Message-ID: <7cbf20e2-6a81-d555-a635-0db0274d19ff@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.04.2017 13:02, Arnd Bergmann wrote:
> On Thu, Apr 20, 2017 at 11:44 AM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
>> On 20.04.2017 11:25, Arnd Bergmann wrote:
>>> On Thu, Apr 20, 2017 at 9:02 AM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
>>>> On 19.04.2017 21:24, Arnd Bergmann wrote:
>>>
>>> I don't think this can be a per-platform policy.
>>
>>
>> Yeah, now that we are using the ARM SMMU on T186 onwards it's more difficult
>> than when we were using the Tegra SMMU, so we'll probably have to change
>> that.
>>
>> The goal of the current code is to allocate memory from the CMA, so one
>> option would be to change it to use dma_alloc_from_contiguous. That way we
>> wouldn't get the double IOMMU mapping, which would be nice.
>
> Right, also we shouldn't define what a particular API does based on
> which platform you run on.

Indeed.

>
>> The goal of the current code is to allocate memory from the CMA, so one
>> option would be to change it to use dma_alloc_from_contiguous. That way
>> we wouldn't get the double IOMMU mapping, which would be nice.
>
> dma_alloc_from_contiguous() is intentionally not exported to drivers,
> and it would result in a page that is not mapped into your kernel
> address space.

Ah, sorry, didn't notice that while looking.

>
> This is probably not the only driver that has this issue, so maybe a
> better approach would be to fill the API gap and introduce an IOMMU
> API function that takes a domain/iova/length tuple as its argument
> and allocates coherent or WC memory that it maps into that address?

There is definitely space for some API improvement in the whole IOMMU 
domain memory allocation space. I would prefer keeping the IOMMU mapping 
and memory allocation separate, though, since otherwise we couldn't map 
the same physical memory into multiple domains (or have some memory that 
is temporarily not mapped into any.)

The issue seems to be non-trivial, so I'm fine with your RFC patch - it 
solves the issue and the double domain mapping thing is not a problem 
currently as we don't yet support IOMMU on T186. By the time we do 
support it I hope we'll have the new API or whatever replacement in place.

>
>       Arnd
>

Thanks,
Mikko
