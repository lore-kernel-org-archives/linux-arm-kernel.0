From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 29 Jun 2015 19:29:38 +0200
Subject: [PATCH] clk: samsung: fix cpu clock's flags checking
Message-ID: <1435598978-21800-1-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CLK_CPU_HAS_DIV1 and CLK_CPU_NEEDS_DEBUG_ALT_DIV masks were
incorrectly used as a bit numbers.  Fix it.

Tested on Exynos4210 based Origen board and on Exynos5250 based
Arndale board.

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/clk/samsung/clk-cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index 3a1fe07..dd02356 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -161,7 +161,7 @@ static int exynos_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 	 * the values for DIV_COPY and DIV_HPM dividers need not be set.
 	 */
 	div0 = cfg_data->div0;
-	if (test_bit(CLK_CPU_HAS_DIV1, &cpuclk->flags)) {
+	if (cpuclk->flags & CLK_CPU_HAS_DIV1) {
 		div1 = cfg_data->div1;
 		if (readl(base + E4210_SRC_CPU) & E4210_MUX_HPM_MASK)
 			div1 = readl(base + E4210_DIV_CPU1) &
@@ -182,7 +182,7 @@ static int exynos_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 		alt_div = DIV_ROUND_UP(alt_prate, tmp_rate) - 1;
 		WARN_ON(alt_div >= MAX_DIV);
 
-		if (test_bit(CLK_CPU_NEEDS_DEBUG_ALT_DIV, &cpuclk->flags)) {
+		if (cpuclk->flags & CLK_CPU_NEEDS_DEBUG_ALT_DIV) {
 			/*
 			 * In Exynos4210, ATB clock parent is also mout_core. So
 			 * ATB clock also needs to be mantained at safe speed.
@@ -203,7 +203,7 @@ static int exynos_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
 	writel(div0, base + E4210_DIV_CPU0);
 	wait_until_divider_stable(base + E4210_DIV_STAT_CPU0, DIV_MASK_ALL);
 
-	if (test_bit(CLK_CPU_HAS_DIV1, &cpuclk->flags)) {
+	if (cpuclk->flags & CLK_CPU_HAS_DIV1) {
 		writel(div1, base + E4210_DIV_CPU1);
 		wait_until_divider_stable(base + E4210_DIV_STAT_CPU1,
 				DIV_MASK_ALL);
@@ -222,7 +222,7 @@ static int exynos_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
 	unsigned long mux_reg;
 
 	/* find out the divider values to use for clock data */
-	if (test_bit(CLK_CPU_NEEDS_DEBUG_ALT_DIV, &cpuclk->flags)) {
+	if (cpuclk->flags & CLK_CPU_NEEDS_DEBUG_ALT_DIV) {
 		while ((cfg_data->prate * 1000) != ndata->new_rate) {
 			if (cfg_data->prate == 0)
 				return -EINVAL;
@@ -237,7 +237,7 @@ static int exynos_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
 	writel(mux_reg & ~(1 << 16), base + E4210_SRC_CPU);
 	wait_until_mux_stable(base + E4210_STAT_CPU, 16, 1);
 
-	if (test_bit(CLK_CPU_NEEDS_DEBUG_ALT_DIV, &cpuclk->flags)) {
+	if (cpuclk->flags & CLK_CPU_NEEDS_DEBUG_ALT_DIV) {
 		div |= (cfg_data->div0 & E4210_DIV0_ATB_MASK);
 		div_mask |= E4210_DIV0_ATB_MASK;
 	}
-- 
1.9.1
