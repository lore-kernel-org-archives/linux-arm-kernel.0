From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 14 Jan 2013 09:52:50 +0200
Subject: [PATCH 2/2] ARM: tegra: Use DT /cpu node to detect number of CPU core
In-Reply-To: <1358149970-28156-1-git-send-email-hdoyu@nvidia.com>
References: <1358149970-28156-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1358149970-28156-2-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SCU based detection only works with Cortex-A9 MP and it doesn't
support ones with multiple clusters. The only way to detect number of
CPU core correctly is with DT /cpu node. If DT /cpu node based
detection fails, we just simply fall back a single core in Tegra SoCs.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
Based on the discussion:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/140608.html
---
 arch/arm/mach-tegra/platsmp.c |   17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index 6867030..456e7cc 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -24,6 +24,7 @@
 #include <asm/mach-types.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_plat.h>
+#include <asm/prom.h>
 
 #include <mach/powergate.h>
 
@@ -177,22 +178,10 @@ done:
 	return status;
 }
 
-/*
- * Initialise the CPU possible map early - this describes the CPUs
- * which may be present or become present in the system.
- */
 static void __init tegra_smp_init_cpus(void)
 {
-	unsigned int i, ncores = scu_get_core_count(scu_base);
-
-	if (ncores > nr_cpu_ids) {
-		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
-			ncores, nr_cpu_ids);
-		ncores = nr_cpu_ids;
-	}
-
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
+	if (!arm_dt_cpu_map_valid())
+		set_cpu_possible(0, true);
 
 	set_smp_cross_call(gic_raise_softirq);
 }
-- 
1.7.9.5
