From: oliver@neukum.org (Oliver Neukum)
Date: Tue, 11 Jun 2013 12:51:41 +0200
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <CACVXFVMxAddaHdjfi2rOOEW46-XA3KozULjFtLvEpo-MZC7+Aw@mail.gmail.com>
References: <CACVXFVNdy_cffR7JYNVfs40QJ9eF4Y8UKL7ZsRPOTOegghFkaQ@mail.gmail.com>
 <1888740.dKYctKO5at@linux-5eaq.site>
 <CACVXFVMxAddaHdjfi2rOOEW46-XA3KozULjFtLvEpo-MZC7+Aw@mail.gmail.com>
Message-ID: <4881808.FBe1KpJCmT@linux-5eaq.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 June 2013 17:27:28 Ming Lei wrote:
> On Tue, Jun 11, 2013 at 4:49 PM, Oliver Neukum <oliver@neukum.org> wrote:
> > On Tuesday 11 June 2013 16:14:25 Ming Lei wrote:

> > The driver itself may have submitted a timer and race against it.
> > What locking do you need in complete() and a timer to lock against
> > each other?
> 
> Good catch.
> 
> The problem will come if only spin_lock() is called inside complete(),
> I will check main USB drivers in tree to see if there is such use case.

All network drivers race against timeout. I think they just unlink the URB,
but there's a lot of them.

> > But it makes no sense to go to a tasklet when you are already in task context.
> > In those cases you need to do something, essentially blocking the tasklet.
> 
> At least now, always doing complete() in tasklet handler can simplify
> implementation since these cases aren't in hot path.

Well, I am afraid this is not simply the case. These cases are partially
synchronous. For example you need to make sure all calls to complete()
are finished before you disconnect a HCD itself. The same applies to a device
being disconnected.

It the same area, what happens if an URB is unlinked between the irq handler
and the tasklet?

	Regards
		Oliver
