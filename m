From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 15 Jan 2014 09:55:30 -0800
Subject: [PATCH v2 2/7] ARM: perf_event: Assign pdev pointer earlier for CPU
 PMUs
In-Reply-To: <1389808535-23852-1-git-send-email-sboyd@codeaurora.org>
References: <1389808535-23852-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1389808535-23852-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to inspect the of_node that the pdev is pointing to in
the Krait CPU specific PMU initialization function. Assign it
earlier so that we don't crash with a NULL pointer dereference.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/kernel/perf_event_cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 6efd8aab15df..68d02ca0ca1b 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -311,6 +311,9 @@ static int cpu_pmu_device_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	cpu_pmu = pmu;
+	cpu_pmu->plat_device = pdev;
+
 	if (node && (of_id = of_match_node(cpu_pmu_of_device_ids, pdev->dev.of_node))) {
 		init_fn = of_id->data;
 		ret = init_fn(pmu);
@@ -323,8 +326,6 @@ static int cpu_pmu_device_probe(struct platform_device *pdev)
 		goto out_free;
 	}
 
-	cpu_pmu = pmu;
-	cpu_pmu->plat_device = pdev;
 	cpu_pmu_init(cpu_pmu);
 	ret = armpmu_register(cpu_pmu, PERF_TYPE_RAW);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
