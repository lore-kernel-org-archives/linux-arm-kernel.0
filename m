From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Mon, 29 Jun 2015 16:02:40 +0800
Subject: [PATCH] arm64: perf: fix unassigned cpu_pmu->plat_device when probing
 PMU PPIs
Message-ID: <1435564960-9516-1-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Commit d795ef9aa831 ("arm64: perf: don't warn about missing
interrupt-affinity property for PPIs") added a check for PPIs so that
we avoid parsing the interrupt-affinity property for these naturally
affine interrupts.

Unfortunately, this check can trigger an early (successful) return and
we will not assign the value of cpu_pmu->plat_device. This patch fixes
the issue.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 arch/arm64/kernel/perf_event.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 702591f..fd26e57 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1318,7 +1318,7 @@ static int armpmu_device_probe(struct platform_device *pdev)
 	/* Don't bother with PPIs; they're already affine */
 	irq = platform_get_irq(pdev, 0);
 	if (irq >= 0 && irq_is_percpu(irq))
-		return 0;
+		goto out;
 
 	irqs = kcalloc(pdev->num_resources, sizeof(*irqs), GFP_KERNEL);
 	if (!irqs)
@@ -1355,6 +1355,7 @@ static int armpmu_device_probe(struct platform_device *pdev)
 	else
 		kfree(irqs);
 
+out:
 	cpu_pmu->plat_device = pdev;
 	return 0;
 }
-- 
2.0.4
