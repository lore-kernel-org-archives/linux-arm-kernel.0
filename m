From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Mon,  1 Jan 2018 19:34:47 +0000
Subject: [PATCH v2 21/34] clk: lpc32xx: change clk_hclk_pll_round_rate()
 return logic
In-Reply-To: <1514835300-381-1-git-send-email-pure.logic@nexus-software.ie>
References: <1514835300-381-1-git-send-email-pure.logic@nexus-software.ie>
Message-ID: <1514835300-381-7-git-send-email-pure.logic@nexus-software.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the round_rate() logic here to return zero instead of a
negative number on error.

In conjunction with higher-level changes associated with acting on the
return value of clk_ops->round_rate() it is then possible to have
clk_ops->round_rate() return values from 1 Hz to ULONG_MAX Hz instead of
the current limitation of 1 Hz to LONG_MAX Hz.

Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: Gabriel Fernandez <gabriel.fernandez@st.com>
Cc: linux-clk at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/clk/nxp/clk-lpc32xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/nxp/clk-lpc32xx.c b/drivers/clk/nxp/clk-lpc32xx.c
index 81ab57d..76c17f4 100644
--- a/drivers/clk/nxp/clk-lpc32xx.c
+++ b/drivers/clk/nxp/clk-lpc32xx.c
@@ -595,7 +595,7 @@ static unsigned long clk_hclk_pll_round_rate(struct clk_hw *hw,
 	pr_debug("%s: %lu/%lu\n", clk_hw_get_name(hw), *parent_rate, rate);
 
 	if (rate > 266500000)
-		return -EINVAL;
+		return 0;
 
 	/* Have to check all 20 possibilities to find the minimal M */
 	for (p_i = 4; p_i >= 0; p_i--) {
@@ -622,7 +622,7 @@ static unsigned long clk_hclk_pll_round_rate(struct clk_hw *hw,
 	if (d == (u64)rate << 6) {
 		pr_err("%s: %lu: no valid PLL parameters are found\n",
 		       clk_hw_get_name(hw), rate);
-		return -EINVAL;
+		return 0;
 	}
 
 	clk->m_div = m;
-- 
2.7.4
