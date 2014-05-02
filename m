From: george.cherian@ti.com (George Cherian)
Date: Fri, 2 May 2014 12:02:03 +0530
Subject: [PATCH v2 5/6] ARM: AM43xx: clk: Change the cpts ref clock source to
 dpll_core_m5 clk
In-Reply-To: <1399012324-20737-1-git-send-email-george.cherian@ti.com>
References: <1399012324-20737-1-git-send-email-george.cherian@ti.com>
Message-ID: <1399012324-20737-6-git-send-email-george.cherian@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpsw_cpts_rft_clk has got the choice of 3 clocksources
 -dpll_core_m4_ck
 -dpll_core_m5_ck
 -dpll_disp_m2_ck

By default dpll_core_m4_ck is selected, witn this as clock
source the CPTS doesnot work properly. It gives clockcheck errors
while running PTP.

 clockcheck: clock jumped backward or running slower than expected!

By selecting dpll_core_m5_ck as the clocksource fixes this issue.
In AM335x dpll_core_m5_ck is the default clocksource.

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 drivers/clk/ti/clk-43xx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clk/ti/clk-43xx.c b/drivers/clk/ti/clk-43xx.c
index 67c8de5..b4877e0 100644
--- a/drivers/clk/ti/clk-43xx.c
+++ b/drivers/clk/ti/clk-43xx.c
@@ -110,9 +110,25 @@ static struct ti_dt_clk am43xx_clks[] = {
 
 int __init am43xx_dt_clk_init(void)
 {
+	struct clk *clk1, *clk2;
+
 	ti_dt_clocks_register(am43xx_clks);
 
 	omap2_clk_disable_autoidle_all();
 
+	/*
+	 * cpsw_cpts_rft_clk  has got the choice of 3 clocksources
+	 * dpll_core_m4_ck, dpll_core_m5_ck and dpll_disp_m2_ck.
+	 * By default dpll_core_m4_ck is selected, witn this as clock
+	 * source the CPTS doesnot work properly. It gives clockcheck errors
+	 * while running PTP.
+	 * clockcheck: clock jumped backward or running slower than expected!
+	 * By selecting dpll_core_m5_ck as the clocksource fixes this issue.
+	 * In AM335x dpll_core_m5_ck is the default clocksource.
+	 */
+	clk1 = clk_get_sys(NULL, "cpsw_cpts_rft_clk");
+	clk2 = clk_get_sys(NULL, "dpll_core_m5_ck");
+	clk_set_parent(clk1, clk2);
+
 	return 0;
 }
-- 
1.8.3.1
