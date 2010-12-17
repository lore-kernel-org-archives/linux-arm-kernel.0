From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Dec 2010 19:05:54 +0000
Subject: [PATCH 28/40] ARM: sched_clock: provide common infrastructure
	for sched_clock()
In-Reply-To: <alpine.LFD.2.00.1012171334530.10437@xanadu.home>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
	<E1PTYmu-0006jS-Na@rmk-PC.arm.linux.org.uk>
	<alpine.LFD.2.00.1012171334530.10437@xanadu.home>
Message-ID: <20101217190554.GD9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 17, 2010 at 01:51:35PM -0500, Nicolas Pitre wrote:
> On Fri, 17 Dec 2010, Russell King - ARM Linux wrote:
> 
> > Provide common sched_clock() infrastructure for platforms to use to
> > create a 64-bit ns based sched_clock() implementation from a counter
> > running at a non-variable clock rate.
> > 
> > This implementation is based upon maintaining an epoch for the counter
> > and an epoch for the nanosecond time.  When we desire a sched_clock()
> > time, we calculate the number of counter ticks since the last epoch
> > update, convert this to nanoseconds and add to the epoch nanoseconds.
> > 
> > We regularly refresh these epochs within the counter wrap interval.
> > We perform a similar calculation as above, and store the new epochs.
> > 
> > We read and write the epochs in such a way that sched_clock() can easily
> > (and locklessly) detect when an update is in progress, and repeat the
> > loading of these constants when they're known not to be stable.  The
> > one caveat is that sched_clock() is not called in the middle of an
> > update.
> 
> How is this ensured?  I think this is currently a problem.
> 
> Right now there is nothing that prevents  update_sched_clock() from 
> being interrupted in the middle of cd->epoch_cyc and cd->epoch_cyc_copy.  
> Let's say an interrupt happens when those two are different.
> 
> Within an interrupt handler, you may find calls to printk(), which may 
> also end up calling sched_clock() for time stamping. The sched_clock() 
> function will call cyc_to_fixed_sched_clock() which will deadlock.
> 
> Maybe you should at least mask interrupts in update_sched_clock() so 
> that the epoch update is not interruptible.

I left this for you to find, as I knew you wouldn't be satisfied without
finding some hole in my scheme. ;)

Yes, you're right, it should disable local IRQs across the update.  Thanks
for spotting.
