From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 2 Jul 2013 13:17:58 -0400 (EDT)
Subject: [RFC PATCH 4/6] USB: ehci-omap: Suspend the controller during
 bus suspend
In-Reply-To: <51D28DB9.704@ti.com>
Message-ID: <Pine.LNX.4.44L0.1307021302430.1086-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2 Jul 2013, Roger Quadros wrote:

> On 07/02/2013 12:01 AM, Alan Stern wrote:
> > On Mon, 1 Jul 2013, Felipe Balbi wrote:
> > 
> >>> I don't know what Pad wakeup is.  The wakeup signal has to originate 
> >>> from the EHCI controller, doesn't it?  If not, how does the Pad know 
> >>> when a wakeup is needed?
> >>
> >> That's really an OMAP thing, I guess. Pad wakeup sits in the PRCM (IIRC)
> >> inside and always on power domain. EHCI sits in another power domain
> >> which be turned off. When it's turned off (power gated and clock gated)
> >> the EHCI block has no means to wakeup whatsoever. That's when pad wakeup
> >> comes into play. It is generated when PRCM sees a change in the actual
> >> pad of the die. To check who should 'own' the wakeup, it checks the
> >> muxing settings to verify whose pad is that.
> > 
> > How does the PRCM know which changes should generate wakeup events?  
> 
> It doesn't know. It will always generate a wakeup on any change in the monitored pins.
> We can only configure which pins we want to monitor.
> So we can't choose which wakeup events we want to monitor. We just can
> enable or disable all events.
> 
> > In the EHCI controller, this is managed by the settings of the WKOC_E,
> > WKDSCNNT_E, and WKCNNT_E bits in the PORTSC registers.  But if EHCI is
> > powered off, those bits can't be used.
> 
> Is "powered off" same as ehci_suspend? If yes then how does it work on other systems
> for remote wakeup?

Above, Felipe wrote that on OMAP, EHCI sits in a power domain which is
turned off: power gated and clock gated.  ehci_suspend() doesn't do
those things, but they are what I was referring to.

A PCI-based EHCI controller has two power sources: the core well (which
is turned off during suspend) and the auxiliary well (which remains
powered).  That's how remote wakeup works; it uses the auxiliary well.

> > Also, once the wakeup signal has been turned on, how does it get turned 
> > off again?
> 
> That is taken care of by the OMAP pinctrl driver. It will always turn off the
> wakeup signal once the event is detected and forwarded as an IRQ.
> 
> I know that all this is a bit ugly :(.

I still a little confused.  The wakeup signal turns on.  Then the
pinctrl driver sees it, forwards it as an IRQ, and turns the wakeup
signal off.  But what if the IRQ is disabled (as it would be with your
patch)?  Does the IRQ line remain active until it causes an interrupt?  
What eventually turns off the IRQ line?

Alan Stern
