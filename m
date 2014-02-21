From: will.deacon@arm.com (Will Deacon)
Date: Fri, 21 Feb 2014 16:54:31 +0000
Subject: [PATCH 1/3] ARM: perf: hook up perf_sample_event_took around pmu irq
 handling
In-Reply-To: <1393001673-8589-1-git-send-email-will.deacon@arm.com>
References: <1393001673-8589-1-git-send-email-will.deacon@arm.com>
Message-ID: <1393001673-8589-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we indirect all of our PMU IRQ handling through a dispatcher, it's
trivial to hook up perf_sample_event_took to prevent applications such
as oprofile from generating interrupt storms due to an unrealisticly
low sample period.

Reported-by: Robert Richter <rric@kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 361a1aaee7c8..a6bc431cde70 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -302,6 +302,8 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
 	struct arm_pmu *armpmu;
 	struct platform_device *plat_device;
 	struct arm_pmu_platdata *plat;
+	int ret;
+	u64 start_clock, finish_clock;
 
 	if (irq_is_percpu(irq))
 		dev = *(void **)dev;
@@ -309,10 +311,15 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
 	plat_device = armpmu->plat_device;
 	plat = dev_get_platdata(&plat_device->dev);
 
+	start_clock = sched_clock();
 	if (plat && plat->handle_irq)
-		return plat->handle_irq(irq, dev, armpmu->handle_irq);
+		ret = plat->handle_irq(irq, dev, armpmu->handle_irq);
 	else
-		return armpmu->handle_irq(irq, dev);
+		ret = armpmu->handle_irq(irq, dev);
+	finish_clock = sched_clock();
+
+	perf_sample_event_took(finish_clock - start_clock);
+	return ret;
 }
 
 static void
-- 
1.8.2.2
