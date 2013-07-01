From: balbi@ti.com (Felipe Balbi)
Date: Mon, 1 Jul 2013 19:49:20 +0300
Subject: [RFC PATCH 4/6] USB: ehci-omap: Suspend the controller during
 bus suspend
In-Reply-To: <Pine.LNX.4.44L0.1307011209440.1547-100000@iolanthe.rowland.org>
References: <51D13AED.4010307@ti.com>
 <Pine.LNX.4.44L0.1307011209440.1547-100000@iolanthe.rowland.org>
Message-ID: <20130701164920.GA31370@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 01, 2013 at 12:24:07PM -0400, Alan Stern wrote:
> On Mon, 1 Jul 2013, Roger Quadros wrote:
> 
> > On 06/28/2013 10:06 PM, Alan Stern wrote:
> > > On Fri, 28 Jun 2013, Roger Quadros wrote:
> > > 
> > >>> That's not what I meant.  Never mind the pinctrl; I was asking about
> > >>> the EHCI controller itself.  Under what circumstances does the
> > >>> controller assert its wakeup signal?  And how do you tell it to stop
> > >>> asserting that signal?
> > >>
> > >> I believe this would be through the EHCI Interrupt enable register (USBINTR).
> > >> I'm not aware of any other mechanism.
> > > 
> > > That's strange, because ehci_suspend() sets the intr_enable register to 
> > > 0.  So how do you ever get any wakeup interrupts at all?
> > 
> > Because after ehci_suspend() for OMAP, we solely rely on the out of band wake up
> > mechanism. i.e. Pad wakeup.
> 
> I don't know what Pad wakeup is.  The wakeup signal has to originate 
> from the EHCI controller, doesn't it?  If not, how does the Pad know 
> when a wakeup is needed?

That's really an OMAP thing, I guess. Pad wakeup sits in the PRCM (IIRC)
inside and always on power domain. EHCI sits in another power domain
which be turned off. When it's turned off (power gated and clock gated)
the EHCI block has no means to wakeup whatsoever. That's when pad wakeup
comes into play. It is generated when PRCM sees a change in the actual
pad of the die. To check who should 'own' the wakeup, it checks the
muxing settings to verify whose pad is that.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130701/b515cd6c/attachment.sig>
