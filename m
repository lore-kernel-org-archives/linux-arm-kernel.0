From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Fri, 24 Apr 2015 16:43:21 -0500
Subject: [PATCH 2/2] ARM: VDSO: use arch_timer_okay_for_vdso
In-Reply-To: <1429911801-6069-1-git-send-email-nathan_lynch@mentor.com>
References: <1429911801-6069-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <1429911801-6069-2-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the facility now provided by the arm_arch_timer driver to
determine whether there's a usable virtual counter for the VDSO.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 arch/arm/kernel/vdso.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index efe17dd9b921..f06fd6f3f65f 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -21,7 +21,6 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
-#include <linux/of.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/timekeeper_internal.h>
@@ -69,33 +68,6 @@ struct elfinfo {
  */
 static bool cntvct_ok __read_mostly;
 
-static bool __init cntvct_functional(void)
-{
-	struct device_node *np;
-	bool ret = false;
-
-	if (!IS_ENABLED(CONFIG_ARM_ARCH_TIMER))
-		goto out;
-
-	/* The arm_arch_timer core should export
-	 * arch_timer_use_virtual or similar so we don't have to do
-	 * this.
-	 */
-	np = of_find_compatible_node(NULL, NULL, "arm,armv7-timer");
-	if (!np)
-		goto out_put;
-
-	if (of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
-		goto out_put;
-
-	ret = true;
-
-out_put:
-	of_node_put(np);
-out:
-	return ret;
-}
-
 static void * __init find_section(Elf32_Ehdr *ehdr, const char *name,
 				  unsigned long *size)
 {
@@ -208,7 +180,7 @@ static int __init vdso_init(void)
 	vdso_total_pages = 1; /* for the data/vvar page */
 	vdso_total_pages += text_pages;
 
-	cntvct_ok = cntvct_functional();
+	cntvct_ok = arch_timer_okay_for_vdso();
 
 	patch_vdso(&vdso_start);
 
-- 
1.9.3
