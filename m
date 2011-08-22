From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 22 Aug 2011 11:10:38 +0200
Subject: [PATCH] OMAP2+: Add a common method to init globals using DT compatible
Message-ID: <mailman.116.1314963838.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks to the DT root node compatible information, we can extract
the compatible SoC and use it to select the proper globals.
Create a common omap2_set_globals API that can be used by every
OMAP2+ platforms.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/common.c             |   73 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/common.h |    1 +
 2 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 3f20cbb..ee5a225 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/of_fdt.h>
 
 #include <plat/common.h>
 #include <plat/board.h>
@@ -140,3 +141,75 @@ void __init omap2_set_globals_443x(void)
 }
 #endif
 
+#ifdef CONFIG_OF
+/*
+ * DT method to get the proper globals configuration
+ */
+static const struct of_device_id omap_soc_match[] = {
+#if defined(CONFIG_ARCH_OMAP4)
+        {
+                .compatible = "ti,omap4",
+                .data = &omap4_globals,
+        },
+#endif
+#if defined(CONFIG_ARCH_OMAP3)
+        {
+                .compatible = "ti,omap3",
+                .data = &omap3_globals,
+        },
+#endif
+#if defined(CONFIG_SOC_OMAP2430)
+        {
+                .compatible = "ti,omap2430",
+                .data = &omap243x_globals,
+        },
+#endif
+#if defined(CONFIG_SOC_OMAP2420)
+        {
+                .compatible = "ti,omap2420",
+                .data = &omap242x_globals,
+        },
+#endif
+	{},
+};
+
+/* Helper to find the proper of_device_id from a FDT */
+static __init const struct of_device_id *_fdt_match_node(
+					const struct of_device_id *matches,
+					int fdt_node)
+{
+	unsigned int score = 0;
+
+	if (!matches)
+		return NULL;
+
+	while (matches->compatible[0]) {
+		score = of_flat_dt_is_compatible(fdt_node, matches->compatible);
+		if (score > 0)
+			return matches;
+		matches++;
+	}
+	return NULL;
+}
+
+void __init omap2_set_globals(void)
+{
+        unsigned long fdt_root;
+	const struct of_device_id *match;
+
+	/* the DT is still flat at map_io time... */
+        fdt_root = of_get_flat_dt_root();
+	match = _fdt_match_node(omap_soc_match, fdt_root);
+	if (!match) {
+		pr_err("%s(): Cannot initialize the platform globals data\n",
+		       __func__);
+	}
+
+	pr_info("%s(): %s\n", __func__, match->compatible);
+
+	omap2_set_globals_tap(match->data);
+	omap2_set_globals_sdrc(match->data);
+	omap2_set_globals_control(match->data);
+	omap2_set_globals_prcm(match->data);
+}
+#endif
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 4564cc6..fb79269 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -67,6 +67,7 @@ void omap2_set_globals_243x(void);
 void omap2_set_globals_3xxx(void);
 void omap2_set_globals_443x(void);
 void omap2_set_globals_ti816x(void);
+void omap2_set_globals(void);
 
 /* These get called from omap2_set_globals_xxxx(), do not call these */
 void omap2_set_globals_tap(struct omap_globals *);
-- 
1.7.0.4
