From: gsi@denx.de (Gerhard Sittig)
Date: Sun, 6 Oct 2013 11:06:09 +0200
Subject: [PATCH] clk: provide public clk_is_enabled function
In-Reply-To: <20131005204208.GB28106@lunn.ch>
References: <1380881310-24345-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20131005202430.GI10079@pengutronix.de>
 <20131005204208.GB28106@lunn.ch>
Message-ID: <20131006090609.GK14747@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 05, 2013 at 22:42 +0200, Andrew Lunn wrote:
> 
> On Sat, Oct 05, 2013 at 10:24:30PM +0200, Uwe Kleine-K?nig wrote:
> > On Fri, Oct 04, 2013 at 12:08:30PM +0200, Sebastian Hesselbarth wrote:
> > > To determine if a clk has been previously enabled, provide a public
> > > clk_is_enabled function. This is especially helpful to check the state
> > > of clk-gate without actually changing the state of the gate.
> > I wonder what you want to do with the return value.
> > 
> > When doing
> > 
> > 	if (clk_is_enabled(someclk))
> > 		do_something();
> > 
> > you cannot in general know if the clock is still on when you start to
> > do_something.
> 
> Hi Uwe
> 
> At least in the use case Sebastian needs it for, we don't need an "in
> general" solution. It is used early boot time to see if the boot
> loader left the clock running.

Wait, unless I'm missing something, the clk_is_enabled() call
_won't_ determine whether the clock is enabled in hardware
(whether the boot loader created or left this condition), instead
it only determines whether clk_enable() was called previously and
thus the clock _shall_ be enabled.

AFAIK the kernel's CCF support is "self contained" and does not
consider any data or state that was "inherited" from boot staged
before the kernel.  That's why the "disable unused" step disables
everything that wasn't acquired _in the kernel_ regardless of
what the boot loader may have done or what is enabled at reset.

> The other user of the clock is the
> ethernet driver, which we know cannot change it yet, because driver
> probing has not started yet.

I understand that the situation here is, that the ethernet driver
hasn't probed yet, but the clock driver did.  You are in early
setup code and want to (check and) fetch data from the hardware
which the ethernet driver later needs.

What's wrong with an explicit enable/disable around the data
acquisition?  This allows to reliably fetch and store the
information (into the device tree data?) for later use, and is
neutral to the enable counter.  If the clock was enabled before,
it remains enabled.  If the clock was disabled before, it will
get disabled again.  In any case clock only may be turned off
after you have grabbed the data, the data is only taken when it's
available and valid.

This approach of explicit enable/disable around data access only
breaks if the ethernet driver won't acquire its related clock
appropriately, which would be a bug in the ethernet driver that
should be easy to fix.  (Strictly speaking it's not the data
gathering that breaks, but the already broken network driver
which accesses the hardware without acquiring the clock, and not
finds the clock disabled.)


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
