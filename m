From: ccross@android.com (Colin Cross)
Date: Tue, 1 May 2012 17:11:27 -0700
Subject: [PATCHv3 0/5] coupled cpuidle state support
In-Reply-To: <20120501104310.GB28930@e102568-lin.cambridge.arm.com>
References: <1335816551-27756-1-git-send-email-ccross@android.com>
 <201204302325.09505.rjw@sisk.pl>
 <CAMbhsRRReyiv2LgUNgp6XiW07V8Eb0gd4fb7W6nBjMZ1FpmOBQ@mail.gmail.com>
 <20120501104310.GB28930@e102568-lin.cambridge.arm.com>
Message-ID: <CAMbhsRRhJ-7Am0k0OCJG0E9C=w+ApVi2Ce4b-BfV_6frJfTh=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 1, 2012 at 3:43 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> Hi Colin,
>
> On Mon, Apr 30, 2012 at 10:37:30PM +0100, Colin Cross wrote:
<snip>

>> On Tegra3, the deepest individual cpu state for cpus 1-3 is OFF, the
>> same state the cpu would go into as the first step of a transition to
>> a deeper power state (cpus 0-3 OFF). ?It would be more optimal in that
>> case to bypass the SMP cross call, and leave the cpu in OFF, but that
>> would require some way of disabling all wakeups for the secondary cpus
>> and then verifying that they didn't start waking up just before the
>> wakeups were disabled. ?I have just started considering this
>> optimization, but I don't see anything in the existing code that would
>> prevent adding it later.
>
> I agree it is certainly an optimization that can be added later if benchmarks
> show it is needed (but again it is heavily platform dependent, ie technology
> dependent).
> On a side note, disabling (or move to the primary) wake-ups for "secondaries"
> on platforms where every core is in a different power domain is still needed
> to avoid having a situation where a CPU can independently get out of idle, ie
> abort idle, after hitting the coupled barrier.
> Still do not know if for those platforms coupled C-states should be used, but
> it is much better to have a choice there IMHO.

Yes, that is the primary need for the coupled_cpuidle_parallel_barrier
function - secondary cpus need to disable their wakeup sources, then
check that a wakeup was not already pending and abort if necessary.

> I have also started thinking about a cluster or multi-CPU "next-event" that
> could avoid triggering heavy operations like L2 cleaning (ie cluster shutdown)
> if a timer is about to expire on a given CPU (as you know CPUs get in and out
> of idle independently so the governor decision at the point the coupled state
> barrier is hit might be stale).

It would be possible to re-check the governor to decide the next state
(maybe only if the previous decision is out of date by more than the
target_residency?), but I left that as an additional optimization.

> I reckon the coupled C-state concept can prove to be an effective one for
> some platforms, currently benchmarking it.
>
>> A simple measurement using the tracing may show that it is
>> unnecessary. ?If the wakeup time for CPU1 to go from OFF to active is
>> small there might be no need to optimize out the extra wakeup.
>
> Indeed, it is all about resetting the CPU and getting it started, with
> inclusive L2 the power cost of shutting down a CPU and resuming it should be
> low (and timing very fast) for most platforms.

The limiting factor may be the amount of time spent in ROM/Trustzone
code when bringing a cpu back online.
