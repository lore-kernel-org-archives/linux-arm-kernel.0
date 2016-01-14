From: ggdavisiv@gmail.com (George G. Davis)
Date: Wed, 13 Jan 2016 23:36:26 -0500
Subject: [PATCH v4 1/1] ARM: perf: Set ARMv7 SDER SUNIDEN bit
In-Reply-To: <20160112171109.GJ15737@arm.com>
References: <20140805144831.25462.18149.stgit@localhost>
 <20140805144833.25462.46011.stgit@localhost>
 <20140806104947.GD25953@arm.com> <53E22E0B.7080907@parkeon.com>
 <20140807173316.GH31101@arm.com>
 <20160106145500.GA92797@gandalf.middle.earth.net>
 <20160112171109.GJ15737@arm.com>
Message-ID: <20160114043626.GA45778@gandalf.middle.earth.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Fuzzey <mfuzzey@parkeon.com>

ARMv7 counters other than the CPU cycle counter only work if the Secure
Debug Enable Register (SDER) SUNIDEN bit is set.

Since access to the SDER is only possible in secure state, it will
only be done if the device tree property "secure-reg-access" is set.

Without this:
# perf stat -e cycles,instructions sleep 1

 Performance counter stats for 'sleep 1':

          14606094 cycles                    #    0.000 GHz
                 0 instructions              #    0.00  insns per cycle

After applying:
# perf stat -e cycles,instructions sleep 1

 Performance counter stats for 'sleep 1':

           5843809 cycles
           2566484 instructions              #    0.44  insns per cycle

       1.020144000 seconds time elapsed

Some platforms (eg i.MX53) may also need additional platform specific
setup.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
Signed-off-by: Pooya Keshavarzi <Pooya.Keshavarzi@de.bosch.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
---
Changes in v4:
- Reword commit message to clarify that this change is ARMv7 specific.
- Clarify that secure-reg-access property is only valid for ARMv7 CPUs
  and is not supported on anything else (in particular, the arm64
  port requires you to boot in non-secure mode).
- Convert on_each_cpu(armv7pmu_enable_secure_access, NULL, 1) call in
  armv7pmu_init() to in-lined code in ->reset callback, since that is
  called off the back of a CPU hotplug notifier when the PMU may need
  to be reinitialised.
Changes in v3:
- Pooya Keshavarzi:
  * v2 review comment fixups
  * Use on_each_cpu() to set SUNIDEN on all CPUs
  * Move armv7pmu_enable_secure_access() call from armv7pmu_start() to
    armv7_a8_map_event() such that is called only once instead of each
    time `perf` is executed
- George G. Davis:
  * Fixup to apply after file renames due to commit fa8ad78 (arm: perf:
    factor arm_pmu core out to drivers)
  * Fix checkpatch 'CHECK: Prefer using the BIT macro' issue
---
 Documentation/devicetree/bindings/arm/pmu.txt | 10 ++++++++++
 arch/arm/kernel/perf_event_v7.c               | 13 ++++++++++++-
 drivers/perf/arm_pmu.c                        |  3 +++
 include/linux/perf/arm_pmu.h                  |  1 +
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
index 97ba45a..27f5873 100644
--- a/Documentation/devicetree/bindings/arm/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/pmu.txt
@@ -45,6 +45,16 @@ Optional properties:
 - qcom,no-pc-write : Indicates that this PMU doesn't support the 0xc and 0xd
                      events.
 
+- secure-reg-access : Indicates that the ARMv7 Secure Debug Enable Register
+		      (SDER) is accessible. This will cause the driver to do
+		      any setup required that is only possible in ARMv7 secure
+		      state. If not present the ARMv7 SDER will not be touched,
+		      which means the PMU may fail to operate unless external
+		      code (bootloader or security monitor) has performed the
+		      appropriate initialisation. Note that this property is
+		      not valid for non-ARMv7 CPUs or ARMv7 CPUs booting Linux
+		      in Non-secure state.
+
 Example:
 
 pmu {
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 126dc67..1c3551c 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -600,6 +600,11 @@ static const unsigned scorpion_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 #define	ARMV7_EXCLUDE_USER	(1 << 30)
 #define	ARMV7_INCLUDE_HYP	(1 << 27)
 
+/*
+ * Secure debug enable reg
+ */
+#define ARMV7_SDER_SUNIDEN	BIT(1) /* Permit non-invasive debug */
+
 static inline u32 armv7_pmnc_read(void)
 {
 	u32 val;
@@ -982,7 +987,13 @@ static int armv7pmu_set_event_filter(struct hw_perf_event *event,
 static void armv7pmu_reset(void *info)
 {
 	struct arm_pmu *cpu_pmu = (struct arm_pmu *)info;
-	u32 idx, nb_cnt = cpu_pmu->num_events;
+	u32 idx, nb_cnt = cpu_pmu->num_events, val;
+
+	if (cpu_pmu->secure_access) {
+		asm volatile("mrc p15, 0, %0, c1, c1, 1" : "=r" (val));
+		val |= ARMV7_SDER_SUNIDEN;
+		asm volatile("mcr p15, 0, %0, c1, c1, 1" : : "r" (val));
+	}
 
 	/* The counter and interrupt enable registers are unknown at reset. */
 	for (idx = ARMV7_IDX_CYCLE_COUNTER; idx < nb_cnt; ++idx) {
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index be3755c..972e6b7 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -895,6 +895,9 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 	if (node && (of_id = of_match_node(of_table, pdev->dev.of_node))) {
 		init_fn = of_id->data;
 
+		pmu->secure_access = of_property_read_bool(pdev->dev.of_node,
+							   "secure-reg-access");
+
 		ret = of_pmu_irq_cfg(pmu);
 		if (!ret)
 			ret = init_fn(pmu);
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index bfa673b..4b8dc13 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -104,6 +104,7 @@ struct arm_pmu {
 	atomic_t	active_events;
 	struct mutex	reserve_mutex;
 	u64		max_period;
+	bool		secure_access;
 	struct platform_device	*plat_device;
 	struct pmu_hw_events	__percpu *hw_events;
 	struct notifier_block	hotplug_nb;
-- 
1.9.3
