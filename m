From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 20 Jan 2015 10:27:07 +0900
Subject: [PATCH 1/3] ARM: shmobile: R-Mobile: Consolidate
 rmobile_pd_suspend_*()
In-Reply-To: <cover.1421715134.git.horms+renesas@verge.net.au>
References: <cover.1421715134.git.horms+renesas@verge.net.au>
Message-ID: <e43ee86efb68808c8847de17e58f5427b006363c.1421715134.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Consolidate the identical rmobile_pd_suspend_*() routines that just
return -EBUSY to prevent a PM domain from being powered down into a
single rmobile_pd_suspend_busy().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pm-rmobile.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 85a7fdd..e1be4b8 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -200,11 +200,10 @@ void rmobile_add_devices_to_domains(struct pm_domain_device data[],
 
 #else /* !CONFIG_ARCH_SHMOBILE_LEGACY */
 
-static int rmobile_pd_suspend_cpu(void)
+static int rmobile_pd_suspend_busy(void)
 {
 	/*
-	 * This domain contains the CPU core and therefore it should
-	 * only be turned off if the CPU is not in use.
+	 * This domain should not be turned off.
 	 */
 	return -EBUSY;
 }
@@ -218,16 +217,6 @@ static int rmobile_pd_suspend_console(void)
 	return console_suspend_enabled ? 0 : -EBUSY;
 }
 
-static int rmobile_pd_suspend_debug(void)
-{
-	/*
-	 * This domain contains the Coresight-ETM hardware block and
-	 * therefore it should only be turned off if the debug module is
-	 * not in use.
-	 */
-	return -EBUSY;
-}
-
 #define MAX_NUM_CPU_PDS		8
 
 static unsigned int num_cpu_pds __initdata;
@@ -303,17 +292,26 @@ static void __init rmobile_setup_pm_domain(struct device_node *np,
 	const char *name = pd->genpd.name;
 
 	if (pd_contains_cpu(np)) {
+		/*
+		 * This domain contains the CPU core and therefore it should
+		 * only be turned off if the CPU is not in use.
+		 */
 		pr_debug("PM domain %s contains CPU\n", name);
 		pd->gov = &pm_domain_always_on_gov;
-		pd->suspend = rmobile_pd_suspend_cpu;
+		pd->suspend = rmobile_pd_suspend_busy;
 	} else if (np == console_pd) {
 		pr_debug("PM domain %s contains serial console\n", name);
 		pd->gov = &pm_domain_always_on_gov;
 		pd->suspend = rmobile_pd_suspend_console;
 	} else if (np == debug_pd) {
+		/*
+		 * This domain contains the Coresight-ETM hardware block and
+		 * therefore it should only be turned off if the debug module
+		 * is not in use.
+		 */
 		pr_debug("PM domain %s contains Coresight-ETM\n", name);
 		pd->gov = &pm_domain_always_on_gov;
-		pd->suspend = rmobile_pd_suspend_debug;
+		pd->suspend = rmobile_pd_suspend_busy;
 	}
 
 	rmobile_init_pm_domain(pd);
-- 
2.1.4
