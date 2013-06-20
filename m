From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 20 Jun 2013 13:33:05 -0400 (EDT)
Subject: [RFC PATCH 4/6] USB: ehci-omap: Suspend the controller during
 bus suspend
In-Reply-To: <51C2F70A.3040708@ti.com>
Message-ID: <Pine.LNX.4.44L0.1306201326100.2063-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Jun 2013, Roger Quadros wrote:

> > runtime_resume(dev)
> > {
> > 	...
> > 
> > 	if (omap->flags & OMAP_EHCI_IRQ_PENDING) {
> > 		process_pending_irqs(omap);
> 
> OK, thanks. 
> 
> But I'm not sure if the generic ehci_irq handler is able to
> run in a process context. Maybe if we replace spin_lock(&ehci->lock);
> with spin_lock_irqsave() there, it will work.
> 
> Alan is this a doable option?

ehci_irq() will work okay in process context, provided the caller 
disables interrupts.

But maybe none of this will be needed after Roger redesigns the
controller suspend to work at the right time.  Or if it is, we could
adopt a simpler alternative: the controller's resume routine could
always call usb_hcd_resume_root_hub().  After all, about the only
reason for doing a runtime resume of the controller is because the root
hub needs to do something.

Alan Stern
