From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 21 Aug 2014 07:19:59 -0700
Subject: [v4] watchdog: Add DA906x PMIC watchdog driver.
In-Reply-To: <20140821061525.GA23823@pengutronix.de>
References: <1408192545-23987-1-git-send-email-mpa@pengutronix.de>
 <20140820144322.GA7609@roeck-us.net>
 <20140821061525.GA23823@pengutronix.de>
Message-ID: <20140821141959.GA26019@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 08:15:25AM +0200, Markus Pargmann wrote:
> Hi,
> 
...
> > > +static int da9063_wdt_timeout_to_sel(int secs)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = DA9063_TWDSCALE_MIN; i <= DA9063_TWDSCALE_MAX; i++) {
> > 
> > When building with W=1, gcc complains about this line. Would be great if you can
> > have a look and fix it.
> 
> I just compiled with W=1, it doesn't complain here about this line.
> Could you give me the warning?
> 
drivers/watchdog/da9063_wdt.c: In function 'da9063_wdt_timeout_to_sel':
drivers/watchdog/da9063_wdt.c:48:34: warning: comparison between signed and
unsigned integer expressions [-Wsign-compare]

This is with arm-poky-linux-gnueabi-gcc (GCC) 4.7.2.

> > > +static int da9063_wdt_stop(struct watchdog_device *wdd)
> > > +{
> > > +	struct da9063_watchdog *wdt = watchdog_get_drvdata(wdd);
> > > +	int ret;
> > > +
> > > +	mutex_lock(&wdt->lock);
> > > +	ret = da9063_wdt_disable(wdt->da9063);
> > > +	if (ret)
> > > +		dev_alert(wdt->da9063->dev, "Watchdog failed to stop (err = %d)\n",
> > > +				ret);
> > 
> > You have a number of places where the continuation line _on purpose_
> > does not align to te opening '('. I would understand it if your indentation
> > rules were in any way consistent, but I don't see that either.
> > Ok, I can see that you dislike the rule that continuation lines should be
> > aligned to '(', but to misalign even when the '(' matches a tab position doesn't
> > really make any sense.
> 
> My indentation rules are consistent, otherwise I made a mistake. I
> always indent two tabs after an opening bracket when breaking long
> lines. Also I can't find any specific rules about how to break long
> lines in the coding style document.
> 
Hmm, I thought this was an official CodingStyle rule. Guess it is just a
checkpatch rule. Oh well.

Guenter
