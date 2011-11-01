From: ming.lei@canonical.com (Ming Lei)
Date: Tue, 1 Nov 2011 11:26:46 +0800
Subject: [PATCH v5 2/7] arm: pmu: allow platform specific irq
	enable/disable handling
In-Reply-To: <1319467559-5518-3-git-send-email-ming.lei@canonical.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
	<1319467559-5518-3-git-send-email-ming.lei@canonical.com>
Message-ID: <20111101112646.75fba9db@tom-ThinkPad-T410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Attach the patch [PATCH v5 2/7] which is rebased on 3.1 -next.

BTW: The [PATCH v5 3/7] should be dropped as commented before, other patches
are OK against 3.1 -next.

thanks,
--
Ming Lei

--
>From 6125bef1aeee84ef22efdf743077f27f5274b6da Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@canonical.com>
Date: Wed, 2 Mar 2011 15:00:08 +0800
Subject: [PATCH v6 2/6] arm: pmu: allow platform specific irq enable/disable
 handling

This patch introduces .enable_irq and .disable_irq into
struct arm_pmu_platdata, so platform specific irq enablement
can be handled after request_irq, and platform specific irq
disablement can be handled before free_irq.

This patch is for support of  pmu irq routed from CTI on omap4.

Acked-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 arch/arm/include/asm/pmu.h   |   15 ++++++++++++---
 arch/arm/kernel/perf_event.c |   10 ++++++++--
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index 71d99b8..46a96a8 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -27,13 +27,22 @@ enum arm_pmu_type {
 /*
  * struct arm_pmu_platdata - ARM PMU platform data
  *
- * @handle_irq: an optional handler which will be called from the interrupt and
- * passed the address of the low level handler, and can be used to implement
- * any platform specific handling before or after calling it.
+ * @handle_irq: an optional handler which will be called from the
+ *	interrupt and passed the address of the low level handler,
+ *	and can be used to implement any platform specific handling
+ *	before or after calling it.
+ * @enable_irq: an optional handler which will be called after
+ *	request_irq and be used to handle some platform specific
+ *	irq enablement
+ * @disable_irq: an optional handler which will be called before
+ *	free_irq and be used to handle some platform specific
+ *	irq disablement
  */
 struct arm_pmu_platdata {
 	irqreturn_t (*handle_irq)(int irq, void *dev,
 				  irq_handler_t pmu_handler);
+	void (*enable_irq)(int irq);
+	void (*disable_irq)(int irq);
 };
 
 #ifdef CONFIG_CPU_HAS_PMU
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index e6e5d7c..4c4aa83 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -374,6 +374,8 @@ armpmu_release_hardware(struct arm_pmu *armpmu)
 {
 	int i, irq, irqs;
 	struct platform_device *pmu_device = armpmu->plat_device;
+	struct arm_pmu_platdata *plat =
+		dev_get_platdata(&pmu_device->dev);
 
 	irqs = min(pmu_device->num_resources, num_possible_cpus());
 
@@ -381,8 +383,11 @@ armpmu_release_hardware(struct arm_pmu *armpmu)
 		if (!cpumask_test_and_clear_cpu(i, &armpmu->active_irqs))
 			continue;
 		irq = platform_get_irq(pmu_device, i);
-		if (irq >= 0)
+		if (irq >= 0) {
+			if (plat && plat->disable_irq)
+				plat->disable_irq(irq);
 			free_irq(irq, armpmu);
+		}
 	}
 
 	release_pmu(armpmu->type);
@@ -439,7 +444,8 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
 				irq);
 			armpmu_release_hardware(armpmu);
 			return err;
-		}
+		} else if (plat && plat->enable_irq)
+			plat->enable_irq(irq);
 
 		cpumask_set_cpu(i, &armpmu->active_irqs);
 	}
-- 
1.7.5.4





-- 
Ming Lei
