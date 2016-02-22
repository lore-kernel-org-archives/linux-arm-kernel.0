From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 22 Feb 2016 15:02:03 +0000
Subject: [PATCH v6 10/12] arm-cci: CCI-500: Work around PMU counter writes
In-Reply-To: <1453720877-24962-11-git-send-email-suzuki.poulose@arm.com>
References: <1453720877-24962-1-git-send-email-suzuki.poulose@arm.com>
 <1453720877-24962-11-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160222150203.GF3435@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 11:21:15AM +0000, Suzuki K. Poulose wrote:
> The CCI PMU driver sets the event counter to the half of the maximum
> value(2^31) it can count before we start the counters via
> pmu_event_set_period(). This is done to give us the best chance to
> handle the overflow interrupt, taking care of extreme interrupt latencies.
> 
> However, CCI-500 comes with advanced power saving schemes, which
> disables the clock to the event counters unless the counters are enabled to
> count (PMCR.CEN). This prevents the driver from writing the period to the
> counters before starting them.  Also, there is no way we can reset the
> individual event counter to 0 (PMCR.RST resets all the counters, losing
> their current readings). However the value of the counter is preserved and
> could be read back, when the counters are not enabled.
> 
> So we cannot reliably use the counters and compute the number of events
> generated during the sampling period since we don't have the value of the
> counter at start.
> 
> This patch works around this issue by changing writes to the counter
> with the following steps.
> 
>  1) Disable all the counters (remembering any counters which were enabled)
>  2) Enable the PMU, now that all the counters are disabled.
> 
>  For each counter to be programmed, repeat steps 3-7
>  3) Save the current event and program the target counter to count an
>     invalid event, which by spec is guaranteed to not-generate any events.
>  4) Enable the target counter.
>  5) Write to the target counter.
>  6) Disable the target counter
>  7) Restore the event back on the target counter.
> 
>  8) Disable the PMU
>  9) Restore the status of the all the counters

[...]

> + * For each counter to be programmed, repeat steps 3-7:
> + *
> + * 3) Write an invalid event code to the event control register for the
> +      counter, so that the counters are not modified.
> + * 4) Enable the counter control for the counter.
> + * 5) Set the counter value
> + * 6) Restore the event in the target counter
> + * 7) Disable the counter

Steps 6 and 7 are the wrong way around here. They are correct in the
commit message and the code.

[...]

> + * We choose an event code which has very little chances of getting
> + * assigned a valid code for step(2). We use the highest possible
> + * event code (0x1f) for the master interface 0.
> + */

Let's just say:

	We choose an event which for CCI-500 is guaranteed not to count.
	We use the highest possible event code (0x1f) for master
	interface 0.

Otherwise this looks fine.

Mark.
