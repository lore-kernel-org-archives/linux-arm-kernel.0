From: mturquette@baylibre.com (Michael Turquette)
Date: Fri, 28 Aug 2015 15:53:49 -0700
Subject: [RESEND PATCH v16 4/4] ARM: dts: add the support power-domain
 node on RK3288 SoCs
In-Reply-To: <CAD=FV=UrWauwX143MSZpus=L7N__jL1dU-FwaE8BU7wi=Lu2Qg@mail.gmail.com>
References: <1440487486-6154-1-git-send-email-wxt@rock-chips.com>
 <1440487486-6154-5-git-send-email-wxt@rock-chips.com>
 <7hfv37axhj.fsf@deeprootsystems.com>
 <CAD=FV=V6oG+9U=W_JZmqCuNo-9-5wW8ffZzG7ZE_3cnSTNAjFQ@mail.gmail.com>
 <7htwrn6l7g.fsf@deeprootsystems.com>
 <CAKdAkRS=9Dq+YpMNSjpij0Am4ZD6uUURv74OLLYf+akD=W885A@mail.gmail.com>
 <7hmvxc45w2.fsf@deeprootsystems.com>
 <CAD=FV=VTR-PBcXXX1jHNw65x_cMP9CKwVWBs+XCcFqFPp7msjA@mail.gmail.com>
 <20150828200238.30921.24441@quantum>
 <CAD=FV=UrWauwX143MSZpus=L7N__jL1dU-FwaE8BU7wi=Lu2Qg@mail.gmail.com>
Message-ID: <20150828225349.11508.41285@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Doug Anderson (2015-08-28 14:08:52)
> Mike,
> 
> On Fri, Aug 28, 2015 at 1:02 PM, Michael Turquette
> <mturquette@linaro.org> wrote:
> > Hi Doug,
> >
> > Quoting Doug Anderson (2015-08-27 19:03:20)
> >> Kevin,
> >>
> >> On Thu, Aug 27, 2015 at 5:24 PM, Kevin Hilman <khilman@kernel.org> wrote:
> >> >> That is not really workable: the attach and detach happen in
> >> >> probe/remove path; if you do not have driver for the device you will
> >> >> miss the clocks for it.
> >> >
> >> > And in my proposal, I suggested that clocks without drivers are
> >> > good candidates to list in the domain, with the caveat that the be
> >> > called out (documented) as being device clocks that are missing a
> >> > driver, so when a driver shows up they can be moved accordingly, and in
> >> > a way that actually describes the hardware.
> >>
> >> What happens if someone disables the driver using the CONFIG subsystem?
> >
> > Kevin asked me to chime in on this thread, as I have a half-baked idea
> > that might solve the problem posed by your question above.
> >
> > One thing I have been considering for a while is a fallback compatible
> > string that can be used for an IP block when either there is no driver
> > loaded or no driver exists at all. Something like "generic-ip-block".
> >
> > The purpose of this compatible string is to allow us to model resource
> > consumption in dts accurately, regardless of whether or not a proper
> > driver has been written in Linux. This idea was born out of the
> > simple-fb binding/driver discussion last year[0].
> >
> > Obviously such a binding would not enable any of the logic or function
> > of that IP block; that would require a proper driver. But it would allow
> > us to properly link system-wide resources that are consumed: the
> > generic-ip could consume clocks and regulators, it could belong to power
> > domains, etc. For this reason I have also thought that
> > "generic-resource-consumer" is an accurate compatible string.
> >
> > This spares us from having to encode nasty details into the power domain
> > binding, which is exactly what would happen if you needed a dedicated
> > list of clocks in the power domain node that were not claimed by device
> > nodes/drivers.
> >
> > Note that a real driver might exist for an IP block, but if that driver
> > is disabled in Kconfig AND the corresponding dt node has this fallback
> > compatible string, then we could be OK, from the perspective of the
> > power domain problem.
> 
> OK, so that could solve the "Kconfig" problem.
> 
> 
> >> What happens if this is a device that someone has set to 'status =
> >> "disabled";' in the device tree?
> >
> > If someone does that, then I think we should let that break power domain
> > transitions.
> 
> So if you're on a board that doesn't use EDP but uses LVDS then their
> suspend/resume should be broken?
> 
> Specifically, it's my understanding that on this SoC:
> 
> 1. There's a single "video IO" power domain that contains things like
> the video output processor, EDP, LVDS, HDMI, etc.
> 
> 2. When you turn on/off the power domain it's important to clock all
> devices in the domain during the reset.
> 
> 3. If you don't clock all devices during the reset they get left in a
> "wedged" state.
> 
> 4. If you try to do things like suspend/resume it will query all
> devices.  If they've been left in the wedged state then suspend/resume
> will be blocked.
> 
> ...so this problem is still not solved.

I talked to Kevin about this and we both agree that the power domain's
use of the clock consumer binding is totally valid. So I still think
there might be a use for the generic-ip binding, but I also think the
solution in this original patch also looks sane.

A paraphrase of my discussion with Kevin is that we can think of both
the device (EDP, LVDS) and the power domain as clock consumers, so
basically there is nothing weird going on here. Feel free to add:

Reviewed-by: Michael Turquette <mturquette@baylibre.com>

I do also agree with Kevin that we have a lot of layering issues to
consider here with description of PM hardware, and there are temptations
to take the shortest route to get things working. Truly modeling
relationships is the best way forward and we need to keep that in mind
over the long haul.

> 
> >> Even if the device is disabled in one of those two ways, we still need
> >> the clocks to be turned on.  ...so if we turn on/off the VIO domain we
> >> need to turn on the EDP clock even if there's no EDP in the current
> >> board / config.  We might turn on/off VIO for one of the other devices
> >> in the VIO domain for one of the other devices in VIO that we are
> >> using.
> >
> > I'm hesitant to mention this but I am working on a patch series to
> > implement a clock "handoff" mechanism (also inspired by the simplefb
> > discussion). This allows us to set a per-clock flag that tells the
> > framework to enable that clock at registration time, and then the first
> > clock consumer driver to come along and claim that clock inherits that
> > clock enable reference count.
> >
> > I'm working on v2 that lets us set this flag from DT, but I really only
> > plan to do this for special cases. For the normal case the flag should
> > be set in the Linux clock provider driver. In the mean time v1 is under
> > discussion[1].
> 
> In this case if we're using LVDS and HDMI on a system, we don't want
> the EDP clock always on (that just wastes power).  We just need to
> clock it for the power domain transition.
> 
> 
> Note that nothing in the above solves the problem that not all clocks
> for a given device need to be turned on during power domain
> transitions.  If we're trying to describe hardware perfectly, we'd
> really need to add to each device:
> 
> clocks = <clk1>, <clk2>, <clk3>, ...
> clock-names = "name1", "name2", "name3", ...
> clocks-for-power-domain-transition = "name2", "name3";
> 
> ...since perhaps the clock named "name1" isn't required for power
> domain transitions and so shouldn't be turned on.  Note that once
> we're going through and adding a special list, it doesn't seem that
> different than just adding the list in the power domain node instead
> (other than being more complex).

Yes, this is a broader issue with mapping clocks onto consumer use
cases. The same is exactly true for any consumer driver that consumes
multiple clocks and enables/disables them differently (e.g. interface
clocks versus functional clocks). How to convey that in DT?

Regards,
Mike
