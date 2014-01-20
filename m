From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 20 Jan 2014 16:48:10 +0100
Subject: [PATCH] ARM: shmobile: compile drivers/sh for
 CONFIG_ARCH_SHMOBILE_MULTI
In-Reply-To: <52DD224B.1050502@codethink.co.uk>
References: <1389707776-23306-1-git-send-email-ben.dooks@codethink.co.uk>
 <20140120125436.GN17314@sirena.org.uk> <52DD224B.1050502@codethink.co.uk>
Message-ID: <1482392.XFeYNLvUZH@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 January 2014 13:19:07 Ben Dooks wrote:
> I've added linux-arm-kernel to the list to get a wider view from
> people who actively use the clock subsystem.
> 
> On 20/01/14 12:54, Mark Brown wrote:
> > On Mon, Jan 20, 2014 at 12:01:00PM +0000, Ben Dooks wrote:
> >> On 20/01/14 11:47, Mark Brown wrote:
> >>> I think that just makes things more complicated and isn't adding
> >>> anything over pm_runtime_enable(), it's just boilerplate code.  In
> >>> theory essentially every driver running on platforms which don't have
> >>> explicit management of core IP clocks ought to be calling this since
> >>> potentially the IP might be deployed on another platform which does have
> >>> clock management (this does actually happen with things like the
> >>> DesignWare IPs) and it doesn't do anything like say which clocks are
> >>> expected to be managed in this way which is another thing that can come
> >>> up when moving devices between platforms.
> >> 
> >> That sounds like a real headache where you have two sets of code
> >> looking at possibly the same clocks, and behaving differently between
> >> different platforms.
> > 
> > Yup, it's usually only one set of code on the client side but it's
> > annoying that platform integrations aren't done consistently in hardware
> > and that this flows through into software.
> > 
> >>> I'm also struggling to see how it provides any sort of build time
> >>> protection, it would allow the generation of a warning at runtime at
> >>> best.
> >> 
> >> If you don't have the code it WILL NOT LINK. At the moment it is
> >> entirely possible to link a kernel which will produce a set of confusing
> >> errors as drivers fail to initialise at startup.
> > 
> > How will this prevent the code linking?  I would expect the "manage the
> > clocks via runtime PM" call to be a bit of core code, I wouldn't expect
> > it to be provided by a specific platform otherwise we're in for fail in
> > a multiplatform environment.  Besides, if it fails to link there's some
> > missing Kconfig anyway since randconfig is supposed to work.
> > 
> >> We've already had other people run into the issue where they do not
> >> know why a driver is failing to work (rcar-thermal is one) as the code
> >> that was managing the clock for it magically vanished during the
> >> development cycle.
> > 
> > I agree there's a usability problem here, I just don't think that this
> > is the best fix for it, I think it's breaking abstractions.
> > 
> >>> As far as I can tell the problem that Ben has seen here is that the
> >>> platform really, really needs the code for its power domains running to
> >>> be functional (this doesn't seem unreasonable and may not be related to
> >>> clocks, this may be required to have the IPs powered up at all).  I'd
> >>> expect this is something for the platform to sort out rather than
> >>> something for individual drivers to have to carry code for.
> >> 
> >> What's power domains got to do with this? You keep bringing this up
> >> but the error is purely to do with clock management. The code happens
> >> to be sitting in the drivers/base/pm directory, but could easily sit
> >> elsewhere.
> > 
> > What these platforms are saying is esssentially that the clocks are part
> > of the power domain - they're a fundamental part of getting the IP
> > available for use so there is no point in managing them separately.
> > This is where I think the abstraction problem is coming, to me it seems
> > like the platform isn't successfully ensuring that the code to manage
> > the power domain is there.  The fact that part of what's missing is the
> > clocks shouldn't matter to the drivers, in doing things like this the
> > platform is trying to abstract that detail away from the drivers.
> > 
> >>> If it was going to be drivers carrying code for this I would expect it
> >>> to be something like providing a list of clocks to be managed along with
> >>> runtime PM - this would also make the code more widely applicable since
> >>> it's quite common for the runtime PM callbacks to do nothing more than
> >>> just enable and disable clocks.
> >> 
> >> If we are really saying that bus clocks should not be managed
> >> by the drivers, then we should just enable this across the whole
> >> kernel and remove the management from any extant drivers (or make
> >> it so that any drivers that must manage their bus clocks have a
> >> call to do so).
> > 
> > Yes, I think that would be a useful way to go since it would factor out
> > some common code patterns that keep cropping up (as I suggested to you
> > previously).  It may not just be the main IP clocks that the drivers are
> > managing like this (some drivers end up managing other clocks at the
> > same time even if they could be more flexible) so if it was something
> > drivers could make use of themselves that'd be good.
> 
> At the moment, the code to actually use the support is sitting in
> drivers/sh and gets initialised if it is built. This is the source
> of the original confusions.
> 
> I think it would be ok if drivers could /opt out/

Most drivers have a single functional clock (if any) and only need it to be 
enabled/disabled in sync with runtime PM. As this requirements is common, 
making it the default sounds reasonable. Other drivers need to manage their 
clocks, or at least part of their clocks, manually. There are good and bad 
reasons for this, and some bad reasons come from driver code that should be 
fixed, but we can't ignore the problems for now.

The simplest implementation would be a way to let a driver opt-out completely. 
Unless a driver opts out, the runtime PM core will get the default clock for 
the device (with a NULL con ID) and manage it automatically. I'm not sure what 
to do when the runtime PM core fails to get the clock, as this can be caused 
by various problems or non-problems.

One particular problem that needs to be considered is deferred probing. An 
option would be to have all non-SoC devices opt-out from automatic clock 
management, but that will make the opt-out case the most common one. We also 
need to consider IP cores that can be present on-SoC or off-SoC in discrete 
chips.

The problem isn't as simple as it seems, and more advanced implementations 
that would allow listing clocks that should be managed automatically (or the 
other way around) would also add another level of complexity. The required 
information is platform-dependent, but we currently don't express it as such 
in DT.

> if the bus clock handling was done like this for all platforms and we simply
> noted that the pm code is doing it. At that point it would be nice just to
> build the code in drivers/base/power unconditionally.
> 
> At the moment we could quite easily enable this code for all the ARM
> platforms as the clk framework should deal nicely with properly balanced
> clk_enable() and clk_disable() calls.
> 
> Enabling it across the board would also remove any issues with changes in
> platform behaviour and find any bugs sooner rather than later.
-- 
Regards,

Laurent Pinchart
