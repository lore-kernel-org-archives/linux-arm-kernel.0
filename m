From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Wed, 21 Jan 2015 20:49:40 +0800
Subject: [PATCH v4 2/2] I2C: mediatek: Add driver for MediaTek I2C
 controller
In-Reply-To: <20150121081519.GS22880@pengutronix.de>
References: <1421404418-50718-1-git-send-email-eddie.huang@mediatek.com>
 <1421404418-50718-3-git-send-email-eddie.huang@mediatek.com>
 <20150118101816.GF22880@pengutronix.de>
 <1421810004.15468.825.camel@mtksdaap41>
 <1421821809.11671.117.camel@mtksdaap41>
 <20150121081519.GS22880@pengutronix.de>
Message-ID: <1421844580.11671.145.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-01-21 at 09:15 +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Wed, Jan 21, 2015 at 02:30:09PM +0800, Yingjoe Chen wrote:
> > On Wed, 2015-01-21 at 11:13 +0800, Eddie Huang wrote:
> > <...>
> > > > > +		ret = -EINVAL;
> > > > > +		goto err_exit;
> > > > > +	}
> > > > > +
> > > > > +	if (msgs->buf == NULL) {
> > > > > +		dev_dbg(i2c->dev, " data buffer is NULL.\n");
> > > > > +		ret = -EINVAL;
> > > > > +		goto err_exit;
> > > > > +	}
> > > > > +
> > > > > +	i2c->addr = msgs->addr;
> > > > > +	i2c->msg_len = msgs->len;
> > > > > +	i2c->msg_buf = msgs->buf;
> > > > > +
> > > > > +	if (msgs->flags & I2C_M_RD)
> > > > > +		i2c->op = I2C_MASTER_RD;
> > > > > +	else
> > > > > +		i2c->op = I2C_MASTER_WR;
> > > > > +
> > > > > +	/* combined two messages into one transaction */
> > > > > +	if (num > 1) {
> > > > > +		i2c->msg_aux_len = (msgs + 1)->len;
> > > > > +		i2c->op = I2C_MASTER_WRRD;
> > > > > +	}
> > > > This means "write then read", right? You should check here that the
> > > > first message is really a write and the 2nd a read then.
> > > > Can this happen at all with the quirks defined below (.max_num_msgs =
> > > > 1)?
> > > Yes, mean write then read. Indeed, add check is better.
> > > If msg number is 1, means normal write or read, not "write then read".
> > 
> > The quirks will increase the message count and check 'write then read'
> > for us. We don't have to add check here.
> I have to admit I don't know that quirks stuff, so it's well possible
> that I'm wrong here.
>  
> > > > > +static int mtk_i2c_remove(struct platform_device *pdev)
> > > > > +{
> > > > > +	struct mtk_i2c *i2c = platform_get_drvdata(pdev);
> > > > > +
> > > > > +	i2c_del_adapter(&i2c->adap);
> > > > > +	free_i2c_dma_bufs(i2c);
> > > > > +	platform_set_drvdata(pdev, NULL);
> > > > > +
> > > > Here you need to make sure that no irq is running when i2c_del_adapter
> > > > is called.
> > > OK, add check here
> > 
> > I thought after i2c_del_adapter() is complete, all i2c_transfer for this
> > adapter is completed. If this is true, then i2c clock is already off and
> > we won't have any on-going transfer/pending irq.
> Consider that there is an ongoing transaction and before it completes
> the adapter-device is unbound from the driver. Then i2c_del_adapter is
> called which frees the resources managed by the core, then the device's
> completion irq triggers and the freed adapter is used which probably
> results in an oops.

Not sure if I missed anything. i2c_transfer() is a synchronize call. If
we fixed timeout issue you mentioned in mtk_i2c_transfer(), it will turn
off clock before it return, which disable any transaction and clear all
pending irq.

Your scenario can only happens when one thread is still running in
i2c_transfer/algo->master_xfer and the other thread is trying to remove
the device. If that happened, then every device data access in
mtk_i2c_transfer might cause oops. I looked at some i2c drivers and
can't find any checking for this case, I can't find anything prevent i2c
device removal before pending i2c_transfer complete either. Would you
give me an example?

Joe.C
