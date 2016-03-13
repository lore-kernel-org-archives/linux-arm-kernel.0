From: jeremy.linton@arm.com (Jeremy Linton)
Date: Sun, 13 Mar 2016 18:23:15 -0500
Subject: [PATCH 1/4] arm: pmu: Fix non-devicetree probing
In-Reply-To: <1457911398-22412-1-git-send-email-jeremy.linton@arm.com>
References: <1457911398-22412-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1457911398-22412-2-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Salter <msalter@redhat.com>

There is a problem in the non-devicetree PMU probing where some
probe functions may get the number of supported events through
smp_call_function_any() using the arm_pmu supported_cpus mask.
But at the time the probe function is called, the supported_cpus
mask is empty so the call fails. This patch makes sure the mask
is set before calling the init function rather than after.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 drivers/perf/arm_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 11bacc7..0f33c96 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -997,8 +997,8 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 		if (!ret)
 			ret = init_fn(pmu);
 	} else {
-		ret = probe_current_pmu(pmu, probe_table);
 		cpumask_setall(&pmu->supported_cpus);
+		ret = probe_current_pmu(pmu, probe_table);
 	}
 
 	if (ret) {
-- 
2.4.3
