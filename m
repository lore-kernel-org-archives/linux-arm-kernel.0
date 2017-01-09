From: niklas.soderlund@ragnatech.se (Niklas =?iso-8859-1?Q?S=F6derlund?=)
Date: Mon, 9 Jan 2017 16:42:20 +0100
Subject: [PATCHv9 6/6] dmaengine: rcar-dmac: add iommu support for slave
 transfers
In-Reply-To: <26490346.qhNpbOL6eO@avalon>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se>
 <20160810112219.17964-7-niklas.soderlund+renesas@ragnatech.se>
 <6358234.jyTvyVnNF0@avalon> <26490346.qhNpbOL6eO@avalon>
Message-ID: <20170109154220.GH29854@bigcity.dyn.berto.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On 2017-01-02 01:08:04 +0200, Laurent Pinchart wrote:
> Hi Niklas,
> 
> On Monday 05 Sep 2016 12:52:44 Laurent Pinchart wrote:
> > On Wednesday 10 Aug 2016 13:22:19 Niklas S?derlund wrote:
> > > Enable slave transfers to a device behind a IPMMU by mapping the slave
> > > addresses using the dma-mapping API.
> > > 
> > > Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
> > > ---
> > > drivers/dma/sh/rcar-dmac.c | 82 ++++++++++++++++++++++++++++++++++++-----
> > > 1 file changed, 74 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> > > index cf983a9..22a5e40 100644
> > > --- a/drivers/dma/sh/rcar-dmac.c
> > > +++ b/drivers/dma/sh/rcar-dmac.c
> 
> [snip]
> 
> > > +static int rcar_dmac_map_slave_addr(struct dma_chan *chan,
> > > +				    enum dma_transfer_direction dir)
> > > +{
> > > +	struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
> > > +	struct rcar_dmac_chan_map *map = &rchan->map;
> > > +	phys_addr_t dev_addr;
> > > +	size_t dev_size;
> > > +	enum dma_data_direction dev_dir;
> > > +
> > > +	if (dir == DMA_DEV_TO_MEM) {
> > > +		dev_addr = rchan->src.slave_addr;
> > > +		dev_size = rchan->src.xfer_size;
> > > +		dev_dir = DMA_TO_DEVICE;
> > 
> > Shouldn't this be DMA_FROM_DEVICE, and DMA_TO_DEVICE below ?
> 
> This comment can be ignored (thank you Robin for the explanation), but ...
> 
> > > +	} else {
> > > +		dev_addr = rchan->dst.slave_addr;
> > > +		dev_size = rchan->dst.xfer_size;
> > > +		dev_dir = DMA_FROM_DEVICE;
> > > +	}
> > > +
> > > +	/* Reuse current map if possible. */
> > > +	if (dev_addr == map->slave.slave_addr &&
> > > +	    dev_size == map->slave.xfer_size &&
> > > +	    dev_dir == map->dir)
> > > +		return 0;
> > > +
> > > +	/* Remove old mapping if present. */
> > > +	if (map->slave.xfer_size)
> > > +		dma_unmap_resource(chan->device->dev, map->addr,
> > > +				   map->slave.xfer_size, map->dir, 0);
> > 
> > Unless I'm mistaken the resource will not be unmapped when freeing channel
> > resources, will it ?
> 
> I believe this one still needs to be addressed.

I believe you are correct, I will look in to it and hopefully submit a 
patch to address it. Thanks for brining it up.

> 
> > > +	map->slave.xfer_size = 0;
> > > +
> > > +	/* Create new slave address map. */
> > > +	map->addr = dma_map_resource(chan->device->dev, dev_addr, dev_size,
> > > +				     dev_dir, 0);
> > > +
> > > +	if (dma_mapping_error(chan->device->dev, map->addr)) {
> > > +		dev_err(chan->device->dev,
> > > +			"chan%u: failed to map %zx@%pap", rchan->index,
> > > +			dev_size, &dev_addr);
> > > +		return -EIO;
> > > +	}
> > > +
> > > +	dev_dbg(chan->device->dev, "chan%u: map %zx@%pap to %pad dir: %s\n",
> > > +		rchan->index, dev_size, &dev_addr, &map->addr,
> > 
> > > +		dev_dir == DMA_TO_DEVICE ? "DMA_TO_DEVICE" :
> > "DMA_FROM_DEVICE");
> > 
> > > +
> > > +	map->slave.slave_addr = dev_addr;
> > > +	map->slave.xfer_size = dev_size;
> > > +	map->dir = dev_dir;
> > > +
> > > +	return 0;
> > > +}
> 
> [snip]
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 

-- 
Regards,
Niklas S?derlund
