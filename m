From: romain.perier@gmail.com (Romain Perier)
Date: Wed, 16 Jul 2014 20:39:08 +0200
Subject: [PATCH v1] ARM: rockchip: Add cpu hotplug support
Message-ID: <53C6C6CC.2050508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch adds support for cpu hotplug for rockchip SoCs. You can now 
use kexec with rockchip compatible devices.
That's my first patch to the kernel, so perhaps that there are missing 
things (I am sorry if this is the case).


Regards,
Romain

-------------- next part --------------
>From 6727523766e3711ab58b2276d2e60bee0f7b7ba8 Mon Sep 17 00:00:00 2001
From: Romain Perier <romain.perier@gmail.com>
Date: Tue, 15 Jul 2014 19:38:05 +0000
Subject: [PATCH] Add cpu hotplug support

---
 arch/arm/mach-rockchip/platsmp.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index 910835d..7cdcf5f 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -21,6 +21,7 @@
 #include <linux/of_address.h>
 
 #include <asm/cacheflush.h>
+#include <asm/cp15.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_plat.h>
 #include <asm/mach/map.h>
@@ -178,8 +179,38 @@ static void __init rockchip_smp_prepare_cpus(unsigned int max_cpus)
 		pmu_set_power_domain(0 + i, false);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static DECLARE_COMPLETION(cpu_died);
+
+static int rockchip_cpu_kill(unsigned int cpu)
+{
+	if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(1000))) {
+		pr_err("CPU%d: didn't die correctly\n", cpu);
+		return 0;
+	}
+	pmu_set_power_domain(0 + cpu, false);
+	return 1;
+}
+
+
+static void rockchip_cpu_die(unsigned int cpu)
+{
+	complete(&cpu_died);
+	flush_cache_louis();
+
+	v7_exit_coherency_flush(louis);
+
+	while(1)
+		cpu_do_idle();
+}
+#endif
+
 static struct smp_operations rockchip_smp_ops __initdata = {
 	.smp_prepare_cpus	= rockchip_smp_prepare_cpus,
-	.smp_boot_secondary	= rockchip_boot_secondary,
+	.smp_boot_secondary	= rockchip_boot_secondary
+#ifdef CONFIG_HOTPLUG_CPU
+	, .cpu_kill		= rockchip_cpu_kill,
+	.cpu_die		= rockchip_cpu_die
+#endif
 };
 CPU_METHOD_OF_DECLARE(rk3066_smp, "rockchip,rk3066-smp", &rockchip_smp_ops);
-- 
1.9.1
