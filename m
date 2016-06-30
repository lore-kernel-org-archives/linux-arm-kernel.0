From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:16:22 +0200
Subject: [PATCH 6/8] ARM: shmobile: smp: Add function to prioritize DT SMP
In-Reply-To: <cover.1467293089.git.horms+renesas@verge.net.au>
References: <cover.1467293089.git.horms+renesas@verge.net.au>
Message-ID: <c21af444eace56619e33df0b1fc67ec2e33481ac.1467293089.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Add a function to check if other DT based method is available, and
if so return false to not hook up smp_ops from the machine vector.

This results in that DT-based SMP support has priority over older
C-based smp_ops code, and in case DT-based SMP support code does not
exist in the DTB then the old smp_ops code will still work as-is.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/common.h  | 1 +
 arch/arm/mach-shmobile/platsmp.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 3b562d87826d..1a8f7b3ab449 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -10,6 +10,7 @@ extern void shmobile_smp_sleep(void);
 extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
 			      unsigned long arg);
 extern bool shmobile_smp_cpu_can_disable(unsigned int cpu);
+extern bool shmobile_smp_init_fallback_ops(void);
 extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(phys_addr_t scu_base_phys,
 					  unsigned int max_cpus);
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index b23378f3d7e1..f3dba6f356e2 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -36,3 +36,9 @@ bool shmobile_smp_cpu_can_disable(unsigned int cpu)
 	return true; /* Hotplug of any CPU is supported */
 }
 #endif
+
+bool __init shmobile_smp_init_fallback_ops(void)
+{
+	/* fallback on PSCI/smp_ops if no other DT based method is detected */
+	return platform_can_secondary_boot() ? true : false;
+}
-- 
2.7.0.rc3.207.g0ac5344
