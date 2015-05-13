From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 13 May 2015 17:12:24 +0100
Subject: [PATCH 2/7] arm: perf: make of_pmu_irq_cfg take arm_pmu
In-Reply-To: <1431533549-27715-1-git-send-email-mark.rutland@arm.com>
References: <1431533549-27715-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1431533549-27715-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To support multiple PMUs we'll need to pass the arm_pmu instance around.
Update of_pmu_irq_cfg to take an arm_pmu, and acquire the platform
device from this.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_cpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 91c7ba1..2a9003e 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -301,9 +301,10 @@ static int probe_current_pmu(struct arm_pmu *pmu)
 	return ret;
 }
 
-static int of_pmu_irq_cfg(struct platform_device *pdev)
+static int of_pmu_irq_cfg(struct arm_pmu *pmu)
 {
 	int i;
+	struct platform_device *pdev = pmu->plat_device;
 	int *irqs = kcalloc(pdev->num_resources, sizeof(*irqs), GFP_KERNEL);
 
 	if (!irqs)
@@ -336,7 +337,7 @@ static int of_pmu_irq_cfg(struct platform_device *pdev)
 	}
 
 	if (i == pdev->num_resources)
-		cpu_pmu->irq_affinity = irqs;
+		pmu->irq_affinity = irqs;
 	else
 		kfree(irqs);
 
@@ -368,7 +369,7 @@ static int cpu_pmu_device_probe(struct platform_device *pdev)
 	if (node && (of_id = of_match_node(cpu_pmu_of_device_ids, pdev->dev.of_node))) {
 		init_fn = of_id->data;
 
-		ret = of_pmu_irq_cfg(pdev);
+		ret = of_pmu_irq_cfg(pmu);
 		if (!ret)
 			ret = init_fn(pmu);
 	} else {
-- 
1.9.1
