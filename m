From: yanjiang.jin@windriver.com (yanjiang.jin at windriver.com)
Date: Wed, 10 May 2017 01:13:04 -0400
Subject: [PATCH] socfpga_a10: reset CPU1 in socfpga_cpu_kill()
In-Reply-To: <20170510051304.131042-1-yanjiang.jin@windriver.com>
References: <20170510051304.131042-1-yanjiang.jin@windriver.com>
Message-ID: <20170510051304.131042-2-yanjiang.jin@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yanjiang Jin <yanjiang.jin@windriver.com>

Kexec's second kernel would hang if CPU1 isn't reset.

Signed-off-by: Yanjiang Jin <yanjiang.jin@windriver.com>
---
 arch/arm/mach-socfpga/platsmp.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index 0ee7677..db3940e 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -117,6 +117,16 @@ static int socfpga_cpu_kill(unsigned int cpu)
 {
 	return 1;
 }
+
+static int socfpga_a10_cpu_kill(unsigned int cpu)
+{
+	/* This will put CPU #1 into reset. */
+	if (socfpga_cpu1start_addr)
+		writel(RSTMGR_MPUMODRST_CPU1, rst_manager_base_addr +
+			SOCFPGA_A10_RSTMGR_MODMPURST);
+
+	return 1;
+}
 #endif
 
 static const struct smp_operations socfpga_smp_ops __initconst = {
@@ -133,7 +143,7 @@ static int socfpga_cpu_kill(unsigned int cpu)
 	.smp_boot_secondary	= socfpga_a10_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= socfpga_cpu_die,
-	.cpu_kill		= socfpga_cpu_kill,
+	.cpu_kill		= socfpga_a10_cpu_kill,
 #endif
 };
 
-- 
1.9.1
