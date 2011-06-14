From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 14 Jun 2011 09:46:11 +0200
Subject: [RFC 0/2] ARM: DMA-mapping & IOMMU integration
In-Reply-To: <BANLkTikR5AE=-wTWzrSJ0TUaks0_rA3mcg@mail.gmail.com>
References: <1306308920-8602-1-git-send-email-m.szyprowski@samsung.com>
	<BANLkTi=HtrFETnjk1Zu0v9wqa==r0OALvA@mail.gmail.com>
	<201106131707.49217.arnd@arndb.de>
	<BANLkTikR5AE=-wTWzrSJ0TUaks0_rA3mcg@mail.gmail.com>
Message-ID: <000001cc2a67$216e3310$644a9930$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, June 13, 2011 5:31 PM KyongHo Cho wrote:

> On Tue, Jun 14, 2011 at 12:07 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > I'm sure that the graphics people will disagree with you on that.
> > Having the frame buffer mapped in write-combine mode is rather
> > important when you want to efficiently output videos from your
> > CPU.
> >
> I agree with you.
> But I am discussing about dma_alloc_writecombine() in ARM.
> You can see that only ARM and AVR32 implement it and there are few
> drivers which use it.
> No function in dma_map_ops corresponds to dma_alloc_writecombine().
> That's why Marek tried to add 'alloc_writecombine' to dma_map_ops.

I also introduced dma_alloc_attrs() to allow other types of 
memory&mappings combinations in the future. For example in case of
IOMMU the driver might like to call a function that will allocate 
a buffer that will 'work best with hardware'. This means that the
buffer might be build from pages larger than 4KiB, aligned to 
particular IOMMU requirements. Handling such requirements are
definitely not a part of the driver, only particular implementation
of dma-mapping will know them. The driver may just provide a some
hints how the memory will be used. The one that I'm particularly
thinking of are different types of caching.

> > I can understand that there are arguments why mapping a DMA buffer into
> > user space doesn't belong into dma_map_ops, but I don't see how the
> > presence of an IOMMU is one of them.
> >
> > The entire purpose of dma_map_ops is to hide from the user whether
> > you have an IOMMU or not, so that would be the main argument for
> > putting it in there, not against doing so.
>
> I also understand the reasons why dma_map_ops maps a buffer into user space.
> Mapping in device and user space at the same time or in a simple
> approach may look good.
> But I think mapping to user must be and driver-specific.
> Moreover, kernel already provides various ways to map physical memory
> to user space.
> And I think that remapping DMA address that is in device address space
> to user space is not a good idea
> because DMA address is not same to physical address semantically if
> features of IOMMU are implemented.

Mapping DMA address to user-space is one of the common feature of various
APIs (framebuffer, v4l2, alsa). In most cases the kernel virtual address 
in not even required for such drivers, because they just want to expose 
the buffer content to userspace. It would be great if dma-mapping will allow
allocating a coherent buffer without the need of mapping it to kernel space
at all. Kernel virtual space is really limited. For some multimedia
processing (like capturing & encoding HD movie from camera sensor) we
might need buffers of total size over 128MB or even more).

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
