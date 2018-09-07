From: tfiga@chromium.org (Tomasz Figa)
Date: Fri, 7 Sep 2018 17:54:22 +0900
Subject: [RFC 3/3] stk1160: Use non-coherent buffers for USB transfers
In-Reply-To: <20180830175937.GB11521@infradead.org>
References: <20180830172030.23344-1-ezequiel@collabora.com>
 <20180830172030.23344-4-ezequiel@collabora.com>
 <20180830175937.GB11521@infradead.org>
Message-ID: <CAAFQd5D=tETh0638gR0TP=_FZXzMcy=6EjOLW8n1SRPqR=sCrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 2:59 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +     dma_sync_single_for_cpu(&urb->dev->dev, urb->transfer_dma,
> > +             urb->transfer_buffer_length, DMA_FROM_DEVICE);
>
> You can't ue dma_sync_single_for_cpu on non-coherent dma buffers,
> which is one of the major issues with them.

It's not an issue of DMA API, but just an API mismatch. By design,
memory allocated for device (e.g. by DMA API) doesn't have to be
physically contiguous, while dma_*_single() API expects a _single_,
physically contiguous region of memory.

We need a way to allocate non-coherent memory using DMA API to handle
(on USB example, but applies to virtually any class of devices doing
DMA):
 - DMA address range limitations (e.g. dma_mask) - while a USB HCD
driver is normally aware of those, USB device driver should have no
idea,
 - memory mapping capability === whether contiguous memory or a set of
random pages can be allocated - this is a platform integration detail,
which even a USB HCD driver may not be aware of, if a SoC IOMMU is
just stuffed between the bus and HCD,
 - platform coherency specifics - there are practical scenarios when
on a coherent-by-default system it's more efficient to allocate
non-coherent memory and manage caches explicitly to avoid the costs of
cache snooping.

If DMA_ATTR_NON_CONSISTENT is not the right way to do it, there should
be definitely a new API introduced, coupled closely to DMA API
implementation on given platform, since it's the only place which can
solve all the constraints above.

Best regards,
Tomasz
