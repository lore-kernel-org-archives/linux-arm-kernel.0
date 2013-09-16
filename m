From: robherring2@gmail.com (Rob Herring)
Date: Mon, 16 Sep 2013 18:09:07 -0500
Subject: [PATCH 11/28] arm: use early_init_dt_scan
In-Reply-To: <1379372965-22359-1-git-send-email-robherring2@gmail.com>
References: <1379372965-22359-1-git-send-email-robherring2@gmail.com>
Message-ID: <1379372965-22359-12-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Convert arm to use new early_init_dt_scan function.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/kernel/devtree.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index f35906b..04050f7 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -183,7 +183,6 @@ bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
  */
 const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 {
-	struct boot_param_header *devtree;
 	const struct machine_desc *mdesc, *mdesc_best = NULL;
 	unsigned int score, mdesc_score = ~1;
 	unsigned long dt_root;
@@ -199,14 +198,9 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 	if (!dt_phys)
 		return NULL;
 
-	devtree = phys_to_virt(dt_phys);
-
-	/* check device tree validity */
-	if (be32_to_cpu(devtree->magic) != OF_DT_HEADER)
-		return NULL;
+	early_init_dt_scan(phys_to_virt(dt_phys));
 
 	/* Search the mdescs for the 'best' compatible value match */
-	initial_boot_params = devtree;
 	dt_root = of_get_flat_dt_root();
 	for_each_machine_desc(mdesc) {
 		score = of_flat_dt_match(dt_root, mdesc->dt_compat);
@@ -240,13 +234,6 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 		model = "<unknown>";
 	pr_info("Machine: %s, model: %s\n", mdesc_best->name, model);
 
-	/* Retrieve various information from the /chosen node */
-	of_scan_flat_dt(early_init_dt_scan_chosen, boot_command_line);
-	/* Initialize {size,address}-cells info */
-	of_scan_flat_dt(early_init_dt_scan_root, NULL);
-	/* Setup memory, calling early_init_dt_add_memory_arch */
-	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
-
 	/* Change machine number to match the mdesc we're using */
 	__machine_arch_type = mdesc_best->nr;
 
-- 
1.8.1.2
