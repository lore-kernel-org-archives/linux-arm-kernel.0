From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon,  4 Jan 2016 11:54:39 +0000
Subject: [PATCH v5 00/11] arm-cci: PMU updates
Message-ID: <1451908490-2615-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series includes:

 - Work around for writing to CCI-500/550(introduced later) PMU
   counters (Patches 1-9)
 - Support for CCI-550 PMU (10-11) with Acked-bys.

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

This patch implements option 4 for CCI-500(and CCI-550). CCI-400 behavior
remains unchanged.

The tree including [1] on top of 4.4-rc8 is available at :

    git://linux-arm.org/linux-skp.git   cci-updates/4.4-rc8

Changes since V4:
 - Drop transaction hooks. Instead, group and delay the writes to pmu_enable().
 - Rebased to 4.4-rc8

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

Suzuki K. Poulose (11):
  arm-cci: Define CCI counter period
  arm-cci: Refactor pmu_write_counter
  arm-cci: Group writes to counter
  arm-cci: Refactor CCI PMU enable/disable methods
  arm-cci PMU: Delay counter writes to pmu_enable
  arm-cci: Get the status of a counter
  arm-cci: Add routines to save/restore all counters
  arm-cci: Provide hook for writing to PMU counters
  arm-cci: CCI-500: Work around PMU counter writes
  arm-cci500: Rearrange PMU driver for code sharing with CCI-550 PMU
  arm-cci: CoreLink CCI-550 PMU driver

 Documentation/devicetree/bindings/arm/cci.txt |    2 +
 drivers/bus/Kconfig                           |   10 +-
 drivers/bus/arm-cci.c                         |  524 +++++++++++++++++++------
 3 files changed, 408 insertions(+), 128 deletions(-)

-- 
1.7.9.5
