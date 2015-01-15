From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 15 Jan 2015 17:32:35 +0100
Subject: [PATCH v4 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
In-Reply-To: <20150115120704.GB2549@katana>
References: <rjui@broadcom.com>
 <1421274213-3544-1-git-send-email-rjui@broadcom.com>
 <1421274213-3544-3-git-send-email-rjui@broadcom.com>
 <20150115084119.GN22880@pengutronix.de>
 <20150115120704.GB2549@katana>
Message-ID: <20150115163235.GQ22880@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Jan 15, 2015 at 01:07:05PM +0100, Wolfram Sang wrote:
> > > +	iproc_i2c->msg = msg;
> > Can it happen that iproc_i2c->msg still holds an uncompleted message
> > here or is this serialized by the core? Wolfram? Either here something
> 
> We have per-adapter locks serializing transfers, if you mean that?
ok, so in the efm32 driver the if (ddata->msgs) condition in
efm32_i2c_master_xfer can never be true, right?

> > > +static int bcm_iproc_i2c_remove(struct platform_device *pdev)
> > > +{
> > > +	struct bcm_iproc_i2c_dev *iproc_i2c = platform_get_drvdata(pdev);
> > > +
> > > +	i2c_del_adapter(&iproc_i2c->adapter);
> > You need to free the irq before i2c_del_adapter.
> 
> One could also keep using devm_request_irq and disable all interrupts
> sources here?
calling devm_free_irq would work or writel(0, iproc_i2c->base +
IE_OFFSET) + synchronize_irq().

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
