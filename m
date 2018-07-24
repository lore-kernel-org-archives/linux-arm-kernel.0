From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 24 Jul 2018 11:22:16 +0200
Subject: [PATCH v3 3/3] dmaengine: imx-sdma: allocate max 20 bds for one
 transfer
In-Reply-To: <DB6PR04MB322323354B2184421502FC5889560@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <1532367972-29707-1-git-send-email-yibin.gong@nxp.com>
 <1532367972-29707-4-git-send-email-yibin.gong@nxp.com>
 <1532343252.3163.99.camel@pengutronix.de>
 <DB6PR04MB322323354B2184421502FC5889560@DB6PR04MB3223.eurprd04.prod.outlook.com>
Message-ID: <1532424136.32306.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 23.07.2018, 13:55 +0000 schrieb Robin Gong:
> > -----Original Message-----
> > From: Lucas Stach [mailto:l.stach at pengutronix.de]
> > Sent: 2018?7?23? 18:54
> > To: Robin Gong <yibin.gong@nxp.com>; vkoul at kernel.org;
> > dan.j.williams at intel.com; s.hauer at pengutronix.de; linux at armlinux.or
> > g.uk
> > Cc: dmaengine at vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> > kernel at pengutronix.de; linux-arm-kernel at lists.infradead.org;
> > linux-kernel at vger.kernel.org
> > Subject: Re: [PATCH v3 3/3] dmaengine: imx-sdma: allocate max 20
> > bds for one
> > transfer
> > 
> > Am Dienstag, den 24.07.2018, 01:46 +0800 schrieb Robin Gong:
> > > If multi-bds used in one transfer, all bds should be consisten
> > > memory.To easily follow it, enlarge the dma pool size into 20
> > > bds, and
> > > it will report error if the number of bds is over than 20. For
> > > dmatest, the max count for single transfer is NUM_BD *
> > 
> > SDMA_BD_MAX_CNT
> > > = 20 * 65535 = ~1.28MB.
> > 
> > Both the commit message and the comment need a lot more care to
> > actually
> > tell what this commit is trying to achieve. Currently I don't
> > follow at all. What
> > does "consisten" mean? Do you mean BDs should be contiguous in
> > memory?
> 
> Yes, BDs should be contiguous??one by one in memory.

Okay, but this isn't what the code change does. By increasing the size
parameter of the dma pool you just allocate 20 times as much memory as
needed for each BD. So actually the BDs end up being very non-
contiguous in memory as there are now holes of 19 BD sizes between the
start of each BD.

So something isn't right with this change.

Regards,
Lucas

> > 
> > What do you gain by over-allocating each BD by a factor of 20?
> 
> I guess dma_pool_alloc will return error in such case, and then cause
> dma setup
> transfer failure.
> > 
> > Regards,
> > Lucas
> > 
> > > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > > ---
> > > ?drivers/dma/imx-sdma.c | 17 ++++++++++++++++-
> > > ?1 file changed, 16 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > > index
> > > b4ec2d2..5973489 100644
> > > --- a/drivers/dma/imx-sdma.c
> > > +++ b/drivers/dma/imx-sdma.c
> > > @@ -298,6 +298,15 @@ struct sdma_context_data {
> > > > ?	u32??scratch7;
> > > 
> > > ?} __attribute__ ((packed));
> > > 
> > > +/*
> > > + * All bds in one transfer should be consitent on SDMA. To
> > > easily
> > > +follow it,just
> > > + * set the dma pool size as the enough bds. For example, in
> > > dmatest
> > > +case, the
> > > + * max 20 bds means the max for single transfer is NUM_BD *
> > > +SDMA_BD_MAX_CNT = 20
> > > + * * 65535 = ~1.28MB. 20 bds supposed to be enough basically.If
> > > it's
> > > +still not
> > > + * enough in some specific cases, enlarge it here.Warning
> > > message
> > > +would also
> > > + * appear if the bd numbers is over than 20.
> > > + */
> > > +#define NUM_BD 20
> > > 
> > > ?struct sdma_engine;
> > > 
> > > @@ -1273,7 +1282,7 @@ static int sdma_alloc_chan_resources(struct
> > > dma_chan *chan)
> > > > ?		goto disable_clk_ahb;
> > > > ?	sdmac->bd_pool = dma_pool_create("bd_pool", chan-
> > > > >device->dev,
> > > > -				sizeof(struct
> > > > sdma_buffer_descriptor),
> > > > +				NUM_BD * sizeof(struct
> > > > sdma_buffer_descriptor),
> > > > ?				32, 0);
> > > > ?	return 0;
> > > 
> > > @@ -1314,6 +1323,12 @@ static struct sdma_desc
> > > *sdma_transfer_init(struct sdma_channel *sdmac,
> > > ?{
> > > > ?	struct sdma_desc *desc;
> > > > +	if (bds > NUM_BD) {
> > > > +		dev_err(sdmac->sdma->dev, "%d bds exceed the
> > > > max %d\n",
> > > > +			bds, NUM_BD);
> > > > +		goto err_out;
> > > > +	}
> > > 
> > > +
> > > > ?	desc = kzalloc((sizeof(*desc)), GFP_NOWAIT);
> > > > ?	if (!desc)
> > > > ?		goto err_out;
