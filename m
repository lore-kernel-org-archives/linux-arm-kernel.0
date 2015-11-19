From: lho@apm.com (Loc Ho)
Date: Thu, 19 Nov 2015 12:20:30 -0700
Subject: [PATCH] clk: xgene: Fix divider with non-zero shift value
Message-ID: <1447960830-8675-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The X-Gene clock driver missed the divider shift operation when
set the divider value.

Signed-off-by: Loc Ho <lho@apm.com>
---
 drivers/clk/clk-xgene.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/clk-xgene.c b/drivers/clk/clk-xgene.c
index 27c0da2..10224b0 100644
--- a/drivers/clk/clk-xgene.c
+++ b/drivers/clk/clk-xgene.c
@@ -351,7 +351,8 @@ static int xgene_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 		/* Set new divider */
 		data = xgene_clk_read(pclk->param.divider_reg +
 				pclk->param.reg_divider_offset);
-		data &= ~((1 << pclk->param.reg_divider_width) - 1);
+		data &= ~((1 << pclk->param.reg_divider_width) - 1)
+				<< pclk->param.reg_divider_shift;
 		data |= divider;
 		xgene_clk_write(data, pclk->param.divider_reg +
 					pclk->param.reg_divider_offset);
-- 
1.7.1
