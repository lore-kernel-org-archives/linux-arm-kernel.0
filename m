From: olof@lixom.net (Olof Johansson)
Date: Thu, 22 Oct 2015 10:00:25 -0700
Subject: [PATCHv2 0/4] arm-cci500: Workaround pmu_event_set_period
In-Reply-To: <1445346326-30820-1-git-send-email-suzuki.poulose@arm.com>
References: <1445346326-30820-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151022170025.GF19953@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 02:05:22PM +0100, Suzuki K. Poulose wrote:
> The CCI PMU driver sets the event counter to the half of the maximum
> value(2^31) it can count before we start the counters via
> pmu_event_set_period(). This is done to give us the best chance to
> handle the overflow interrupt, taking care of extreme interrupt latencies.
> 
> However, CCI-500 comes with advanced power saving schemes, which disables
> the clock to the event counters unless the counters are enabled to count
> (PMCR.CEN). This prevents the driver from writing the period to the
> counters before starting them.  Also, there is no way we can reset the
> individual event counter to 0 (PMCR.RST resets all the counters, losing
> their current readings). However the value of the counter is preserved and
> could be read back, when the counters are not enabled.
> 
> So we cannot reliably use the counters and compute the number of events
> generated during the sampling period since we don't have the value of the
> counter at start.
> 
> Here are the possible solutions:
> 
>  1) Disable clock gating on CCI-500 by setting Control_Override_Reg[bit3].
>     - The Control_Override_Reg is secure (and hence not programmable from
>       Linux), and also has an impact on power consumption.
> 
>  2) Change the order of operations
> 	i.e,
> 	a) Program and enable individual counters
> 	b) Enable counting on all the counters by setting PMCR.CEN
> 	c) Write the period to the individual counters
> 	d) Disable the counters
>     - This could cause in unnecessary noise in the other counters and is
>       costly (we should repeat this for all enabled counters).
> 
>  3) Don't set the counter value, instead use the current count as the
>     starting count and compute the delta at the end of sampling.
> 
>  4) Modified version of 2, which disables all the other counters, except
>     the target counter, with the target counter programmed with an invalid
>     event code(which guarantees that the counter won't change during the
>     operation).
> 
> This patch implements option 4 for CCI-500. CCI-400 behavior remains
> unchanged. The problem didn't surface on a fast model, but was revealed
> on an FPGA model. Without this patch profiling on CCI-500 is broken and
> should be fixed for 4.3.

Hi,

Given that CCI-500 is only now showing up in FPGA models, and is new hardware
support and not a regression, combined with the late time in the release cycle
means this is really 4.4 material by now.

Mark, can you review given that you've been involved already, please? Happy to
apply for 4.4 if it's ready for it soon.


-Olof
