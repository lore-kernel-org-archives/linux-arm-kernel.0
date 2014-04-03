From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 3 Apr 2014 09:10:04 +0200
Subject: [PATCH v3 1/2] i2c: Add driver for Cadence I2C controller
In-Reply-To: <533CF913.4020308@monstr.eu>
References: <1394556613-11692-1-git-send-email-soren.brinkmann@xilinx.com>
 <533CF913.4020308@monstr.eu>
Message-ID: <20140403071004.GA2571@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Please don't quote large parts of the message f you are not referring to
it.

> > +#ifdef CONFIG_PM_SLEEP
> > +/**
> > + * cdns_i2c_suspend - Suspend method for the driver
> > + * @_dev:	Address of the platform_device structure
> > + * Return: 0 always
> > + *
> > + * Put the driver into low power mode.
> > + */
> > +static int cdns_i2c_suspend(struct device *_dev)
> > +{
> > +	struct platform_device *pdev = container_of(_dev,
> > +			struct platform_device, dev);
> > +	struct cdns_i2c *xi2c = platform_get_drvdata(pdev);
> > +
> > +	clk_disable(xi2c->clk);
> > +	xi2c->suspended = 1;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * cdns_i2c_resume - Resume from suspend
> > + * @_dev:	Address of the platform_device structure
> > + * Return: 0 on success and error value on error
> > + *
> > + * Resume operation after suspend.
> > + */
> > +static int cdns_i2c_resume(struct device *_dev)
> > +{
> > +	struct platform_device *pdev = container_of(_dev,
> > +			struct platform_device, dev);
> > +	struct cdns_i2c *xi2c = platform_get_drvdata(pdev);
> > +	int ret;
> > +
> > +	ret = clk_enable(xi2c->clk);
> > +	if (ret) {
> > +		dev_err(_dev, "Cannot enable clock.\n");
> > +		return ret;
> > +	}
> > +
> > +	xi2c->suspended = 0;
> > +
> > +	return 0;
> > +}
> > +#endif
> 
> Can you also please remove this #ifdef and use __maybe_used
> instead? Better not to have any ifdef in the code.

Is this a new pattern? For PM_SLEEP, #ifdef seems to be quite common.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140403/1da2955a/attachment.sig>
