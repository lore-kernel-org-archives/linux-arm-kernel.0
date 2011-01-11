From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Jan 2011 09:28:42 +0000
Subject: Locking in the clk API
In-Reply-To: <20110111090311.GM12078@pengutronix.de>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111031552.GJ3760@linux-sh.org>
	<201101111211.30172.jeremy.kerr@canonical.com>
	<20110111090311.GM12078@pengutronix.de>
Message-ID: <20110111092842.GJ12552@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 10:03:11AM +0100, Sascha Hauer wrote:
> Quoting Russell:
> 
> > I hate the GPIO APIs for doing this _cansleep crap as the decision of
> > whether to use the _cansleep or normal APIs normally can't be made at
> > the time when the API is used, but sometime later.  Many people just use
> > the non-_cansleep versions irrespective of the context they're in -
> > which is unnecessarily restrictive - consider what happens if you then
> > have that driver use a GPIO on an I2C peripheral...
> 
> Sounds like we should rather have s sleeping clk_enable and a
> clk_enable_atomic. This way people can use standard clk_enable until
> a 'scheduling while atomic' gives a hint in the right direction.

Well, there's a problem lurking here - lets take the PL011 driver.  You
convert the console write calls to use clk_enable_atomic(), leaving the
rest.

The driver will appear to work fine with a sleeping clk, until you get
a console write.  Maybe your SoC developer never tried the console on
the particular port you just tried to use?  Maybe such a driver should
use the _atomic() versions throughout?

Another solution occurs to me: clk_enable() which returns -EAGAIN if
it's called in an atomic context but needs to sleep, and let the driver
deal with the clock not being enabled when it wants it.  The down side
is it requires the driver to have additional code to sort out such a
problem.

Maybe another approach for the time being is to unify in two steps: first
unify the implementations which use a spinlock - and those which can use
a spinlock, and separately those which must use a mutex.

Then this issue can be revisited in the future.
