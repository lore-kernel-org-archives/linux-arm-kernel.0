From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Dec 2011 08:22:25 +0000
Subject: [PATCH] MXS: Convert mutexes in clock.c to spinlocks
In-Reply-To: <201112190503.46668.marek.vasut@gmail.com>
References: <1324217174-6574-1-git-send-email-marek.vasut@gmail.com>
 <20111219032712.GB4962@S2100-06.ap.freescale.net>
 <201112190503.46668.marek.vasut@gmail.com>
Message-ID: <20111219082225.GC14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 05:03:45AM +0100, Marek Vasut wrote:
> > On Sun, Dec 18, 2011 at 03:06:13PM +0100, Marek Vasut wrote:
> > > The mutexes can't be safely used under certain circumstances. I noticed
> > > this
> > 
> > > issue during some network instability at home:
> > Yes, this is a known issue.  And there was some discussion[1] about
> > why mutex is needed.
> 
> Thanks for pointing this out, I was unaware of it.
> 
> > But I really have not thought about why we can
> > not use spinlock only, since using mutex only leads to the issue we
> > are seeing here, and using spinlock in enable/disable and mutex in
> > rate/parent will not work, because the mxs clocks have enable/disable
> > and rate/parent functions access the same register.  I know it's not
> > good to hold spinlock in rate/parent functions for a long time, but
> > do we have a way around rather than using spinlock for both sets of
> > functions?
> 
> Yea, spinlock is not good either. On the other hand, is it really held for so 
> long ?

There is another solution to this, which I've pointed out before when
this has come up:

1. Convert all your drivers to _also_ use clk_prepare()/clk_unprepare().
   You need to do this anyway as it will become mandatory for the common
   clk stuff.

2. Rename your existing clk_enable()/clk_disable() implementation to
   clk_prepare()/clk_unprepare().  Ensure CONFIG_HAVE_CLK_PREPARE is
   selected.

3. Provide a new no-op clk_enable()/clk_disable() functions.

This fixes the issue because clk_prepare()/clk_unprepare() must only be
called from process contexts, whereas clk_enable()/clk_disable() may be
called from atomic contexts as well.
