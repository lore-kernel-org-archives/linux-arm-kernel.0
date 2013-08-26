From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 26 Aug 2013 13:48:36 +0200
Subject: [PATCH] cpufreq: imx6q: Fix clock enable balance
Message-ID: <1377517716-27470-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For changing the cpu frequency the i.MX6q has to be switched to some
intermediate clock during the PLL reprogramming. The driver tries
to be clever to keep the enable count correct but gets it wrong. If
the cpufreq is increased it calls clk_disable_unprepare twice
on pll2_pfd2_396m. This puts all other devices which get their clock
from pll2_pfd2_396m into a nonworking state.

Fix this by removing the clk enabling/disabling altogether since the
clk core will do this automatically during a reparent.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/cpufreq/imx6q-cpufreq.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index e37cdae..2971d12 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -117,28 +117,11 @@ static int imx6q_set_target(struct cpufreq_policy *policy,
 	 *  - Reprogram pll1_sys_clk and reparent pll1_sw_clk back to it
 	 *  - Disable pll2_pfd2_396m_clk
 	 */
-	clk_prepare_enable(pll2_pfd2_396m_clk);
 	clk_set_parent(step_clk, pll2_pfd2_396m_clk);
 	clk_set_parent(pll1_sw_clk, step_clk);
 	if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk)) {
 		clk_set_rate(pll1_sys_clk, freqs.new * 1000);
-		/*
-		 * If we are leaving 396 MHz set-point, we need to enable
-		 * pll1_sys_clk and disable pll2_pfd2_396m_clk to keep
-		 * their use count correct.
-		 */
-		if (freqs.old * 1000 <= clk_get_rate(pll2_pfd2_396m_clk)) {
-			clk_prepare_enable(pll1_sys_clk);
-			clk_disable_unprepare(pll2_pfd2_396m_clk);
-		}
 		clk_set_parent(pll1_sw_clk, pll1_sys_clk);
-		clk_disable_unprepare(pll2_pfd2_396m_clk);
-	} else {
-		/*
-		 * Disable pll1_sys_clk if pll2_pfd2_396m_clk is sufficient
-		 * to provide the frequency.
-		 */
-		clk_disable_unprepare(pll1_sys_clk);
 	}
 
 	/* Ensure the arm clock divider is what we expect */
-- 
1.8.4.rc3
