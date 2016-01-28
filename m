From: jglauber@cavium.com (Jan Glauber)
Date: Thu, 28 Jan 2016 15:55:02 +0100
Subject: [PATCH v2 4/5] arm64/perf: Enable PMCR long cycle counter bit
In-Reply-To: <cover.1453992560.git.jglauber@cavium.com>
References: <cover.1453992560.git.jglauber@cavium.com>
Message-ID: <5632ade9c6893a63ca5cb34bf1b0e9a44cbd2ab1.1453992560.git.jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the long cycle counter bit (LC) disabled the cycle counter is not
working on ThunderX SOC (ThunderX only implements Aarch64).
Also, according to documentation LC == 0 is deprecated.

To keep the code simple the patch does not introduce 64 bit wide counter
functions. Instead writing the cycle counter always sets the upper
32 bits so overflow interrupts are generated as before.

Original patch from Andrew Pinksi <Andrew.Pinksi@caviumnetworks.com>

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 arch/arm64/kernel/perf_event.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index c038e4e..5e4275e 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -405,6 +405,7 @@ static const struct attribute_group *armv8_pmuv3_attr_groups[] = {
 #define ARMV8_PMCR_D		(1 << 3) /* CCNT counts every 64th cpu cycle */
 #define ARMV8_PMCR_X		(1 << 4) /* Export to ETM */
 #define ARMV8_PMCR_DP		(1 << 5) /* Disable CCNT if non-invasive debug*/
+#define ARMV8_PMCR_LC		(1 << 6) /* Overflow on 64 bit cycle counter */
 #define	ARMV8_PMCR_N_SHIFT	11	 /* Number of counters supported */
 #define	ARMV8_PMCR_N_MASK	0x1f
 #define	ARMV8_PMCR_MASK		0x3f	 /* Mask for writable bits */
@@ -494,9 +495,16 @@ static inline void armv8pmu_write_counter(struct perf_event *event, u32 value)
 	if (!armv8pmu_counter_valid(cpu_pmu, idx))
 		pr_err("CPU%u writing wrong counter %d\n",
 			smp_processor_id(), idx);
-	else if (idx == ARMV8_IDX_CYCLE_COUNTER)
-		asm volatile("msr pmccntr_el0, %0" :: "r" (value));
-	else if (armv8pmu_select_counter(idx) == idx)
+	else if (idx == ARMV8_IDX_CYCLE_COUNTER) {
+		/*
+		 * Set the upper 32bits as this is a 64bit counter but we only
+		 * count using the lower 32bits and we want an interrupt when
+		 * it overflows.
+		 */
+		u64 value64 = 0xffffffff00000000ULL | value;
+
+		asm volatile("msr pmccntr_el0, %0" :: "r" (value64));
+	} else if (armv8pmu_select_counter(idx) == idx)
 		asm volatile("msr pmxevcntr_el0, %0" :: "r" (value));
 }
 
@@ -768,8 +776,11 @@ static void armv8pmu_reset(void *info)
 		armv8pmu_disable_intens(idx);
 	}
 
-	/* Initialize & Reset PMNC: C and P bits. */
-	armv8pmu_pmcr_write(ARMV8_PMCR_P | ARMV8_PMCR_C);
+	/*
+	 * Initialize & Reset PMNC. Request overflow on 64 bit but
+	 * cheat in armv8pmu_write_counter().
+	 */
+	armv8pmu_pmcr_write(ARMV8_PMCR_P | ARMV8_PMCR_C | ARMV8_PMCR_LC);
 }
 
 static int armv8_pmuv3_map_event(struct perf_event *event)
-- 
1.9.1
