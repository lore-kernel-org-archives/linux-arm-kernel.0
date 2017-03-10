From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 10 Mar 2017 11:04:42 +0000
Subject: [PATCH 05/14] drivers/perf: arm_pmu: simplify cpu_pmu_request_irqs()
In-Reply-To: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
References: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1489143891-11596-6-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM PMU framework code always uses armpmu_dispatch_irq as its common
IRQ handler. Passing this down from cpu_pmu_init() is somewhat
pointless, and gets in the way of refactoring.

This patch makes cpu_pmu_request_irqs() always use armpmu_dispatch_irq
as the handler when requesting IRQs, and removes the handler parameter
from its prototype.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 4ae9c49..6196777 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -543,10 +543,11 @@ static void cpu_pmu_free_irqs(struct arm_pmu *cpu_pmu)
 	}
 }
 
-static int cpu_pmu_request_irqs(struct arm_pmu *cpu_pmu, irq_handler_t handler)
+static int cpu_pmu_request_irqs(struct arm_pmu *cpu_pmu)
 {
 	int cpu, err;
 	struct pmu_hw_events __percpu *hw_events = cpu_pmu->hw_events;
+	const irq_handler_t handler = armpmu_dispatch_irq;
 
 	for_each_cpu(cpu, &cpu_pmu->supported_cpus) {
 		int irq = per_cpu(hw_events->irq, cpu);
@@ -735,7 +736,7 @@ static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	int err;
 
-	err = cpu_pmu_request_irqs(cpu_pmu, armpmu_dispatch_irq);
+	err = cpu_pmu_request_irqs(cpu_pmu);
 	if (err)
 		goto out;
 
-- 
1.9.1
