From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 14 Jun 2013 16:01:53 -0400 (EDT)
Subject: [PATCh V10 04/12] usb: ehci: ehci-mv: use PHY driver for ehci
In-Reply-To: <51BADD6D.5040600@ti.com>
Message-ID: <Pine.LNX.4.44L0.1306141553030.3152-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Jun 2013, Roger Quadros wrote:

> >> hi
> >> The following is my understanding.
> >> I think for PHY initialization and shutdown part, it is generic for
> >> other parts.
> >> PHY initialization need to be called before hc_driver->reset is called.
> >> I think it can be added at usb_add_hcd.
> >> For PHY shutdown, it can be added at usb_remove_hcd.
> > 
> > Yes, that should work.
> 
> I don't think this will work with OMAP USB host controller when used in
> Transceiver-less mode (e.g. HSIC). In this mode we need to release the HSIC
> reset (mapped to PHY init), after the EHCI controller is up and running.
> 
> On the other hand, in the PHY mode, the PHY needs to be initialized (brought out
> of reset) before the EHCI controller starts.

In other words, transceiver-less mode effectively works without using a 
software-controlled PHY?

> This behavior might be different on other controllers. Generalization is good
> as long as there is an override available for the controllers to handle the
> PHY init/shutdown themselves.

To avoid PHY init/shutdown, the platform driver should simply leave the 
generic PHY pointer (which has not yet been added to struct hcd) set to 
NULL.

> >> For suspend/resume, i do not know how to add it. For our EHCI driver,
> >> when system goes to deep idle states, we just directly shutdown the
> >> hcd and initialize it again when the system goes back.
> > 
> > You shut down the host controller?  Then how does it detect wakeup 
> > events?  And how does it know if a device was disconnected while the 
> > power was off?
> > 
> 
> On OMAP as well we are aiming to cut clocks to the host controller (state saved)
> during bus/system suspend. PHY is in low power mode capable of detecting wakeup events.
> The SoC is configured to wake up on any I/O activity on the PHY pins. Upon
> detection of PHY related I/O event, SoC wakes up, we restore the host controller state
> and proceed as normal.

Maybe it's just me, but turning off USB Vbus power during suspend seems
like a bad idea.  Except for the case where all the root-hub ports are 
disabled (such as when no devices are plugged in) -- in that case it's 
fine.

But turning off power to an enabled device should be avoided, even
though the kernel does a decent job of recovering when this happens.  
Not all devices respond well to this sort of treatment.

Alan Stern
