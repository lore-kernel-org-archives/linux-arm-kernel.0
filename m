From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  6 Jan 2017 12:18:59 +0100
Subject: [PATCH 4/5] ARM: shmobile: r8a7791: Allow booting secondary CPU cores
 in debug mode
In-Reply-To: <cover.1483701101.git.horms+renesas@verge.net.au>
References: <cover.1483701101.git.horms+renesas@verge.net.au>
Message-ID: <367ed998fa3e04d8bde42f431e880cd3e5922095.1483701101.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Now debug resource reset is handled properly, allow booting secondary
CPU cores when hardware debug mode is enabled (MD21=1, SW8-4=OFF on
koelsch) on legacy r8a7791.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-r8a7791.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7791.c b/arch/arm/mach-shmobile/smp-r8a7791.c
index 2d6417af73b5..2948c22cfc53 100644
--- a/arch/arm/mach-shmobile/smp-r8a7791.c
+++ b/arch/arm/mach-shmobile/smp-r8a7791.c
@@ -42,21 +42,9 @@ static void __init r8a7791_smp_prepare_cpus(unsigned int max_cpus)
 	rcar_gen2_pm_init();
 }
 
-static int r8a7791_smp_boot_secondary(unsigned int cpu,
-				      struct task_struct *idle)
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
 const struct smp_operations r8a7791_smp_ops __initconst = {
 	.smp_prepare_cpus	= r8a7791_smp_prepare_cpus,
-	.smp_boot_secondary	= r8a7791_smp_boot_secondary,
+	.smp_boot_secondary	= shmobile_smp_apmu_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_can_disable	= shmobile_smp_cpu_can_disable,
 	.cpu_die		= shmobile_smp_apmu_cpu_die,
-- 
2.7.0.rc3.207.g0ac5344
