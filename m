From: tony@atomide.com (Tony Lindgren)
Date: Sat, 23 Dec 2017 08:36:51 -0800
Subject: [RFC PATCH v2 1/3] PCI: rockchip: Add support for pcie wake irq
In-Reply-To: <20171222232043.GA158981@google.com>
References: <20170817120431.12398-1-jeffy.chen@rock-chips.com>
 <20170817120431.12398-2-jeffy.chen@rock-chips.com>
 <20170818170107.GA119461@google.com>
 <20170818181416.GF6008@atomide.com>
 <5997486D.4040803@rock-chips.com>
 <20170822172653.GJ6008@atomide.com>
 <599CDB37.3070307@rock-chips.com>
 <20171219004811.GA216620@google.com>
 <20171220191912.GM3875@atomide.com>
 <20171222232043.GA158981@google.com>
Message-ID: <20171223163651.GD3875@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Brian Norris <briannorris@chromium.org> [171222 23:23]:
> + Rafael to this thread
> 
> On Wed, Dec 20, 2017 at 11:19:12AM -0800, Tony Lindgren wrote:
> > * Brian Norris <briannorris@chromium.org> [171219 00:50]:
> > > On Wed, Aug 23, 2017 at 09:32:39AM +0800, Jeffy Chen wrote:
> > > 
> > > Did this problem ever get resolved? To be clear, I believe the problem
> > > at hand is:
> > > 
> > > (a) in suspend/resume (not runtime PM; we may not even have runtime PM
> > > support for most PCI devices)
> > 
> > It seems it should be enough to implement runtime PM in the PCI
> > controller. Isn't each PCI WAKE# line is wired from each PCI device
> > to the PCI controller?
> 
> No, not really. As discussed in later versions of this thread already,
> the WAKE# hierarchy is orthogonal to the PCI hierarchy, and I think we
> settled that it's reasonable to just consider this as a 1-per-device
> thing, with each device "directly" attached to the PM controller. While
> sharing could happen, that's something we decided to punt on...didn't
> we?

Sounds like we need a confirmation from some hardware people on
this if the PCI device WAKE# can be wired to PCI controller or
to a separate PM controller directly :)

> > Then the PCI controller can figure out from which PCI device the
> > WAKE# came from.
> 
> I'm not completely sure of the details, but I believe this *can* be
> determined by PME. But I'm not sure it's guaranteed to be supported,
> especially in cases where we already have 1:1 WAKE#. So we should be
> *trying* to report this wakeirq info from the device, if possible.

If a PCI device has it's WAKE# wired directly to a PM controller
instead of the PCI controller, then it seems that the PCI controller
should be woken up and then presumably the regular PCI device
interrupts will take care of the rest.

Or else I'd say if the driver for the PCI device in some custom
case needs to do something specific, then having that driver
implement PM runtime makes sense. Naturally we want to avoid a
dependency where all the possible drivers would need to implement
PM runtime, I doubt that's needed though.

Regards,

Tony
