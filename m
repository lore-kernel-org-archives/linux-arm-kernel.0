From: kim.phillips@arm.com (Kim Phillips)
Date: Tue, 24 Oct 2017 20:05:00 -0500
Subject: [RFC 3/3] perf tool: arm-ccn: add a supplemental strerror function
In-Reply-To: <20171024133518.GA13445@arm.com>
References: <20171024030415.9baa5157e506892a757bf8c7@arm.com>
 <20171024133518.GA13445@arm.com>
Message-ID: <20171024200500.619cef54ad276b2d680b613d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Oct 2017 14:35:19 +0100
Will Deacon <will.deacon@arm.com> wrote:

> On Tue, Oct 24, 2017 at 03:04:15AM -0500, Kim Phillips wrote:
> > Use the Arm CCN driver as an example of how to try to improve
> > upon its existing dmesg error output, and duplicate error string
> > generation logic in the perf tool.
> 
> [...]
> 
> > Comments?  Is this really that much better than the existing dmesg that
> > the user is already being pointed to by the perf tool?
> 
> Having never used the CCN PMU, I can't speak to the usefulness of this
> change, but I can say that I think this needs to be PMU-specific rather than
> arch-specific. The CCN driver can, for example, be built for 32-bit ARM
> systems but the directory structure here doesn't reflect that.

Sure, but the gist of this RFC is to determine whether it useful to
users of the CCN PMU, and other hard-to-use PMUs.

In the very last example provided, one can see that how referring the
user to dmesg will be helpful, because only the kernel driver knows the
node/xp vs topology enough to validate the user request.

BEFORE THIS SERIES:

>From the perf tool, we get:

Warning:
ccn/xp_watchpoint,xp=3,vc=5,port=9,dir=1,cmp_l=0,cmp_h=1,mask=0/ event is not supported by the kernel.

>From dmesg, we get:

[16561.872725] arm-ccn e8000000.ccn: Invalid vc 5 for node/XP 3!

AFTER THIS SERIES (amended to only strerror_arch output):

The tool gives us:

Warning:
ccn/xp_watchpoint,xp=3,vc=5,port=9,dir=1,cmp_l=0,cmp_h=1,mask=0/: Invalid MN / XP / node ID, or node type, or node/XP port / vc or event, or mixed PMU group. See dmesg for details

So the usefulness of this series is still debatable - at least for CCN
- given the tool already points the user to dmesg.

> > +	switch (err) {
> > +	case EOPNOTSUPP:
> > +		if (attr->sample_period)
> > +			return scnprintf(msg, size, "%s: Sampling not supported, try 'perf stat'\n", evname);
> 
> ... and then the existing code prints:
> 
> 	"PMU Hardware doesn't support sampling/overflow-interrupts."
> 
> so why do we need both?

We don't; just didn't want to tread too hard on the common code on this
first RFC, but you (and acme) are right: this should default back to
the generic/shared strerror (and be removed from here).

> > +		if (target__has_task(target))
> > +			return scnprintf(msg, size, "%s: Can't provide per-task data!\n", evname);
> 
> Isn't this the case for all uncore PMUs? If so, could we predicate this
> additionally on evsel->system_wide and print this in the shared error
> handler?

That actually should have been !target__has_cpu, since the driver
checks for event->cpu < 0.

hmm, I can't find a way to get that message out of the driver (on
dmesg).  E.g., --per-thread invocations are being caught by the perf
front end parser...but, yes, this probably should be removed from the
custom CCN strerror code.

> > +		break;
> > +	case EINVAL:
> > +		if ((attr->sample_type & PERF_SAMPLE_BRANCH_STACK) ||
> > +			attr->exclude_user ||
> > +			attr->exclude_kernel || attr->exclude_hv ||
> > +			attr->exclude_idle || attr->exclude_host ||
> > +			attr->exclude_guest)
> > +			return scnprintf(msg, size, "%s: Can't exclude execution levels!\n", evname);
> 
> A better way to do this might be to identify some common failure modes,
> e.g. unable to support some of the exclude_* fields in perf_event_attr,
> then have an optional per-PMU callback which returns a bool to say
> whether or not the error is because of that.

Not sure exactly what that would look like for this context, but
tools/perf/util/evsel.c:perf_evsel__fallback() gets called after the
event open fails and already contains some of that logic...

Kim
