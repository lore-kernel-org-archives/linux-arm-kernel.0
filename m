From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 5 Aug 2011 12:33:31 -0700
Subject: [RFC PATCH 0/3] If an IRQ is a GPIO, request and configure it
In-Reply-To: <20110805191504.GB28958@n2100.arm.linux.org.uk>
References: <1312498820-2275-1-git-send-email-swarren@nvidia.com>
	<20110805094017.GC20575@n2100.arm.linux.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF049F171EFC@HQMAIL01.nvidia.com>
	<20110805191504.GB28958@n2100.arm.linux.org.uk>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049F171FD3@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote at Friday, August 05, 2011 1:15 PM:
> On Fri, Aug 05, 2011 at 08:43:20AM -0700, Stephen Warren wrote:
> > Russell King - ARM Linux wrote at Friday, August 05, 2011 3:40 AM:
> > > On Thu, Aug 04, 2011 at 05:00:17PM -0600, Stephen Warren wrote:
> > > > In http://www.spinics.net/lists/linux-tegra/msg01731.html, Mark Brown
> > > > pointed out that it was a little silly forcing every board or driver
> > > > to gpio_request() a GPIO that is later converted to an IRQ, and passed
> > > > to request_irq. The first patch in this series instead makes the core
> > > > IRQ code perform these calls when appropriate, to avoid duplicating it
> > > > everywhere.
> > >
> > > Trying to go from IRQ to GPIO is not a good idea - most of the
> > > IRQ <-> GPIO macros we have today are just plain broken.  Many of them
> > > just add or subtract a constant, which means non-GPIO IRQs have an
> > > apparant GPIO number too.  Couple this with the fact that all positive
> > > GPIO numbers are valid, and this is a recipe for wrong GPIOs getting
> > > used and GPIOs being requested for non-GPIO IRQs.
> > >
> > > I think this was also discussed in the past, and the conclusion was that
> > > IRQs should be kept separate from GPIOs.  Maybe views have changed since
> > > then...
> > >
> > > However, if we do want to do this, then it would be much better to provide
> > > a new API for requesting GPIO IRQs, eg:
> > >
> > > gpio_request_irq()
> > >
> > > which would wrap around request_threaded_irq(), takes a GPIO number,
> > > does the GPIO->IRQ conversion internally, and whatever GPIO setup is
> > > required.  Something like this:
> >
> > With that approach, drivers need to explicitly know whether they're
> > passed a GPIO or an IRQ, and do something different, or they need to
> > choose to only accept a GPIO or IRQ.
> 
> You completely missed the biggest reason why your approach is broken.

No, I didn't.

I was discussing whether an alternative API for IRQ registration
would work, and I was pointing out some problems with it.

That has nothing to do with whether my original proposal is workable.

-- 
nvpublic
