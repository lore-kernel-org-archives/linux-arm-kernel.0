From: marex@denx.de (Marek Vasut)
Date: Fri, 28 Feb 2014 10:04:10 +0100
Subject: [PATCH 1/3] i2c: add DMA support for freescale i2c driver
In-Reply-To: <3f58a8abdda74100b4f7b14d0c31c90e@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1393481115-22136-1-git-send-email-yao.yuan@freescale.com>
 <201402272139.36076.marex@denx.de>
 <3f58a8abdda74100b4f7b14d0c31c90e@BL2PR03MB338.namprd03.prod.outlook.com>
Message-ID: <201402281004.10238.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, February 28, 2014 at 06:19:18 AM, Yao Yuan wrote:

[...]

> > > @@ -213,6 +238,7 @@ static struct imx_i2c_hwdata vf610_i2c_hwdata = {
> > > 
> > >  	.ndivs			= ARRAY_SIZE(vf610_i2c_clk_div),
> > >  	.i2sr_clr_opcode	= I2SR_CLR_OPCODE_W1C,
> > >  	.i2cr_ien_opcode	= I2CR_IEN_OPCODE_0,
> > > 
> > > +	.has_dma_support	= true,
> > 
> > So why exactly don't we have a DT prop for determining whether the
> > controller has DMA support ?
> > 
> > What about the other controllers, do they not support DMA for some
> > specific reason? Please elaborate on that, thank you !
> 
> Sorry for my fault. I will modify it.

I would prefer if you could explain why other controllers do have DMA disabled 
even if the hardware does support the DMA operation.
 
> > [...]
> > 
> > > +static void i2c_imx_dma_tx_callback(void *arg)
> > 
> > [...]
> > 
> > > +static int i2c_imx_dma_tx(struct imx_i2c_struct *i2c_imx, struct
> > > +i2c_msg
> > > *msgs) +{
> > 
> > [...]
> > 
> > > +static void i2c_imx_dma_rx_callback(void *arg)
> > 
> > [...]
> > 
> > > +static int i2c_imx_dma_rx(struct imx_i2c_struct *i2c_imx, struct
> > > +i2c_msg
> > > *msgs) +{
> > 
> > [...]
> > 
> > Looks like there's quite a bit of code duplication in the four functions
> > above, can you not unify them ?
> 
> Yes, There's looks like quite a bit of code duplication in the four
> functions above. I also hate quite a bit of code duplication.
> But there are many differences in fact.
> If unify them we should add many conditional statements and auxiliary
> variable. I think it's superfluous and will damage the readability.
> So, I am very confused. And if you think unify them will be better I will
> modify it. Thanks for your suggestion and looking forward to hearing from
> you.

I'd say try it, the RX and TX callback look almost the same. So does the 
i2c_imx_dma_rx() and i2c_imx_dma_tx() .

> > Also, can the DMA not do full-duplex operation ? What I see here is just
> > half- duplex operations , one for RX and the other one for TX .
> 
> Yes, here have two dma channels, one for RX and the other one for TX.
> When we request the channel we should determine it for TX or RX.

Sorry, I don't quite understand this. If you have two DMA channels, can you not 
use them both to do full-duplex SPI transfer ?

> > > +static void i2c_imx_dma_free(struct imx_i2c_struct *i2c_imx) {
> > > +	struct imx_i2c_dma *dma = i2c_imx->dma;
> > > +	struct dma_chan *dma_chan;
> > > +
> > > +	dma_chan = dma->chan_tx;
> > > +	dma->chan_tx = NULL;
> > > +	dma->buf_tx = 0;
> > > +	dma->len_tx = 0;
> > > +	dma_release_channel(dma_chan);
> > > +
> > > +	dma_chan = dma->chan_rx;
> > > +	dma->chan_tx = NULL;
> > > +	dma->buf_rx = 0;
> > > +	dma->len_rx = 0;
> > > +	dma_release_channel(dma_chan);
> > 
> > You must make _DEAD_ _SURE_ this function is not ever called while the
> > DMA is still active. In your case, I have a feeling that's not handled.
> 
> I think this function will not called while the DMA is still
> active because of the Linux synchronization mechanism - completion.
> I used it in the dma function.

This doesn't check whether the completion is actually finished anywhere. I don't 
quite understand how this is safe .

[...]

> > > +static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
> > > +							struct i2c_msg *msgs)
> > > +{
> > 
> > Looks like almost an duplication as well...
> 
> Considering the symmetric with them i2c_imx_dma_write.
> i2c_imx_dma_write and i2c_imx_pio_write have many differences. So I
> separate them. But i2c_imx_dma_read and i2c_imx_pio_read is the same at
> first part. I may should unify them. But it's will not symmetric with them
> i2c_imx_dma_write if unified them. So I don't know which will be better?
> Looking forward to hearing from you.

The dma_read() looks almost like dma_write(), so I'd also try merging them 
together.

> > Besides, full-duplex DMA operation is missing, please explain why.
> > 
> > THanks!
