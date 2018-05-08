From: kim.phillips@arm.com (Kim Phillips)
Date: Tue, 8 May 2018 18:40:50 -0500
Subject: [PATCH] drivers/perf: arm-ccn: stop spamming dmesg in event_init
In-Reply-To: <20180504104117.8086-1-mark.rutland@arm.com>
References: <20180504104117.8086-1-mark.rutland@arm.com>
Message-ID: <20180508184050.75c60b82ba538d0ecdeb2d78@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  4 May 2018 11:41:17 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

[adding Pawel, arm-ccn driver author]

> The ARM CCN PMU driver uses dev_warn() to complain about parameters in
> the user-provided perf_event_attr. This means that under normal
> operation (e.g. a single invocation of the perf tool), dmesg may be
> spammed with multiple messages.

Nothing new there:  perf does that all the time: E.g., a single, basic
x86 invocation causes all this:

[77360.630571] perf: interrupt took too long (2549 > 2500), lowering kernel.perf_event_max_sample_rate to 78250
[77360.630800] perf: interrupt took too long (3492 > 3186), lowering kernel.perf_event_max_sample_rate to 57250
[77360.631045] perf: interrupt took too long (4379 > 4365), lowering kernel.perf_event_max_sample_rate to 45500
[77360.631437] perf: interrupt took too long (5845 > 5473), lowering kernel.perf_event_max_sample_rate to 34000
[77360.631967] perf: interrupt took too long (7736 > 7306), lowering kernel.perf_event_max_sample_rate to 25750
[77360.632520] perf: interrupt took too long (9921 > 9670), lowering kernel.perf_event_max_sample_rate to 20000
[77360.633344] perf: interrupt took too long (12778 > 12401), lowering kernel.perf_event_max_sample_rate to 15500
[77360.634294] perf: interrupt took too long (16030 > 15972), lowering kernel.perf_event_max_sample_rate to 12250
[77360.635587] perf: interrupt took too long (20105 > 20037), lowering kernel.perf_event_max_sample_rate to 9750
[77360.637301] perf: interrupt took too long (25319 > 25131), lowering kernel.perf_event_max_sample_rate to 7750

> Tools may issue multiple syscalls to probe for feature support, and

Why isn't it helpful?  A user can see the tool is trying different
options, and as they are tried, to see which ones are they can do
something about.  Arm-ccn has plenty of h/w specific errors, and users
need to know things like node specific details.

> multiple applications (from multiple users) can attempt to open events
> simultaneously, so this is not very helpful, 

Does running perf on the same PMU h/w against other users even work?
Is it even practical, if they get it to?  In any case, for Arm-ccn,
since it's system-wide PMU h/w, this use-case is completely unrealistic.

> even if a user happens to have access to dmesg.

Again, unrealistic:  If they have access to run arm-ccn, kptrs are
unrestricted, so they have way more access than to just dmesg.

> Worse, this can push important information out of
> the dmesg ring buffer,

Like what, specifically?  People about to run perf do so on a stable
system, for measurement of performance accuracy reasons.   Anyway,
there are logging daemons to help with that, and arm-ccn doesn't emit
*that* many messages such as to even come close to filling the buffer.

> and can significantly slow down syscall fuzzers,
> vastly increasing the time it takes to find critical bugs.

Facilitating first user experience  - esp. for Arm perf - trumps fuzzer
runner convenience any day, in my book.  Fuzzer runners can patch their
kernels prior to running the fuzzers.

> Demote the dev_warn() instances to dev_dbg(), as is the case for all
> other PMU drivers under drivers/perf/. Users who wish to debug PMU event
> initialisation can enable dynamic debug to receive these messages.

After having already debugged things to the point where they find the
problem is the driver's event_init() function?  Then they find they
have to recompile their kernels yet again, with DYNAMIC_DEBUG set?

No, please, this is a definite usability regression for Arm-ccn users.

In fact, are you sure it shouldn't be the other way around?:
{kernel,PMU driver} developers that wish to run fuzzers should disable
warnings using /proc/sys/kernel/printk, or boot with a different
loglevel on the boot command line.  I think our users would appreciate
that more than this patch.

Thanks,

Kim
