From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Mon,  1 Jan 2018 19:42:50 +0000
Subject: [PATCH v3 11/34] clk: bcm: iproc: change iproc_pll_round_rate()
 return logic
In-Reply-To: <1514835793-1104-1-git-send-email-pure.logic@nexus-software.ie>
References: <1514835793-1104-1-git-send-email-pure.logic@nexus-software.ie>
Message-ID: <1514835793-1104-12-git-send-email-pure.logic@nexus-software.ie>
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
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Jon Mason <jonmason@broadcom.com>
Cc: bcm-kernel-feedback-list at broadcom.com
Cc: linux-clk at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/clk/bcm/clk-iproc-pll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-iproc-pll.c b/drivers/clk/bcm/clk-iproc-pll.c
index b5399b2..54e914c 100644
--- a/drivers/clk/bcm/clk-iproc-pll.c
+++ b/drivers/clk/bcm/clk-iproc-pll.c
@@ -439,7 +439,7 @@ static unsigned long iproc_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 	struct iproc_pll *pll = clk->pll;
 
 	if (rate == 0 || *parent_rate == 0 || !pll->vco_param)
-		return -EINVAL;
+		return 0;
 
 	for (i = 0; i < pll->num_vco_entries; i++) {
 		if (rate <= pll->vco_param[i].rate)
@@ -541,7 +541,7 @@ static unsigned long iproc_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned int div;
 
 	if (rate == 0 || *parent_rate == 0)
-		return -EINVAL;
+		return 0;
 
 	if (rate == *parent_rate)
 		return *parent_rate;
-- 
2.7.4
