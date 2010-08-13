From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 13 Aug 2010 12:24:53 -0700
Subject: [PATCH] input/touch: Introduce the LPC32xx touchscreen
	controller driver
In-Reply-To: <AANLkTik0voaTUHoJuaVGvmhqpUh_tfbk3VUNXyWMh1av@mail.gmail.com>
References: <1281568142-12892-1-git-send-email-wellsk40@gmail.com>
	<1281568142-12892-2-git-send-email-wellsk40@gmail.com>
	<20100813083311.GA7824@core.coreip.homeip.net>
	<AANLkTik0voaTUHoJuaVGvmhqpUh_tfbk3VUNXyWMh1av@mail.gmail.com>
Message-ID: <20100813192453.GA8387@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 13, 2010 at 12:00:33PM -0700, Kevin Wells wrote:
> >>
> >> This patch set introduces support for the LPC32xx touchscreen
> >> controller driver. The LPC32xx touchscreen controller supports
> >> automated event detection and X/Y data conversion for resistive
> >> touchscreens.
> >>
> >
> > Overall looks very nice, a few comments below.
> >
> 
> Thanks for helping review this driver. I'll update and repost once
> the fixes and changes are finalized.
> 
> >> +
> >> + ? ? if (input_register_device(tsc->dev)) {
> >> + ? ? ? ? ? ? dev_err(&pdev->dev, "failed registering input device\n");
> >> + ? ? ? ? ? ? goto err_stop_clk;
> >
> > retval is garbage here, you need to do:
> >
> > ? ? ? ?error = input_register_device();
> > ? ? ? ?if (error) {
> > ? ? ? ? ? ? ? ?...
> > ? ? ? ? ? ? ? ?goto err_stop_clk;
> > ? ? ? ?}
> >
> > I must say that I do not like mixing devm_* with the standard error path
> > unwinding, if we can rely on devm_xxx() calls to take care of everything
> > we should revert to standard error unsinding practice for everythng.
> >
> 
> Would it be preferable to just use standard resource functions and error
> path unwinding (with fixes in _remove too) similar to the other drivers in
> ./drivers/input?

Yes, that what I was trying to say. If only I didn't make so many
typos...

-- 
Dmitry
