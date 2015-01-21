From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Wed, 21 Jan 2015 14:30:09 +0800
Subject: [PATCH v4 2/2] I2C: mediatek: Add driver for MediaTek I2C
 controller
In-Reply-To: <1421810004.15468.825.camel@mtksdaap41>
References: <1421404418-50718-1-git-send-email-eddie.huang@mediatek.com>
 <1421404418-50718-3-git-send-email-eddie.huang@mediatek.com>
 <20150118101816.GF22880@pengutronix.de>
 <1421810004.15468.825.camel@mtksdaap41>
Message-ID: <1421821809.11671.117.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Uwe,

Thanks for your review,

On Wed, 2015-01-21 at 11:13 +0800, Eddie Huang wrote:
<...>
> > > +		ret = -EINVAL;
> > > +		goto err_exit;
> > > +	}
> > > +
> > > +	if (msgs->buf == NULL) {
> > > +		dev_dbg(i2c->dev, " data buffer is NULL.\n");
> > > +		ret = -EINVAL;
> > > +		goto err_exit;
> > > +	}
> > > +
> > > +	i2c->addr = msgs->addr;
> > > +	i2c->msg_len = msgs->len;
> > > +	i2c->msg_buf = msgs->buf;
> > > +
> > > +	if (msgs->flags & I2C_M_RD)
> > > +		i2c->op = I2C_MASTER_RD;
> > > +	else
> > > +		i2c->op = I2C_MASTER_WR;
> > > +
> > > +	/* combined two messages into one transaction */
> > > +	if (num > 1) {
> > > +		i2c->msg_aux_len = (msgs + 1)->len;
> > > +		i2c->op = I2C_MASTER_WRRD;
> > > +	}
> > This means "write then read", right? You should check here that the
> > first message is really a write and the 2nd a read then.
> > Can this happen at all with the quirks defined below (.max_num_msgs =
> > 1)?
> Yes, mean write then read. Indeed, add check is better.
> If msg number is 1, means normal write or read, not "write then read".

The quirks will increase the message count and check 'write then read'
for us. We don't have to add check here.


<...>
> > > +static int mtk_i2c_remove(struct platform_device *pdev)
> > > +{
> > > +	struct mtk_i2c *i2c = platform_get_drvdata(pdev);
> > > +
> > > +	i2c_del_adapter(&i2c->adap);
> > > +	free_i2c_dma_bufs(i2c);
> > > +	platform_set_drvdata(pdev, NULL);
> > > +
> > Here you need to make sure that no irq is running when i2c_del_adapter
> > is called.
> OK, add check here

I thought after i2c_del_adapter() is complete, all i2c_transfer for this
adapter is completed. If this is true, then i2c clock is already off and
we won't have any on-going transfer/pending irq.

Joe.C
