From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 16 Nov 2016 10:37:29 +0000
Subject: [PATCH v7] soc: qcom: add l2 cache perf events driver
In-Reply-To: <e917b871-d6ee-d52b-aedc-b3ee75aed05f@codeaurora.org>
References: <1477687813-11412-1-git-send-email-nleeder@codeaurora.org>
 <20161109175413.GE17020@leverpostej>
 <20161109181652.GK17771@arm.com>
 <e917b871-d6ee-d52b-aedc-b3ee75aed05f@codeaurora.org>
Message-ID: <20161116103729.GB11228@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 04:52:35PM -0500, Leeder, Neil wrote:
> So is there a use-case for individual uncore PMUs when they can't be
> used in task mode or per-cpu?
> 
> The main (only?) use will be in system mode, in which case surely it
> makes sense to provide a single aggregated count?

If you are aware of the system topology, the numbers may be more useful
than the summed count. If you aren't, it's still possible to sum them in
userspace.

Having them summed by the kernel means that the kernel is implying it
supports group semantics that it cannot, since it cannot start/stop all
counters in a group atomically if they're split across several units.

> With individual PMUs exposed there will be potentially dozens of
> nodes for userspace to collect from which would make perf
> command-line usage unwieldy at best.

FWIW, for uncore/system PMUs, even on x86 there are a number of
independent units.

Some PMUs (those which are symmetric across the topology) get hidden
behind the same struct PMU, but instances are still isolated (and their
values not summed).

Thanks,
Mark.
