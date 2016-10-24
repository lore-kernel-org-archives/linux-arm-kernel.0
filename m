From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 24 Oct 2016 12:37:56 +0100
Subject: [PATCH] Documentation: DMA-API: Clarify semantics of
 dma_set_mask_and_coherent
In-Reply-To: <20161024110819.GO3541@8bytes.org> (Joerg Roedel's message of
 "Mon, 24 Oct 2016 13:08:19 +0200")
References: <20161017152623.7649-1-punit.agrawal@arm.com>
 <20161021150916.0d274e9f@lwn.net> <20161024110819.GO3541@8bytes.org>
Message-ID: <87k2cy6kq3.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joerg Roedel <joro@8bytes.org> writes:

> On Fri, Oct 21, 2016 at 03:09:16PM -0600, Jonathan Corbet wrote:
>> On Mon, 17 Oct 2016 16:26:23 +0100
>> Punit Agrawal <punit.agrawal@arm.com> wrote:
>> 
>> > The dma mapping api howto gives the impression that using the
>> > dma_set_mask_and_coherent (and related DMA APIs) will cause the kernel
>> > to check all the components in the path from the device to memory for
>> > addressing restrictions. In systems with address translations between
>> > the device and memory (e.g., when using IOMMU), this implies that a
>> > successful call to set set dma mask has checked the addressing
>> > constraints of the intermediaries as well.
>
> This is basically true when you have DMA controllers in the path from
> device to memory. But it is not true for IOMMUs, because IOMMU drivers
> are consumers of the dma-masks, they don't really restrict them. An
> IOMMU driver knows the limitations of IOMMU hardware and counts that in
> when allocating an address for a dma-buffer.

Yes, that's what I'd found looking at the IOMMU drivers in the tree.

>
> So long story short: Any IOMMU restrictions in address space size don't
> need to be represented in the dma-mask for a device.

That was another rabbit hole I'd spend some time in - whether IOMMU
restrictions need to be factored into the dma_mask for devices.

As size(dma_mask) > size(iommu supported address size) still works, I
came to the conclusion that the documentation can maybe help clarify
this.

This patch is an attempt to update the documentation to inform the user
that even if the dma_set_mask call succeeds, the system may still not
use the entire device address space.

Thanks for clarifying a few of my doubts.

Punit

>
>
>
> 	Joerg
