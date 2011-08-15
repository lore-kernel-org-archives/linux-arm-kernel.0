From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 15 Aug 2011 14:55:11 +0100
Subject: [RFC PATCH 10/15] ARM: perf: add type field to struct arm_pmu
In-Reply-To: <1313416516-8006-1-git-send-email-mark.rutland@arm.com>
References: <1313416516-8006-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1313416516-8006-11-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the ARM perf code assumes all PMUs it will handle are
CPU PMUs, having ARM_PMU_DEVICE_CPU hardcoded when reserving or
releasing hardware. This means that currently, the ARM perf code can't
support system PMUs.

This patch adds a 'type' field to struct arm_pmu, which allows the code
to reserve & release the hardware regardless of the PMU type.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 9331d57..1a2ebbf 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -60,6 +60,7 @@ static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
 
 struct arm_pmu {
 	enum arm_perf_pmu_ids id;
+	enum arm_pmu_type type;
 	cpumask_t	active_irqs;
 	const char	*name;
 	irqreturn_t	(*handle_irq)(int irq_num, void *dev);
@@ -396,7 +397,7 @@ armpmu_release_hardware(void)
 			free_irq(irq, NULL);
 	}
 
-	release_pmu(ARM_PMU_DEVICE_CPU);
+	release_pmu(armpmu->type);
 }
 
 static int
@@ -407,7 +408,7 @@ armpmu_reserve_hardware(void)
 	int i, err, irq, irqs;
 	struct platform_device *pmu_device = armpmu->plat_device;
 
-	err = reserve_pmu(ARM_PMU_DEVICE_CPU);
+	err = reserve_pmu(armpmu->type);
 	if (err) {
 		pr_warning("unable to reserve pmu\n");
 		return err;
@@ -691,6 +692,7 @@ static void __init cpu_pmu_init(struct arm_pmu *armpmu)
 		raw_spin_lock_init(&events->pmu_lock);
 	}
 	armpmu->get_hw_events = armpmu_get_cpu_events;
+	armpmu->type = ARM_PMU_DEVICE_CPU;
 }
 
 /*
-- 
1.7.0.4
