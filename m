From: nm@ti.com (Nishanth Menon)
Date: Fri, 22 Aug 2014 08:51:53 -0500
Subject: [PATCH 6/6] ARM: OMAP3+: PRM: register interrupt information from DT
In-Reply-To: <1408715513-25851-1-git-send-email-nm@ti.com>
References: <1408715513-25851-1-git-send-email-nm@ti.com>
Message-ID: <1408715513-25851-7-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow the PRM interrupt information to be picked up from device tree.
OMAP3 may use legacy boot and needs to be compatible with old dtbs
(without interrupt populated), for these, we use the value which is
pre-populated.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/prm3xxx.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 2458be6..e0088e0 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/of_irq.h>
 
 #include "soc.h"
 #include "common.h"
@@ -649,6 +650,11 @@ int __init omap3xxx_prm_init(void)
 	return prm_register(&omap3xxx_prm_ll_data);
 }
 
+static struct of_device_id omap3_prm_dt_match_table[] = {
+	{ .compatible = "ti,omap3-prm" },
+	{ }
+};
+
 static int omap3xxx_prm_late_init(void)
 {
 	int ret;
@@ -656,6 +662,18 @@ static int omap3xxx_prm_late_init(void)
 	if (!(prm_features & PRM_HAS_IO_WAKEUP))
 		return 0;
 
+	if (of_have_populated_dt()) {
+		struct device_node *np;
+		int irq_num;
+
+		np = of_find_matching_node(NULL, omap3_prm_dt_match_table);
+		if (np) {
+			irq_num = of_irq_get(np, 0);
+			if (irq_num >= 0)
+				omap3_prcm_irq_setup.irq = irq_num;
+		}
+	}
+
 	omap3xxx_prm_enable_io_wakeup();
 	ret = omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
 	if (!ret)
-- 
1.7.9.5
