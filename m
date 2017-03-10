From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 10 Mar 2017 11:04:46 +0000
Subject: [PATCH 09/14] drivers/perf: arm_pmu: move irq request/free into probe
In-Reply-To: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
References: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1489143891-11596-10-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we request (and potentially free) all IRQs for a given PMU in
cpu_pmu_init(). This works for platform/DT probing today, but it doesn't
fit ACPI well as we don't have all our affinity data up-front.

In preparation for ACPI support, fold the IRQ request/free into
arm_pmu_device_probe(), which will remain specific to platform/DT
probing.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 5e5ea12..d202a73 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -758,10 +758,6 @@ static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	int err;
 
-	err = armpmu_request_irqs(cpu_pmu);
-	if (err)
-		goto out;
-
 	err = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_STARTING,
 				       &cpu_pmu->node);
 	if (err)
@@ -777,7 +773,6 @@ static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
 	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_STARTING,
 					    &cpu_pmu->node);
 out:
-	armpmu_free_irqs(cpu_pmu);
 	return err;
 }
 
@@ -1073,12 +1068,18 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 		goto out_free;
 	}
 
+	ret = armpmu_request_irqs(pmu);
+	if (ret)
+		goto out_free_irqs;
+
 	ret = armpmu_register(pmu);
 	if (ret)
 		goto out_free;
 
 	return 0;
 
+out_free_irqs:
+	armpmu_free_irqs(pmu);
 out_free:
 	pr_info("%s: failed to register PMU devices!\n",
 		of_node_full_name(node));
-- 
1.9.1
