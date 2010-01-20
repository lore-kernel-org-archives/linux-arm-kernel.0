From: t.fujak@samsung.com (Tomasz Fujak)
Date: Wed, 20 Jan 2010 10:46:25 +0100
Subject: [PATCH/RFC v1 0/2] Human readable performance event description in
	sysfs
In-Reply-To: <1263978999.4283.823.camel@laptop>
References: <1263978706-15499-1-git-send-email-t.fujak@samsung.com>
	<1263978999.4283.823.camel@laptop>
Message-ID: <023a01ca99b5$6ea3cf80$4beb6e80$%fujak@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Peter Zijlstra
> Sent: Wednesday, January 20, 2010 10:17 AM
> To: Tomasz Fujak
> Cc: jpihet at mvista.com; p.osciak at samsung.com; jamie.iles at picochip.com;
> will.deacon at arm.com; linux-kernel at vger.kernel.org;
> kyungmin.park at samsung.com; mingo at elte.hu; linux-arm-
> kernel at lists.infradead.org; m.szyprowski at samsung.com
> Subject: Re: [PATCH/RFC v1 0/2] Human readable performance event
> description in sysfs
> 
> On Wed, 2010-01-20 at 10:11 +0100, Tomasz Fujak wrote:
> > Hi,
> >
> > While I managed to build and run the early version (back from
> > December), I was unable to find the newest sources (infra + ARMv6,
> > ARMv7 support).
> > Where do I find them?
> >
> > The following patches provide a sysfs entry with hardware event human
> > readable description in the form of "0x%llx\t%lld-%lld\t%s\t%s" %
> > (event_value, minval, maxval, name, description) and means to
> populate
> > the file.
> > The version posted contains ARMv6, ARMv7 (Cortex-A[89]) support in
> > this matter.
> >
> > The intended use is twofold: for users to read the list directly and
> > for tools (like perf).
> >
> > This series includes:
> > [PATCH v1 1/2] perfevent: Add performance event structure definition
> > and 'extevents' sysfs entry
> > [PATCH v1 2/2] [ARM] perfevent: Event description list for ARMv6,
> > Cortex-A8 and Cortex-A9 exported
> 
> Why do this in kernel space? Listing available events seems like
> something we can do from userspace just fine.

Sure we could, it's the other option. But it does not appeal to me. In case
of userspace tools (like the pref for which the above is meant) they'd need
to come with their own version of the list, which must match the host
platform. Right now the perf just forwards raw event number to the kernel
and that's it. Potentially it could bind a set of events supported to a
platform (how to detect which platform we execute on?). But how do we handle
different revisions and minor changes within a single platform?

That's why I think the kernel should expose supported events. At least with
an identifier suitable to unambiguously detect which HW defined event it is.

In the proposed approach I also provided a name a and description.
Right now if one wants to set a counter with some non-generic value, a
datasheet comes handy.
And Joe the average user does not necessarily know the detailed machine
he/she has, let alone the datasheet. With this approach the user is armed
with the event definition, which helps them go around outdated/unsupported
tools.

> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
