From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 28 Apr 2016 16:05:01 +0100
Subject: [PATCH] [for 4.7] arm-ccn: Enable building as module
Message-ID: <1461855901-23794-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm-ccn driver uses irq_set_affinity, which is not exported and
hence cannot be built as a module, eventhough we have all the
bits ready. This patch makes use of the exported helper
irq_set_affinity_hint() instead. Also, the __free_irq expects
the affinity_hint to be NULL when we free the irq. So set the
affinity_hint to NULL at clean up.

Now that we can build it as a module, update the Kconfig to
reflect the change.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Acked-by: Pawel Moll <pawel.moll@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/Kconfig   |    2 +-
 drivers/bus/arm-ccn.c |    7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index d4a3a31..3efc996 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -48,7 +48,7 @@ config ARM_CCI5xx_PMU
 	  If unsure, say Y
 
 config ARM_CCN
-	bool "ARM CCN driver support"
+	tristate "ARM CCN driver support"
 	depends on ARM || ARM64
 	depends on PERF_EVENTS
 	help
diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index 7082c72..acc3eb5 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -1189,7 +1189,7 @@ static int arm_ccn_pmu_cpu_notifier(struct notifier_block *nb,
 		perf_pmu_migrate_context(&dt->pmu, cpu, target);
 		cpumask_set_cpu(target, &dt->cpu);
 		if (ccn->irq)
-			WARN_ON(irq_set_affinity(ccn->irq, &dt->cpu) != 0);
+			WARN_ON(irq_set_affinity_hint(ccn->irq, &dt->cpu) != 0);
 	default:
 		break;
 	}
@@ -1278,7 +1278,7 @@ static int arm_ccn_pmu_init(struct arm_ccn *ccn)
 
 	/* Also make sure that the overflow interrupt is handled by this CPU */
 	if (ccn->irq) {
-		err = irq_set_affinity(ccn->irq, &ccn->dt.cpu);
+		err = irq_set_affinity_hint(ccn->irq, &ccn->dt.cpu);
 		if (err) {
 			dev_err(ccn->dev, "Failed to set interrupt affinity!\n");
 			goto error_set_affinity;
@@ -1306,7 +1306,8 @@ static void arm_ccn_pmu_cleanup(struct arm_ccn *ccn)
 {
 	int i;
 
-	irq_set_affinity(ccn->irq, cpu_possible_mask);
+	if (ccn->irq)
+		irq_set_affinity_hint(ccn->irq, NULL);
 	unregister_cpu_notifier(&ccn->dt.cpu_nb);
 	for (i = 0; i < ccn->num_xps; i++)
 		writel(0, ccn->xp[i].base + CCN_XP_DT_CONTROL);
-- 
1.7.9.5
