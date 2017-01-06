From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  6 Jan 2017 12:18:58 +0100
Subject: [PATCH 3/5] ARM: shmobile: apmu: Allow booting secondary CPU cores in
 debug mode
In-Reply-To: <cover.1483701101.git.horms+renesas@verge.net.au>
References: <cover.1483701101.git.horms+renesas@verge.net.au>
Message-ID: <d03c8f78d03af2a46127537dd1daa67164e53c09.1483701101.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Now debug resource reset is handled properly, allow booting secondary
CPU cores when hardware debug mode is enabled (MD21=1) on SoCs using the
"renesas,apmu" enable method.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 7e4ca6788be5..e19266844e16 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -216,21 +216,9 @@ static void __init shmobile_smp_apmu_prepare_cpus_dt(unsigned int max_cpus)
 	rcar_gen2_pm_init();
 }
 
-static int shmobile_smp_apmu_boot_secondary_md21(unsigned int cpu,
-						 struct task_struct *idle)
-{
-	/* Error out when hardware debug mode is enabled */
-	if (rcar_gen2_read_mode_pins() & BIT(21)) {
-		pr_warn("Unable to boot CPU%u when MD21 is set\n", cpu);
-		return -ENOTSUPP;
-	}
-
-	return shmobile_smp_apmu_boot_secondary(cpu, idle);
-}
-
 static struct smp_operations apmu_smp_ops __initdata = {
 	.smp_prepare_cpus	= shmobile_smp_apmu_prepare_cpus_dt,
-	.smp_boot_secondary	= shmobile_smp_apmu_boot_secondary_md21,
+	.smp_boot_secondary	= shmobile_smp_apmu_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_can_disable	= shmobile_smp_cpu_can_disable,
 	.cpu_die		= shmobile_smp_apmu_cpu_die,
-- 
2.7.0.rc3.207.g0ac5344
