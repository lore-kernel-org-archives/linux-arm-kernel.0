From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 May 2015 18:41:44 +0100
Subject: [PATCH 2/2] arm64: perf: fix memory leak when probing PMU PPIs
In-Reply-To: <1431366104-27393-1-git-send-email-will.deacon@arm.com>
References: <1431366104-27393-1-git-send-email-will.deacon@arm.com>
Message-ID: <1431366104-27393-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit d795ef9aa831 ("arm64: perf: don't warn about missing
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
 arch/arm64/kernel/perf_event.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 23f25acf43a9..cce18c85d2e8 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1315,15 +1315,15 @@ static int armpmu_device_probe(struct platform_device *pdev)
 	if (!cpu_pmu)
 		return -ENODEV;
 
-	irqs = kcalloc(pdev->num_resources, sizeof(*irqs), GFP_KERNEL);
-	if (!irqs)
-		return -ENOMEM;
-
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
