From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Jun 2011 17:20:15 +0200
Subject: [Linaro-mm-sig] [PATCH/RFC 0/8] ARM: DMA-mapping
	=?iso-8859-1?q?framework=09redesign?=
In-Reply-To: <4E02119F.4000901@codeaurora.org>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<002701cc30be$ab296cc0$017c4640$%szyprowski@samsung.com>
	<4E02119F.4000901@codeaurora.org>
Message-ID: <201106241720.15385.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 June 2011, Jordan Crouse wrote:
> >> I have a query in similar lines, but related to user virtual address
> >> space. Is it feasible to extend these DMA interfaces(and IOMMU), to map
> >> a user allocated buffer into the hardware?
> >
> > This can be done with the current API, although it may not look so
> > straightforward. You just need to create a scatter list of user pages
> > (these can be gathered with get_user_pages function) and use dma_map_sg()
> > function. If the dma-mapping support iommu, it can map all these pages
> > into a single contiguous buffer on device (DMA) address space.
> >
> > Some additional 'magic' might be required to get access to pages that are
> > mapped with pure PFN (VM_PFNMAP flag), but imho it still can be done.
> >
> > I will try to implement this feature in videobuf2-dma-config allocator
> > together with the next version of my patches for dma-mapping&iommu.
> 
> With luck DMA_ATTRIB_NO_KERNEL_MAPPING should remove any lingering arguments
> for trying to map user pages. Given that our ultimate goal here is buffer
> sharing, user allocated pages have limited value and appeal. If anything, I
> vote that this be a far lower priority compared to the rest of the win you
> have here.

I agree. Mapping user-allocated buffers is extremely hard to get right
when there are extra constraints. If it doesn't work already for some driver,
I wouldn't put too much effort into making it work for more special cases.

	Arnd
