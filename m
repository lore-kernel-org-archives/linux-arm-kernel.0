From: Stefan.Bruens@rwth-aachen.de (=?iso-8859-1?Q?Br=FCns=2C_Stefan?=)
Date: Mon, 4 Sep 2017 14:47:24 +0000
Subject: [PATCH 02/10] dmaengine: sun6i: Correct burst length field
 offsets for H3
In-Reply-To: <20170904075924.jufrqijrtxcqvztd@flea>
References: <20170903224100.17893-1-stefan.bruens@rwth-aachen.de>
 <20170903224100.17893-3-stefan.bruens@rwth-aachen.de>
 <20170904075924.jufrqijrtxcqvztd@flea>
Message-ID: <2223782.bf3lvqWUP7@sbruens-linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Montag, 4. September 2017 09:59:24 CEST Maxime Ripard wrote:
> On Mon, Sep 04, 2017 at 12:40:53AM +0200, Stefan Br?ns wrote:
> > For the H3, the burst lengths field offsets in the channel configuration
> > register differs from earlier SoC generations.
> > 
> > Using the A31 register macros actually configured the H3 controller
> > do to bursts of length 1 always, which although working leads to higher
> > bus utilisation.
> > 
> > Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
> > ---
> > 
> >  drivers/dma/sun6i-dma.c | 28 +++++++++++++++++++++-------
> >  1 file changed, 21 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> > index 1d9b3be30d22..f1a139f0102f 100644
> > --- a/drivers/dma/sun6i-dma.c
> > +++ b/drivers/dma/sun6i-dma.c
> > @@ -68,13 +68,15 @@
> > 
> >  #define DMA_CHAN_CFG_SRC_DRQ(x)		((x) & 0x1f)
> >  #define DMA_CHAN_CFG_SRC_IO_MODE	BIT(5)
> >  #define DMA_CHAN_CFG_SRC_LINEAR_MODE	(0 << 5)
> > 
> > -#define DMA_CHAN_CFG_SRC_BURST(x)	(((x) & 0x3) << 7)
> > +#define DMA_CHAN_CFG_SRC_BURST_A31(x)	(((x) & 0x3) << 7)
> > +#define DMA_CHAN_CFG_SRC_BURST_H3(x)	(((x) & 0x3) << 6)
> > 
> >  #define DMA_CHAN_CFG_SRC_WIDTH(x)	(((x) & 0x3) << 9)
> >  
> >  #define DMA_CHAN_CFG_DST_DRQ(x)		(DMA_CHAN_CFG_SRC_DRQ(x) << 16)
> >  #define DMA_CHAN_CFG_DST_IO_MODE	(DMA_CHAN_CFG_SRC_IO_MODE << 16)
> >  #define DMA_CHAN_CFG_DST_LINEAR_MODE	(DMA_CHAN_CFG_SRC_LINEAR_MODE << 16)
> > 
> > -#define DMA_CHAN_CFG_DST_BURST(x)	(DMA_CHAN_CFG_SRC_BURST(x) << 16)
> > +#define DMA_CHAN_CFG_DST_BURST_A31(x)	(DMA_CHAN_CFG_SRC_BURST_A31(x) <<
> > 16) +#define DMA_CHAN_CFG_DST_BURST_H3(x)	(DMA_CHAN_CFG_SRC_BURST_H3(x)
> > << 16)> 
> >  #define DMA_CHAN_CFG_DST_WIDTH(x)	(DMA_CHAN_CFG_SRC_WIDTH(x) << 16)
> >  
> >  #define DMA_CHAN_CUR_SRC	0x10
> > 
> > @@ -554,11 +556,17 @@ static int set_config(struct sun6i_dma_dev *sdev,
> > 
> >  	if (dst_width < 0)
> >  	
> >  		return dst_width;
> > 
> > -	*p_cfg = DMA_CHAN_CFG_SRC_BURST(src_burst) |
> > -		DMA_CHAN_CFG_SRC_WIDTH(src_width) |
> > -		DMA_CHAN_CFG_DST_BURST(dst_burst) |
> > +	*p_cfg = DMA_CHAN_CFG_SRC_WIDTH(src_width) |
> > 
> >  		DMA_CHAN_CFG_DST_WIDTH(dst_width);
> > 
> > +	if (sdev->cfg->dmac_variant == DMAC_VARIANT_H3) {
> > +		*p_cfg |= DMA_CHAN_CFG_SRC_BURST_H3(src_burst) |
> > +			  DMA_CHAN_CFG_DST_BURST_H3(dst_burst);
> > +	} else {
> > +		*p_cfg |= DMA_CHAN_CFG_SRC_BURST_A31(src_burst) |
> > +			  DMA_CHAN_CFG_DST_BURST_A31(dst_burst);
> > +	}
> > +
> 
> I guess we have two options to support that properly. We could either
> have a different function that would generate that register value
> based on the parameters we have, or duplicate the set_config function
> entirely, with function pointer stored in the configuration.
> 
> I think I prefer the former, as it reduces the code duplication.

Duplicating "set_config" would also mean duplicating sun6i_dma_prep_dma_memcpy 
- there are two hunks which change setting of the burst length register value.

A function pointer in the config would work.

Kind regards,

Stefan
