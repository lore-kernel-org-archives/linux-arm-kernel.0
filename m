From: nm@ti.com (Nishanth Menon)
Date: Thu, 5 Jun 2014 22:35:58 -0500
Subject: [RFC PATCH 4/7] ARM: OMAP4+: PRM: register interrupt information from
 DT
In-Reply-To: <1402025761-16831-1-git-send-email-nm@ti.com>
References: <1402025761-16831-1-git-send-email-nm@ti.com>
Message-ID: <1402025761-16831-5-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow the PRM interrupt information to be picked up from device tree.
the only exception is for OMAP4 which uses values pre-populated and allows
compatibility with older dtb.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/prm44xx.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 1ecf244..784b3e1 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -17,6 +17,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/of_irq.h>
 
 
 #include "soc.h"
@@ -698,11 +699,51 @@ int __init omap44xx_prm_init(void)
 	return prm_register(&omap44xx_prm_ll_data);
 }
 
+static struct of_device_id omap_prm_dt_match_table[] = {
+	{ .compatible = "ti,omap4-prm" },
+	{ .compatible = "ti,omap5-prm" },
+	{ .compatible = "ti,dra7-prm" },
+	{ }
+};
+
 static int omap44xx_prm_late_init(void)
 {
+	struct device_node *np;
+	int irq_num;
+
+	/* OMAP4+ is DT only now */
+	if (!of_have_populated_dt())
+		return 0;
+
 	if (!(prm_features & PRM_HAS_IO_WAKEUP))
 		return 0;
 
+	np = of_find_matching_node(NULL, omap_prm_dt_match_table);
+
+	if (!np) {
+		/* Default loaded up with OMAP4 values - older dtb compatible? */
+		if (!cpu_is_omap44xx())
+			return 0;
+	} else {
+		irq_num = of_irq_get(np, 0);
+		/*
+		 * Already have OMAP4 IRQ num. For all other platforms, we need
+		 * IRQ numbers from DT - old dtb compatible?
+		 */
+		if (irq_num < 0 && !cpu_is_omap44xx()) {
+
+			if (irq_num == -EPROBE_DEFER)
+				return irq_num;
+
+			/* Have nothing to do */
+			return 0;
+		}
+
+		/* Once OMAP4 DT is filled as well */
+		if (irq_num >= 0)
+			omap4_prcm_irq_setup.irq = irq_num;
+	}
+
 	omap44xx_prm_enable_io_wakeup();
 
 	return omap_prcm_register_chain_handler(&omap4_prcm_irq_setup);
-- 
1.7.9.5
