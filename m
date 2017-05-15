From: yanjiang.jin@windriver.com (yanjiang.jin at windriver.com)
Date: Mon, 15 May 2017 17:13:36 +0800
Subject: [PATCH] socfpga_a10: reset CPU1 in socfpga_cpu_kill()
In-Reply-To: <20170515091336.10827-1-yanjiang.jin@windriver.com>
References: <20170515091336.10827-1-yanjiang.jin@windriver.com>
Message-ID: <20170515091336.10827-2-yanjiang.jin@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yanjiang Jin <yanjiang.jin@windriver.com>

socfpga_cpu_die() just puts CPU in WFI, not actually off. So that Kexec's
second kernel goes wrong since the kerenl text gets ovewritten.
Now reset CPU1 in cpu_kill() to avoid this error.
Also add flush_cache_all() to prevent data from being lost in cpu_die().

Signed-off-by: Yanjiang Jin <yanjiang.jin@windriver.com>
---
 arch/arm/mach-socfpga/platsmp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index 0ee7677..53f290e 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -102,6 +102,8 @@ static void __init socfpga_smp_prepare_cpus(unsigned int max_cpus)
  */
 static void socfpga_cpu_die(unsigned int cpu)
 {
+	flush_cache_all();
+
 	/* Do WFI. If we wake up early, go back into WFI */
 	while (1)
 		cpu_do_idle();
@@ -117,6 +119,15 @@ static int socfpga_cpu_kill(unsigned int cpu)
 {
 	return 1;
 }
+
+static int socfpga_a10_cpu_kill(unsigned int cpu)
+{
+	/* This will put CPU #1 into reset. */
+	writel(RSTMGR_MPUMODRST_CPU1, rst_manager_base_addr +
+		SOCFPGA_A10_RSTMGR_MODMPURST);
+
+	return 1;
+}
 #endif
 
 static const struct smp_operations socfpga_smp_ops __initconst = {
@@ -133,7 +144,7 @@ static int socfpga_cpu_kill(unsigned int cpu)
 	.smp_boot_secondary	= socfpga_a10_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= socfpga_cpu_die,
-	.cpu_kill		= socfpga_cpu_kill,
+	.cpu_kill		= socfpga_a10_cpu_kill,
 #endif
 };
 
-- 
1.9.1
