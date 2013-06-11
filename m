From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 11 Jun 2013 15:10:03 -0400 (EDT)
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <CACVXFVMNzwD44mhKijURSWrqLKjy7_oOY8hrTtjbyOxGS2tv=g@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1306111431170.1392-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Jun 2013, Ming Lei wrote:

> >> Is there any good reason to do URB giveback with interrupt disabled?
> >
> > That's a good question.  Offhand I can't think of any drivers that rely
> > on this -- although there certainly are places where callback routines
> > use spin_lock() rather than spin_lock_irq() or spin_lock_irqsave(),
> > because they know that interrupts are already disabled.
> 
> Complete() may take long time, for example in UVC's driver, URB's
> complete() may take more than 3 ms, as reported in below link:
> 
>       http://marc.info/?t=136438111600010&r=1&w=2
> 
> Also complete() is provided by interface driver, and it does many driver
> specific works, so it isn't good to disable interrupt only for one driver.

You probably mean "it isn't good to disable interrupts for the sake of
only one driver".  As things stand now, we disable interrupts for all 
callbacks in all drivers.

> If complete() callback runs in one tasklet context, spin_lock() inside
> complete() is enough, just like hard irq, the tasklet itself is disabled
> during complete(), if the percpu tasklet is converted to single tasklet.
> So no problem when the lock is to protect shared resources between
> complete().
> 
> When the lock is to protect shared resources between complete() and
> non-IRQ context, currently spin_lock_irqsave() is used in non-IRQ
> context, which is enough to prevent tasklet from being run on the CPU,
> so no problem for this situation too.
> 
> When all HCDs support to run URB giveback in tasklet context, we can
> change all spin_lock_irq*() to spin_lock() in drivers URB->complete(), and
> in other places, the spin_lock_irq*() can be changed to spin_lock_bh().

I don't follow your reasoning.  Consider the following situation, where
the same spinlock is used in both a URB completion handler and an
interrupt handler:

	URB completes
	A tasklet calls the completion handler, with interrupts enabled
	The completion handler does
		spin_lock(&lock);
	An interrupt occurs
	The interrupt handler does
		spin_lock(&lock);	// Deadlock!

In order to prevent this from happening, you would have to change the
spin_lock() call in the completion handler to spin_lock_irqsave().  
Furthermore, you will have to audit every USB driver to make sure that
all the completion handlers get fixed.

> > However, changing a documented API is not something to be done lightly.
> > You would have to audit _every_ USB driver to make sure no trouble
> > would arise.
> 
> OK, I will write patch to request for changing the API if the improvement
> on the situation isn't objected.

I don't mind.  But don't be surprised if you end up breaking some
drivers.

> In fact, at least now, the change on API is only about document change, and
> no drivers' change is required, isn't it?  We can describe that URB->complete()
> might run in hard irq or softirq context, depends on HCD_BH flag of
> hcd->driver->flags.

The drivers _do_ need to be changed, as explained above.  And that
explanation was only one failure scenario.  There may be others.

> Even with current code, one HCD's interrupt handling still may delay
> the handling for another HCD interrupt handling for quite long, that is
> the motivation to decrease the interrupt handling time of USB HCD, ;-)
> And finally, USB HCDs themselves will benefit from the change, won't they?

How will they benefit?  Merely from not releasing their private locks?  
That involves a fairly small amount of code.

> >> For async transfer, generally, it should have no effect since there should
> >> have URBs queued on the qh queue before submitting URB.
> >
> > That's not how the Bulk-Only mass-storage protocol works.  There are
> > times when the protocol _requires_ bulk packets not to be submitted
> > until a particular URB has completed.
> 
> Yes, I agree. But mass-storage driver itself is very fragile, it will perform
> badly if CPU has a higher load.

Why does that make it fragile?  _Every_ driver and program will behave
worse when the system is under a heavy load.

>  And it is better to submit DATA/CSW
> transfer in previous transfer's complete(), IMO.

Actually, it would be even better to submit DATA _before_ the CBW
completes, and to submit the CSW before submitting DATA-OUT.  
Unfortunately, the design of the SG library makes it impossible to
submit the CSW during DATA-IN completion.

> Compared with "usb-storage" task's schedule latency, the tasklet
> schedule delay should be lower at most of situations since the tasklet
> is scheduled inside irq handler.

True.  But the two latencies add.

> So I decided to replace the percpu tasklet with one single tasklet,
> which can avoid the problem.

Hmmm.  What happens when there is more than one host controller?  The 
tasklet will give back only one URB at a time, and it won't run on more 
than one CPU at a time.  The existing drivers allow URBs to be given 
back on multiple CPUs simultaneously.

> Also the tasklet running in CPU0 can handle the work which should
> have been done by the same tasket scheduled in CPU1,  so we can
> avoid busy-waitting in CPU1 which may be introduced by tasklet_schedule()
> in CPU1.

Or you could have a separate tasklet for each host controller.

Alan Stern
