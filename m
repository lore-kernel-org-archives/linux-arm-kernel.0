From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 15 Jan 2011 16:21:21 +0000
Subject: Locking in the clk API
In-Reply-To: <20110115160329.GD6917@pengutronix.de>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111091607.GI12552@n2100.arm.linux.org.uk>
	<4D2D184A.8020405@codeaurora.org>
	<20110112090301.GS11039@n2100.arm.linux.org.uk>
	<4D31A8F1.4080301@weinigel.se>
	<20110115145358.GC15996@n2100.arm.linux.org.uk>
	<20110115150331.GB6917@pengutronix.de>
	<20110115151507.GD15996@n2100.arm.linux.org.uk>
	<20110115160329.GD6917@pengutronix.de>
Message-ID: <20110115162121.GI15996@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 15, 2011 at 05:03:29PM +0100, Uwe Kleine-K?nig wrote:
> On Sat, Jan 15, 2011 at 03:15:07PM +0000, Russell King - ARM Linux wrote:
> > No - I've been suggesting for about a week now about doing two entirely
> > separate consolidations.
> I didn't read that out of your mails.

It was actually four days ago:
| Maybe another approach for the time being is to unify in two steps: first
| unify the implementations which use a spinlock - and those which can use
| a spinlock, and separately those which must use a mutex.
| 
| Then this issue can be revisited in the future.

> > I think it would be insane to do the consolidation of the two different
> > implementations in one patch or even one patch set.  There needs to be
> > a consolidation of spinlock-based clks as one patch set, which is
> > entirely separate and independent from the consolidation of mutex-based
> > clks.
> I think they should share most of the code.  Apart from calling
> different locking functions they should be pretty much identical, no?

That way you get unions of mutexes and spinlocks (which is one thing
we're trying to avoid) and conditionals controlling whether a mutex
or spinlock is taken - which we've already ascertained was strongly
objected to by folk in mainline (and quite rightfully so IMHO.)

> > What if one of the consolidations turns out to be a problem?  Do we want
> > to throw both out, or do we want to keep as much as we possibly can?
> Do you really expect fundamental problems that make it necessary to
> switch all platforms that use the (say) sleeping variant back to their
> original implementation?  I don't think that when the general idea of
> using clk_ops prooves for the atomic case it cannot happen that a
> "native" implementation for a sleeping clk is better that a sleeping
> clk_ops implementation.

I'm saying keep all the options open until we've got the whole thing
sorted out.  If you think it's possible to do without creating a mess
in the process - and without unions of mutexes and spinlocks or
conditionals controlling whether we use mutex_lock vs spin_lock then
please show the patches.
