From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 30 Sep 2014 14:26:26 +0200
Subject: [PATCH/RFC v2 3/4] ARM: shmobile: R-Mobile: Sync
 arm_dbg_regs_available with D4 PM domain
In-Reply-To: <1412079987-1827-1-git-send-email-geert+renesas@glider.be>
References: <1412079987-1827-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1412079987-1827-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If power area D4, which contains the Coresight-ETM hardware block, is
powered down on R-Mobile A1 (r8a7740), the kernel crashes when
suspending from s2ram with:

    Internal error: Oops - undefined instruction: 0 [#1] ARM

This happens because dbg_cpu_pm_notify() calls reset_ctrl_regs(), which
can't access the debug registers as the debug module is powered down.

Keep the arm_dbg_regs_available flag in sync with the state of the PM
domain that contains a device node that is compatible with
"arm,coresight-etm3x".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is a fix on top of series "[PATCH 00/13] ARM: shmobile: R-Mobile:
DT PM domain support" (https://lkml.org/lkml/2014/9/25/452), to be
folded into "[PATCH v3 09/13] ARM: shmobile: R-Mobile: Add DT support
for PM domains" (https://lkml.org/lkml/2014/9/25/448).

v2:
  - New

---
 arch/arm/mach-shmobile/pm-rmobile.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index b1aa0e8541feaea4..80be5848adc8f15c 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -21,7 +21,10 @@
 #include <linux/pm.h>
 #include <linux/pm_clock.h>
 #include <linux/slab.h>
+
+#include <asm/hw_breakpoint.h>
 #include <asm/io.h>
+
 #include "pm-rmobile.h"
 
 /* SYSC */
@@ -198,20 +201,36 @@ static int rmobile_pd_suspend_console(void)
 	return console_suspend_enabled ? 0 : -EBUSY;
 }
 
+/*
+ * This domain contains the Coresight-ETM hardware block.
+ * The debug registers cannot be accessed while this domain is powered down.
+ */
+static int rmobile_pd_suspend_debug(void)
+{
+	arm_dbg_regs_available = false;
+	return 0;
+}
+
+static void rmobile_pd_resume_debug(void)
+{
+	arm_dbg_regs_available = true;
+}
+
 #define MAX_NUM_CPU_PDS		8
 
 static unsigned int num_cpu_pds __initdata;
 static struct device_node *cpu_pds[MAX_NUM_CPU_PDS] __initdata;
 static struct device_node *console_pd __initdata;
+static struct device_node *debug_pd __initdata;
 
 static void __init get_special_pds(void)
 {
-	struct device_node *cpu, *pd;
+	struct device_node *np, *pd;
 	unsigned int i;
 
 	/* PM domains containing CPUs */
-	for_each_node_by_type(cpu, "cpu") {
-		pd = of_parse_phandle(cpu, "power-domains", 0);
+	for_each_node_by_type(np, "cpu") {
+		pd = of_parse_phandle(np, "power-domains", 0);
 		if (!pd)
 			continue;
 
@@ -236,6 +255,11 @@ static void __init get_special_pds(void)
 	/* PM domain containing console */
 	if (of_stdout)
 		console_pd = of_parse_phandle(of_stdout, "power-domains", 0);
+
+	/* PM domain containing Coresight-ETM */
+	np = of_find_compatible_node(NULL, NULL, "arm,coresight-etm3x");
+	if (np)
+		debug_pd = of_parse_phandle(np, "power-domains", 0);
 }
 
 static void __init put_special_pds(void)
@@ -245,6 +269,7 @@ static void __init put_special_pds(void)
 	for (i = 0; i < num_cpu_pds; i++)
 		of_node_put(cpu_pds[i]);
 	of_node_put(console_pd);
+	of_node_put(debug_pd);
 }
 
 static bool __init pd_contains_cpu(const struct device_node *pd)
@@ -271,6 +296,10 @@ static void __init rmobile_setup_pm_domain(struct device_node *np,
 		pr_debug("PM domain %s contains serial console\n", name);
 		pd->gov = &pm_domain_always_on_gov;
 		pd->suspend = rmobile_pd_suspend_console;
+	} else if (np == debug_pd) {
+		pr_debug("PM domain %s contains Coresight-ETM\n", name);
+		pd->suspend = rmobile_pd_suspend_debug;
+		pd->resume = rmobile_pd_resume_debug;
 	}
 
 	rmobile_init_pm_domain(pd);
-- 
1.9.1
