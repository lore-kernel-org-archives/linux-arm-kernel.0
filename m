From: pali.rohar@gmail.com (=?UTF-8?q?Pali=20Roh=C3=A1r?=)
Date: Mon,  6 Jul 2015 22:26:09 +0200
Subject: [PATCH 1/5] arm: devtree: Set system_rev from DT "/revision"
In-Reply-To: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <1436214373-12969-2-git-send-email-pali.rohar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this patch "/revision" DT entry is used to set global system_rev
variable. DT "/revision" is expected to be u32 numeric value.

TODO: add documentation

Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
---
 arch/arm/kernel/devtree.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 11c54de..7d82749 100644
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
@@ -204,6 +206,8 @@ static const void * __init arch_get_next_mach(const char *const **match)
 const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 {
 	const struct machine_desc *mdesc, *mdesc_best = NULL;
+	unsigned long dt_root;
+	const u32 *rev;
 
 #ifdef CONFIG_ARCH_MULTIPLATFORM
 	DT_MACHINE_START(GENERIC_DT, "Generic DT based system")
@@ -215,17 +219,16 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 	if (!dt_phys || !early_init_dt_verify(phys_to_virt(dt_phys)))
 		return NULL;
 
+	dt_root = of_get_flat_dt_root();
 	mdesc = of_flat_dt_match_machine(mdesc_best, arch_get_next_mach);
 
 	if (!mdesc) {
 		const char *prop;
 		int size;
-		unsigned long dt_root;
 
 		early_print("\nError: unrecognized/unsupported "
 			    "device tree compatible list:\n[ ");
 
-		dt_root = of_get_flat_dt_root();
 		prop = of_get_flat_dt_prop(dt_root, "compatible", &size);
 		while (size > 0) {
 			early_print("'%s' ", prop);
@@ -246,5 +249,10 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 	/* Change machine number to match the mdesc we're using */
 	__machine_arch_type = mdesc->nr;
 
+	/* Set system revision from DT */
+	rev = of_get_flat_dt_prop(dt_root, "revision", NULL);
+	if (rev)
+		system_rev = fdt32_to_cpu(*rev);
+
 	return mdesc;
 }
-- 
1.7.9.5
