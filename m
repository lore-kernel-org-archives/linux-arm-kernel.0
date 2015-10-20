From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 20 Oct 2015 14:05:22 +0100
Subject: [PATCHv2 0/4] arm-cci500: Workaround pmu_event_set_period
Message-ID: <1445346326-30820-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CCI PMU driver sets the event counter to the half of the maximum
value(2^31) it can count before we start the counters via
pmu_event_set_period(). This is done to give us the best chance to
handle the overflow interrupt, taking care of extreme interrupt latencies.

However, CCI-500 comes with advanced power saving schemes, which disables
the clock to the event counters unless the counters are enabled to count
(PMCR.CEN). This prevents the driver from writing the period to the
counters before starting them.  Also, there is no way we can reset the
individual event counter to 0 (PMCR.RST resets all the counters, losing
their current readings). However the value of the counter is preserved and
could be read back, when the counters are not enabled.

So we cannot reliably use the counters and compute the number of events
generated during the sampling period since we don't have the value of the
counter at start.

Here are the possible solutions:

 1) Disable clock gating on CCI-500 by setting Control_Override_Reg[bit3].
    - The Control_Override_Reg is secure (and hence not programmable from
      Linux), and also has an impact on power consumption.

 2) Change the order of operations
	i.e,
	a) Program and enable individual counters
	b) Enable counting on all the counters by setting PMCR.CEN
	c) Write the period to the individual counters
	d) Disable the counters
    - This could cause in unnecessary noise in the other counters and is
      costly (we should repeat this for all enabled counters).

 3) Don't set the counter value, instead use the current count as the
    starting count and compute the delta at the end of sampling.

 4) Modified version of 2, which disables all the other counters, except
    the target counter, with the target counter programmed with an invalid
    event code(which guarantees that the counter won't change during the
    operation).

This patch implements option 4 for CCI-500. CCI-400 behavior remains
unchanged. The problem didn't surface on a fast model, but was revealed
on an FPGA model. Without this patch profiling on CCI-500 is broken and
should be fixed for 4.3.

Changes since V1:
 - Choose 4 instead of 3 above, suggested by Mark Rutland

Suzuki K. Poulose (4):
  arm-cci: Refactor CCI PMU code
  arm-cci: Get the status of a counter
  arm-cci: Add routines to enable/disable all counters
  arm-cci500: Work around PMU counter writes

 drivers/bus/arm-cci.c |  184 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 147 insertions(+), 37 deletions(-)

-- 
1.7.9.5
