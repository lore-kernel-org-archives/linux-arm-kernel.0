From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 26 Apr 2013 10:13:56 +0200
Subject: [PATCH 2/2] ARM: i.MX6: add i.MX6 specific L2 cache configuration
In-Reply-To: <1366964036-17275-1-git-send-email-dirk.behme@de.bosch.com>
References: <1366964036-17275-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <1366964036-17275-2-git-send-email-dirk.behme@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To improve the performance and power consumption add an i.MX6
specific L2 cache initialization.

This configuration is taken from Freescale's kernel patch

"ENGR00153601 [MX6]Adjust L2 cache parameter" [1]

with two additional improvements:

a) The L2X0_POWER_CTRL has only the two bits we set. So no need
   to read the register before. Remove the register read done
   in Freescale's patch.

b) In the L2X0_PREFETCH_CTRL register, besides the double linefill (bit[30]),
   additionally enable the instruction and data prefetch (bit[29-28]).

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
CC: Shawn Guo <shawn.guo@linaro.org>

[1] http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/commit/arch/arm/mach-mx6/mm.c?h=imx_3.0.35_12.09.01&id=814656410b40c67a10b25300e51b0477b2bb96d1
---
 arch/arm/mach-imx/mach-imx6q.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 9ffd103..cdaeab5 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -281,9 +281,43 @@ static void __init imx6q_map_io(void)
 	imx_scu_map_io();
 }
 
-static void __init imx6q_init_irq(void)
+#ifdef CONFIG_CACHE_L2X0
+static void __init imx6q_init_l2cache(void)
 {
+	void __iomem *l2x0_base;
+	struct device_node *np;
+	unsigned int val;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,pl310-cache");
+	if (!np)
+		goto out;
+
+	l2x0_base = of_iomap(np, 0);
+	if (!l2x0_base) {
+		of_node_put(np);
+		goto out;
+	}
+
+	/* Configure the L2 PREFETCH and POWER registers */
+	val = readl_relaxed(l2x0_base + L2X0_PREFETCH_CTRL);
+	val |= 0x70800000;
+	writel_relaxed(val, l2x0_base + L2X0_PREFETCH_CTRL);
+	val = L2X0_DYNAMIC_CLK_GATING_EN | L2X0_STNDBY_MODE_EN;
+	writel_relaxed(val, l2x0_base + L2X0_POWER_CTRL);
+
+	iounmap(l2x0_base);
+	of_node_put(np);
+
+out:
 	l2x0_of_init(0, ~0UL);
+}
+#else
+static inline void imx6q_init_l2cache(void) {}
+#endif
+
+static void __init imx6q_init_irq(void)
+{
+	imx6q_init_l2cache();
 	imx_src_init();
 	imx_gpc_init();
 	irqchip_init();
-- 
1.8.2
