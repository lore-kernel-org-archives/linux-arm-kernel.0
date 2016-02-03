From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 3 Feb 2016 10:45:34 -0500 (EST)
Subject: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
In-Reply-To: <CAPDyKFpNRc3Nf9ofXhZrfBa54vXMxWboDScCrYFrZy97m8Y5gg@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1602031034360.2041-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 3 Feb 2016, Ulf Hansson wrote:

> > Let me summarize my understanding of this thread so far.
> >
> > It looks like the omap3 code initializes hardware in ->probe() and
> > then it may return -EPROBE_DEFER due to some unmet dependencies.  In
> > that case the hardware is not reset to the previous state and the
> > runtime PM framework is left in the state that corresponds to the
> > current hardware state.  Before we had pm_runtime_reinit(), everything
> > worked as expected on the second ->probe() call, because things were
> > in sync then.
> 
> Correct!
> 
> Before pm_runtime_reinit(), the failing probe case (-EPROBE_DEFER)
> worked fine because the HW state and the runtime PM status was in
> sync. The device was powered and the runtime PM status was RPM_ACTIVE.
> 
> >
> > The introduction of pm_runtime_reinit() changed the situation and now
> > effectively the hardware is required to be reset to the initial state
> > if -EPROBE_DEFER is to be returned too.
> 
> Not correct. The hardware doesn't need a reset as it stays powered
> after a failed probe.
> 
> Instead, only the runtime PM status needs to be synchronized with the
> HW state the next probe attempt.

In other words, the probe routine assumes the actual state is the same
as the PM status.  This may have been true before pm_runtime_reinit()
came along, but it's not true now.

> In other words, when the PM domain's ->runtime_resume() callbacks gets
> called due to a pm_runtime_get_sync() in the second probe attempt, it
> may find that the HW is already powered and can return zero instead of
> resetting it.

What's wrong with going ahead and resetting the hardware anyway?

Alan Stern
