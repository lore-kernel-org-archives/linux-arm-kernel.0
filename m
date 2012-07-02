From: bob.beckett@gmail.com (Robert Beckett)
Date: Mon, 2 Jul 2012 14:48:13 +0100
Subject: arm_vmregion_alloc call
In-Reply-To: <CAOmFF13Cif=K62oHR3QEg-ni0X0EopxtOXM7LGkF9FJd2WCZKg@mail.gmail.com>
References: <CAOmFF13Cif=K62oHR3QEg-ni0X0EopxtOXM7LGkF9FJd2WCZKg@mail.gmail.com>
Message-ID: <CAOmFF133BYMg3kLrM=D4R1Q=fxU-8qe6SMdFErwwQ3DWF33cxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

I just debugged a problem with a USB driver where it was calling
dma_alloc_coherent with a GFP_DMA32 flag.
It turned out that in __dma_alloc_remap, it clears the GFP_DMA and
GFP_HIGHMEM flags when calling arm_vmregion_alloc so that it does not clash
with the slab allocator flag requirements, but it does not clear GFP_DMA32.
The GFP_SLAB_BUG_MASK includes GFP_DMA32, so this looks like a bug to me.
Should it be clearing GFP_DMA32 as well as GFP_DMA and GFP_HIGHMEM ?

I checked in the latest kernel.org code, and the issue is still there.

Is this a bug, or should it just be calling with GFP_DMA instead of
GFP_DMA32?

For now, I am working around it by using GFP_DMA in the dma_alloc_coherent
call as we have no GFP_DMA lower limit, so GFP_DMA and GFP_DMA32 are the
same on my architecture.

Any advice appreciated,

Thanks

Bob
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120702/2b683745/attachment-0001.html>
