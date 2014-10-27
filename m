From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 27 Oct 2014 12:06:38 +0000
Subject: [PATCHv2 8/9] arm: perf: dynamically allocate cpu hardware data
In-Reply-To: <1414411599-1938-1-git-send-email-mark.rutland@arm.com>
References: <1414411599-1938-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1414411599-1938-9-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To support multiple PMUs, each PMU will need its own accounting data.
As we don't know how (in general) many PMUs we'll have to support at
compile-time, we must allocate the data at runtime dynamically

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm/kernel/perf_event_cpu.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 5eecfe9..6e550cf 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -35,8 +35,6 @@
 /* Set at runtime when we know what CPU type we are. */
 static struct arm_pmu *cpu_pmu;
 
-static DEFINE_PER_CPU(struct pmu_hw_events, cpu_hw_events);
-
 /*
  * Despite the names, these two functions are CPU-specific and are used
  * by the OProfile/perf code.
@@ -162,16 +160,22 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
 	return 0;
 }
 
-static void cpu_pmu_init(struct arm_pmu *cpu_pmu)
+static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	int cpu;
+	struct pmu_hw_events __percpu *cpu_hw_events;
+
+	cpu_hw_events = alloc_percpu(struct pmu_hw_events);
+	if (!cpu_hw_events)
+		return -ENOMEM;
+
 	for_each_possible_cpu(cpu) {
-		struct pmu_hw_events *events = &per_cpu(cpu_hw_events, cpu);
+		struct pmu_hw_events *events = per_cpu_ptr(cpu_hw_events, cpu);
 		raw_spin_lock_init(&events->pmu_lock);
 		events->percpu_pmu = cpu_pmu;
 	}
 
-	cpu_pmu->hw_events	= &cpu_hw_events;
+	cpu_pmu->hw_events	= cpu_hw_events;
 	cpu_pmu->request_irq	= cpu_pmu_request_irq;
 	cpu_pmu->free_irq	= cpu_pmu_free_irq;
 
@@ -182,6 +186,13 @@ static void cpu_pmu_init(struct arm_pmu *cpu_pmu)
 	/* If no interrupts available, set the corresponding capability flag */
 	if (!platform_get_irq(cpu_pmu->plat_device, 0))
 		cpu_pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
+
+	return 0;
+}
+
+static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu)
+{
+	free_percpu(cpu_pmu->hw_events);
 }
 
 /*
@@ -303,12 +314,18 @@ static int cpu_pmu_device_probe(struct platform_device *pdev)
 		goto out_free;
 	}
 
-	cpu_pmu_init(cpu_pmu);
+	ret = cpu_pmu_init(cpu_pmu);
+	if (ret)
+		goto out_free;
+
 	ret = armpmu_register(cpu_pmu, -1);
+	if (ret)
+		goto out_destroy;
 
-	if (!ret)
-		return 0;
+	return 0;
 
+out_destroy:
+	cpu_pmu_destroy(cpu_pmu);
 out_free:
 	pr_info("failed to register PMU devices!\n");
 	kfree(pmu);
-- 
1.9.1
