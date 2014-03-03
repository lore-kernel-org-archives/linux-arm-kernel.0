From: yao.yuan@freescale.com (Yao Yuan)
Date: Mon, 3 Mar 2014 10:23:33 +0000
Subject: [PATCH 1/3] i2c: add DMA support for freescale i2c driver
In-Reply-To: <201402272139.36076.marex@denx.de>
References: <1393481115-22136-1-git-send-email-yao.yuan@freescale.com>
 <1393481115-22136-2-git-send-email-yao.yuan@freescale.com>
 <201402272139.36076.marex@denx.de>
Message-ID: <3bbad0af0bc74f04bc386b141dadedb3@BL2PR03MB338.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Marek

Marek Vasut wrote:
> On Thursday, February 27, 2014 at 07:05:14 AM, Yuan Yao wrote:
> 
> [...]
> 
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

Thanks for your attention.
This few days I look up the code for the realization of dma_release_channel(). 
I found that it will disable the dma request first. So it's may safe. 
And drivers hadn't check whether dma is still active before dma_release_channel() as a usually usage.
Because it will be disabled automatic.

The only problem is that, it will be forced to cancel the transfer which was not yet completed.
Looking forward to hearing from you.

Best regards,
Yuan Yao
