From: kim.phillips@arm.com (Kim Phillips)
Date: Fri, 7 Apr 2017 16:22:24 +0100
Subject: [PATCH v2 5/6] drivers/perf: Add support for ARMv8.2
 Statistical Profiling Extension
In-Reply-To: <20170407113106.GA18829@leverpostej>
References: <1491495496-1524-1-git-send-email-will.deacon@arm.com>
 <1491495496-1524-6-git-send-email-will.deacon@arm.com>
 <20170406193307.e1046706e122d80c036ad1a9@arm.com>
 <20170406184503.GC11871@leverpostej>
 <20170407115241.841f6d259cfa4a1165d106c5@arm.com>
 <20170407113106.GA18829@leverpostej>
Message-ID: <20170407162224.c81f50838be6add33a419adc@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Apr 2017 12:31:07 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> Hi Kim,

Hi Mark,

> On Fri, Apr 07, 2017 at 11:52:41AM +0100, Kim Phillips wrote:
> > On Thu, 6 Apr 2017 19:45:04 +0100
> > Mark Rutland <mark.rutland@arm.com> wrote:
> > > On Thu, Apr 06, 2017 at 07:33:07PM +0100, Kim Phillips wrote:
> > > > On Thu, 6 Apr 2017 17:18:15 +0100
> > > > Will Deacon <will.deacon@arm.com> wrote:
> 
> > > > > +	if ((reg & BIT(PMSFCR_EL1_FL_SHIFT)) &&
> > > > > +	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
> > > > > +		return -EOPNOTSUPP;
> 
> > > > Can you please explain why we're not emitting messages to dmesg here?:
> > > > 
> > > > https://patchwork.kernel.org/patch/9545979/
> > > 
> > > The above cases are not (system) errors, and using dev_err (even
> > > ratelimited) is certainly not appropriate. These are pr_debug() at best.
> > 
> > They are driver errors:  the input parameters to the driver were bad,
> > and it failed to execute.
> 
> This is not a driver error; the user requested something that the driver
> does not or cannot support, and the driver responded appropriately and
> correctly.
> 
> A *_err print is for when something is truly wrong at the system level,
> for example if the HW behaves unexpectedly, FW reports something
> invalid, or some kernel code invariant has been violated. It is not for
> every case where an error code is returned.

The driver is trying to report an error:  in the above example, it's
reporting that it cannot support an operation by returning
-*E*OPNOTSUPP: an ERROR because it was unable to complete the request:
the request failed.  Unlike e.g., a warning where something may not
have been quite right, but went along with executing the operation
anyway.

> > pr_debug - to me at least - should indicate progress during normal
> > operation.
> 
> Quite frankly, the above is the normal operation of the driver. We don't
> pr_err in every syscall path when validating arguments provided by the
> user, and this is no different.

It is different because this particular system call's error reporting
is notoriously bad, vis-a-vis this discussion.

debug-level messages such as pr_debug, dev_dbg can easily be hidden
from the user, depending on the distro's default dmesg level
preferences.

> > > The dmesg is not always the appropriate place to dump such information,
> > > even if it happens to be convenient. As part of usual operation, dmesg
> > > should be very quiet, and we don't log messages elsewhere where the user
> > > passes some parameter the kernel does not like.
> > > 
> > > These messages are really only useful to those developing tools (such as
> > > yourself).
> > 
> > We had a customer come back with a simple usage failure because they
> > were running a kernel with a different VHE configuration, blindly
> > failing the hv exclusion check above.  They had to manually modify the
> > driver to find the cause.  So it affects all users, not just me.
> 
> I agree that we can and should do something better for regular users. I
> disagree that dmesg is the solution.
> 
> What we need to do is expose information such that the tool can provide
> useful messages at the point of use, which are guaranteed to correspond
> to a particular action.
> 
> A user may not be aware of dmesg (e.g. if they're SSH'd in they're
> unlikely to see it), and cannot match messages to particular actions
> when there are multiple applications and/or users. So this doesn't solve
> the general case.

dmesg isn't the ultimate solution, no, but it's currently what we
have.

Meanwhile, perf occasionally says things like:

"/bin/dmesg may provide additional information"

so people know to look there, for now at least.

> > Unless you're implying the above code be duplicated in the perf tool
> > somehow?
> 
> Some feature probing could be done by the tool. We already do that today
> for CPU PMUs. If you take a look at perf_evsel__open, you can see it
> automatically determines whether the kernel supports guest exclusion for
> CPU PMU events.
> 
> We might be able to do something similar by default to cater for the VHE
> case you mentioned above.
> 
> We could also expose information under sysfs to explicitly tell the tool
> what is and is not supported by the driver.

This is essentially the gist of the code in question: that's exactly
what it's doing, except it's not doing it via sysfs.

I think the best solution is what Will originally pointed me to during
an earlier review round:  adding capability to perf syscalls to return
error strings:

https://lkml.org/lkml/2015/8/24/506

but we're not there yet.

> > > There are some cases where they're actively harmful (e.g.
> > > when fuzzing).
> > 
> > I'd expect fuzzer users to be more amenable to manually modifying the
> > driver rather than regular users of the driver.
> 
> When fuzzing, I take a mainline, defconfig kernel, and run it through
> its paces. I don't touch each and every driver.
> 
> As above, prints are not the solution for regular users.

In the context of this patch review, dmesg is all we have for now:
let's use it please.

Kim
