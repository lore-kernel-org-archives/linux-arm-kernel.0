From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 May 2015 18:41:43 +0100
Subject: [PATCH 1/2] ARM: perf: fix memory leak when probing PMU PPIs
Message-ID: <1431366104-27393-1-git-send-email-will.deacon@arm.com>
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

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_cpu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 213919ba326f..3b8c2833c537 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -304,16 +304,17 @@ static int probe_current_pmu(struct arm_pmu *pmu)
 static int of_pmu_irq_cfg(struct platform_device *pdev)
 {
 	int i, irq;
-	int *irqs = kcalloc(pdev->num_resources, sizeof(*irqs), GFP_KERNEL);
-
-	if (!irqs)
-		return -ENOMEM;
+	int *irqs;
 
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
