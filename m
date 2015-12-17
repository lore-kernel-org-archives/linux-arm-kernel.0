From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 17 Dec 2015 17:49:07 +0000
Subject: [PATCHv4 00/12] arm-cci: PMU updates
Message-ID: <1450374559-23315-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series includes:

 - Introduction of transaction hooks for CCI PMU to batch the CCI
   counter programming (Patches 1-5)
 - Work around for writing to CCI-500/550(introduced later) PMU
   counters (Patches 6-10)
 - Support for CCI-550 PMU (11-12) with Acked-bys.

Since all of these are related I am clubbing it all in one series
so that it is easier to carry them around (and merge it possibly).

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
unchanged.

Changes sinces V3:
 - Added transaction hooks to batch the writes to PMU counters for
   group events.
 - Pulled ARM CCI 550 PMU support patches

Changes since V2:
 - Rebased to 4.4-rc1 + Mark's patch to simply PMU syfs attributes [1]
 - Address comments on v2.
 - Split the introduction of write_counter hook to a separate patch

Changes since V1:
 - Choose 4 instead of 3 above, suggested by Mark Rutland

 [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/373129.html


Suzuki K. Poulose (12):
  arm-cci: Define CCI counter period
  arm-cci: Refactor pmu_write_counter
  arm-cci: Group writes to counter
  arm-cci: Fix the flags for pmu_start called from pmu_add
  arm-cci: PMU: Add support for transactions
  arm-cci: Refactor CCI PMU enable/disable methods
  arm-cci: Get the status of a counter
  arm-cci: Add routines to save/restore all counters
  arm-cci: Provide hook for writing to PMU counters
  arm-cci: CCI-500: Work around PMU counter writes
  arm-cci500: Rearrange PMU driver for code sharing with CCI-550 PMU
  arm-cci: CoreLink CCI-550 PMU driver

 Documentation/devicetree/bindings/arm/cci.txt |    2 +
 drivers/bus/Kconfig                           |   10 +-
 drivers/bus/arm-cci.c                         |  599 +++++++++++++++++++------
 3 files changed, 479 insertions(+), 132 deletions(-)

-- 
1.7.9.5
