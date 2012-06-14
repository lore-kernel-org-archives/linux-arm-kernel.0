From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Jun 2012 10:47:48 +0200
Subject: [Linaro-mm-sig] [PATCHv2 0/6] ARM: DMA-mapping: new extensions for
 buffer sharing
In-Reply-To: <20120613190131.GO4829@phenom.ffwll.local>
References: <1339588218-24398-1-git-send-email-m.szyprowski@samsung.com>
 <20120613141211.GJ5979@phenom.dumpdata.com>
 <20120613190131.GO4829@phenom.ffwll.local>
Message-ID: <002901cd4a0a$667e1600$337a4200$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, June 13, 2012 9:02 PM Daniel Vetter wrote:

> On Wed, Jun 13, 2012 at 10:12:12AM -0400, Konrad Rzeszutek Wilk wrote:
> > On Wed, Jun 13, 2012 at 01:50:12PM +0200, Marek Szyprowski wrote:

> (snipped)

> > > The third extension solves the performance issues which we observed with
> > > some advanced buffer sharing use cases, which require creating a dma
> > > mapping for the same memory buffer for more than one device. From the
> > > DMA-mapping perspective this requires to call one of the
> > > dma_map_{page,single,sg} function for the given memory buffer a few
> > > times, for each of the devices. Each dma_map_* call performs CPU cache
> > > synchronization, what might be a time consuming operation, especially
> > > when the buffers are large. We would like to avoid any useless and time
> > > consuming operations, so that was the main reason for introducing
> > > another attribute for DMA-mapping subsystem: DMA_ATTR_SKIP_CPU_SYNC,
> > > which lets dma-mapping core to skip CPU cache synchronization in certain
> > > cases.
> 
> Ah, here's the use-case I've missed ;-) I'm a bit vary of totally insane
> platforms that have additional caches only on the device side, and only
> for some devices. Well, tlbs belong to that, but the iommu needs to handle
> that anyway.
> 
> I think it would be good to add a blurb to the documentation that any
> device-side flushing (of tlbs or special caches or whatever) still needs
> to happen and that this is only a performance optimization to avoid the
> costly cpu cache flushing. This way the dma-buf exporter could keep track
> of whether it's 'device-coherent' and set that flag if the cpu caches don't
> need to be flushed.
> 
> Maybe also make it clear that implementing this bit is optional (like your
> doc already mentions for NO_KERNEL_MAPPING).

Ok, I can add additional comment, but support for all dma attributes is optional
(attributes are considered only as hints that might improve performance for some
use cases on some hw platforms).

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
