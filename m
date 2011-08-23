From: Baohua.Song@csr.com (Barry Song)
Date: Mon, 22 Aug 2011 23:15:52 -0700
Subject: [PATCH v2 4/4] ARM: CSR: add PM suspend/resume entries for
	SiRFprimaII L2 cache
In-Reply-To: <1314080152-30503-1-git-send-email-Baohua.Song@csr.com>
References: <1314080152-30503-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1314080152-30503-5-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongjun Ying <rongjun.ying@csr.com>

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/l2x0.c |   82 +++++++++++++++++++++++++++++++-----------
 1 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-prima2/l2x0.c b/arch/arm/mach-prima2/l2x0.c
index 9cda205..620c586 100644
--- a/arch/arm/mach-prima2/l2x0.c
+++ b/arch/arm/mach-prima2/l2x0.c
@@ -18,42 +18,80 @@
 #define L2X0_ADDR_FILTERING_START       0xC00
 #define L2X0_ADDR_FILTERING_END         0xC04
 
-static struct of_device_id l2x_ids[]  = {
+static void __iomem *sirfsoc_l2x0_base;
+
+static struct of_device_id l2x0_ids[]  = {
 	{ .compatible = "arm,pl310-cache" },
 };
 
-static int __init sirfsoc_of_l2x_init(void)
+static void sirfsoc_l2x0_init(void)
 {
-	struct device_node *np;
-	void __iomem *sirfsoc_l2x_base;
-
-	np = of_find_matching_node(NULL, l2x_ids);
-	if (!np)
-		panic("unable to find compatible l2x node in dtb\n");
-
-	sirfsoc_l2x_base = of_iomap(np, 0);
-	if (!sirfsoc_l2x_base)
-		panic("unable to map l2x cpu registers\n");
-
-	of_node_put(np);
-
-	if (!(readl_relaxed(sirfsoc_l2x_base + L2X0_CTRL) & 1)) {
+	if (!(readl_relaxed(sirfsoc_l2x0_base + L2X0_CTRL) & 1)) {
 		/*
 		 * set the physical memory windows L2 cache will cover
 		 */
 		writel_relaxed(PLAT_PHYS_OFFSET + 1024 * 1024 * 1024,
-			sirfsoc_l2x_base + L2X0_ADDR_FILTERING_END);
+			sirfsoc_l2x0_base + L2X0_ADDR_FILTERING_END);
 		writel_relaxed(PLAT_PHYS_OFFSET | 0x1,
-			sirfsoc_l2x_base + L2X0_ADDR_FILTERING_START);
+			sirfsoc_l2x0_base + L2X0_ADDR_FILTERING_START);
 
 		writel_relaxed(0,
-			sirfsoc_l2x_base + L2X0_TAG_LATENCY_CTRL);
+			sirfsoc_l2x0_base + L2X0_TAG_LATENCY_CTRL);
 		writel_relaxed(0,
-			sirfsoc_l2x_base + L2X0_DATA_LATENCY_CTRL);
+			sirfsoc_l2x0_base + L2X0_DATA_LATENCY_CTRL);
 	}
-	l2x0_init((void __iomem *)sirfsoc_l2x_base, 0x00040000,
+	l2x0_init((void __iomem *)sirfsoc_l2x0_base, 0x00040000,
 		0x00000000);
+}
+
+static int __init sirfsoc_of_l2x0_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, l2x0_ids);
+	if (!np)
+		panic("unable to find compatible l2x node in dtb\n");
+
+	sirfsoc_l2x0_base = of_iomap(np, 0);
+	if (!sirfsoc_l2x0_base)
+		panic("unable to map l2x cpu registers\n");
 
+	of_node_put(np);
+
+	sirfsoc_l2x0_init();
+
+	return 0;
+}
+early_initcall(sirfsoc_of_l2x0_init);
+
+#ifdef CONFIG_PM
+#include <linux/syscore_ops.h>
+
+static int sirfsoc_l2x0_pm_suspend(void)
+{
+	writel_relaxed(0xFF, sirfsoc_l2x0_base + L2X0_CLEAN_INV_WAY);
+	while (readl_relaxed(sirfsoc_l2x0_base + L2X0_CLEAN_INV_WAY))
+		continue;
+	writel_relaxed(0x0, sirfsoc_l2x0_base + L2X0_CACHE_SYNC);
+	writel_relaxed(0x0, sirfsoc_l2x0_base + L2X0_CTRL);
+	return 0;
+}
+
+static void sirfsoc_l2x0_pm_resume(void)
+{
+	sirfsoc_l2x0_init();
+}
+
+static struct syscore_ops sirfsoc_l2x0_pm_syscore_ops = {
+	.suspend	= sirfsoc_l2x0_pm_suspend,
+	.resume		= sirfsoc_l2x0_pm_resume,
+};
+
+static int sirfsoc_l2x0_pm_init(void)
+{
+	register_syscore_ops(&sirfsoc_l2x0_pm_syscore_ops);
 	return 0;
 }
-early_initcall(sirfsoc_of_l2x_init);
+late_initcall(sirfsoc_l2x0_pm_init);
+
+#endif
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
