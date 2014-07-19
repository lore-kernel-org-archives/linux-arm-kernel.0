From: romain.perier@gmail.com (Romain Perier)
Date: Sat, 19 Jul 2014 13:03:26 +0000
Subject: [PATCH v2] ARM: rockchip: Add cpu hotplug support for RK3XXX SoCs
Message-ID: <1405775006-950-1-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds ability to shutdown all CPUs except the first one
(since it might be special for a lot of platforms).
It is now possible to use kexec which requires such a feature.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/mach-rockchip/platsmp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index 910835d..189684f 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -21,6 +21,7 @@
 #include <linux/of_address.h>
 
 #include <asm/cacheflush.h>
+#include <asm/cp15.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_plat.h>
 #include <asm/mach/map.h>
@@ -178,8 +179,27 @@ static void __init rockchip_smp_prepare_cpus(unsigned int max_cpus)
 		pmu_set_power_domain(0 + i, false);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int rockchip_cpu_kill(unsigned int cpu)
+{
+	pmu_set_power_domain(0 + cpu, false);
+	return 1;
+}
+
+static void rockchip_cpu_die(unsigned int cpu)
+{
+	v7_exit_coherency_flush(louis);
+	while(1)
+		cpu_do_idle();
+}
+#endif
+
 static struct smp_operations rockchip_smp_ops __initdata = {
 	.smp_prepare_cpus	= rockchip_smp_prepare_cpus,
 	.smp_boot_secondary	= rockchip_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_kill		= rockchip_cpu_kill,
+	.cpu_die		= rockchip_cpu_die,
+#endif
 };
 CPU_METHOD_OF_DECLARE(rk3066_smp, "rockchip,rk3066-smp", &rockchip_smp_ops);
-- 
1.9.1
