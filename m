From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 14 Jan 2015 08:51:37 +0100
Subject: [PATCH v3 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
In-Reply-To: <54B5D0F9.8030902@broadcom.com>
References: <rjui@broadcom.com>
 <1418183832-24793-1-git-send-email-rjui@broadcom.com>
 <1418183832-24793-3-git-send-email-rjui@broadcom.com>
 <20150113225012.GK22880@pengutronix.de>
 <54B5D0F9.8030902@broadcom.com>
Message-ID: <20150114075137.GL22880@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Jan 13, 2015 at 06:14:17PM -0800, Ray Jui wrote:
> >> +	irq = platform_get_irq(pdev, 0);
> >> +	if (irq < 0) {
> > irq == 0 should be handled as error, too.
> > 
> Ah. I thought zero is a valid global interrupt number, and I see other
> drivers checking against < 0 as well. Is my understanding incorrect?
These are wrong, too. 0 should never be a valid interrupt number. There
are some exceptions but mostly for historic reasons. The right handling
is used for example in drivers/i2c/busses/i2c-efm32.c.

> >> +		dev_err(dev->device, "no irq resource\n");
> >> +		return irq;
> >> +	}
> [...]
> >> +static int bcm_iproc_i2c_remove(struct platform_device *pdev)
> >> +{
> >> +	struct bcm_iproc_i2c_dev *dev = platform_get_drvdata(pdev);
> >> +
> >> +	i2c_del_adapter(&dev->adapter);
> >> +	bcm_iproc_i2c_disable(dev);
> > I think you have a problem here if bcm_iproc_i2c_remove is called while
> > an irq is still being serviced. I'm not sure how to prevent this
> > properly for a shared interrupt.
> > 
> Can I grab i2c_lock_adapter to ensure the bus is locked (so there's no
> outstanding transactions or IRQs by the time we remove the adapter)? But
> I see no I2C bus driver does this in their remove function...
The problem I pointed out is the reason for some driver authors not to
use devm_request_irq. If you use plain request_irq and the matching
free_irq in the .remove callback you can be sure that the irq isn't
running any more as soon as free_irq returns.

BTW, if you use vim, you can add

	set cinoptions=(,:
	if has("autocmd")
		filetype plugin indent on
	endif

to your .vimrc. Then while typing vim does the indention right and
consistent, and with the = command you can reindent.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
