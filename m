From: mturquette@linaro.org (Michael Turquette)
Date: Fri, 28 Aug 2015 13:02:38 -0700
Subject: [RESEND PATCH v16 4/4] ARM: dts: add the support power-domain
 node on RK3288 SoCs
In-Reply-To: <CAD=FV=VTR-PBcXXX1jHNw65x_cMP9CKwVWBs+XCcFqFPp7msjA@mail.gmail.com>
References: <1440487486-6154-1-git-send-email-wxt@rock-chips.com>
 <1440487486-6154-5-git-send-email-wxt@rock-chips.com>
 <7hfv37axhj.fsf@deeprootsystems.com>
 <CAD=FV=V6oG+9U=W_JZmqCuNo-9-5wW8ffZzG7ZE_3cnSTNAjFQ@mail.gmail.com>
 <7htwrn6l7g.fsf@deeprootsystems.com>
 <CAKdAkRS=9Dq+YpMNSjpij0Am4ZD6uUURv74OLLYf+akD=W885A@mail.gmail.com>
 <7hmvxc45w2.fsf@deeprootsystems.com>
 <CAD=FV=VTR-PBcXXX1jHNw65x_cMP9CKwVWBs+XCcFqFPp7msjA@mail.gmail.com>
Message-ID: <20150828200238.30921.24441@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

Quoting Doug Anderson (2015-08-27 19:03:20)
> Kevin,
> 
> On Thu, Aug 27, 2015 at 5:24 PM, Kevin Hilman <khilman@kernel.org> wrote:
> >> That is not really workable: the attach and detach happen in
> >> probe/remove path; if you do not have driver for the device you will
> >> miss the clocks for it.
> >
> > And in my proposal, I suggested that clocks without drivers are
> > good candidates to list in the domain, with the caveat that the be
> > called out (documented) as being device clocks that are missing a
> > driver, so when a driver shows up they can be moved accordingly, and in
> > a way that actually describes the hardware.
> 
> What happens if someone disables the driver using the CONFIG subsystem?

Kevin asked me to chime in on this thread, as I have a half-baked idea
that might solve the problem posed by your question above.

One thing I have been considering for a while is a fallback compatible
string that can be used for an IP block when either there is no driver
loaded or no driver exists at all. Something like "generic-ip-block".

The purpose of this compatible string is to allow us to model resource
consumption in dts accurately, regardless of whether or not a proper
driver has been written in Linux. This idea was born out of the
simple-fb binding/driver discussion last year[0].

Obviously such a binding would not enable any of the logic or function
of that IP block; that would require a proper driver. But it would allow
us to properly link system-wide resources that are consumed: the
generic-ip could consume clocks and regulators, it could belong to power
domains, etc. For this reason I have also thought that
"generic-resource-consumer" is an accurate compatible string.

This spares us from having to encode nasty details into the power domain
binding, which is exactly what would happen if you needed a dedicated
list of clocks in the power domain node that were not claimed by device
nodes/drivers.

Note that a real driver might exist for an IP block, but if that driver
is disabled in Kconfig AND the corresponding dt node has this fallback
compatible string, then we could be OK, from the perspective of the
power domain problem.

> 
> What happens if this is a device that someone has set to 'status =
> "disabled";' in the device tree?

If someone does that, then I think we should let that break power domain
transitions.

> 
> Even if the device is disabled in one of those two ways, we still need
> the clocks to be turned on.  ...so if we turn on/off the VIO domain we
> need to turn on the EDP clock even if there's no EDP in the current
> board / config.  We might turn on/off VIO for one of the other devices
> in the VIO domain for one of the other devices in VIO that we are
> using.

I'm hesitant to mention this but I am working on a patch series to
implement a clock "handoff" mechanism (also inspired by the simplefb
discussion). This allows us to set a per-clock flag that tells the
framework to enable that clock at registration time, and then the first
clock consumer driver to come along and claim that clock inherits that
clock enable reference count.

I'm working on v2 that lets us set this flag from DT, but I really only
plan to do this for special cases. For the normal case the flag should
be set in the Linux clock provider driver. In the mean time v1 is under
discussion[1].

[0] http://lkml.kernel.org/r/<1407914239-12054-5-git-send-email-libv@skynet.be>
[1] http://lkml.kernel.org/r/<1438974570-20812-1-git-send-email-mturquette@baylibre.com>

Regards,
Mike

> 
> -Doug
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
