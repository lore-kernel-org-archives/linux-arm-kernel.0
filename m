From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 7 Mar 2016 16:47:02 +0100
Subject: [linux-sunxi] [PATCH] dma: sun4i: expose block size and wait
 cycle configuration to DMA users
In-Reply-To: <1457364641.20836.5.camel@plaes.org>
References: <1457344771-12946-1-git-send-email-boris.brezillon@free-electrons.com>
 <1457364641.20836.5.camel@plaes.org>
Message-ID: <20160307164702.59f5d9d1@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Priit,

On Mon, 07 Mar 2016 17:30:41 +0200
Priit Laes <plaes@plaes.org> wrote:

> On Mon, 2016-03-07 at 10:59 +0100, Boris Brezillon wrote:
> > Some drivers might need to tweak the block size and wait cycles
> > values
> > to get better performances.
> > Create and export the sun4i_dma_set_chan_config() to do that.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/dma/sun4i-dma.c       | 44 ++++++++++++++++++++++++++++++---
> > ----------
> >  include/linux/dma/sun4i-dma.h | 38
> > +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 69 insertions(+), 13 deletions(-)
> >  create mode 100644 include/linux/dma/sun4i-dma.h
> > 
> > diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
> > index 1661d518..e48f537 100644
> > --- a/drivers/dma/sun4i-dma.c
> > +++ b/drivers/dma/sun4i-dma.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/bitops.h>
> >  #include <linux/clk.h>
> >  #include <linux/dmaengine.h>
> > +#include <linux/dma/sun4i-dma.h>
> >  #include <linux/dmapool.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/module.h>
> > @@ -138,6 +139,7 @@ struct sun4i_dma_pchan {
> >  struct sun4i_dma_vchan {
> >  	struct virt_dma_chan		vc;
> >  	struct dma_slave_config		cfg;
> > +	struct sun4i_dma_chan_config	scfg;
> >  	struct sun4i_dma_pchan		*pchan;
> >  	struct sun4i_dma_promise	*processing;
> >  	struct sun4i_dma_contract	*contract;
> > @@ -779,7 +781,7 @@ sun4i_dma_prep_slave_sg(struct dma_chan *chan,
> > struct scatterlist *sgl,
> >  	u8 ram_type, io_mode, linear_mode;
> >  	struct scatterlist *sg;
> >  	dma_addr_t srcaddr, dstaddr;
> > -	u32 endpoints, para;
> > +	u32 endpoints;
> >  	int i;
> >  
> >  	if (!sgl)
> > @@ -825,17 +827,6 @@ sun4i_dma_prep_slave_sg(struct dma_chan *chan,
> > struct scatterlist *sgl,
> >  			dstaddr = sg_dma_address(sg);
> >  		}
> >  
> > -		/*
> > -		 * These are the magic DMA engine timings that keep
> > SPI going.
> > -		 * I haven't seen any interface on DMAEngine to
> > configure
> > -		 * timings, and so far they seem to work for
> > everything we
> > -		 * support, so I've kept them here. I don't know if
> > other
> > -		 * devices need different timings because, as usual,
> > we only
> > -		 * have the "para" bitfield meanings, but no comment
> > on what
> > -		 * the values should be when doing a certain
> > operation :|
> > -		 */
> > -		para = SUN4I_DDMA_MAGIC_SPI_PARAMETERS;
> > -
> >  		/* And make a suitable promise */
> >  		if (vchan->is_dedicated)
> >  			promise = generate_ddma_promise(chan,
> > srcaddr, dstaddr,
> > @@ -850,7 +841,7 @@ sun4i_dma_prep_slave_sg(struct dma_chan *chan,
> > struct scatterlist *sgl,
> >  			return NULL; /* TODO: should we free
> > everything? */
> >  
> >  		promise->cfg |= endpoints;
> > -		promise->para = para;
> > +		promise->para = vchan->scfg.para;
> >  
> >  		/* Then add it to the contract */
> >  		list_add_tail(&promise->list, &contract->demands);
> > @@ -908,6 +899,21 @@ static int sun4i_dma_config(struct dma_chan
> > *chan,
> >  	return 0;
> >  }
> >  
> > +int sun4i_dma_set_chan_config(struct dma_chan *dchan,
> > +			      const struct sun4i_dma_chan_config
> > *cfg)
> > +{
> > +	struct sun4i_dma_vchan *vchan = to_sun4i_dma_vchan(dchan);
> > +
> > +	if (!vchan->is_dedicated)
> > +		return -ENOTSUPP;
> > +
> > +	/* TODO: control cfg value */
> > +	vchan->scfg = *cfg;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(sun4i_dma_set_chan_config);
> > +
> >  static struct dma_chan *sun4i_dma_of_xlate(struct of_phandle_args
> > *dma_spec,
> >  					   struct of_dma *ofdma)
> >  {
> > @@ -1206,6 +1212,18 @@ static int sun4i_dma_probe(struct
> > platform_device *pdev)
> >  		spin_lock_init(&vchan->vc.lock);
> >  		vchan->vc.desc_free = sun4i_dma_free_contract;
> >  		vchan_init(&vchan->vc, &priv->slave);
> > +
> > +		/*
> > +		 * These are the magic DMA engine timings that keep
> > SPI going.
> > +		 * I haven't seen any interface on DMAEngine to
> > configure
> > +		 * timings, and so far they seem to work for
> > everything we
> > +		 * support, so I've kept them here. I don't know if
> > other
> > +		 * devices need different timings because, as usual,
> > we only
> > +		 * have the "para" bitfield meanings, but no comment
> > on what
> > +		 * the values should be when doing a certain
> > operation :|
> > +		 */
> > +		vchan->scfg.para = SUN4I_DDMA_MAGIC_SPI_PARAMETERS;
> 
> Does SPI refer the Serial Peripheral Interface?
> 
> If yes, then I would point out that current sun4i SPI driver doesn't
> actually use DMA [1]
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/411
> 722.html

I just moved this assignment and the associated comment in the driver,
so maybe we should ask Emilio why he thinks SPI config should be the
default one, and how he tested it...

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
