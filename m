From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Mar 2014 15:35:50 +0100
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <4757683.7Ln0Vh5c4G@wuerfel>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
 <1394463171.2270.54.camel@shinybook.infradead.org>
 <CACRpkdZrRYY0U5zDwoKRarAH=W6UmxGKX_gWR6nYPM64t6Dzpg@mail.gmail.com>
 <4757683.7Ln0Vh5c4G@wuerfel>
Message-ID: <CACRpkdZALBWJAFc5j_KpXc1iahkYNYp0B3q5v1Rj8w+MknoHzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 9:52 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 13 March 2014 09:17:04 Linus Walleij wrote:
>>
>> Again as Russell stated that doesn't necessarily influence any memory
>> coherency or the physical address pointer written into the DMAC
>> hardware at all, does it? The transfers can still happen between the
>> peripheral and DMAC, and the IOMMU can still be sitting in the middle
>> of things, in front of the DMAC not the device, needing to be flushed etc.
>>
>> Sorry if I don't get it... maybe this is one of these funny Intel things
>> I cannot wrap my head around properly.
>
> The device pointer we pass into dma_map_* can be used for anything that
> the underlying dma_map_ops implementation requires. This includes
> determining:
>
> * coherency
> * offsets between bus and cpu physical address
> * presence of IOMMU
> * limits in available bus address space (dma_mask)
> * iommu context ID (normally the location on the PCI bus)
>
> The difference is that on ARM we usually care about the first
> four, which may be different for each device. The case that Dave is
> interested in is when these four are known implicitly but the fifth
> one is not know but depends on the slave device.

Ahhh I get it. But the topological question remains I guess...

ARM buses have something like bus master IDs I think (usually
only visible to the hardware) I guess it fills a similar purpose thoug
we never really see it from the OS side.

Yours,
Linus Walleij
