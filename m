From: stefan.bruens@rwth-aachen.de (Stefan Bruens)
Date: Mon, 4 Sep 2017 02:12:07 +0200
Subject: [PATCH 07/10] dmaengine: sun6i: Retrieve channel count/max
 request from devicetree
In-Reply-To: <d211b11c-09f6-8a69-2560-6be89f3b9c3c@arm.com>
References: <20170903224100.17893-1-stefan.bruens@rwth-aachen.de>
 <20170903224100.17893-8-stefan.bruens@rwth-aachen.de>
 <d211b11c-09f6-8a69-2560-6be89f3b9c3c@arm.com>
Message-ID: <2286861.ip18xhFNEq@pebbles.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Montag, 4. September 2017 01:44:54 CEST Andr? Przywara wrote:
> Hi,
> 
> On 03/09/17 23:40, Stefan Br?ns wrote:
> > To avoid introduction of a new compatible for each small SoC/DMA
> > controller
> > variation, move the definition of the channel count to the devicetree.
> > 
> > The number of vchans is no longer explicit, but limited by the highest
> > port/DMA request number. The result is a slight overallocation for SoCs
> > with a sparse port mapping.
> > 
> > Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
> > ---
> > 
> >  drivers/dma/sun6i-dma.c | 35 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 34 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> > index c69dadb853d2..bd4c2e4a759b 100644
> > --- a/drivers/dma/sun6i-dma.c
> > +++ b/drivers/dma/sun6i-dma.c
> > @@ -42,6 +42,9 @@
> > 
> >  #define DMA_STAT		0x30
> > 
> > +/* Offset between DMA_IRQ_EN and DMA_IRQ_STAT limits number of channels
> > */
> > +#define DMA_MAX_CHANNELS	(DMA_IRQ_CHAN_NR * 0x10 / 4)
> > +
> > 
> >  /*
> >  
> >   * sun8i specific registers
> >   */
> > 
> > @@ -65,7 +68,8 @@
> > 
> >  #define DMA_CHAN_LLI_ADDR	0x08
> >  
> >  #define DMA_CHAN_CUR_CFG	0x0c
> > 
> > -#define DMA_CHAN_CFG_SRC_DRQ(x)		((x) & 0x1f)
> > +#define DMA_CHAN_MAX_DRQ		0x1f
> > +#define DMA_CHAN_CFG_SRC_DRQ(x)		((x) & DMA_CHAN_MAX_DRQ)
> > 
> >  #define DMA_CHAN_CFG_SRC_IO_MODE	BIT(5)
> >  #define DMA_CHAN_CFG_SRC_LINEAR_MODE	(0 << 5)
> >  #define DMA_CHAN_CFG_SRC_BURST_A31(x)	(((x) & 0x3) << 7)
> > 
> > @@ -1173,6 +1177,35 @@ static int sun6i_dma_probe(struct platform_device
> > *pdev)> 
> >  	sdc->num_vchans = sdc->cfg->nr_max_vchans;
> >  	sdc->max_request = sdc->cfg->nr_max_requests;
> > 
> > +	ret = of_property_read_u32(np, "dma-channels", &sdc->num_pchans);
> > +	if (ret && !sdc->num_pchans) {
> > +		dev_err(&pdev->dev, "Can't get dma-channels.\n");
> > +		return ret;
> > +	}
> > +
> > +	if (sdc->num_pchans > DMA_MAX_CHANNELS) {
> > +		dev_err(&pdev->dev, "Number of dma-channels out of range.\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = of_property_read_u32(np, "dma-requests", &sdc->max_request);
> > +	if (ret && !sdc->max_request) {
> > +		dev_info(&pdev->dev, "Missing dma-requests, using %u.\n",
> > +			 DMA_CHAN_MAX_DRQ);
> 
> Mmmh, is this mapping of "!sdc->max_request" -> DMA_CHAN_MAX_DRQ
> implemented somewhere else? Or is it just missing here:
> 		sdc->max_request = DMA_CHAN_MAX_DRQ;

Well spotted, that assignment is actually missing.

With this line added, your comment for patch 8/10 should also be addressed 
(regarding the default value).
 
> Otherwise this is looking good, thanks for picking up the DT property
> approach!
> 
> Cheers,
> Andre.
> 

Kind regards,

Stefan

-- 
Stefan Br?ns  /  Bergstra?e 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
