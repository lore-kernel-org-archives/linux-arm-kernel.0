From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 11 Apr 2017 09:39:49 +0100
Subject: [PATCHv3 06/14] drivers/perf: arm_pmu: handle no platform_device
In-Reply-To: <1491899997-32210-1-git-send-email-mark.rutland@arm.com>
References: <1491899997-32210-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1491899997-32210-7-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In armpmu_dispatch_irq() we look at arm_pmu::plat_device to acquire
platdata, so that we can defer to platform-specific IRQ handling,
required on some 32-bit parts. With the advent of ACPI we won't always
have a platform_device, and so we must avoid trying to dereference
fields from it.

This patch fixes up armpmu_dispatch_irq() to avoid doing so, introducing
a new armpmu_get_platdata() helper.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 183c6fd..2442038 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -316,10 +316,16 @@ static void armpmu_start(struct perf_event *event, int flags)
 	return 0;
 }
 
+static struct arm_pmu_platdata *armpmu_get_platdata(struct arm_pmu *armpmu)
+{
+	struct platform_device *pdev = armpmu->plat_device;
+
+	return pdev ? dev_get_platdata(&pdev->dev) : NULL;
+}
+
 static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
 {
 	struct arm_pmu *armpmu;
-	struct platform_device *plat_device;
 	struct arm_pmu_platdata *plat;
 	int ret;
 	u64 start_clock, finish_clock;
@@ -331,8 +337,8 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
 	 * dereference.
 	 */
 	armpmu = *(void **)dev;
-	plat_device = armpmu->plat_device;
-	plat = dev_get_platdata(&plat_device->dev);
+
+	plat = armpmu_get_platdata(armpmu);
 
 	start_clock = sched_clock();
 	if (plat && plat->handle_irq)
-- 
1.9.1
