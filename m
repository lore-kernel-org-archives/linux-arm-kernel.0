From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 21 Nov 2014 08:02:21 +0100
Subject: [PATCH] i2c: at91: introduce probe deferring
In-Reply-To: <20141119101403.GE3639@ldesroches-Latitude-E6320>
References: <1415972879-26509-1-git-send-email-ludovic.desroches@atmel.com>
 <20141119091647.GB1439@katana> <5216790.dAh2H6iKq8@wuerfel>
 <20141119101403.GE3639@ldesroches-Latitude-E6320>
Message-ID: <20141121070221.GE1480@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 11:14:03AM +0100, Ludovic Desroches wrote:
> On Wed, Nov 19, 2014 at 10:47:15AM +0100, Arnd Bergmann wrote:
> > On Wednesday 19 November 2014 10:16:47 Wolfram Sang wrote:
> > > On Fri, Nov 14, 2014 at 02:47:59PM +0100, Ludovic Desroches wrote:
> > > > Return probe defer if requesting a dma channel without a dma controller probed.
> > > > 
> > > > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > > > ---
> > > >  drivers/i2c/busses/i2c-at91.c | 22 ++++++++++++++++------
> > > >  1 file changed, 16 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> > > > index 77fb647..df3f4c4 100644
> > > > --- a/drivers/i2c/busses/i2c-at91.c
> > > > +++ b/drivers/i2c/busses/i2c-at91.c
> > > > @@ -679,14 +679,21 @@ static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
> > > >  	dma_cap_zero(mask);
> > > >  	dma_cap_set(DMA_SLAVE, mask);
> > > >  
> > > > -	dma->chan_tx = dma_request_slave_channel_compat(mask, filter, pdata,
> > > > -							dev->dev, "tx");
> > > > -	if (!dma->chan_tx) {
> > > > +	dma->chan_tx = dma_request_slave_channel_reason(dev->dev, "tx");
> > > 
> > > Will it cause regressions if you drop the compat-version of requesting
> > > a channel?
> > 
> > I got curious about this, since the patch looks obviously wrong, but
> > actually it's ok. However the entire DMA support for non-DT platforms
> > can be dropped in this driver, see patch below
> > 
> > > > +	if (IS_ERR(dma->chan_tx)) {
> > > > +		ret = PTR_ERR(dma->chan_tx);
> > > > +		if (ret == -EPROBE_DEFER) {
> > > > +			dev_warn(dev->dev, "no DMA channel available at the moment\n");
> > > 
> > > I'd say drop this warning. The core usually prints when deferred probing
> > > takes place.
> > 
> > Definitely yes.
> > 
> > 	Arnd
> > 8<---
> > [PATCH] i2c: at91: remove legacy DMA supoprt
> > 
> > Since at91sam9g45 is now DT-only, all DMA capable users of this driver are
> > using the DT case, and the legacy support can be removed. While at it, fix
> > the deferred probe case.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for this cleanup, yet I'd really appreciate a build test at
least.

> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

>From you, I had even hoped for a quick runtime test. Would that be
possible for future patches?

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141121/3afced22/attachment.sig>
