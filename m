From: oliver@neukum.org (Oliver Neukum)
Date: Wed, 12 Jun 2013 12:19:28 +0200
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <CACVXFVMQGqGNcKntLbpQSJN+mkVZoRTRNYZ+TMVSmnGwK7BiBQ@mail.gmail.com>
References: <Pine.LNX.4.44L0.1306111431170.1392-100000@iolanthe.rowland.org>
 <2722548.PBMM2Yn19A@linux-5eaq.site>
 <CACVXFVMQGqGNcKntLbpQSJN+mkVZoRTRNYZ+TMVSmnGwK7BiBQ@mail.gmail.com>
Message-ID: <3473222.45jKxS1jDK@linux-5eaq.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 June 2013 18:11:34 Ming Lei wrote:
> On Wed, Jun 12, 2013 at 5:11 PM, Oliver Neukum <oliver@neukum.org> wrote:
> > On Tuesday 11 June 2013 15:10:03 Alan Stern wrote:
> >> In order to prevent this from happening, you would have to change the
> >> spin_lock() call in the completion handler to spin_lock_irqsave().
> >> Furthermore, you will have to audit every USB driver to make sure that
> >> all the completion handlers get fixed.
> >
> > Yes. However, it can be done mechanically. And we know only
> > the handlers for complete need to be fixed.
> 
> I am wondering if the change is needed since timer function is still
> run in softirq context instead of hard irq.
> 
> Looks Alan concerned that one USB interface driver may have another
> hard interrupt handler involved. Is there such kind of USB driver/device
> in tree?

No. Suppose a USB network driver.
The complete() handler is written on the assumption that interrupts are off.
So it takes a spinlock from the network subsystem. It does so with spin_lock()

Other network drivers also take the lock. And they may take it from an IRQ handler.
If such an IRQ interrupts the tasklet complete() is running in, the CPU will deadlock.

The danger is not interrupt handlers in the same driver but IRQ handlers of _other_
drivers (PCI, ...) a lock is shared with.

You need to go through all USB drivers and change every spin_lock() that goes
for a lock that is exported to a spin_lock_irqsave()

	Regards
		Oliver
