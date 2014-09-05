From: marex@denx.de (Marek Vasut)
Date: Fri, 5 Sep 2014 12:40:44 +0200
Subject: [PATCH v7 1/2] i2c: imx: add DMA support for freescale i2c driver
In-Reply-To: <c10c1960255e4dbca2a281b995290c6d@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1407923215-3749-1-git-send-email-yao.yuan@freescale.com>
 <201409041638.45537.marex@denx.de>
 <c10c1960255e4dbca2a281b995290c6d@BL2PR03MB338.namprd03.prod.outlook.com>
Message-ID: <201409051240.44469.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 05, 2014 at 12:32:40 PM, Yao Yuan wrote:
[...]
> > > +static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
> > > +					struct i2c_msg *msgs)
> > > +{
> > > +	int result;
> > > +	unsigned int temp = 0;
> > > +	unsigned long orig_jiffies = jiffies;
> > > +	struct imx_i2c_dma *dma = i2c_imx->dma;
> > > +	struct device *dev = &i2c_imx->adapter.dev;
> > > +
> > > +	dev_dbg(dev, "<%s> write slave address: addr=0x%x\n",
> > > +		__func__, msgs->addr << 1);
> > > +
> > > +	reinit_completion(&i2c_imx->dma->cmd_complete);
> > > +	dma->chan_using = dma->chan_tx;
> > > +	dma->dma_transfer_dir = DMA_MEM_TO_DEV;
> > > +	dma->dma_data_dir = DMA_TO_DEVICE;
> > > +	dma->dma_len = msgs->len - 1;
> > > +	result = i2c_imx_dma_xfer(i2c_imx, msgs);
> > > +	if (result)
> > > +		return result;
> > > +
> > > +	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> > > +	temp |= I2CR_DMAEN;
> > > +	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> > > +
> > > +	/*
> > > +	 * Write slave address.
> > > +	 * The first byte muse be transmitted by the CPU.
> > > +	 */
> > > +	imx_i2c_write_reg(msgs->addr << 1, i2c_imx, IMX_I2C_I2DR);
> > > +	result = wait_for_completion_interruptible_timeout(
> > > +				&i2c_imx->dma->cmd_complete,
> > > +				msecs_to_jiffies(IMX_I2C_DMA_TIMEOUT));
> > > +	if (result <= 0) {
> > > +		dmaengine_terminate_all(dma->chan_using);
> > > +		if (result)
> > > +			return result;
> > > +		else
> > > +			return -ETIMEDOUT;
> > 
> > Shouldn't you force-disable the DMA here somehow (like unsetting
> > I2CR_DMAEN bit), if it failed or timed out?
> 
> [Yuan Yao] Yes, I put the code for force-disable DMA in i2c_imx_start().
> In order to make sure any DMA error will not effect the I2C.
> It seems almost the same as put the code here, how about your think?

Would that mean that the "crashed" DMA would be running until the next 
transmission is scheduled ?

[...]
