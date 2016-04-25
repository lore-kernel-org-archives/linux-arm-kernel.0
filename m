From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 25 Apr 2016 21:03:34 +0200
Subject: linux-next: perf issue on big.LITTLE since 26657848502b7847
In-Reply-To: <20160425175837.GB3141@leverpostej>
References: <20160425175837.GB3141@leverpostej>
Message-ID: <20160425190334.GK3448@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 06:58:37PM +0100, Mark Rutland wrote:
> Hi,
> 
> When booting an arm64 defconfig linux-next (next-20160422) on an ARM
> Juno system, I hit a WARN_ON_ONCE in perf_pmu_register (see backtrace at
> the end of this email).
> 
> This was introduced by commit 26657848502b7847 ("perf/core: Verify we
> have a single perf_hw_context PMU") where we forcefully prevent multiple
> PMUs from sharing perf_hw_context (with a warning), and force additional
> PMUs to use perf_invalid_context.
> 
> Generally that makes sense, but unfortunately it breaks systems which
> genuinely do have disparate HW (i.e. CPU) PMUs, such as Juno, which has
> both Cortex-A57 PMUs and Cortex-A53 PMUs. We register a logical PMU for
> each microarchitecture, which accept CPU-bound events for relevant CPUs,
> or task-bound events. One task may have events for multiple logical PMUs
> (and hence, they must share perf_hw_context).
> 
> The commit message for 26657848502b7847 mentions that the check is
> intended to ensure that round-robin scheduling of events works, though
> we already work around that issue by other means. In commit
> 66eb579e66ecfea5 ("perf: allow for PMU-specific event filtering"), we
> added a PMU-specific callback specifically to avoid this issue, which we
> wired up for ARM in commit c904e32a69b7c779 ("arm: perf: filter
> unschedulable events").
> 
> Are you happy to revert 26657848502b787 for the timebeing? Or to somehow
> predicate the check such that it doesn't adversely affect those HW PMUs?

I'm happy with a chicken bit for now, its already found two real issues,
so I'd like to keep it.
