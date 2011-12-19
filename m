From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Dec 2011 12:15:59 +0000
Subject: [PATCH] MXS: Convert mutexes in clock.c to spinlocks
In-Reply-To: <201112191257.06145.marek.vasut@gmail.com>
References: <1324217174-6574-1-git-send-email-marek.vasut@gmail.com>
 <201112190503.46668.marek.vasut@gmail.com>
 <20111219082225.GC14542@n2100.arm.linux.org.uk>
 <201112191257.06145.marek.vasut@gmail.com>
Message-ID: <20111219121559.GF14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 12:57:05PM +0100, Marek Vasut wrote:
> > There is another solution to this, which I've pointed out before when
> > this has come up:
> > 
> > 1. Convert all your drivers to _also_ use clk_prepare()/clk_unprepare().
> >    You need to do this anyway as it will become mandatory for the common
> >    clk stuff.
> > 
> > 2. Rename your existing clk_enable()/clk_disable() implementation to
> >    clk_prepare()/clk_unprepare().  Ensure CONFIG_HAVE_CLK_PREPARE is
> >    selected.
> > 
> > 3. Provide a new no-op clk_enable()/clk_disable() functions.
> 
> Well, I'm still unsure how'd you then enable/disable the clock ? 
> clk_prepare/clk_unprepare is good, but how would that help in avoiding the 
> mutex/spinlock?

Then, quite simply, you don't understand clk_prepare/clk_unprepare.

Lets go back to the original discussion.  We have two classes of
implementations of the clk API:

1. We have those where clk_enable() and clk_disable() can be called from
   any context.

2. We have those where clk_enable() and clk_disable() can only be called
   from process context.

Then we have drivers - some of which call clk_enable() and clk_disable()
from atomic contexts.

Obviously, this situation can't be unified as is, because the different
requirements of the implementations and drivers are such that it's
impossible to have a single implementation which works across the board.

So, to allow a single implementation to proceed, it was decided that we'd
split clk_enable() and clk_disable() into two parts - an atomic part and
a non-atomic part.

The atomic part keeps the clk_enable() and clk_disable() name.  The
non-atomic part gets the new clk_prepare() and clk_unprepare() name.

Drivers must respect the following sequence throughout their code:

	clk = clk_get();
	clk_prepare(clk);
	clk_enable(clk);

	clk_disable(clk);
	clk_unprepare(clk);
	clk_put(clk);

In other words, it is _illegal_ for any driver to enable a clock which
they have not _themselves_ prepared - in the same way that it is illegal
to call clk_enable() on a clk that they have already put.

Drivers which only enable/disable their clocks from process context would
pair the clk_prepare()+clk_enable() calls together, and the clk_disable()+
clk_unprepare() calls.

Drivers which enable/disable their clocks from atomic contexts must ensure
that a clk is already prepared in some process context prior to calling
clk_enable() - as it is not permitted to call clk_prepare() from atomic
contexts.

For the PL011 UART, this means that:

1. Clocks are prepared when the port is opened _or_ when the console is
   configured.

2. Clocks are enabled when the port is opened _or_ when there is a message
   to output through the console.

3. Clocks are disabled when the port is closed _or_ when the console output
   has finished.

4. Clocks are unprepared when the port is closed.

This means that if you are capable of _only _process-context based clock
handing, and you use this driver, your clock will be enabled for the
console port at boot time and _never_ turned off.  That's the penalty
you _have_ to pay to satisfy the conditions imposed by your implementation.

So, there are two solutions:

1. Fix your clk API implementation such that clk_enable/clk_disable() are
   callable from atomic contexts.

2. Fix your clk API to rename the non-atomic clk_enable/clk_disable() to
   clk_prepare/clk_unprepare() and provide dummy clk_enable/clk_disable().

'Fixing' the driver is not an option - and would be just a case of moving
the existing clk_enable/clk_disable calls to where the clk_prepare/
clk_unprepare calls currently are - crippling those implementations which
are good citizens.

So, in summary, you have everything you require to fix it outside the
driver.  You just have to decide which of the two options you want to
proceed with, and actually (and finally) do it instead of endlessly
procrastinating and waiting for more and more bug reports (which is
exactly what has happened so far.)
