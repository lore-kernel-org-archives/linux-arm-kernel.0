From: pranavkumar@linaro.org (Pranavkumar Sawargaonkar)
Date: Wed, 22 May 2013 16:18:33 +0530
Subject: [RFC] arm64: Add support to pass earlyprintk argument via device tree
Message-ID: <1369219713-18590-1-git-send-email-pranavkumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for defining and passing earlyprintk
related information i.e. device and address information via
device tree by adding it inside "chosen" node.

This will help user to just specify "earlyprintk" from bootargs
without actually knowing the address and device to enable
earlyprintk.

Mechanism:

One can just append earlyprintk=device-type,address (same as we pass
through command line) in "/chosen" node to notify kernel which is the
earlyprintk device and what is its address.

Backward Compatibility:

This patch also allows existing method of specifying earlyprintk
parameter via bootargs.

Existing method i.e. passing via bootargs will still have precedence
over device tree i.e. if one specifies earlyprintk=device-type,address
in bootargs then kernel will use information from bootargs instead of
device tree.

If user just specifies earlyprintk (without =...) then kernel will
look for device tree earlyprintk parameter.

Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Signed-off-by: Anup Patel <anup.patel@linaro.org>
---
 arch/arm64/kernel/early_printk.c |    7 +++++++
 arch/arm64/kernel/setup.c        |   22 +++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/early_printk.c b/arch/arm64/kernel/early_printk.c
index fbb6e18..4e6f845 100644
--- a/arch/arm64/kernel/early_printk.c
+++ b/arch/arm64/kernel/early_printk.c
@@ -29,6 +29,8 @@
 static void __iomem *early_base;
 static void (*printch)(char ch);
 
+extern char *earlyprintk_dt_args;
+
 /*
  * PL011 single character TX.
  */
@@ -116,6 +118,11 @@ static int __init setup_early_printk(char *buf)
 	phys_addr_t paddr = 0;
 
 	if (!buf) {
+		/* Try to check if Device Tree has this argument or not ? */
+		buf = earlyprintk_dt_args;
+	}
+
+	if (!buf) {
 		pr_warning("No earlyprintk arguments passed.\n");
 		return 0;
 	}
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 6a9a532..94ce7a9 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -60,6 +60,9 @@ EXPORT_SYMBOL(processor_id);
 unsigned int elf_hwcap __read_mostly;
 EXPORT_SYMBOL_GPL(elf_hwcap);
 
+char *earlyprintk_dt_args;
+EXPORT_SYMBOL_GPL(earlyprintk_dt_args);
+
 static const char *cpu_name;
 static const char *machine_name;
 phys_addr_t __fdt_pointer __initdata;
@@ -122,6 +125,23 @@ static void __init setup_processor(void)
 	elf_hwcap = 0;
 }
 
+int __init early_init_dt_scan_chosen_arm64(unsigned long node,
+					   const char *uname,
+					   int depth, void *data)
+{
+	char *prop;
+
+	/* Check if this is chosen node */
+	if (early_init_dt_scan_chosen(node, uname, depth, data) == 0)
+		return 0;
+
+	prop = of_get_flat_dt_prop(node, "earlyprintk", NULL);
+	if (prop)
+		earlyprintk_dt_args = prop;
+
+	return 1;
+}
+
 static void __init setup_machine_fdt(phys_addr_t dt_phys)
 {
 	struct boot_param_header *devtree;
@@ -165,7 +185,7 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
 	pr_info("Machine: %s\n", machine_name);
 
 	/* Retrieve various information from the /chosen node */
-	of_scan_flat_dt(early_init_dt_scan_chosen, boot_command_line);
+	of_scan_flat_dt(early_init_dt_scan_chosen_arm64, boot_command_line);
 	/* Initialize {size,address}-cells info */
 	of_scan_flat_dt(early_init_dt_scan_root, NULL);
 	/* Setup memory, calling early_init_dt_add_memory_arch */
-- 
1.7.9.5
