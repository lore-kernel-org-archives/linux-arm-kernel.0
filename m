From: tfiga@chromium.org (Tomasz Figa)
Date: Fri, 31 Aug 2018 15:51:54 +0900
Subject: [RFC 2/3] USB: core: Add non-coherent buffer allocation helpers
In-Reply-To: <20180831055047.GA9140@infradead.org>
References: <20180830172030.23344-1-ezequiel@collabora.com>
 <20180830172030.23344-3-ezequiel@collabora.com>
 <20180830175850.GA11521@infradead.org>
 <4fc5107f93871599ead017af7ad50f22535a7683.camel@collabora.com>
 <20180831055047.GA9140@infradead.org>
Message-ID: <CAAFQd5DhFr8ywjc41oK9q+zZXH9zsOKh_7DxWmjzcE0+5Q3hGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 2:50 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Aug 30, 2018 at 07:11:35PM -0300, Ezequiel Garcia wrote:
> > On Thu, 2018-08-30 at 10:58 -0700, Christoph Hellwig wrote:
> > > Please don't introduce new DMA_ATTR_NON_CONSISTENT users, it is
> > > a rather horrible interface, and I plan to kill it off rather sooner
> > > than later.  I plan to post some patches for a better interface
> > > that can reuse the normal dma_sync_single_* interfaces for ownership
> > > transfers.  I can happily include usb in that initial patch set based
> > > on your work here if that helps.
> >
> > Please do. Until we have proper allocators that go thru the DMA API,
> > drivers will have to kmalloc the USB transfer buffers, and have
> > streaming mappings. Which in turns mean not using IOMMU or CMA.
>
> dma_map_page will of course use the iommu.

Sure, dma_map*() will, but using kmalloc() defeats (half of) the
purpose of it, since contiguous memory would be allocated
unnecessarily, risking failures due to fragmentation.

Best regards,
Tomasz
