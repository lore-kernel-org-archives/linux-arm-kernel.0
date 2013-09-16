From: robherring2@gmail.com (Rob Herring)
Date: Mon, 16 Sep 2013 18:09:21 -0500
Subject: [PATCH 25/28] arm: use common of_flat_dt_match_machine
In-Reply-To: <1379372965-22359-1-git-send-email-robherring2@gmail.com>
References: <1379372965-22359-1-git-send-email-robherring2@gmail.com>
Message-ID: <1379372965-22359-26-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Convert arm to use the common of_flat_dt_match_machine function.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/kernel/devtree.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 04050f7..cb918f6 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -174,6 +174,19 @@ bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 	return (phys_id & MPIDR_HWID_BITMASK) == cpu_logical_map(cpu);
 }
 
+static void * __init arch_get_next_mach(const char *const **match)
+{
+	static struct machine_desc *mdesc = __arch_info_begin;
+	struct machine_desc *m = mdesc;
+
+	if (m >= __arch_info_end)
+		return NULL;
+
+	mdesc++;
+	*match = m->dt_compat;
+	return m;
+}
+
 /**
  * setup_machine_fdt - Machine setup when an dtb was passed to the kernel
  * @dt_phys: physical address of dt blob
@@ -184,9 +197,6 @@ bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 {
 	const struct machine_desc *mdesc, *mdesc_best = NULL;
-	unsigned int score, mdesc_score = ~1;
-	unsigned long dt_root;
-	const char *model;
 
 #ifdef CONFIG_ARCH_MULTIPLATFORM
 	DT_MACHINE_START(GENERIC_DT, "Generic DT based system")
@@ -199,23 +209,17 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 		return NULL;
 
 	early_init_dt_scan(phys_to_virt(dt_phys));
+	mdesc = of_flat_dt_match_machine(mdesc_best, arch_get_next_mach);
 
-	/* Search the mdescs for the 'best' compatible value match */
-	dt_root = of_get_flat_dt_root();
-	for_each_machine_desc(mdesc) {
-		score = of_flat_dt_match(dt_root, mdesc->dt_compat);
-		if (score > 0 && score < mdesc_score) {
-			mdesc_best = mdesc;
-			mdesc_score = score;
-		}
-	}
-	if (!mdesc_best) {
+	if (!mdesc) {
 		const char *prop;
 		long size;
+		unsigned long dt_root;
 
 		early_print("\nError: unrecognized/unsupported "
 			    "device tree compatible list:\n[ ");
 
+		dt_root = of_get_flat_dt_root();
 		prop = of_get_flat_dt_prop(dt_root, "compatible", &size);
 		while (size > 0) {
 			early_print("'%s' ", prop);
@@ -226,16 +230,10 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 
 		dump_machine_table(); /* does not return */
 	}
-
-	model = of_get_flat_dt_prop(dt_root, "model", NULL);
-	if (!model)
-		model = of_get_flat_dt_prop(dt_root, "compatible", NULL);
-	if (!model)
-		model = "<unknown>";
-	pr_info("Machine: %s, model: %s\n", mdesc_best->name, model);
+	early_print("matched mach %s\n", mdesc->name);
 
 	/* Change machine number to match the mdesc we're using */
-	__machine_arch_type = mdesc_best->nr;
+	__machine_arch_type = mdesc->nr;
 
-	return mdesc_best;
+	return mdesc;
 }
-- 
1.8.1.2
