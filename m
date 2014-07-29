From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 29 Jul 2014 14:33:01 +0200
Subject: [PATCH 2/4] ARM: perf: Add platform specific start/stop callbacks.
In-Reply-To: <20140729123256.13347.79778.stgit@localhost>
References: <20140729123256.13347.79778.stgit@localhost>
Message-ID: <20140729123301.13347.39881.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms (such as i.MX53) require SOC specific registers
to be manipulated to make the PMU work.

Add callback hooks to support this.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 arch/arm/include/asm/pmu.h   |    9 +++++++++
 arch/arm/kernel/perf_event.c |   13 ++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index 0bd181f..0f361c9 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -15,6 +15,8 @@
 #include <linux/interrupt.h>
 #include <linux/perf_event.h>
 
+struct arm_pmu;
+
 /*
  * struct arm_pmu_platdata - ARM PMU platform data
  *
@@ -32,12 +34,18 @@
  *	succession this handler will only be called following the
  *	final call to pm_runtime_put() that actually disables the
  *	hardware.
+ * @start: an optional handler which will be called before starting
+ *	the PMU to do any platform specific setup
+ * @stop: an optional handler which be called after stopping the PMU
+ *	to do any platform specific teardown
  */
 struct arm_pmu_platdata {
 	irqreturn_t (*handle_irq)(int irq, void *dev,
 				  irq_handler_t pmu_handler);
 	int (*runtime_resume)(struct device *dev);
 	int (*runtime_suspend)(struct device *dev);
+	void (*start)(struct arm_pmu *arm_pmu);
+	void (*stop)(struct arm_pmu *arm_pmu);
 };
 
 #ifdef CONFIG_HW_PERF_EVENTS
@@ -67,6 +75,7 @@ struct pmu_hw_events {
 	 */
 	unsigned int		activated_flags;
 	#define ARM_PMU_ACTIVATED_SECURE_DEBUG	(1 << 0)
+	#define ARM_PMU_ACTIVATED_PLATFORM	(1 << 1)
 };
 
 struct arm_pmu {
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 4238bcb..d0d9a25 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -469,16 +469,27 @@ static void armpmu_enable(struct pmu *pmu)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(pmu);
 	struct pmu_hw_events *hw_events = armpmu->get_hw_events();
+	struct arm_pmu_platdata *plat =
+				dev_get_platdata(&armpmu->plat_device->dev);
+
 	int enabled = bitmap_weight(hw_events->used_mask, armpmu->num_events);
 
-	if (enabled)
+	if (enabled) {
+		if (plat && plat->start)
+			plat->start(armpmu);
 		armpmu->start(armpmu);
+	}
 }
 
 static void armpmu_disable(struct pmu *pmu)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(pmu);
+	struct arm_pmu_platdata *plat =
+				dev_get_platdata(&armpmu->plat_device->dev);
+
 	armpmu->stop(armpmu);
+	if (plat && plat->stop)
+		plat->stop(armpmu);
 }
 
 #ifdef CONFIG_PM_RUNTIME
