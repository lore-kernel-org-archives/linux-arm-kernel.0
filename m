From: colin.king@canonical.com (Colin King)
Date: Mon, 18 May 2015 12:00:36 +0100
Subject: [PATCH][V2] ARM: 8351/1: perf: fix memory leak on return
Message-ID: <1431946836-11243-1-git-send-email-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Recent commit 3b8786ff7a1b31645ae2c26a2ec32dbd42ac1094
("ARM: 8352/1: perf: Fix the pmu node name in warning message")
introduced a memory leak of irqs on the "Don't bother with PPIs"
return path. This was picked up by static analysis by cppcheck:

[arch/arm/kernel/perf_event_cpu.c:315]: (error) Memory leak: irqs

Perform allocation of irqs after getting the irq hence removing need to
clean up an allocation on the PPI affine return path.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/arm/kernel/perf_event_cpu.c | 10 +++++-----
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
2.1.4
