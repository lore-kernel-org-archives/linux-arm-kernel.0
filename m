From: hechtb@gmail.com (Bastian Hecht)
Date: Wed,  9 Jan 2013 20:41:52 +0100
Subject: [PATCH v2 2/2] ARM: SH-Mobile: sh73a0: Add CPU Hotplug
In-Reply-To: <1357760512-2634-1-git-send-email-hechtb+renesas@gmail.com>
References: <1357760512-2634-1-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <1357760512-2634-2-git-send-email-hechtb+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the capability to add and remove CPUs on the fly.
The Cortex-A9 offers the possibility to take single cores out of the
MP Core. We add this capabilty taking care that caches are kept
coherent. For verifying the shutdown we rely on the internal SH73A0
Power Status Register PSTR.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
v2: don't use custom function sh73a0_do_wfi() but trust in cpu_do_idle()

 arch/arm/mach-shmobile/smp-sh73a0.c |   36 +++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index 5e36f5d..88aee9d 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -24,6 +24,7 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <mach/common.h>
+#include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 #include <mach/sh73a0.h>
 #include <asm/smp_scu.h>
@@ -36,6 +37,8 @@
 #define SBAR		IOMEM(0xe6180020)
 #define APARMBAREA	IOMEM(0xe6f10020)
 
+#define PSTR_SHUTDOWN_MODE	3
+
 static void __iomem *scu_base_addr(void)
 {
 	return (void __iomem *)0xf0000000;
@@ -92,16 +95,20 @@ static void __init sh73a0_smp_init_cpus(void)
 	shmobile_smp_init_cpus(ncores);
 }
 
-static int __maybe_unused sh73a0_cpu_kill(unsigned int cpu)
+#ifdef CONFIG_HOTPLUG_CPU
+static int sh73a0_cpu_kill(unsigned int cpu)
 {
+
 	int k;
+	u32 pstr;
 
-	/* this function is running on another CPU than the offline target,
-	 * here we need wait for shutdown code in platform_cpu_die() to
-	 * finish before asking SoC-specific code to power off the CPU core.
+	/*
+	 * wait until the power status register confirms the shutdown of the
+	 * offline target
 	 */
 	for (k = 0; k < 1000; k++) {
-		if (shmobile_cpu_is_dead(cpu))
+		pstr = (__raw_readl(PSTR) >> (4 * cpu)) & 3;
+		if (pstr == PSTR_SHUTDOWN_MODE)
 			return 1;
 
 		mdelay(1);
@@ -110,6 +117,23 @@ static int __maybe_unused sh73a0_cpu_kill(unsigned int cpu)
 	return 0;
 }
 
+static void sh73a0_cpu_die(unsigned int cpu)
+{
+	/*
+	 * The ARM MPcore does not issue a cache coherency request for the L1
+	 * cache when powering off single CPUs. We must take care of this and
+	 * further caches.
+	 */
+	dsb();
+	flush_cache_all();
+
+	/* Set power off mode. This takes the CPU out of the MP cluster */
+	scu_power_mode(scu_base_addr(), SCU_PM_POWEROFF);
+
+	/* Enter shutdown mode */
+	cpu_do_idle();
+}
+#endif /* CONFIG_HOTPLUG_CPU */
 
 struct smp_operations sh73a0_smp_ops __initdata = {
 	.smp_init_cpus		= sh73a0_smp_init_cpus,
@@ -118,7 +142,7 @@ struct smp_operations sh73a0_smp_ops __initdata = {
 	.smp_boot_secondary	= sh73a0_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_kill		= sh73a0_cpu_kill,
-	.cpu_die		= shmobile_cpu_die,
+	.cpu_die		= sh73a0_cpu_die,
 	.cpu_disable		= shmobile_cpu_disable,
 #endif
 };
-- 
1.7.9.5
