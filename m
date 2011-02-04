From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Feb 2011 10:57:10 +0000
Subject: Locking in the clk API, part 2: clk_prepare/clk_unprepare
In-Reply-To: <20110204102120.GJ30452@pengutronix.de>
References: <20110201105449.GY1147@pengutronix.de>
	<20110201131512.GH31216@n2100.arm.linux.org.uk>
	<20110201141837.GA1147@pengutronix.de>
	<20110201143932.GK31216@n2100.arm.linux.org.uk>
	<20110201151846.GD1147@pengutronix.de>
	<20110201152458.GP31216@n2100.arm.linux.org.uk>
	<4D48741F.8060006@codeaurora.org>
	<20110201212409.GU31216@n2100.arm.linux.org.uk>
	<20110204095424.GB2347@richard-laptop>
	<20110204102120.GJ30452@pengutronix.de>
Message-ID: <20110204105710.GF14627@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 04, 2011 at 11:21:20AM +0100, Uwe Kleine-K?nig wrote:
> I happily point out that the prepare_count needs to be protected by a
> spinlock and you need a flag that signals a prepare or unprepare is
> currently running.

It's really simple.  You don't use a struct clk pointer in any way until
you've called a clk_get() to get a pointer.  So what's the problem with
ensuring that you do clk_prepare() on it before you register whatever
services may end up calling clk_enable().

That is good practice.  It's precisely the same practice which says that
you shall not register device drivers with subsystems, thereby making
them visible, until you're absolutely ready in the driver to start taking
requests to use your driver.  Precisely the same thing applies here.

In other words, to go back to the UART console driver case, in the
UART console setup function, you do this:

	clk = clk_get(...);
	if (IS_ERR(clk))
		return PTR_ERR(clk);

	err = clk_prepare(clk);
	if (err) {
		clk_put(clk);
		return err;
	}

	rate = clk_get_rate(clk);
	... setup UART, setup baud rate according to rate ...

	return 0;

So, this means that clk_enable() in the console write function will not
be called until after the initialization function has finished - by which
time clk_prepare() will have completed.

There is no need for any kind of spinlocking, atomic types or other such
crap for the prepare count.  We do not care about concurrent clk_enables().

The only time you'd need such games as you're suggesting is if you're still
promoting your idea about calling clk_prepare() from clk_enable() "in case
driver writers forget it", which is soo broken it's untrue.
