From: ming.lei@canonical.com (ming.lei at canonical.com)
Date: Mon, 24 Oct 2011 22:45:55 +0800
Subject: [PATCH v5 3/7] arm: perf: support device with other non-irq resources
In-Reply-To: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
Message-ID: <1319467559-5518-4-git-send-email-ming.lei@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ming Lei <ming.lei@canonical.com>

omap4 may create device via hwmod, which can create resources
automatically, so may include some non-irq resources.

This patch supports device with other non-irq resources.

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 arch/arm/kernel/perf_event.c |    5 +++--
 arch/arm/kernel/pmu.c        |   12 ++++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index f367780..d91dba2 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/uaccess.h>
+#include <linux/cpumask.h>
 
 #include <asm/cputype.h>
 #include <asm/irq.h>
@@ -414,7 +415,7 @@ armpmu_reserve_hardware(void)
 		return -ENODEV;
 	}
 
-	for (i = 0; i < pmu_device->num_resources; ++i) {
+	for (i = 0; i < nr_cpu_ids; ++i) {
 		irq = platform_get_irq(pmu_device, i);
 		if (irq < 0)
 			continue;
@@ -453,7 +454,7 @@ armpmu_release_hardware(void)
 	struct arm_pmu_platdata *plat =
 		dev_get_platdata(&pmu_device->dev);
 
-	for (i = pmu_device->num_resources - 1; i >= 0; --i) {
+	for (i = nr_cpu_ids - 1; i >= 0; --i) {
 		irq = platform_get_irq(pmu_device, i);
 		if (irq >= 0) {
 			if (plat && plat->disable_irq)
diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
index c53474f..0e9c908 100644
--- a/arch/arm/kernel/pmu.c
+++ b/arch/arm/kernel/pmu.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/cpumask.h>
 
 #include <asm/pmu.h>
 
@@ -172,8 +173,15 @@ init_cpu_pmu(void)
 	if (irqs == 1 && !irq_can_set_affinity(platform_get_irq(pdev, 0)))
 		return 0;
 
-	for (i = 0; i < irqs; ++i) {
-		err = set_irq_affinity(platform_get_irq(pdev, i), i);
+	for (i = 0; i < nr_cpu_ids; ++i) {
+		int irq;
+
+		irq = platform_get_irq(pdev, i);
+
+		if (irq < 0)
+			continue;
+
+		err = set_irq_affinity(irq, i);
 		if (err)
 			break;
 	}
-- 
1.7.5.4
