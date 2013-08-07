From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:39:32 +0900
Subject: [GIT PULL 6/9] ARM: shmobile: Use shared SCU CPU Hotplug code on
 sh73a0
In-Reply-To: <cover.1375841380.git.horms+renesas@verge.net.au>
References: <cover.1375841380.git.horms+renesas@verge.net.au>
Message-ID: <352e57a3af195825767d0f638cb9ec3517f93de4.1375841380.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update the sh73a0 specific CPU Hotplug code to make use of
the recently introduced shared SCU functions. The sh73a0
power control hardware relies on SCU_PM_POWEROFF with WFI
so the shared SCU code will as-is power down the hardware
as expected.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-sh73a0.c | 41 +++----------------------------------
 1 file changed, 3 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index 1096b0e..8b3b977 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -20,14 +20,11 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/smp.h>
-#include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <mach/common.h>
-#include <asm/cacheflush.h>
-#include <asm/smp_plat.h>
 #include <mach/sh73a0.h>
-#include <asm/smp_scu.h>
+#include <asm/smp_plat.h>
 #include <asm/smp_twd.h>
 
 #define WUPCR		IOMEM(0xe6151010)
@@ -36,8 +33,6 @@
 #define SBAR		IOMEM(0xe6180020)
 #define APARMBAREA	IOMEM(0xe6f10020)
 
-#define PSTR_SHUTDOWN_MODE	3
-
 #define SH73A0_SCU_BASE 0xf0000000
 
 #ifdef CONFIG_HAVE_ARM_TWD
@@ -77,36 +72,6 @@ static void __init sh73a0_smp_prepare_cpus(unsigned int max_cpus)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-static int sh73a0_cpu_kill(unsigned int cpu)
-{
-
-	int k;
-	u32 pstr;
-
-	/*
-	 * wait until the power status register confirms the shutdown of the
-	 * offline target
-	 */
-	for (k = 0; k < 1000; k++) {
-		pstr = (__raw_readl(PSTR) >> (4 * cpu)) & 3;
-		if (pstr == PSTR_SHUTDOWN_MODE)
-			return 1;
-
-		mdelay(1);
-	}
-
-	return 0;
-}
-
-static void sh73a0_cpu_die(unsigned int cpu)
-{
-	/* Set power off mode. This takes the CPU out of the MP cluster */
-	scu_power_mode(shmobile_scu_base, SCU_PM_POWEROFF);
-
-	/* Enter shutdown mode */
-	cpu_do_idle();
-}
-
 static int sh73a0_cpu_disable(unsigned int cpu)
 {
 	return 0; /* CPU0 and CPU1 supported */
@@ -117,8 +82,8 @@ struct smp_operations sh73a0_smp_ops __initdata = {
 	.smp_prepare_cpus	= sh73a0_smp_prepare_cpus,
 	.smp_boot_secondary	= sh73a0_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
-	.cpu_kill		= sh73a0_cpu_kill,
-	.cpu_die		= sh73a0_cpu_die,
 	.cpu_disable		= sh73a0_cpu_disable,
+	.cpu_die		= shmobile_smp_scu_cpu_die,
+	.cpu_kill		= shmobile_smp_scu_cpu_kill,
 #endif
 };
-- 
1.8.3.2
