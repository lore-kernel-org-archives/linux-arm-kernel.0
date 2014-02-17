From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 17 Feb 2014 14:24:59 +0530
Subject: [Patch v5 1/2] dmaengine: add Qualcomm BAM dma driver
In-Reply-To: <20140211205852.GA10744@qualcomm.com>
References: <1391546556-27702-1-git-send-email-agross@codeaurora.org>
 <1391546556-27702-2-git-send-email-agross@codeaurora.org>
 <20140211173048.GP10628@intel.com>
 <20140211205852.GA10744@qualcomm.com>
Message-ID: <20140217085458.GB10628@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 02:58:52PM -0600, Andy Gross wrote:
> On Tue, Feb 11, 2014 at 11:00:48PM +0530, Vinod Koul wrote:
> > On Tue, Feb 04, 2014 at 02:42:35PM -0600, Andy Gross wrote:
> > > Add the DMA engine driver for the QCOM Bus Access Manager (BAM) DMA controller
> > > found in the MSM 8x74 platforms.
> > > 
> 
> > > +/**
> > > + * bam_alloc_chan - Allocate channel resources for DMA channel.
> > > + * @chan: specified channel
> > > + *
> > > + * This function allocates the FIFO descriptor memory
> > > + */
> > > +static int bam_alloc_chan(struct dma_chan *chan)
> > > +{
> > > +	struct bam_chan *bchan = to_bam_chan(chan);
> > > +	struct bam_device *bdev = bchan->bdev;
> > > +
> > > +	/* allocate FIFO descriptor space, but only if necessary */
> > > +	if (!bchan->fifo_virt) {
> > > +		bchan->fifo_virt = dma_alloc_writecombine(bdev->dev,
> > > +					BAM_DESC_FIFO_SIZE, &bchan->fifo_phys,
> > > +					GFP_KERNEL);
> > > +
> > > +		if (!bchan->fifo_virt) {
> > > +			dev_err(bdev->dev, "Failed to allocate desc fifo\n");
> > > +			return -ENOMEM;
> > > +		}
> > > +	}
> > > +
> > > +	return BAM_DESC_FIFO_SIZE;
> > But you cna have SW descriptors more than HW ones and issue new ones once HW is
> > done with them. Why tie the limit to what HW supports and not create a better
> > driver?
> 
> Given that the virt-dma only allows me to have one outstanding transaction that
> consumes the fifo, and that I allocate descriptors from kzalloc, this would be
> as many as you can get until you go OOM.
well you can update virt-dma to queue up multiple descriptors to HW is thats
supported :)
> 
> The slave_sg() doesn't pull from a pool of descriptors.  It uses kzalloc.  So
> what value should I use for return value?  Most drivers use 1.
Lots do 0 as they dont allocate descriptor here, they allocate when the
.prep_xxx call gets invoked, which is what I suspect from you case too.

> 
> [....]
> 
> > > +static void bam_slave_config(struct bam_chan *bchan,
> > > +		struct dma_slave_config *cfg)
> > > +{
> > > +	struct bam_device *bdev = bchan->bdev;
> > > +	u32 maxburst;
> > > +
> > > +	if (bchan->slave.direction == DMA_DEV_TO_MEM)
> > > +		maxburst = bchan->slave.src_maxburst = cfg->src_maxburst;
> > > +	else
> > > +		maxburst = bchan->slave.dst_maxburst = cfg->dst_maxburst;
> > can you remove usage of slave.direction have save both. I am going to remove
> > this member...
> > 
> 
> Yes. no problem.
> 
> [....]
> 
> > > +
> > > +
> > > +	/* allocate enough room to accomodate the number of entries */
> > > +	async_desc = kzalloc(sizeof(*async_desc) +
> > > +			(sg_len * sizeof(struct bam_desc_hw)), GFP_NOWAIT);
> > this seems to assume that each sg entry length will not exceed the HW capablity.
> > Does engine support any length descriptor, if not you may want to split to
> > multiple.
> 
> Isn't this what the dma_set_max_seg_size supposed to fix?  The client is not
> supposed to send segments larger than the max segment you can take.  If that is
> true, then I have no issues.
Thats is true too, but do we want to limit this in driver ? This is more of a SW
limitation of who breaks up. for some like audio it makese sense but other not
too sure...

-- 
~Vinod
