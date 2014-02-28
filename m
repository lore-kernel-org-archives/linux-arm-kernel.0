From: yao.yuan@freescale.com (Yao Yuan)
Date: Fri, 28 Feb 2014 05:19:18 +0000
Subject: [PATCH 1/3] i2c: add DMA support for freescale i2c driver
In-Reply-To: <201402272139.36076.marex@denx.de>
References: <1393481115-22136-1-git-send-email-yao.yuan@freescale.com>
 <1393481115-22136-2-git-send-email-yao.yuan@freescale.com>
 <201402272139.36076.marex@denx.de>
Message-ID: <3f58a8abdda74100b4f7b14d0c31c90e@BL2PR03MB338.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

Thank you very much for your suggestion.

> -----Original Message-----
> From: Marek Vasut [mailto:marex at denx.de]
> Sent: Friday, February 28, 2014 4:40 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Yuan Yao-B46683; wsa at the-dreams.de; mark.rutland at arm.com;
> shawn.guo at linaro.org; linux-kernel at vger.kernel.org; linux-
> i2c at vger.kernel.org
> Subject: Re: [PATCH 1/3] i2c: add DMA support for freescale i2c driver
> 
> On Thursday, February 27, 2014 at 07:05:14 AM, Yuan Yao wrote:
> 
> [...]
> 
> > *****/ @@ -63,6 +68,9 @@
> >  /* Default value */
> >  #define IMX_I2C_BIT_RATE	100000	/* 100kHz */
> >
> > +/* enable DMA if transfer size is bigger than this threshold */
> > +#define IMX_I2C_DMA_THRESHOLD	16
> 
> So what's the unit here , potatoes or beers or what ? I suppose it's
> bytes , but please make it explicit in the comment ...
> 

Yes it's bytes. I will make it explicit in the comment.

> [...]
> 
> >  static const struct imx_i2c_hwdata imx1_i2c_hwdata  = { @@ -193,6
> > +216,7 @@ static const struct imx_i2c_hwdata imx1_i2c_hwdata  = {
> >  	.ndivs			= ARRAY_SIZE(imx_i2c_clk_div),
> >  	.i2sr_clr_opcode	= I2SR_CLR_OPCODE_W0C,
> >  	.i2cr_ien_opcode	= I2CR_IEN_OPCODE_1,
> > +	.has_dma_support	= false,
> >
> >  };
> >
> > @@ -203,6 +227,7 @@ static const struct imx_i2c_hwdata imx21_i2c_hwdata
> =
> > { .ndivs			= ARRAY_SIZE(imx_i2c_clk_div),
> >  	.i2sr_clr_opcode	= I2SR_CLR_OPCODE_W0C,
> >  	.i2cr_ien_opcode	= I2CR_IEN_OPCODE_1,
> > +	.has_dma_support	= false,
> >
> >  };
> >
> > @@ -213,6 +238,7 @@ static struct imx_i2c_hwdata vf610_i2c_hwdata = {
> >  	.ndivs			= ARRAY_SIZE(vf610_i2c_clk_div),
> >  	.i2sr_clr_opcode	= I2SR_CLR_OPCODE_W1C,
> >  	.i2cr_ien_opcode	= I2CR_IEN_OPCODE_0,
> > +	.has_dma_support	= true,
> 
> So why exactly don't we have a DT prop for determining whether the
> controller has DMA support ?
> 
> What about the other controllers, do they not support DMA for some
> specific reason? Please elaborate on that, thank you !

Sorry for my fault. I will modify it.

> [...]
> 
> > +static void i2c_imx_dma_tx_callback(void *arg)
> [...]
> > +static int i2c_imx_dma_tx(struct imx_i2c_struct *i2c_imx, struct
> > +i2c_msg
> > *msgs) +{
> [...]
> > +static void i2c_imx_dma_rx_callback(void *arg)
> [...]
> > +static int i2c_imx_dma_rx(struct imx_i2c_struct *i2c_imx, struct
> > +i2c_msg
> > *msgs) +{
> [...]
> 
> Looks like there's quite a bit of code duplication in the four functions
> above, can you not unify them ?
> 

Yes, There's looks like quite a bit of code duplication in the four functions above.
I also hate quite a bit of code duplication.
But there are many differences in fact.
If unify them we should add many conditional statements and auxiliary variable.
I think it's superfluous and will damage the readability.
So, I am very confused. And if you think unify them will be better I will modify it. 
Thanks for your suggestion and looking forward to hearing from you.


> Also, can the DMA not do full-duplex operation ? What I see here is just
> half- duplex operations , one for RX and the other one for TX .
> 

Yes, here have two dma channels, one for RX and the other one for TX.
When we request the channel we should determine it for TX or RX.

> > +static void i2c_imx_dma_free(struct imx_i2c_struct *i2c_imx) {
> > +	struct imx_i2c_dma *dma = i2c_imx->dma;
> > +	struct dma_chan *dma_chan;
> > +
> > +	dma_chan = dma->chan_tx;
> > +	dma->chan_tx = NULL;
> > +	dma->buf_tx = 0;
> > +	dma->len_tx = 0;
> > +	dma_release_channel(dma_chan);
> > +
> > +	dma_chan = dma->chan_rx;
> > +	dma->chan_tx = NULL;
> > +	dma->buf_rx = 0;
> > +	dma->len_rx = 0;
> > +	dma_release_channel(dma_chan);
> 
> You must make _DEAD_ _SURE_ this function is not ever called while the
> DMA is still active. In your case, I have a feeling that's not handled.
>

I think this function will not called while the DMA is still 
active because of the Linux synchronization mechanism - completion. 
I used it in the dma function.

> > +}
> >  /** Functions for IMX I2C adapter driver
> > ***************************************
> > **********************************************************************
> > ****
> > *****/
> >
> > @@ -425,7 +600,8 @@ static irqreturn_t i2c_imx_isr(int irq, void
> *dev_id)
> >  	return IRQ_NONE;
> >  }
> >
> > -static int i2c_imx_write(struct imx_i2c_struct *i2c_imx, struct
> > i2c_msg
> > *msgs) +static int i2c_imx_pio_write(struct imx_i2c_struct *i2c_imx,
> > +							struct i2c_msg *msgs)
> >  {
> >  	int i, result;
> >
> > @@ -458,7 +634,56 @@ static int i2c_imx_write(struct imx_i2c_struct
> > *i2c_imx, struct i2c_msg *msgs) return 0;  }
> >
> > -static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct
> > i2c_msg
> > *msgs) +static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
> > +							struct i2c_msg *msgs)
> > +{
> > +	int result, timeout=1000;
> > +	unsigned int temp = 0;
> > +
> > +	reinit_completion(&i2c_imx->dma->cmd_complete);
> > +	result = i2c_imx_dma_tx(i2c_imx, msgs);
> > +	if(result)
> > +		return result;
> > +
> > +	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> > +	temp |= I2CR_DMAEN;
> > +	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> > +
> > +	/* write slave address */
> > +	imx_i2c_write_reg(msgs->addr << 1, i2c_imx, IMX_I2C_I2DR);
> > +	result = wait_for_completion_interruptible_timeout(
> > +						&i2c_imx->dma->cmd_complete,
> > +						msecs_to_jiffies(1000));
> 
> Pull the magic constant of 1000 out and #define it as some
> I2C_IMX_DMA_TIMEOUT please .
> 

Thanks, I will modify it.

> > +	if (result == 0)
> > +		return  -ETIMEDOUT;
> > +
> > +	/* waiting for Transfer complete. */
> > +	while(timeout--) {
> > +		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> > +		if (temp & 0x80)
> > +			break;
> > +		udelay(10);
> > +	}
> > +
> > +	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> > +	temp &= ~I2CR_DMAEN;
> > +	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> > +
> > +	/* write the last byte */
> > +	imx_i2c_write_reg(msgs->buf[msgs->len-1], i2c_imx, IMX_I2C_I2DR);
> > +	result = i2c_imx_trx_complete(i2c_imx);
> > +	if (result)
> > +		return result;
> > +
> > +	result = i2c_imx_acked(i2c_imx);
> > +	if (result)
> > +		return result;
> > +
> > +	return 0;
> > +}
> > +
> > +static int i2c_imx_pio_read(struct imx_i2c_struct *i2c_imx,
> > +							struct i2c_msg *msgs)
> >  {
> >  	int i, result;
> >  	unsigned int temp;
> > @@ -518,6 +743,80 @@ static int i2c_imx_read(struct imx_i2c_struct
> > *i2c_imx, struct i2c_msg *msgs) return 0;  }
> >
> > +static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
> > +							struct i2c_msg *msgs)
> > +{
> 
> Looks like almost an duplication as well...
> 

Considering the symmetric with them i2c_imx_dma_write.
i2c_imx_dma_write and i2c_imx_pio_write have many differences. So I separate them.
But i2c_imx_dma_read and i2c_imx_pio_read is the same at first part. I may should unify them.
But it's will not symmetric with them i2c_imx_dma_write if unified them. So I don't know which will be better?
Looking forward to hearing from you.

> Besides, full-duplex DMA operation is missing, please explain why.
> 
> THanks!
> 
