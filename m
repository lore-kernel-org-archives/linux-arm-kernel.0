From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 15 Nov 2018 16:11:30 +0100
Subject: [PATCH 1/9] ARM: EXYNOS: remove secondary startup initialization
 from smp_prepare_cpus
In-Reply-To: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
References: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20181115151211epcas2p4fdc719d354f2a732f70667ccbd8f1bae@epcas2p4.samsung.com>
Message-ID: <1542294698-17470-2-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pankaj Dubey <pankaj.dubey@samsung.com>

We are taking care of setting secondary cpu boot address in
exynos_boot_secondary just before sending ipi to secondary CPUs,
so we can safely remove this setting from smp_prepare_cpus.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/platsmp.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 6a1e682..c39ffd2 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -397,38 +397,12 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
 {
-	int i;
-
 	exynos_sysram_init();
 
 	exynos_set_delayed_reset_assertion(true);
 
 	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9)
 		exynos_scu_enable();
-
-	/*
-	 * Write the address of secondary startup into the
-	 * system-wide flags register. The boot monitor waits
-	 * until it receives a soft interrupt, and then the
-	 * secondary CPU branches to this address.
-	 *
-	 * Try using firmware operation first and fall back to
-	 * boot register if it fails.
-	 */
-	for (i = 1; i < max_cpus; ++i) {
-		unsigned long boot_addr;
-		u32 mpidr;
-		u32 core_id;
-		int ret;
-
-		mpidr = cpu_logical_map(i);
-		core_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-		boot_addr = __pa_symbol(exynos4_secondary_startup);
-
-		ret = exynos_set_boot_addr(core_id, boot_addr);
-		if (ret)
-			break;
-	}
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-- 
1.9.1
