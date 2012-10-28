From: linux@prisktech.co.nz (Tony Prisk)
Date: Mon, 29 Oct 2012 10:40:31 +1300
Subject: [PATCH 2/2] clk: vt8500: Remove dependancy on pmc_base
In-Reply-To: <1351460431-1048-1-git-send-email-linux@prisktech.co.nz>
References: <1351460431-1048-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1351460431-1048-2-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the requirement to pass a Power Management
Controller base address to vtwm_clk_init(), in preparation of
separating the power management code from arch-vt8500/vt8500.c.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
Mike,

Do you mind if this patch goes through arm-soc, given it is self-contained,
so I can base the other PM changes off it?

Regards
Tony P

 arch/arm/mach-vt8500/common.h |    2 +-
 arch/arm/mach-vt8500/vt8500.c |    2 +-
 drivers/clk/clk-vt8500.c      |   20 ++++++++++++++++----
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-vt8500/common.h b/arch/arm/mach-vt8500/common.h
index 2b24196..e38b17f 100644
--- a/arch/arm/mach-vt8500/common.h
+++ b/arch/arm/mach-vt8500/common.h
@@ -23,6 +23,6 @@ int __init vt8500_irq_init(struct device_node *node,
 				struct device_node *parent);
 
 /* defined in drivers/clk/clk-vt8500.c */
-void __init vtwm_clk_init(void __iomem *pmc_base);
+void __init vtwm_clk_init(void);
 
 #endif
diff --git a/arch/arm/mach-vt8500/vt8500.c b/arch/arm/mach-vt8500/vt8500.c
index 8d3871f..0ee2a16 100644
--- a/arch/arm/mach-vt8500/vt8500.c
+++ b/arch/arm/mach-vt8500/vt8500.c
@@ -162,7 +162,7 @@ void __init vt8500_init(void)
 	else
 		pr_err("%s: PMC Hibernation register could not be remapped, not enabling power off!\n", __func__);
 
-	vtwm_clk_init(pmc_base);
+	vtwm_clk_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
diff --git a/drivers/clk/clk-vt8500.c b/drivers/clk/clk-vt8500.c
index fe25570..820f39a 100644
--- a/drivers/clk/clk-vt8500.c
+++ b/drivers/clk/clk-vt8500.c
@@ -15,6 +15,7 @@
 
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <linux/clkdev.h>
@@ -517,12 +518,23 @@ static const __initconst struct of_device_id clk_match[] = {
 	{ /* sentinel */ }
 };
 
-void __init vtwm_clk_init(void __iomem *base)
+void __init vtwm_clk_init(void)
 {
-	if (!base)
-		return;
+	struct device_node *np =
+			of_find_compatible_node(NULL, NULL, "via,vt8500-pmc");
+
+	if (!np) {
+		pr_err("%s: power management device node missing\n", __func__);
+		return -ENODEV;
+	}
 
-	pmc_base = base;
+	pmc_base = of_iomap(np, 0);
+	of_node_put(np);
+
+	if (!pmc_base) {
+		pr_err("%s: of_iomap(pmc) failed\n", __func__);
+		return -ENOMEM;
+	}
 
 	of_clk_init(clk_match);
 }
-- 
1.7.9.5
