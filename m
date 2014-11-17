From: yao.yuan@freescale.com (Yao Yuan)
Date: Mon, 17 Nov 2014 10:41:56 +0000
Subject: [PATCH v9 3/3] i2c: imx: add DMA support for freescale i2c driver
In-Reply-To: <20141108173513.GA4900@katana>
References: <1413025032-14958-1-git-send-email-yao.yuan@freescale.com>
 <1413025032-14958-4-git-send-email-yao.yuan@freescale.com>
 <20141108173513.GA4900@katana>
Message-ID: <BL2PR03MB33877C76779D5588D1B3E30838B0@BL2PR03MB338.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your review.
Your suggestions is really helpful.

I will correct them in v10.

Best Regards,
Yuan Yao

> -----Original Message-----
> From: Wolfram Sang [mailto:wsa at the-dreams.de]
> Sent: Sunday, November 09, 2014 1:35 AM
> To: Yuan Yao-B46683
> Cc: marex at denx.de; LW at KARO-electronics.de; mark.rutland at arm.com; Duan
> Fugang-B38611; shawn.guo at linaro.org; linux-kernel at vger.kernel.org; linux-
> arm-kernel at lists.infradead.org; linux-i2c at vger.kernel.org
> Subject: Re: [PATCH v9 3/3] i2c: imx: add DMA support for freescale i2c
> driver
> 
> Hi,
> 
> mostly looking good...
> 
> > +#define IMX_I2C_DMA_THRESHOLD	16
> 
> Have you guessed or measured this value? A comment about this value would
> be nice.
> 
> >
> > +struct imx_i2c_dma {
> > +	struct dma_chan		*chan_tx;
> > +	struct dma_chan		*chan_rx;
> > +	struct dma_chan		*chan_using;
> > +	struct completion	cmd_complete;
> > +	dma_addr_t		dma_buf;
> > +	unsigned int		dma_len;
> > +	unsigned int		dma_transfer_dir;
> > +	unsigned int		dma_data_dir;
> 
> Please use proper types as there are things like 'enum
> dma_data_direction' and the likes...
> 
> > +	dmaengine_submit(txdesc);
> 
> This can fail, too. Use dma_submit_error() to check.
> 
> > +	result = wait_for_completion_interruptible_timeout(
> > +				&i2c_imx->dma->cmd_complete,
> > +				msecs_to_jiffies(IMX_I2C_DMA_TIMEOUT));
> 
> Have you tested signals extensively? I can't really recommend the
> _intrruptible_ here. I don't see any cleaning up to get the bus to a
> consistent state again. Most people drop the interruptible sooner or
> later.
> 
> > +	/* Init DMA config if support*/
> > +	i2c_imx_dma_request(i2c_imx, phy_addr);
> 
> Make this function void? DMA is optional anyhow.
> 
> Thanks,
> 
>    Wolfram
