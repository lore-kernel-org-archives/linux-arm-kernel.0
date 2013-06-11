From: oliver@neukum.org (Oliver Neukum)
Date: Tue, 11 Jun 2013 09:18:42 +0200
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <CACVXFVMNzwD44mhKijURSWrqLKjy7_oOY8hrTtjbyOxGS2tv=g@mail.gmail.com>
References: <CACVXFVNdy_cffR7JYNVfs40QJ9eF4Y8UKL7ZsRPOTOegghFkaQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1306101316020.1133-100000@iolanthe.rowland.org>
 <CACVXFVMNzwD44mhKijURSWrqLKjy7_oOY8hrTtjbyOxGS2tv=g@mail.gmail.com>
Message-ID: <21763864.rYYOf1P6VP@linux-5eaq.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 June 2013 13:40:20 Ming Lei wrote:
> On Tue, Jun 11, 2013 at 1:36 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Mon, 10 Jun 2013, Ming Lei wrote:

> If complete() callback runs in one tasklet context, spin_lock() inside
> complete() is enough, just like hard irq, the tasklet itself is disabled
> during complete(), if the percpu tasklet is converted to single tasklet.
> So no problem when the lock is to protect shared resources between
> complete().

We also have exclusion between complete() and other contexts, i.e. timers.

> When the lock is to protect shared resources between complete() and
> non-IRQ context, currently spin_lock_irqsave() is used in non-IRQ
> context, which is enough to prevent tasklet from being run on the CPU,
> so no problem for this situation too.
> 
> When all HCDs support to run URB giveback in tasklet context, we can
> change all spin_lock_irq*() to spin_lock() in drivers URB->complete(), and
> in other places, the spin_lock_irq*() can be changed to spin_lock_bh().

Even now we cannot guarantee that all calls to complete() are in irq.
There is the case of HCD hotunplug and other cases, like timeouts.
They will have to be verified.

	Regards
		Oliver
