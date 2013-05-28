From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 28 May 2013 09:04:30 -0300
Subject: [PATCH] ARM: dt: Use the 'model' field for printing the hardware
 revision
Message-ID: <1369742670-16305-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting a device tree kernel, we get the following output from 
'cat /proc/cpuinfo': 

$ cat /proc/cpuinfo 
processor       : 0
model name      : ARMv7 Processor rev 5 (v7l)
BogoMIPS        : 531.66
Features        : swp half thumb fastmult vfp edsp neon vfpv3 tls 
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x2
CPU part        : 0xc08
CPU revision    : 5

Hardware        : Freescale i.MX51 (Device Tree Support)
Revision        : 0000
Serial          : 0000000000000000

The Hardware line does not really describe the hardware type, as it is reading
the information from the dt 'machine' field.

In the dt case, read the 'model' field instead, so that we can have a better
description output as follows:

Hardware        : Freescale i.MX51 Babbage Board

The hardware output string is unchanged for the non-dt kernel case.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/include/asm/mach/arch.h |  1 +
 arch/arm/kernel/devtree.c        | 15 ++++++++-------
 arch/arm/kernel/setup.c          |  7 ++++++-
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 308ad7d..113d4af 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -23,6 +23,7 @@ struct smp_operations;
 struct machine_desc {
 	unsigned int		nr;		/* architecture number	*/
 	const char		*name;		/* architecture name	*/
+	const char		*model;		/* architectute model */
 	unsigned long		atag_offset;	/* tagged list (relative) */
 	const char *const 	*dt_compat;	/* array of device tree
 						 * 'compatible' strings	*/
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 5af04f6..90d541a 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -178,7 +178,6 @@ struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 	struct machine_desc *mdesc, *mdesc_best = NULL;
 	unsigned int score, mdesc_score = ~1;
 	unsigned long dt_root;
-	const char *model;
 
 #ifdef CONFIG_ARCH_MULTIPLATFORM
 	DT_MACHINE_START(GENERIC_DT, "Generic DT based system")
@@ -224,12 +223,14 @@ struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 		dump_machine_table(); /* does not return */
 	}
 
-	model = of_get_flat_dt_prop(dt_root, "model", NULL);
-	if (!model)
-		model = of_get_flat_dt_prop(dt_root, "compatible", NULL);
-	if (!model)
-		model = "<unknown>";
-	pr_info("Machine: %s, model: %s\n", mdesc_best->name, model);
+	mdesc_best->model = of_get_flat_dt_prop(dt_root, "model", NULL);
+	if (!mdesc_best->model)
+		mdesc_best->model = of_get_flat_dt_prop(dt_root, "compatible",
+							NULL);
+	if (!mdesc_best->model)
+		mdesc_best->model = "<unknown>";
+	pr_info("Machine: %s, model: %s\n", mdesc_best->name,
+		mdesc_best->model);
 
 	/* Retrieve various information from the /chosen node */
 	of_scan_flat_dt(early_init_dt_scan_chosen, boot_command_line);
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 79e8d2f..d22f24b 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -137,6 +137,7 @@ EXPORT_SYMBOL(elf_platform);
 
 static const char *cpu_name;
 static const char *machine_name;
+static const char *model_name;
 static char __initdata cmd_line[COMMAND_LINE_SIZE];
 struct machine_desc *machine_desc __initdata;
 
@@ -786,6 +787,7 @@ void __init setup_arch(char **cmdline_p)
 		mdesc = setup_machine_tags(__atags_pointer, __machine_arch_type);
 	machine_desc = mdesc;
 	machine_name = mdesc->name;
+	model_name = mdesc->model;
 
 	setup_dma_zone(mdesc);
 
@@ -950,7 +952,10 @@ static int c_show(struct seq_file *m, void *v)
 		seq_printf(m, "CPU revision\t: %d\n\n", cpuid & 15);
 	}
 
-	seq_printf(m, "Hardware\t: %s\n", machine_name);
+	if (model_name)
+		seq_printf(m, "Hardware\t: %s\n", model_name);
+	else
+		seq_printf(m, "Hardware\t: %s\n", machine_name);
 	seq_printf(m, "Revision\t: %04x\n", system_rev);
 	seq_printf(m, "Serial\t\t: %08x%08x\n",
 		   system_serial_high, system_serial_low);
-- 
1.8.1.2
