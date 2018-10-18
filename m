From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 18 Oct 2018 11:57:03 +0200
Subject: [PATCH v4 1/6] clocksource: exynos_mct: Remove dead code
In-Reply-To: <20181018095708.1527-1-m.szyprowski@samsung.com>
References: <20181018095708.1527-1-m.szyprowski@samsung.com>
 <CGME20181018095716eucas1p192004241424d1cf581f715558b2e67a4@eucas1p1.samsung.com>
Message-ID: <20181018095708.1527-2-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos Multi-Core Timer driver is used only on device-tree based
systems, so remove non-dt related code. In case of !CONFIG_OF
the code is anyway equal because of_irq_count() has a stub
returning 0. Device node pointer is always provided when driver
has been probed from device tree.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 7a244b681876..ef18bbf8d20c 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -507,13 +507,12 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
 	int err, cpu;
 	struct clk *mct_clk, *tick_clk;
 
-	tick_clk = np ? of_clk_get_by_name(np, "fin_pll") :
-				clk_get(NULL, "fin_pll");
+	tick_clk = of_clk_get_by_name(np, "fin_pll");
 	if (IS_ERR(tick_clk))
 		panic("%s: unable to determine tick clock rate\n", __func__);
 	clk_rate = clk_get_rate(tick_clk);
 
-	mct_clk = np ? of_clk_get_by_name(np, "mct") : clk_get(NULL, "mct");
+	mct_clk = of_clk_get_by_name(np, "mct");
 	if (IS_ERR(mct_clk))
 		panic("%s: unable to retrieve mct clock instance\n", __func__);
 	clk_prepare_enable(mct_clk);
@@ -581,11 +580,7 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 	 * timer irqs are specified after the four global timer
 	 * irqs are specified.
 	 */
-#ifdef CONFIG_OF
 	nr_irqs = of_irq_count(np);
-#else
-	nr_irqs = 0;
-#endif
 	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
 		mct_irqs[i] = irq_of_parse_and_map(np, i);
 
-- 
2.17.1
