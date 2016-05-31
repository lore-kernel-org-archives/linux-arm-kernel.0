From: julien.grall@arm.com (Julien Grall)
Date: Tue, 31 May 2016 12:41:23 +0100
Subject: [PATCH 3/3] drivers/perf: arm_pmu: Avoid leaking pmu->irq_affinity on
 error
In-Reply-To: <1464694883-26298-1-git-send-email-julien.grall@arm.com>
References: <1464694883-26298-1-git-send-email-julien.grall@arm.com>
Message-ID: <1464694883-26298-4-git-send-email-julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pmu->irq_affinity will not be freed if an error occurred within
arm_pmu_device_probe after of_pmu_irq_cfg has been called.

Note that in the case of_pmu_irq_cfg is returning an error,
pmu->irq_affinity will not be set, but it should be NULL as pmu was
kzalloc'd. Therefore the result kfree(NULL) is benign.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/perf/arm_pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 95614d2..1b8304e 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -1040,6 +1040,7 @@ out_destroy:
 out_free:
 	pr_info("%s: failed to register PMU devices!\n",
 		of_node_full_name(node));
+	kfree(pmu->irq_affinity);
 	kfree(pmu);
 	return ret;
 }
-- 
1.9.1
