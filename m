From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 5 Sep 2014 19:25:31 +0100
Subject: [STLinux Kernel] [PATCH 4/4] watchdog: st_wdt: Add new driver
 for ST's LPC Watchdog
In-Reply-To: <20140905155811.GA12374@roeck-us.net>
References: <1409841592-18890-1-git-send-email-lee.jones@linaro.org>
 <1409841592-18890-6-git-send-email-lee.jones@linaro.org>
 <20140905155811.GA12374@roeck-us.net>
Message-ID: <20140905182531.GA2383@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> > +static int st_wdog_remove(struct platform_device *pdev)
> > +{
> > +	struct st_wdog *st_wdog = watchdog_get_drvdata(&st_wdog_dev);
> > +
> > +	if (watchdog_active(&st_wdog_dev))
> > +		st_wdog_stop(&st_wdog_dev);
> > +
> > +	st_wdog_setup(st_wdog, WDT_DISABLE);
> > +
> > +	watchdog_unregister_device(&st_wdog_dev);
> > +
> No clk_disable_unprepare ?
> 
> Maye it is not necessary, but then I wonder why you have it above.

I think your right it should have a clk_disable_unprepare. Otherwise you will end up leaking a clock
reference each time you insmod / rmmod the driver.
> 
> > +	return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM
> > +static int st_wdog_suspend(struct device *dev)
> > +{
> > +	if (watchdog_active(&st_wdog_dev))
> > +		st_wdog_stop(&st_wdog_dev);
> > +
> 
> Is any clock activity necessary here ? Just asking, I don't really have an idea.

I would also expect the clock to be managed in suspend / resume callbacks.

regards,

Peter.
