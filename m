From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 1 Jul 2013 12:24:07 -0400 (EDT)
Subject: [RFC PATCH 4/6] USB: ehci-omap: Suspend the controller during
 bus suspend
In-Reply-To: <51D13AED.4010307@ti.com>
Message-ID: <Pine.LNX.4.44L0.1307011209440.1547-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 1 Jul 2013, Roger Quadros wrote:

> On 06/28/2013 10:06 PM, Alan Stern wrote:
> > On Fri, 28 Jun 2013, Roger Quadros wrote:
> > 
> >>> That's not what I meant.  Never mind the pinctrl; I was asking about
> >>> the EHCI controller itself.  Under what circumstances does the
> >>> controller assert its wakeup signal?  And how do you tell it to stop
> >>> asserting that signal?
> >>
> >> I believe this would be through the EHCI Interrupt enable register (USBINTR).
> >> I'm not aware of any other mechanism.
> > 
> > That's strange, because ehci_suspend() sets the intr_enable register to 
> > 0.  So how do you ever get any wakeup interrupts at all?
> 
> Because after ehci_suspend() for OMAP, we solely rely on the out of band wake up
> mechanism. i.e. Pad wakeup.

I don't know what Pad wakeup is.  The wakeup signal has to originate 
from the EHCI controller, doesn't it?  If not, how does the Pad know 
when a wakeup is needed?


> We can't enable_irq at the start as the controller will only be resumed
> after usb_remote_wakeup().

Hmmm, yes, I had realized that at one point and then forgot it.  You
don't want an IRQ to arrive before you're prepared to handle it.

This suggests that you really want to call enable_irq() call at the end
of ehci_resume() instead of the beginning.  (Convert the "return 0" to
a jump to the end of the routine.)

Alan Stern
