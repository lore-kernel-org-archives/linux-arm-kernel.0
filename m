From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 19 Nov 2014 10:55:50 +0100
Subject: [PATCH] i2c: at91: introduce probe deferring
In-Reply-To: <20141119091647.GB1439@katana>
References: <1415972879-26509-1-git-send-email-ludovic.desroches@atmel.com>
 <20141119091647.GB1439@katana>
Message-ID: <20141119095550.GD3639@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 10:16:47AM +0100, Wolfram Sang wrote:
> On Fri, Nov 14, 2014 at 02:47:59PM +0100, Ludovic Desroches wrote:
> > Return probe defer if requesting a dma channel without a dma controller probed.
> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > ---
> >  drivers/i2c/busses/i2c-at91.c | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> > index 77fb647..df3f4c4 100644
> > --- a/drivers/i2c/busses/i2c-at91.c
> > +++ b/drivers/i2c/busses/i2c-at91.c
> > @@ -679,14 +679,21 @@ static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
> >  	dma_cap_zero(mask);
> >  	dma_cap_set(DMA_SLAVE, mask);
> >  
> > -	dma->chan_tx = dma_request_slave_channel_compat(mask, filter, pdata,
> > -							dev->dev, "tx");
> > -	if (!dma->chan_tx) {
> > +	dma->chan_tx = dma_request_slave_channel_reason(dev->dev, "tx");
> 
> Will it cause regressions if you drop the compat-version of requesting
> a channel?

All our devices with a DMA controller have been converted to device tree
and the legacy board support will be removed in 3.19 so it won't cause
regression.

> 
> > +	if (IS_ERR(dma->chan_tx)) {
> > +		ret = PTR_ERR(dma->chan_tx);
> > +		if (ret == -EPROBE_DEFER) {
> > +			dev_warn(dev->dev, "no DMA channel available at the moment\n");
> 
> I'd say drop this warning. The core usually prints when deferred probing
> takes place.
>
 
Ok, I'll remove it.


Ludovic
