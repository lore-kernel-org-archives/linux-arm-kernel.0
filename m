From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 12 Apr 2016 14:25:05 +0100
Subject: [RFC 0/1] ARM: mm: cache shareability tweak
In-Reply-To: <1460448880-5677-1-git-send-email-t-kristo@ti.com>
References: <1460448880-5677-1-git-send-email-t-kristo@ti.com>
Message-ID: <20160412132505.GG28057@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2016 at 11:14:39AM +0300, Tero Kristo wrote:
> Hi,
> 
> This RFC patch attempts to implement support for specifying cache
> shareability setting via kernel cmdline. This is required at least
> for TI keystone2 generation SoCs, where DMA masters are snooping on
> the cache maintenance messages to maintain coherency. Currently we
> are carrying an internal hack that modifies the macros via #ifdefs,
> this is obviously bad as the same kernel image can only work with
> keystone2 (or at least might be causing problems with other SoCs.)

The de-facto semantics (which we should codify) for dma-coherent with
ARMv7 is that a device makes accesses which are coherent with Normal,
Inner Shareable, Inner Write-Back, Outer Write-Back.

In arch/arm/boot/dts/keystone.dtsi I see that /soc/usb at 2680000 has a
dma-coherent flag. Is that device coherent today with upstream? Or is
that misleading currently?

If the device isn't coherent with that, then dma-coherent isn't strictly
true (and should go), and we need additional properties to correctly
describe this case.

> It would be very much preferred to replace this hardcoded
> implementation with a runtime solution.
> 
> Some obvious holes in this implementation:
> 
> 1) during execution of arch/arm/kernel/head.S, the tweaked MMU shareability
>    settings are not in place. However, I am not too sure how much that
>    matters, as I am not sure what is mapped at this point. Kernel image
>    mapping should not matter at least, as we typically should not be doing
>    any DMA transfers from the kernel image.

Strictly speaking, changing the shareability can result in a loss of
coherency, even if all accesses are made by the same CPU. See
"Mismatched memory attributes" in section A3.5.7 of the ARMv7-AR
Reference Manual (ARM DDI 0406C.c).

It's not just DMA that matters. I believe we may have page tables as
part of the kernel image, for instance, and those need to be accessed
with consistent attributes by the MMU when doing page table walks.

You can avoid issues so long as you have appropriate cache maintenance,
but that's both expensive (all memory previously mapped must be
Clean+Invalidated by VA) and painful (as you can't reliably use any of
said memory until after the maintenance).

>    I would like some comments on this, if handling during head.S
>    should be fixed also, how can this be done? Some hack under
>    compressed/keystone-head.S?

If you need to do this, you need consistent attributes from the outset,
or you need to disable the MMU, perform cache maintenance, and re-enter
the kernel.

> 2) the cmdline parameter could be something more descriptive
> 
> 3) The single RFC patch should probably be split up a bit

4) It isn't possible to use dma-coherent to describe this without
   weakening the semantics so as to be meaningless in general. So if we
   go for this approach we need a mechanism to accurately describe the
   coherency guarantees of masters in the system beyond a boolean.

Thanks,
Mark.
