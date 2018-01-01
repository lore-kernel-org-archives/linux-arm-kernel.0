From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Mon,  1 Jan 2018 19:34:55 +0000
Subject: [PATCH v2 29/34] clk: zte: change zx_audio_round_rate() return logic
In-Reply-To: <1514835300-381-1-git-send-email-pure.logic@nexus-software.ie>
References: <1514835300-381-1-git-send-email-pure.logic@nexus-software.ie>
Message-ID: <1514835300-381-15-git-send-email-pure.logic@nexus-software.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the round_rate() logic here to return zero instead of a
negative number on error.

In conjunction with higher-level changes associated with acting on the
return value of clk_ops->round_rate() it is then possible to have
clk_ops->round_rate() return values from 1 Hz to ULONG_MAX Hz instead of
the current limitation of 1 Hz to LONG_MAX Hz.

Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: Jun Nie <jun.nie@linaro.org>
Cc: Baoyou Xie <baoyou.xie@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-clk at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/clk/zte/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/zte/clk.c b/drivers/clk/zte/clk.c
index df91842..6afdc4a 100644
--- a/drivers/clk/zte/clk.c
+++ b/drivers/clk/zte/clk.c
@@ -247,7 +247,7 @@ static unsigned long zx_audio_round_rate(struct clk_hw *hw, unsigned long rate,
 	u32 reg;
 
 	if (rate * 2 > *prate)
-		return -EINVAL;
+		return 0;
 
 	reg = calc_reg(*prate, rate);
 	return calc_rate(reg, *prate);
-- 
2.7.4
