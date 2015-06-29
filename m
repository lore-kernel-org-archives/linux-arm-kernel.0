From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 29 Jun 2015 14:58:46 -0700
Subject: [PATCH] arm: perf: Set affinity for PPI based PMUs
Message-ID: <1435615126-16492-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For PPI based PMUs, we bail out early in of_pmu_irq_cfg() without
setting the PMU's supported_cpus bitmap. This causes the
smp_call_function_any() in armv7_probe_num_events() to fail. Set
the bitmap to be all CPUs so that we properly probe PMUs that use
PPIs.

Fixes: cc88116da0d1 ("arm: perf: treat PMUs as CPU affine")
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/kernel/perf_event.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 54272e0be713..7d5379c1c443 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -795,8 +795,10 @@ static int of_pmu_irq_cfg(struct arm_pmu *pmu)
 
 	/* Don't bother with PPIs; they're already affine */
 	irq = platform_get_irq(pdev, 0);
-	if (irq >= 0 && irq_is_percpu(irq))
+	if (irq >= 0 && irq_is_percpu(irq)) {
+		cpumask_setall(&pmu->supported_cpus);
 		return 0;
+	}
 
 	irqs = kcalloc(pdev->num_resources, sizeof(*irqs), GFP_KERNEL);
 	if (!irqs)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
