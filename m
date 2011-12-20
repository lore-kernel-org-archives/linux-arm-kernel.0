From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 20 Dec 2011 22:56:45 +0100
Subject: [PATCH] ARM/of: allow *machine_desc.dt_compat to be const
Message-ID: <1324418205-30355-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows dt_compat to point to a constant list of compatible strings.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

does this need to be split into an of and an ARM part?

Best regards
Uwe

 arch/arm/include/asm/mach/arch.h |    2 +-
 drivers/of/fdt.c                 |    4 ++--
 include/linux/of_fdt.h           |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 2b0efc3..02a718a 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -19,7 +19,7 @@ struct machine_desc {
 	unsigned int		nr;		/* architecture number	*/
 	const char		*name;		/* architecture name	*/
 	unsigned long		atag_offset;	/* tagged list (relative) */
-	const char		**dt_compat;	/* array of device tree
+	const char *const 	*dt_compat;	/* array of device tree
 						 * 'compatible' strings	*/
 
 	unsigned int		nr_irqs;	/* number of IRQs */
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index fd85fa2..7dc8e6d 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -107,7 +107,7 @@ int of_fdt_is_compatible(struct boot_param_header *blob,
  * of_fdt_match - Return true if node matches a list of compatible values
  */
 int of_fdt_match(struct boot_param_header *blob, unsigned long node,
-                 const char **compat)
+                 const char *const *compat)
 {
 	unsigned int tmp, score = 0;
 
@@ -541,7 +541,7 @@ int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
 /**
  * of_flat_dt_match - Return true if node matches a list of compatible values
  */
-int __init of_flat_dt_match(unsigned long node, const char **compat)
+int __init of_flat_dt_match(unsigned long node, const char *const *compat)
 {
 	return of_fdt_match(initial_boot_params, node, compat);
 }
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index c84d900..ed136ad 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -71,7 +71,7 @@ extern int of_fdt_is_compatible(struct boot_param_header *blob,
 				unsigned long node,
 				const char *compat);
 extern int of_fdt_match(struct boot_param_header *blob, unsigned long node,
-			const char **compat);
+			const char *const *compat);
 extern void of_fdt_unflatten_tree(unsigned long *blob,
 			       struct device_node **mynodes);
 
@@ -88,7 +88,7 @@ extern int of_scan_flat_dt(int (*it)(unsigned long node, const char *uname,
 extern void *of_get_flat_dt_prop(unsigned long node, const char *name,
 				 unsigned long *size);
 extern int of_flat_dt_is_compatible(unsigned long node, const char *name);
-extern int of_flat_dt_match(unsigned long node, const char **matches);
+extern int of_flat_dt_match(unsigned long node, const char *const *matches);
 extern unsigned long of_get_flat_dt_root(void);
 
 extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
-- 
1.7.7.3
