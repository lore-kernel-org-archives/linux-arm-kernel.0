From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  1 Nov 2017 14:12:36 +0000
Subject: [PATCH 2/5] arm_pmu: have armpmu_alloc() take GFP flags
In-Reply-To: <20171101141239.45340-1-mark.rutland@arm.com>
References: <20171101141239.45340-1-mark.rutland@arm.com>
Message-ID: <20171101141239.45340-3-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In ACPI systems, we don't know the makeup of CPUs until we hotplug them
on, and thus have to allocate the PMU datastrcutures at hotplug time.
Thus, we must use GFP_ATOMIC allocations.

Reorganise the PMU allocators to take a GFP argument so that we can
permit this.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c          | 6 +++---
 drivers/perf/arm_pmu_acpi.c     | 2 +-
 drivers/perf/arm_pmu_platform.c | 2 +-
 include/linux/perf/arm_pmu.h    | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 57df8dce8e19..3d6d4c5f2356 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -779,18 +779,18 @@ static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu)
 					    &cpu_pmu->node);
 }
 
-struct arm_pmu *armpmu_alloc(void)
+struct arm_pmu *armpmu_alloc(gfp_t flags)
 {
 	struct arm_pmu *pmu;
 	int cpu;
 
-	pmu = kzalloc(sizeof(*pmu), GFP_KERNEL);
+	pmu = kzalloc(sizeof(*pmu), flags);
 	if (!pmu) {
 		pr_info("failed to allocate PMU device!\n");
 		goto out;
 	}
 
-	pmu->hw_events = alloc_percpu(struct pmu_hw_events);
+	pmu->hw_events = alloc_percpu_gfp(struct pmu_hw_events, flags);
 	if (!pmu->hw_events) {
 		pr_info("failed to allocate per-cpu PMU data.\n");
 		goto out_free_pmu;
diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index 705f1a390e31..a52f5b673a15 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -127,7 +127,7 @@ static struct arm_pmu *arm_pmu_acpi_find_alloc_pmu(void)
 		return pmu;
 	}
 
-	pmu = armpmu_alloc();
+	pmu = armpmu_alloc(GFP_ATOMIC);
 	if (!pmu) {
 		pr_warn("Unable to allocate PMU for CPU%d\n",
 			smp_processor_id());
diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
index db863f14c406..686b3f28c5d1 100644
--- a/drivers/perf/arm_pmu_platform.c
+++ b/drivers/perf/arm_pmu_platform.c
@@ -203,7 +203,7 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 	struct arm_pmu *pmu;
 	int ret = -ENODEV;
 
-	pmu = armpmu_alloc();
+	pmu = armpmu_alloc(GFP_KERNEL);
 	if (!pmu)
 		return -ENOMEM;
 
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 97426407904d..52e6d56a6a4e 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -173,7 +173,7 @@ static inline int arm_pmu_acpi_probe(armpmu_init_fn init_fn) { return 0; }
 #endif
 
 /* Internal functions only for core arm_pmu code */
-struct arm_pmu *armpmu_alloc(void);
+struct arm_pmu *armpmu_alloc(gfp_t flags);
 void armpmu_free(struct arm_pmu *pmu);
 int armpmu_register(struct arm_pmu *pmu);
 int armpmu_request_irq(struct arm_pmu *armpmu, int cpu);
-- 
2.11.0
