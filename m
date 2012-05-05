From: marex@denx.de (Marek Vasut)
Date: Sat, 5 May 2012 15:12:17 +0200
Subject: [PATCH v2 2/5] dma: mxs-dma: make platform_device_id more generic
In-Reply-To: <20120504143442.GL2194@S2101-09.ap.freescale.net>
References: <1336133539-13465-1-git-send-email-b29396@freescale.com>
 <201205041415.04095.marek.vasut@gmail.com>
 <20120504143442.GL2194@S2101-09.ap.freescale.net>
Message-ID: <201205051512.17972.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Fri, May 04, 2012 at 02:15:03PM +0200, Marek Vasut wrote:
> > >  static int __init mxs_add_mxs_dma(void)
> > >  {
> > > 
> > > -	char *apbh = "mxs-dma-apbh";
> > > -	char *apbx = "mxs-dma-apbx";
> > > +	char *mx23_apbh = "imx23-dma-apbh";
> > > +	char *mx23_apbx = "imx23-dma-apbx";
> > > +	char *mx28_apbh = "imx28-dma-apbh";
> > > +	char *mx28_apbx = "imx28-dma-apbx";
> > 
> > Wild guess ... but const char * won't hurt here ?
> 
> Right.  I guess it just followed how the existing code looks like.
> Considering this whole function will be removed patch #4, it should
> not be a big problem, I guess.

Can't the patches be reordered then to avoid adding this altogether?

> > > -#define MXS_DMA_APBH		0
> > > -#define MXS_DMA_APBX		1
> > > -#define dma_is_apbh()		(mxs_dma->dev_id == MXS_DMA_APBH)
> > > -
> > > -#define APBH_VERSION_LATEST	3
> > > -#define apbh_is_old()		(mxs_dma->version < APBH_VERSION_LATEST)
> > > +#define dma_is_apbh()		(mxs_dma->type == MXS_DMA_APBH)
> > > +#define apbh_is_old()		(mxs_dma->dev_id == IMX23_DMA)
> 
> ...
> 
> > > +int mxs_dma_is_apbh(struct dma_chan *chan)
> > > +{
> > > +	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
> > > +	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
> > 
> > Do you need the above here ? :)
> 
> I have to confess it's my bad.  I made the code hard to read when I
> created the driver.  The dma_is_apbh() should really takes mxs_dma
> as a parameter than hiding it in the macro.
> 
> While I agree this is something should be improved, it may be better
> to do it in another patch?

You don't have to add dead code in this patch and re-add it when needed. Or fix 
the macro to take the parameter then, though I don't understand why you'd want 
to take it and then hide it.

> > > +
> > > +	return dma_is_apbh();
> > > +}

Best regards,
Marek Vasut
