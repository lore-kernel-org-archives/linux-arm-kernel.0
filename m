From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 21 Jan 2015 17:03:42 +0000
Subject: [RFC PATCH v2 5/5] arm: perf: Use FIQ to handle PMU events.
In-Reply-To: <1421859822-3621-1-git-send-email-daniel.thompson@linaro.org>
References: <1421166931-14134-1-git-send-email-daniel.thompson@linaro.org>
 <1421859822-3621-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1421859822-3621-6-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using FIQ (if it is available) gives perf a better insight into the
system by allowing code run with interrupts disabled to be profiled.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/include/asm/pmu.h       |  2 ++
 arch/arm/kernel/perf_event.c     |  2 +-
 arch/arm/kernel/perf_event_cpu.c | 14 +++++++++++---
 arch/arm/kernel/traps.c          |  4 ++++
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index b1596bd59129..e6c87e393547 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -123,6 +123,8 @@ struct arm_pmu {
 
 extern const struct dev_pm_ops armpmu_dev_pm_ops;
 
+irqreturn_t armpmu_dispatch_irq(int irq, void *dev);
+
 int armpmu_register(struct arm_pmu *armpmu, int type);
 
 u64 armpmu_event_update(struct perf_event *event);
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index f7c65adaa428..5ae9adf7f18e 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -296,7 +296,7 @@ validate_group(struct perf_event *event)
 	return 0;
 }
 
-static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
+irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
 {
 	struct arm_pmu *armpmu;
 	struct platform_device *plat_device;
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index b30a2645c2f1..e5c9c5d607ab 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -177,9 +177,17 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
 				continue;
 			}
 
-			err = request_irq(irq, handler,
-					  IRQF_NOBALANCING | IRQF_NO_THREAD, "arm-pmu",
-					  per_cpu_ptr(&hw_events->percpu_pmu, i));
+			err = request_irq(
+			    irq, handler,
+			    IRQF_NOBALANCING | IRQF_NMI,
+			    "arm-pmu", per_cpu_ptr(&hw_events->percpu_pmu, i));
+			if (err) {
+				err = request_irq(
+				    irq, handler,
+				    IRQF_NOBALANCING | IRQF_NO_THREAD,
+				    "arm-pmu",
+				    per_cpu_ptr(&hw_events->percpu_pmu, i));
+			}
 			if (err) {
 				pr_err("unable to request IRQ%d for ARM PMU counters\n",
 					irq);
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 445fdf26b1af..a5ffddeb224e 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -39,6 +39,7 @@
 #include <asm/tls.h>
 #include <asm/system_misc.h>
 #include <asm/opcodes.h>
+#include <asm/pmu.h>
 
 
 static const char *handler[]= {
@@ -466,6 +467,9 @@ die_sig:
 int arch_filter_nmi_handler(irq_handler_t handler)
 {
 	irq_handler_t whitelist[] = {
+#ifdef CONFIG_HW_PERF_EVENTS
+		armpmu_dispatch_irq,
+#endif
 	};
 	int i;
 
-- 
1.9.3
