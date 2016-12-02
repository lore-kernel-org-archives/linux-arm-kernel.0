From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  2 Dec 2016 15:50:59 +0000
Subject: [PATCH 2/2] arm64: PMU: Reset PMSELR_EL0 to a sane value at boot time
In-Reply-To: <1480693859-27249-1-git-send-email-marc.zyngier@arm.com>
References: <1480693859-27249-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1480693859-27249-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to avoid any ugly surprise, let's reset PMSELR_EL0 to the
first valid value (avoiding the cycle counter which has been proven
to be troublesome) at CPU boot time. This ensures that no guest will
be faced with some odd value which it cannot modify (due to
MDCR_EL2.TPM being set).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/perf_event.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index a65b757..42d1840 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -910,6 +910,14 @@ static void armv8pmu_reset(void *info)
 	 */
 	armv8pmu_pmcr_write(ARMV8_PMU_PMCR_P | ARMV8_PMU_PMCR_C |
 			    ARMV8_PMU_PMCR_LC);
+
+	/*
+	 * If we have at least one available counter, reset to that
+	 * one so that no illegal value is left in PMSELR_EL0, which
+	 * could have an impact on a guest.
+	 */
+	if (armv8pmu_counter_valid(cpu_pmu, ARMV8_IDX_COUNTER0))
+		armv8pmu_select_counter(ARMV8_IDX_COUNTER0);
 }
 
 static int armv8_pmuv3_map_event(struct perf_event *event)
-- 
2.1.4
