From: pali.rohar@gmail.com (=?UTF-8?q?Pali=20Roh=C3=A1r?=)
Date: Mon,  6 Jul 2015 22:26:12 +0200
Subject: [PATCH 4/5] arm: devtree: Read ATAGs structure from DT "/chosen/linux,
 atags" entry
In-Reply-To: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <1436214373-12969-5-git-send-email-pali.rohar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this patch when linux kernel is compiled with ARM_ATAG_DTB_COMPAT it
reads ATAGs structure from "/chosen/linux,atags" entry and store it into
/proc/atags file. ATAGs structure is not parsed or evaluated, just kernel
exports it to userspace via procfs. It is needed for legacy userspace
application which expect some data from bootloader in /proc/atags file.
This patch keeps them running also on DT kernel if DT "/chosen/linux,atags"
entry exists.

TODO: add documentation

Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
---
 arch/arm/kernel/devtree.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 7d82749..69ff048 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -20,6 +20,7 @@
 #include <linux/of_platform.h>
 #include <linux/smp.h>
 #include <linux/libfdt_env.h>
+#include <linux/libfdt.h>
 
 #include <asm/cputype.h>
 #include <asm/setup.h>
@@ -29,6 +30,7 @@
 #include <asm/mach-types.h>
 #include <asm/system_info.h>
 
+#include "atags.h"
 
 #ifdef CONFIG_SMP
 extern struct of_cpu_method __cpu_method_of_table[];
@@ -208,6 +210,11 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 	const struct machine_desc *mdesc, *mdesc_best = NULL;
 	unsigned long dt_root;
 	const u32 *rev;
+	void *dt_virt;
+#ifdef CONFIG_ARM_ATAG_DTB_COMPAT
+	const void *atags;
+	unsigned long dt_chosen;
+#endif
 
 #ifdef CONFIG_ARCH_MULTIPLATFORM
 	DT_MACHINE_START(GENERIC_DT, "Generic DT based system")
@@ -216,7 +223,12 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 	mdesc_best = &__mach_desc_GENERIC_DT;
 #endif
 
-	if (!dt_phys || !early_init_dt_verify(phys_to_virt(dt_phys)))
+	if (!dt_phys)
+		return NULL;
+
+	dt_virt = phys_to_virt(dt_phys);
+
+	if (!early_init_dt_verify(dt_virt))
 		return NULL;
 
 	dt_root = of_get_flat_dt_root();
@@ -254,5 +266,15 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 	if (rev)
 		system_rev = fdt32_to_cpu(*rev);
 
+#ifdef CONFIG_ARM_ATAG_DTB_COMPAT
+	/* Store DT /chosen/linux,atags into /proc/atags */
+	dt_chosen = fdt_path_offset(dt_virt, "/chosen");
+	if (dt_chosen >= 0) {
+		atags = of_get_flat_dt_prop(dt_chosen, "linux,atags", NULL);
+		if (atags)
+			save_atags(atags);
+	}
+#endif
+
 	return mdesc;
 }
-- 
1.7.9.5
