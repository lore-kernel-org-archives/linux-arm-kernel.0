From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 21:32:38 +0900
Subject: [PATCH 28/43] ARM: shmobile: Update r8a7779 to check SCU for hotplug
In-Reply-To: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
References: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363609973-31086-29-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update the r8a7779 CPU Hotplug code to use SCU PSR
to wait for the target CPU core. Previously the
shared code in hotplug.c was used to let cpu_kill()
wait for cpu_die(). With this change in place the
r8a7779 SMP code does not depend on hotplug.c anymore.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-r8a7779.c |   38 ++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index e69ce25..63c8db9 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -26,6 +26,7 @@
 #include <linux/irqchip/arm-gic.h>
 #include <mach/common.h>
 #include <mach/r8a7779.h>
+#include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_twd.h>
@@ -68,6 +69,16 @@ void __init r8a7779_register_twd(void)
 }
 #endif
 
+static int r8a7779_scu_psr_core_disabled(int cpu)
+{
+	unsigned long mask = 3 << (cpu * 8);
+
+	if ((__raw_readl(shmobile_scu_base + 8) & mask) == mask)
+		return 1;
+
+	return 0;
+}
+
 static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
 {
 	void __iomem *scu_base = shmobile_scu_base;
@@ -89,9 +100,6 @@ static int r8a7779_platform_cpu_kill(unsigned int cpu)
 
 	cpu = cpu_logical_map(cpu);
 
-	/* disable cache coherency */
-	modify_scu_cpu_psr(3 << (cpu * 8), 0);
-
 	if (cpu < ARRAY_SIZE(r8a7779_ch_cpu))
 		ch = r8a7779_ch_cpu[cpu];
 
@@ -110,7 +118,7 @@ static int __maybe_unused r8a7779_cpu_kill(unsigned int cpu)
 	 * finish before asking SoC-specific code to power off the CPU core.
 	 */
 	for (k = 0; k < 1000; k++) {
-		if (shmobile_cpu_is_dead(cpu))
+		if (r8a7779_scu_psr_core_disabled(cpu))
 			return r8a7779_platform_cpu_kill(cpu);
 
 		mdelay(1);
@@ -119,6 +127,24 @@ static int __maybe_unused r8a7779_cpu_kill(unsigned int cpu)
 	return 0;
 }
 
+static void __maybe_unused r8a7779_cpu_die(unsigned int cpu)
+{
+	dsb();
+	flush_cache_all();
+
+	/* disable cache coherency */
+	modify_scu_cpu_psr(3 << (cpu * 8), 0);
+
+	/* Endless loop until power off from r8a7779_cpu_kill() */
+	while (1)
+		cpu_do_idle();
+}
+
+static int __maybe_unused r8a7779_cpu_disable(unsigned int cpu)
+{
+	/* only CPU1->3 have power domains, do not allow hotplug of CPU0 */
+	return cpu == 0 ? -EPERM : 0;
+}
 
 static void __cpuinit r8a7779_secondary_init(unsigned int cpu)
 {
@@ -179,7 +205,7 @@ struct smp_operations r8a7779_smp_ops  __initdata = {
 	.smp_boot_secondary	= r8a7779_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_kill		= r8a7779_cpu_kill,
-	.cpu_die		= shmobile_cpu_die,
-	.cpu_disable		= shmobile_cpu_disable,
+	.cpu_die		= r8a7779_cpu_die,
+	.cpu_disable		= r8a7779_cpu_disable,
 #endif
 };
-- 
1.7.10.4
