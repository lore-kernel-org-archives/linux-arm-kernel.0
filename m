From: daniel.vetter@ffwll.ch (Daniel Vetter)
Date: Tue, 16 Oct 2012 11:30:14 +0200
Subject: [Linaro-mm-sig] [RFC 0/2] DMA-mapping & IOMMU - physically
 contiguous allocations
In-Reply-To: <1350309832-18461-1-git-send-email-m.szyprowski@samsung.com>
References: <1350309832-18461-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAKMK7uEuwYG8F=OL6rOrYWWjdmDhA2UZSFTYO7xETi=4DJigLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2012 at 4:03 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Some devices, which have IOMMU, for some use cases might require to
> allocate a buffers for DMA which is contiguous in physical memory. Such
> use cases appears for example in DRM subsystem when one wants to improve
> performance or use secure buffer protection.
>
> I would like to ask if adding a new attribute, as proposed in this RFC
> is a good idea? I feel that it might be an attribute just for a single
> driver, but I would like to know your opinion. Should we look for other
> solution?

One thing to consider is that up to know all allocation constraints
have been stored somewhere in struct device, either in the dma
attributes (for the more generic stuff) or somewhere in platform
specific data (e.g. for special cma pools). The design of dma_buf
relies on this: The exporter/buffer allocator only sees all the struct
device *devs that want to take part in sharing a given buffer. With
this proposal some of these allocation constraints get moved to alloc
time and aren't visible in the struct device any more. Now I that
dma_buf isn't really there yet and no one has yet implemented a
generic exporter that would allocate the dma_buf at the right spot for
all cases, but I think we should consider this to not draw ourselves
into an ugly api corner.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
