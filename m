From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 3 Apr 2014 08:42:43 -0700
Subject: [PATCH v3 1/2] i2c: Add driver for Cadence I2C controller
In-Reply-To: <533D0CFB.7050707@monstr.eu>
References: <1394556613-11692-1-git-send-email-soren.brinkmann@xilinx.com>
 <533CF913.4020308@monstr.eu> <20140403071004.GA2571@katana>
 <533D0CFB.7050707@monstr.eu>
Message-ID: <d3723b56-61d7-4983-a5d5-6c885c0e9a8e@CH1EHSMHS002.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-04-03 at 09:25AM +0200, Michal Simek wrote:
> On 04/03/2014 09:10 AM, Wolfram Sang wrote:
> > 
> > Please don't quote large parts of the message f you are not referring to
> > it.
> 
> Normally I do it. Forgot sorry.
> 
> >>> +#ifdef CONFIG_PM_SLEEP
> >>> +/**
> >>> + * cdns_i2c_suspend - Suspend method for the driver
> >>> + * @_dev:	Address of the platform_device structure
> >>> + * Return: 0 always
> >>> + *
> >>> + * Put the driver into low power mode.
> >>> + */
> >>> +static int cdns_i2c_suspend(struct device *_dev)
> >>> +{
> >>> +	struct platform_device *pdev = container_of(_dev,
> >>> +			struct platform_device, dev);
> >>> +	struct cdns_i2c *xi2c = platform_get_drvdata(pdev);
> >>> +
> >>> +	clk_disable(xi2c->clk);
> >>> +	xi2c->suspended = 1;
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +/**
> >>> + * cdns_i2c_resume - Resume from suspend
> >>> + * @_dev:	Address of the platform_device structure
> >>> + * Return: 0 on success and error value on error
> >>> + *
> >>> + * Resume operation after suspend.
> >>> + */
> >>> +static int cdns_i2c_resume(struct device *_dev)
> >>> +{
> >>> +	struct platform_device *pdev = container_of(_dev,
> >>> +			struct platform_device, dev);
> >>> +	struct cdns_i2c *xi2c = platform_get_drvdata(pdev);
> >>> +	int ret;
> >>> +
> >>> +	ret = clk_enable(xi2c->clk);
> >>> +	if (ret) {
> >>> +		dev_err(_dev, "Cannot enable clock.\n");
> >>> +		return ret;
> >>> +	}
> >>> +
> >>> +	xi2c->suspended = 0;
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +#endif
> >>
> >> Can you also please remove this #ifdef and use __maybe_used
> >> instead? Better not to have any ifdef in the code.
> > 
> > Is this a new pattern? For PM_SLEEP, #ifdef seems to be quite common.
> 
> The first suggestion to do it came from CAN maintainer.
> It is valid in general for ifdef.
> I have checked all our drivers and we are changing them to use __maybe_used
> because then we can easily find out if there is any problem
> when function prototype has changed.

I already have that change in my current version. I hope to send v4 to the list
soon.

	S?ren
