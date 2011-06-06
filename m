From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Mon, 6 Jun 2011 19:12:20 +0900
Subject: [PATCH v2 1/3] dmaengine: add new dma API for max_segment_number
In-Reply-To: <20110606094751.GC10508@n2100.arm.linux.org.uk>
References: <20110606091410.GB10508@n2100.arm.linux.org.uk>
	<20110606183925D.fujita.tomonori@lab.ntt.co.jp>
	<20110606094751.GC10508@n2100.arm.linux.org.uk>
Message-ID: <20110606191041U.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Jun 2011 10:47:51 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Mon, Jun 06, 2011 at 06:41:09PM +0900, FUJITA Tomonori wrote:
> > On Mon, 6 Jun 2011 10:14:10 +0100
> > Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > 
> > > On Mon, Jun 06, 2011 at 05:06:03PM +0900, FUJITA Tomonori wrote:
> > > > max_segs isn't unrelated with the dma mapping API. I explained above,
> > > > IOMMUs doesn't increase the number of segments (could decrease the
> > > > number of segments by merging).
> > > > 
> > > > The limitation about the number of segment already lives elsewhere
> > > > (e.g. queue's limits.max_segments).
> > > 
> > > I think you're missing the point entirely.
> > > 
> > > Lets take the problem at hand: you have two devices.  One of them is
> > > handled by the DMA engine code.  One of them is a block device.
> > > 
> > > The block layer needs to know the various parameters of what is
> > > allowable for DMA, including such things as the maximum size of a
> > > segment, and the _number_ of segments that can be placed into any
> > > one request.
> > > 
> > > As the DMA provider is _entirely_ separate and unknown to the block
> > > device driver, the block device driver has no way to sanely provide
> > > these parameters to the block layer - they are not a property of the
> > > block device driver, but of the DMA provider.
> > 
> > struct device_dma_parameters is used for a property of the block
> > device drivers (and scsi HBA drivers, etc). Not DMA provider. Right?
> 
> Wrong.  struct device_dma_parameters is a property of the _DMA_ _provider_.
> It has to be.  Read what I said above and think about it.

I think that it's up to your definition of DMA provider.

> In many cases, it so happens that the DMA provider and the block device
> driver are the same entity, and so it may appear that device_dma_parameters

But could be the different entities, right? If so, the value should be
smaller one? Who is responsible for setting the correct value? The
proposed API blindly set the value (just overwrite). The API would be
better to set a new value only when the new value is smaller? Or
having a separate structure and selecting the smallest value?

struct device_dma_parameters assumes that the DMA provider and the
block (and SCSI, etc) device driver are the same entity.

> is a property of the block device driver.  As soon as you have to start
> dealing with DMA providers being separate from the block device driver
> then your eyes will be opened and you'll see that it can't work the way
> you seem to want it to.
> 
> The DMA parameters have to come from the DMA provider or they're a total
> nonsense.

I don't think that I claim that the DMA parameters don't come from the
DMA provider. It depends on the definition of the DMA provider,
though.
