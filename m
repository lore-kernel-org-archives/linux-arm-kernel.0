From: pali.rohar@gmail.com (=?UTF-8?q?Pali=20Roh=C3=A1r?=)
Date: Wed,  6 May 2015 10:49:01 +0200
Subject: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT revision
In-Reply-To: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <1430902142-17035-2-git-send-email-pali.rohar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this patch "revision" DT string entry is used to set global system_rev
variable. DT "revision" is expected to be string with one hexadecimal number.
So "Revision" line in /proc/cpuinfo will be same as "revision" DT value.

Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 arch/arm/kernel/devtree.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 11c54de..7e13e27 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -19,6 +19,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/smp.h>
+#include <linux/libfdt_env.h>
 
 #include <asm/cputype.h>
 #include <asm/setup.h>
@@ -26,6 +27,7 @@
 #include <asm/smp_plat.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+#include <asm/system_info.h>
 
 
 #ifdef CONFIG_SMP
@@ -204,6 +206,9 @@ static const void * __init arch_get_next_mach(const char *const **match)
 const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 {
 	const struct machine_desc *mdesc, *mdesc_best = NULL;
+	unsigned long dt_root;
+	const char *prop;
+	int size;
 
 #ifdef CONFIG_ARCH_MULTIPLATFORM
 	DT_MACHINE_START(GENERIC_DT, "Generic DT based system")
@@ -215,17 +220,13 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 	if (!dt_phys || !early_init_dt_verify(phys_to_virt(dt_phys)))
 		return NULL;
 
+	dt_root = of_get_flat_dt_root();
 	mdesc = of_flat_dt_match_machine(mdesc_best, arch_get_next_mach);
 
 	if (!mdesc) {
-		const char *prop;
-		int size;
-		unsigned long dt_root;
-
 		early_print("\nError: unrecognized/unsupported "
 			    "device tree compatible list:\n[ ");
 
-		dt_root = of_get_flat_dt_root();
 		prop = of_get_flat_dt_prop(dt_root, "compatible", &size);
 		while (size > 0) {
 			early_print("'%s' ", prop);
@@ -246,5 +247,14 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 	/* Change machine number to match the mdesc we're using */
 	__machine_arch_type = mdesc->nr;
 
+	/* Set system revision from DT */
+	prop = of_get_flat_dt_prop(dt_root, "revision", &size);
+	if (prop && size > 0) {
+		char revision[11];
+		strlcpy(revision, prop, min(size, (int)sizeof(revision)));
+		if (kstrtouint(revision, 16, &system_rev) != 0)
+			system_rev = 0;
+	}
+
 	return mdesc;
 }
-- 
1.7.9.5
