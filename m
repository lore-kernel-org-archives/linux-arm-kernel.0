From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Apr 2014 14:20:45 +0100
Subject: arm64: default dma_ops is set to coherent_dma_ops results into
 DMA FAILURE
In-Reply-To: <CALk7dXpKGdYd7K4M68KbBgv9a7oHWhPPLER297xFgkYnEiv8Ug@mail.gmail.com>
References: <CALk7dXpKGdYd7K4M68KbBgv9a7oHWhPPLER297xFgkYnEiv8Ug@mail.gmail.com>
Message-ID: <20140422132045.GB9820@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 01:48:12PM +0100, Ritesh Harjani wrote:
> Hi Catalin/Will,

Hi Ritesh,

> This is regarding the default dma_ops that we populate for arm64.
> 
> PROBLEM:
> Currently in arch/arm64/mm/dma-mapping.c we set dma_ops =
> &coherent_swiotlb_dma_ops.
> 
> The problem with this is, lets say that there is a dma device which
> has not populated its dev->archdata.dma_ops, then this dma device will
> get the coherent dma_ops in which we dont do any cache maintainance.
> 
> So, if the dma driver do kmalloc, make some changes to the buffer and
> after dma_map_single gives it to the dma for the transfer, due to no
> cache maintenance performed, result will be DMA transfer failed.
> 
> 
> 
> Earlier noncoherent ops code was not present at all for arm64, so may
> be we were setting default ops to coherent ops. But now that we have
> noncoherent ops in place shall we make the default dma_ops to
> noncoherent (as what arm also does) ?

The problem with changing the default assumption to non-coherent is that
existing coherent platforms that rely on the coherent DMA ops being selected
without any additional DT properties (e.g. dma-coherent) will break with
this change.

This puts us into a nasty situation where we have the opposite policy from
arch/arm/ regarding default DMA ops, rendering device-trees potentially
incompatible between the two architectures.

I'd be inclined to align the two, but it will break any users relying on the
current behaviour (I believe this includes Applied with their X-gene SoC).

Will
