From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 11 Feb 2011 15:36:15 -0500 (EST)
Subject: [PATCH] PM: Allow pm_runtime_suspend() to succeed during system
	suspend
In-Reply-To: <201102112100.23996.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.1102111514180.2048-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Feb 2011, Rafael J. Wysocki wrote:

> > The reason why runtime suspend is not allowed during system power transitions
> > if the following race:
> > 
> > - A device has been suspended via a system suspend callback.
> > - The runtime PM framework executes a (scheduled) suspend on that device,
> >   not knowing that it's already been suspended, which potentially results in
> >   accessing the device's registers in a low-power state.
> > 
> > Now, it can be avoided if every driver does the right thing and checks whether
> > the device is already suspended in its runtime suspend callback, but that would
> > kind of defeat the purpose of the runtime PM framework, at least partially.
> 
> In fact, I've just realized that the above race cannot really occur, because
> pm_wq is freezable, so I'm proposing the following change.

Yes, I had reached essentially the same conclusion.  Of course, there 
may still be other kernel threads running or interrupt handlers that 
can interfere.  It's probably okay to assume that drivers will handle 
these things.

> Of course, it still doesn't prevent user space from disabling the runtime PM
> framework's helpers via /sys/devices/.../power/control.

True.  So in the end this won't make much difference, but we might as 
well do it.

Alan Stern
