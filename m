From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 6 Jun 2016 15:20:03 +0200 (CEST)
Subject: [PATCH 1/2] clk: imx: do not sleep if IRQ's are still disabled
In-Reply-To: <20160602145915.GA31124@shlinux2>
References: <1454107764-19876-1-git-send-email-stefan@agner.ch>
 <20160421034520.GA19965@shlinux2.ap.freescale.net>
 <20160426012341.GB8870@tiger>
 <CAA+hA=QTNEAaMfjJoMMO5gPR8VPYBWYx=HZgjngUFJK4LxMp=g@mail.gmail.com>
 <1461663072.7839.17.camel@pengutronix.de>
 <CAA+hA=SSQJPbzbhCY7O8JaxiUgMDjG2ATQXsCW-X5zc2inC6kw@mail.gmail.com>
 <CAA+hA=Q5Un7Sib5QEvK4H2PH5qrySAkRR+=ofuaKxX_PCuT-Yw@mail.gmail.com>
 <20160427015835.GE30692@tiger>
 <CAA+hA=REqJ8JhmKt5_jCAaRTUy2E14ww_MqWSSLpNBKgnf=U9A@mail.gmail.com>
 <alpine.DEB.2.11.1604271212290.3941@nanos> <20160602145915.GA31124@shlinux2>
Message-ID: <alpine.DEB.2.11.1606061448010.28031@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Jun 2016, Dong Aisheng wrote:
> On Wed, Apr 27, 2016 at 12:15:00PM +0200, Thomas Gleixner wrote:
> > Calling a function which might sleep _BEFORE_ kernel_init() is wrong. Don't
> > try to work around such an issue by doing magic irq_disabled() checks and busy
> > loops. Fix the call site and be done with it.
> > 
> 
> IRQ chip and clocksource are also initialised before kernel_init()
> which may call clk APIs like clk_prepare_enable().
> We may not be able to guarantee those clocks are unsleepable.
> 
> e.g.
> For IRQ chip, the arm,gic documents the optional clocks property in
> Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt.
> Although there seems no user currently, not sure there might be
> a exception in the future.
> 
> For clocksource driver, it's quite common to call clk APIs to
> enable and get clock rate which may also cause sleep.
> e.g. ARM twd clock in arch/arm/kernel/smp_twd.c.
> 
> If we have to avoid the possible sleep caused by these clocks,
> we may need to manually check it and change the related clocks
> (e.g PLLs) from sleepable to busy loops.
> But that is not a good solution and may also not stable when
> clock varies.
> 
> It looks like not easy to find a generic solution for them.
> What's your suggestion?

I think we should split the prepare callbacks up and move the handling logic
into the core.

clk_ops.prepare()	Legacy callback
clk_ops.prepare_hw()	Callback which writes to the hardware
clk_ops.prepare_done()	Callback which checks whether the prepare is completed

So now the core can do:

clk_prepare()
{
	/* Legacy code should go away */
	if (ops->prepare) {
	      ops->prepare();
	      return;
	}

	if (ops->prepare_hw)
	      ops->prepare_hw();

   	if (!ops->prepare_done())
		return;

	if (early_boot_or_suspend_resume()) {
		/*
		 * Busy loop when we can't schedule in early boot,
		 * suspend and resume.
		 */
		while (!ops->prepare_done())
		      ;
	} else {
		while (!ops->prepare_done())
		      usleep(clk->prepare_delay);
	}
}

As a side effect that allows us to remove the gazillion of

     	    while (!hw_ready)
	    	  usleep();

copies all over the place and we have a single point of control where we allow
the clocks to busy loop.

Toughts?

Thanks,

	tglx
