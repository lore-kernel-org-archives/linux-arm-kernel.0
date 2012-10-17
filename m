From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Oct 2012 16:33:44 +0100
Subject: [PATCH 7/7] ARM: perf: consistently use arm_pmu->name for PMU name
In-Reply-To: <1350488024-3224-1-git-send-email-will.deacon@arm.com>
References: <1350488024-3224-1-git-send-email-will.deacon@arm.com>
Message-ID: <1350488024-3224-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Perf has three ways to name a PMU: either by passing an explicit char *,
reading arm_pmu->name or accessing arm_pmu->pmu.name.

Just use arm_pmu->name consistently in the ARM backend.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pmu.h       |    2 +-
 arch/arm/kernel/perf_event.c     |    4 ++--
 arch/arm/kernel/perf_event_cpu.c |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index a209a38..f24edad 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -93,7 +93,7 @@ struct arm_pmu {
 
 extern const struct dev_pm_ops armpmu_dev_pm_ops;
 
-int armpmu_register(struct arm_pmu *armpmu, char *name, int type);
+int armpmu_register(struct arm_pmu *armpmu, int type);
 
 u64 armpmu_event_update(struct perf_event *event);
 
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 710c65c..1f7166f 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -507,12 +507,12 @@ static void __init armpmu_init(struct arm_pmu *armpmu)
 	};
 }
 
-int armpmu_register(struct arm_pmu *armpmu, char *name, int type)
+int armpmu_register(struct arm_pmu *armpmu, int type)
 {
 	armpmu_init(armpmu);
 	pr_info("enabled with %s PMU driver, %d counters available\n",
 			armpmu->name, armpmu->num_events);
-	return perf_pmu_register(&armpmu->pmu, name, type);
+	return perf_pmu_register(&armpmu->pmu, armpmu->name, type);
 }
 
 /*
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index db9c6b5..9a4f630 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -46,7 +46,7 @@ const char *perf_pmu_name(void)
 	if (!cpu_pmu)
 		return NULL;
 
-	return cpu_pmu->pmu.name;
+	return cpu_pmu->name;
 }
 EXPORT_SYMBOL_GPL(perf_pmu_name);
 
@@ -287,7 +287,7 @@ static int __devinit cpu_pmu_device_probe(struct platform_device *pdev)
 	cpu_pmu = pmu;
 	cpu_pmu->plat_device = pdev;
 	cpu_pmu_init(cpu_pmu);
-	armpmu_register(cpu_pmu, cpu_pmu->name, PERF_TYPE_RAW);
+	armpmu_register(cpu_pmu, PERF_TYPE_RAW);
 
 	return 0;
 }
-- 
1.7.4.1
