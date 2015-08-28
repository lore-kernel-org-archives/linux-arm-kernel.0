From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 28 Aug 2015 14:28:11 -0700
Subject: [RESEND PATCH v16 4/4] ARM: dts: add the support power-domain
 node on RK3288 SoCs
In-Reply-To: <20150828200238.30921.24441@quantum> (Michael Turquette's message
 of "Fri, 28 Aug 2015 13:02:38 -0700")
References: <1440487486-6154-1-git-send-email-wxt@rock-chips.com>
 <1440487486-6154-5-git-send-email-wxt@rock-chips.com>
 <7hfv37axhj.fsf@deeprootsystems.com>
 <CAD=FV=V6oG+9U=W_JZmqCuNo-9-5wW8ffZzG7ZE_3cnSTNAjFQ@mail.gmail.com>
 <7htwrn6l7g.fsf@deeprootsystems.com>
 <CAKdAkRS=9Dq+YpMNSjpij0Am4ZD6uUURv74OLLYf+akD=W885A@mail.gmail.com>
 <7hmvxc45w2.fsf@deeprootsystems.com>
 <CAD=FV=VTR-PBcXXX1jHNw65x_cMP9CKwVWBs+XCcFqFPp7msjA@mail.gmail.com>
 <20150828200238.30921.24441@quantum>
Message-ID: <7hmvxb2jdg.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Turquette <mturquette@linaro.org> writes:

> Hi Doug,
>
> Quoting Doug Anderson (2015-08-27 19:03:20)
>> Kevin,
>> 
>> On Thu, Aug 27, 2015 at 5:24 PM, Kevin Hilman <khilman@kernel.org> wrote:
>> >> That is not really workable: the attach and detach happen in
>> >> probe/remove path; if you do not have driver for the device you will
>> >> miss the clocks for it.
>> >
>> > And in my proposal, I suggested that clocks without drivers are
>> > good candidates to list in the domain, with the caveat that the be
>> > called out (documented) as being device clocks that are missing a
>> > driver, so when a driver shows up they can be moved accordingly, and in
>> > a way that actually describes the hardware.
>> 
>> What happens if someone disables the driver using the CONFIG subsystem?
>
> Kevin asked me to chime in on this thread, as I have a half-baked idea
> that might solve the problem posed by your question above.
>
> One thing I have been considering for a while is a fallback compatible
> string that can be used for an IP block when either there is no driver
> loaded or no driver exists at all. Something like "generic-ip-block".
>
> The purpose of this compatible string is to allow us to model resource
> consumption in dts accurately, regardless of whether or not a proper
> driver has been written in Linux. This idea was born out of the
> simple-fb binding/driver discussion last year[0].
>
> Obviously such a binding would not enable any of the logic or function
> of that IP block; that would require a proper driver. But it would allow
> us to properly link system-wide resources that are consumed: the
> generic-ip could consume clocks and regulators, it could belong to power
> domains, etc. For this reason I have also thought that
> "generic-resource-consumer" is an accurate compatible string.
>
> This spares us from having to encode nasty details into the power domain
> binding, which is exactly what would happen if you needed a dedicated
> list of clocks in the power domain node that were not claimed by device
> nodes/drivers.
>
> Note that a real driver might exist for an IP block, but if that driver
> is disabled in Kconfig AND the corresponding dt node has this fallback
> compatible string, then we could be OK, from the perspective of the
> power domain problem.
>
>> 
>> What happens if this is a device that someone has set to 'status =
>> "disabled";' in the device tree?
>
> If someone does that, then I think we should let that break power domain
> transitions.
>

Well, the catch here is that status=disabled doesn't necessarily mean
that the IP block isn't present.  It can mean "not used", "not needed",
"not wired up to external iface" etc., but if the IP block is physcially
present, then its clocks are still needed for a power domain reset.  If
a node is marked as status=disabled, then even the fallback compatible
doesn't help, as the fallback driver won't be probed/loaded either. :(

Speaking of loading, the module loading/unloading complicates this even
further.  Even if a pm-domain is managing the clocks from a device node,
if a driver is unloaded (and thus removed from the pm domain), the pm
domain driver would stop managing that clock and then the domain reset
would stop working again.  Ugh.  

The more I think through all these corner cases, and also the fact that
we never seem to be able to get a fully accurate description of how the
SoCs actually work at this level (due to missing/poor/wrong docs), I
think the having both the power domain and the device nodes claiming
clocks is the most flexible solution. It's using the clock consumer
binding in a perfectly acceptable way, and the clock fwk usecounting
will manage usecounting etc.

However, I still stick by my earlier insistence that the DT nodes be
thorougly documented though, and be very specific why the clocks are
needed by the power domain, and especially which clocks are device
clocks, etc.  I (and hopefully others) will be looking closely at the
DTs that come through and make that clocks listed in the domains are
well described.

@Doug: thanks for taking the time to spell out the variou corner cases.

Kevin
