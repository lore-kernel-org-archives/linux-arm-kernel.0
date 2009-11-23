From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 24 Nov 2009 00:38:12 +0100
Subject: [PATCH 05/10] ARM: PNX4008: convert watchdog to use clk API
	enable/disable calls
In-Reply-To: <20091120150332.GY19336@infomag.iguana.be>
References: <20091120144422.GA18223@n2100.arm.linux.org.uk>
	<E1NBUk5-0004Pg-Q4@rmk-PC.arm.linux.org.uk>
	<20091120150332.GY19336@infomag.iguana.be>
Message-ID: <083DF309106F364B939360100EC290F804F55464A2@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> Subject: Re: [PATCH 05/10] ARM: PNX4008: convert watchdog to use clk API
> enable/disable calls
> 
> Acked-by: Wim Van Sebroeck <wim@iguana.be>
> 
> > clk_set_rate() is not supposed to be used to turn clocks on and off.
> > That's what clk_enable/clk_disable is for.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  arch/arm/mach-pnx4008/clock.c  |    4 ++--
> >  drivers/watchdog/pnx4008_wdt.c |   37 ++++++++++++++++++++++++----------
> ---
> >  2 files changed, 26 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/arm/mach-pnx4008/clock.c b/arch/arm/mach-
> pnx4008/clock.c
> > index d12e0b1..270c254 100644
> > --- a/arch/arm/mach-pnx4008/clock.c
> > +++ b/arch/arm/mach-pnx4008/clock.c
> > @@ -740,10 +740,10 @@ static struct clk wdt_ck = {
> >  	.name = "wdt_ck",
> >  	.parent = &per_ck,
> >  	.flags = NEEDS_INITIALIZATION,
> > -	.round_rate = &on_off_round_rate,
> > -	.set_rate = &on_off_set_rate,
> >  	.enable_shift = 0,
> >  	.enable_reg = TIMCLKCTRL_REG,
> > +	.enable = clk_reg_enable,
> > +	.disable = clk_reg_disable,
> >  };
> >
> >  /* These clocks are visible outside this module
> > diff --git a/drivers/watchdog/pnx4008_wdt.c
> b/drivers/watchdog/pnx4008_wdt.c
> > index 9add3a8..e274f42 100644
> > --- a/drivers/watchdog/pnx4008_wdt.c
> > +++ b/drivers/watchdog/pnx4008_wdt.c
> > @@ -96,9 +96,6 @@ static void wdt_enable(void)
> >  {
> >  	spin_lock(&io_lock);
> >
> > -	if (wdt_clk)
> > -		clk_set_rate(wdt_clk, 1);
> > -
> >  	/* stop counter, initiate counter reset */
> >  	__raw_writel(RESET_COUNT, WDTIM_CTRL(wdt_base));
> >  	/*wait for reset to complete. 100% guarantee event */

The wdt_enable() functions also assumes a wdt counter rate of 13MHz
with the WDOG_COUNTER_RATE macro. I think this was ok for the original
PNX part, but the LPC32XX platform's rate will vary based on the
system clock rate of the device. The nominal rate is 13.325MHz.

I've checked the previous 3 WDT patches and made the necessary changes
to my clock driver and everything still works on the LPC32xx platforms,
but can't check changes on the PNX4008 platform (have no hardware).

I'll submit a patch to use clk_get_rate instead of the macro..

> > @@ -125,19 +122,25 @@ static void wdt_disable(void)
> >  	spin_lock(&io_lock);
> >
> >  	__raw_writel(0, WDTIM_CTRL(wdt_base));	/*stop counter */
> > -	if (wdt_clk)
> > -		clk_set_rate(wdt_clk, 0);
> >
> >  	spin_unlock(&io_lock);
> >  }
> >
> >  static int pnx4008_wdt_open(struct inode *inode, struct file *file)
> >  {
> > +	int ret;
> > +
> >  	if (test_and_set_bit(WDT_IN_USE, &wdt_status))
> >  		return -EBUSY;
> >
> >  	clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
> >
> > +	ret = clk_enable(wdt_clk);
> > +	if (ret) {
> > +		clear_bit(WDT_IN_USE, &wdt_status);
> > +		return ret;
> > +	}
> > +
> >  	wdt_enable();
> >
> >  	return nonseekable_open(inode, file);
> > @@ -225,6 +228,7 @@ static int pnx4008_wdt_release(struct inode *inode,
> struct file *file)
> >  		printk(KERN_WARNING "WATCHDOG: Device closed unexpectdly\n");
> >
> >  	wdt_disable();
> > +	clk_disable(wdt_clk);
> >  	clear_bit(WDT_IN_USE, &wdt_status);
> >  	clear_bit(WDT_OK_TO_CLOSE, &wdt_status);
> >
> > @@ -279,19 +283,27 @@ static int __devinit pnx4008_wdt_probe(struct
> platform_device *pdev)
> >  		release_resource(wdt_mem);
> >  		kfree(wdt_mem);
> >  		goto out;
> > -	} else
> > -		clk_set_rate(wdt_clk, 1);
> > +	}
> > +
> > +	ret = clk_enable(wdt_clk);
> > +	if (ret) {
> > +		release_resource(wdt_mem);
> > +		kfree(wdt_mem);
> > +		goto out;
> > +	}
> >
> >  	ret = misc_register(&pnx4008_wdt_miscdev);
> >  	if (ret < 0) {
> >  		printk(KERN_ERR MODULE_NAME "cannot register misc device\n");
> >  		release_resource(wdt_mem);
> >  		kfree(wdt_mem);
> > -		clk_set_rate(wdt_clk, 0);
> > +		clk_disable(wdt_clk);
> > +		clk_put(wdt_clk);
> >  	} else {
> >  		boot_status = (__raw_readl(WDTIM_RES(wdt_base)) & WDOG_RESET)
> ?
> >  		    WDIOF_CARDRESET : 0;
> >  		wdt_disable();		/*disable for now */
> > +		clk_disable(wdt_clk);
> >  		set_bit(WDT_DEVICE_INITED, &wdt_status);
> >  	}
> >
> > @@ -302,11 +314,10 @@ out:
> >  static int __devexit pnx4008_wdt_remove(struct platform_device *pdev)
> >  {
> >  	misc_deregister(&pnx4008_wdt_miscdev);
> > -	if (wdt_clk) {
> > -		clk_set_rate(wdt_clk, 0);
> > -		clk_put(wdt_clk);
> > -		wdt_clk = NULL;
> > -	}
> > +
> > +	clk_disable(wdt_clk);
> > +	clk_put(wdt_clk);
> > +
> >  	if (wdt_mem) {
> >  		release_resource(wdt_mem);
> >  		kfree(wdt_mem);
> > --
> > 1.6.2.5
> >
