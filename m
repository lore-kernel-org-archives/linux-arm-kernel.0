From: contact@paulk.fr (Paul Kocialkowski)
Date: Sat, 28 Mar 2015 18:39:31 +0100
Subject: [PATCH 2/2] arch: arm: Show the serial number from devicetree in
 cpuinfo
In-Reply-To: <1427564371-26039-1-git-send-email-contact@paulk.fr>
References: <1427564371-26039-1-git-send-email-contact@paulk.fr>
Message-ID: <1427564371-26039-2-git-send-email-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This grabs the serial number shown in cpuinfo from the serial-number devicetree
property in priority. When booting with ATAGs (and without device-tree), the
provided number is still shown instead.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/include/asm/system_info.h |  1 +
 arch/arm/kernel/atags_parse.c      |  3 +++
 arch/arm/kernel/devtree.c          | 15 ++++++++++-----
 arch/arm/kernel/setup.c            | 11 +++++++++--
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/system_info.h b/arch/arm/include/asm/system_info.h
index 720ea03..3860cbd40 100644
--- a/arch/arm/include/asm/system_info.h
+++ b/arch/arm/include/asm/system_info.h
@@ -17,6 +17,7 @@
 
 /* information about the system we're running on */
 extern unsigned int system_rev;
+extern const char *system_serial;
 extern unsigned int system_serial_low;
 extern unsigned int system_serial_high;
 extern unsigned int mem_fclk_21285;
diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
index 68c6ae0..8384818 100644
--- a/arch/arm/kernel/atags_parse.c
+++ b/arch/arm/kernel/atags_parse.c
@@ -231,6 +231,9 @@ setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr)
 		parse_tags(tags);
 	}
 
+	/* Serial number is stored in system_serial_low/high */
+	system_serial = NULL;
+
 	/* parse_early_param needs a boot_command_line */
 	strlcpy(boot_command_line, from, COMMAND_LINE_SIZE);
 
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 11c54de..a82a04d 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -26,6 +26,7 @@
 #include <asm/smp_plat.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+#include <asm/system_info.h>
 
 
 #ifdef CONFIG_SMP
@@ -204,6 +205,9 @@ static const void * __init arch_get_next_mach(const char *const **match)
 const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 {
 	const struct machine_desc *mdesc, *mdesc_best = NULL;
+	const char *prop;
+	int size;
+	unsigned long dt_root;
 
 #ifdef CONFIG_ARCH_MULTIPLATFORM
 	DT_MACHINE_START(GENERIC_DT, "Generic DT based system")
@@ -215,17 +219,14 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 	if (!dt_phys || !early_init_dt_verify(phys_to_virt(dt_phys)))
 		return NULL;
 
+	dt_root = of_get_flat_dt_root();
+
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
@@ -243,6 +244,10 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 
 	early_init_dt_scan_nodes();
 
+	/* Scan for serial number */
+	prop = of_get_flat_dt_prop(dt_root, "serial-number", &size);
+	system_serial = prop;
+
 	/* Change machine number to match the mdesc we're using */
 	__machine_arch_type = mdesc->nr;
 
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 1d60beb..69fa7ef 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -93,6 +93,9 @@ unsigned int __atags_pointer __initdata;
 unsigned int system_rev;
 EXPORT_SYMBOL(system_rev);
 
+const char *system_serial;
+EXPORT_SYMBOL(system_serial);
+
 unsigned int system_serial_low;
 EXPORT_SYMBOL(system_serial_low);
 
@@ -1091,8 +1094,12 @@ static int c_show(struct seq_file *m, void *v)
 
 	seq_printf(m, "Hardware\t: %s\n", machine_name);
 	seq_printf(m, "Revision\t: %04x\n", system_rev);
-	seq_printf(m, "Serial\t\t: %08x%08x\n",
-		   system_serial_high, system_serial_low);
+
+	if (system_serial)
+		seq_printf(m, "Serial\t\t: %s\n", system_serial);
+	else
+		seq_printf(m, "Serial\t\t: %08x%08x\n",
+			   system_serial_high, system_serial_low);
 
 	return 0;
 }
-- 
1.9.1
