From: shailendra.capricorn@gmail.com (Shailendra Verma)
Date: Fri, 15 May 2015 21:11:54 +0530
Subject: [PATCH 10/10] arm: perf: Fix memory leak when probing PMU PPIs
Message-ID: <1431704514-4204-1-git-send-email-shailendra.capricorn@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 338d9dd3e2ae ("ARM: 8351/1: perf: don't warn about missing
interrupt-affinity property for PPIs") added a check for PPIs so that
we avoid parsing the interrupt-affinity property for these naturally
affine interrupts.

Unfortunately, this check can trigger an early (successful) return and
we will leak the irqs array. This patch fixes the issue by reordering
the code so that the check is performed before any independent
allocation.

Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
---
 arch/arm/kernel/perf_event_cpu.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 213919b..a7099ee 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -303,17 +303,17 @@ static int probe_current_pmu(struct arm_pmu *pmu)
 
 static int of_pmu_irq_cfg(struct platform_device *pdev)
 {
-	int i, irq;
-	int *irqs = kcalloc(pdev->num_resources, sizeof(*irqs), GFP_KERNEL);
-
-	if (!irqs)
-		return -ENOMEM;
+	int i, irq, *irqs;
 
 	/* Don't bother with PPIs; they're already affine */
 	irq = platform_get_irq(pdev, 0);
 	if (irq >= 0 && irq_is_percpu(irq))
 		return 0;
 
+	irqs = kcalloc(pdev->num_resources, sizeof(*irqs), GFP_KERNEL);
+	if (!irqs)
+		return -ENOMEM;
+
 	for (i = 0; i < pdev->num_resources; ++i) {
 		struct device_node *dn;
 		int cpu;
-- 
1.7.9.5
