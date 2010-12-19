From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 19 Dec 2010 23:39:10 +0000
Subject: [PATCH 0/13] 64-bit sched_clock
In-Reply-To: <AANLkTik0zkpUUvrv8YmxGd_=vMaKR42KbJnd4BqHqias@mail.gmail.com>
References: <20101216092527.GL9937@n2100.arm.linux.org.uk>
	<20101216130411.GR9937@n2100.arm.linux.org.uk>
	<AANLkTik0zkpUUvrv8YmxGd_=vMaKR42KbJnd4BqHqias@mail.gmail.com>
Message-ID: <20101219233910.GA816@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 19, 2010 at 11:23:02PM +0100, Linus Walleij wrote:
> 2010/12/16 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> 
> > I can provide an init_early() method in the machine description which
> > setup_arch() can call as the last thing it does - this will happen
> > after the ->reserve and ->map_io callbacks, but before interrupts and
> > timers have been setup. ?This is the ideal time to setup the
> > sched_clock(). ?However, that means digging through lots of arch code
> > to sort out what can be moved where, and that's going to be inherently
> > unreliable.
> >
> > I think init_early() has merit in other ways - it'll allow us to remove
> > crap from the ->map_io callbacks which is doing stuff like registering
> > clk structures and so forth.
> 
> I agree. I was contemplating a clock_init() or similar a way back
> for setting up clock trees early. We would have to move clock tree
> registration in front of the init_sched_clock() call in the init_early()
> handler in many cases since the rate often comes from the clock
> framework, but this is indeed where it belongs.

Yes, that was indeed one of the subsystems that I thought platforms
should initialize there - one of my motivations is in connection with
6433/1 and 6434/1.

If we have everyone setting up their clock subsystems in init_early,
then we can have both the TWD and SP804 always getting their clock
rates from the clk API, rather than having the conditional approach
in those two patches.
