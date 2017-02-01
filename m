From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 1 Feb 2017 16:38:14 +0000
Subject: [PATCH 2/2] arm64/dma-mapping: validate dma_masks against IORT
 defined limits
In-Reply-To: <CAK8P3a34oCsp8WAnf5EJVT5ioYVmR9aZx0nhEmmT0Sof7QRdaw@mail.gmail.com>
References: <1485893763-20671-1-git-send-email-nwatters@codeaurora.org>
 <1485893763-20671-2-git-send-email-nwatters@codeaurora.org>
 <115903ce-6c1d-faa9-cbe4-e67a3d41f5c9@arm.com>
 <20170201143617.GB20423@red-moon>
 <f8eb99ca-bb5d-105e-19ac-73e7d4e75ec6@arm.com>
 <CAK8P3a34oCsp8WAnf5EJVT5ioYVmR9aZx0nhEmmT0Sof7QRdaw@mail.gmail.com>
Message-ID: <c770d972-7488-a549-85e0-53c267825fd7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/17 15:34, Arnd Bergmann wrote:
> On Wed, Feb 1, 2017 at 4:27 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> 
>>
>> Essentially, all that needs to be done is to ensure that the initial
>> masks set by acpi_dma_configure() truly reflect the maximum hardware
>> capability; everything else will then just fall out of that. The
>> aforementioned thing on the DT side is that of_dma_configure() currently
>> has a bug which prevents masks larger than 32 bits actually being
>> assigned from "dma-ranges" - I need to split out a proper patch from the
>> "git commit -am 'hacks'" that I have on this local branch :)
> 
> Do you mean you want to change the initial DMA mask to the maximum allowed
> mask? I don't think we can do that, as that would break all devices that support
> only 32-bit DMA but happen to sit on a bus that has 64-bit DMA support.

That doesn't break anything provided that the drivers of said 32-bit
devices are calling dma_set_mask_and_coherent(DMA_BIT_MASK(32)) as they
should be. e.g on Juno, we (now) have a top-level "dma-ranges"
describing the 40-bit interconnect, so (given the aforementioned fix)
of_dma_configure() sets initial masks to 40-bit, then the drivers of the
32-bit-only IP blocks (USB, PL330, HDLCD, etc.) reduce their masks to
suit and everything works fine.

Basically, as long as drivers correctly call dma_set_mask*() with the
upper bound of what that device is inherently capable of driving, and
the DT has "dma-ranges" present to describe any configuration where
fewer bits than that are actually wired up (e.g. the Renesas PCIe and
APM SMMU cases), everything's fine. If a 32-bit device on a
correctly-described 64-bit bus were to break (presumably by inheriting a
too-big mask), that's simply uncovering a driver bug, which would
already have been broken until 9a6d7298b083 introduced the erroneous
32-bit clamp.

Robin.

> 
>     Arnd
> 
