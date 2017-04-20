From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Apr 2017 12:02:42 +0200
Subject: [PATCH] [RFC] gpu: host1x: shut up warning about DMA API misuse
In-Reply-To: <46945c47-2e4e-270d-b551-b207c538e5cb@kapsi.fi>
References: <20170419182413.866327-1-arnd@arndb.de>
 <8df7c5a9-c71c-4ee9-9bc2-9c861cf9796c@kapsi.fi>
 <CAK8P3a3JJrA_4Zur47ngWmR7VeKBopJLNZCaqOPzzmnFoV3=Ew@mail.gmail.com>
 <46945c47-2e4e-270d-b551-b207c538e5cb@kapsi.fi>
Message-ID: <CAK8P3a1Xs5XjQ+cPPUEtBE7kC6hs_6ZKKs1kHd608kaO70f6Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 20, 2017 at 11:44 AM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
> On 20.04.2017 11:25, Arnd Bergmann wrote:
>> On Thu, Apr 20, 2017 at 9:02 AM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
>>> On 19.04.2017 21:24, Arnd Bergmann wrote:
>>
>> I don't think this can be a per-platform policy.
>
>
> Yeah, now that we are using the ARM SMMU on T186 onwards it's more difficult
> than when we were using the Tegra SMMU, so we'll probably have to change
> that.
>
> The goal of the current code is to allocate memory from the CMA, so one
> option would be to change it to use dma_alloc_from_contiguous. That way we
> wouldn't get the double IOMMU mapping, which would be nice.

Right, also we shouldn't define what a particular API does based on
which platform you run on.

> The goal of the current code is to allocate memory from the CMA, so one
> option would be to change it to use dma_alloc_from_contiguous. That way
> we wouldn't get the double IOMMU mapping, which would be nice.

dma_alloc_from_contiguous() is intentionally not exported to drivers,
and it would result in a page that is not mapped into your kernel
address space.

This is probably not the only driver that has this issue, so maybe a
better approach would be to fill the API gap and introduce an IOMMU
API function that takes a domain/iova/length tuple as its argument
and allocates coherent or WC memory that it maps into that address?

      Arnd
