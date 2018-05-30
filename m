From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 30 May 2018 17:15:27 +0200
Subject: [PATCH 2/3] ARM: shmobile: apmu: Remove obsolete
 shmobile_smp_apmu_prepare_cpus()
In-Reply-To: <1527693328-10559-1-git-send-email-geert+renesas@glider.be>
References: <1527693328-10559-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1527693328-10559-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the removal of the legacy SMP fallbacks, there are no more users
left of shmobile_smp_apmu_prepare_cpus().

Remove it, together with the legacy SMP config parser.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 40 -----------------------------------
 arch/arm/mach-shmobile/platsmp-apmu.h |  8 -------
 2 files changed, 48 deletions(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 778b6b618ce7c088..42c9405e556b14aa 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -106,38 +106,6 @@ static void apmu_init_cpu(struct resource *res, int cpu, int bit)
 	writel(x, apmu_cpus[cpu].iomem + DBGRCR_OFFS);
 }
 
-static void apmu_parse_cfg(void (*fn)(struct resource *res, int cpu, int bit),
-			   struct rcar_apmu_config *apmu_config, int num)
-{
-	int id;
-	int k;
-	int bit, index;
-	bool is_allowed;
-
-	for (k = 0; k < num; k++) {
-		/* only enable the cluster that includes the boot CPU */
-		is_allowed = false;
-		for (bit = 0; bit < ARRAY_SIZE(apmu_config[k].cpus); bit++) {
-			id = apmu_config[k].cpus[bit];
-			if (id >= 0) {
-				if (id == cpu_logical_map(0))
-					is_allowed = true;
-			}
-		}
-		if (!is_allowed)
-			continue;
-
-		for (bit = 0; bit < ARRAY_SIZE(apmu_config[k].cpus); bit++) {
-			id = apmu_config[k].cpus[bit];
-			if (id >= 0) {
-				index = get_logical_index(id);
-				if (index >= 0)
-					fn(&apmu_config[k].iomem, index, bit);
-			}
-		}
-	}
-}
-
 static const struct of_device_id apmu_ids[] = {
 	{ .compatible = "renesas,apmu" },
 	{ /*sentinel*/ }
@@ -194,14 +162,6 @@ static void __init shmobile_smp_apmu_setup_boot(void)
 	shmobile_boot_fn_gen2 = shmobile_boot_fn;
 }
 
-void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus,
-					   struct rcar_apmu_config *apmu_config,
-					   int num)
-{
-	shmobile_smp_apmu_setup_boot();
-	apmu_parse_cfg(apmu_init_cpu, apmu_config, num);
-}
-
 int shmobile_smp_apmu_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	/* For this particular CPU register boot vector */
diff --git a/arch/arm/mach-shmobile/platsmp-apmu.h b/arch/arm/mach-shmobile/platsmp-apmu.h
index 76512c9a2545da75..70424572b9da2e70 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.h
+++ b/arch/arm/mach-shmobile/platsmp-apmu.h
@@ -16,14 +16,6 @@
 #ifndef PLATSMP_APMU_H
 #define PLATSMP_APMU_H
 
-struct rcar_apmu_config {
-	struct resource iomem;
-	int cpus[4];
-};
-
-extern void shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus,
-					   struct rcar_apmu_config *apmu_config,
-					   int num);
 extern int shmobile_smp_apmu_boot_secondary(unsigned int cpu,
 					    struct task_struct *idle);
 extern void shmobile_smp_apmu_cpu_die(unsigned int cpu);
-- 
2.7.4
