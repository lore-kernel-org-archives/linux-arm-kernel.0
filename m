From: will.deacon@arm.com (Will Deacon)
Date: Thu, 23 Apr 2015 14:50:30 +0100
Subject: [PATCH 1/4] ARM: perf: don't warn about missing interrupt-affinity
 property for PPIs
Message-ID: <1429797033-3787-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PPIs are affine by nature, so the interrupt-affinity property is not
used and therefore we shouldn't print a warning in its absence.

Reported-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_cpu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 91c7ba182dcd..becf7ad6eddc 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -303,12 +303,17 @@ static int probe_current_pmu(struct arm_pmu *pmu)
 
 static int of_pmu_irq_cfg(struct platform_device *pdev)
 {
-	int i;
+	int i, irq;
 	int *irqs = kcalloc(pdev->num_resources, sizeof(*irqs), GFP_KERNEL);
 
 	if (!irqs)
 		return -ENOMEM;
 
+	/* Don't bother with PPIs; they're already affine */
+	irq = platform_get_irq(pdev, 0);
+	if (irq >= 0 && irq_is_percpu(irq))
+		return 0;
+
 	for (i = 0; i < pdev->num_resources; ++i) {
 		struct device_node *dn;
 		int cpu;
-- 
2.1.4
