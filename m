From: will.deacon@arm.com (Will Deacon)
Date: Thu, 23 Apr 2015 14:50:32 +0100
Subject: [PATCH 3/4] arm64: perf: don't warn about missing interrupt-affinity
 property for PPIs
In-Reply-To: <1429797033-3787-1-git-send-email-will.deacon@arm.com>
References: <1429797033-3787-1-git-send-email-will.deacon@arm.com>
Message-ID: <1429797033-3787-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PPIs are affine by nature, so the interrupt-affinity property is not
used and therefore we shouldn't print a warning in its absence.

Reported-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/perf_event.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 195991dadc37..2a9cbcb61126 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1310,7 +1310,7 @@ static const struct of_device_id armpmu_of_device_ids[] = {
 
 static int armpmu_device_probe(struct platform_device *pdev)
 {
-	int i, *irqs;
+	int i, irq, *irqs;
 
 	if (!cpu_pmu)
 		return -ENODEV;
@@ -1319,6 +1319,11 @@ static int armpmu_device_probe(struct platform_device *pdev)
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
