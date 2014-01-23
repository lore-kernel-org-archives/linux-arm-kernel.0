From: chao.xie@marvell.com (Chao Xie)
Date: Thu, 23 Jan 2014 10:47:41 +0800
Subject: [PATCH 2/3] clk: mmp: fix the wrong calculation formula
In-Reply-To: <1390445262-27486-1-git-send-email-chao.xie@marvell.com>
References: <1390445262-27486-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1390445262-27486-3-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

The formula is numerator/denominator = Fin / (Fout * factor)
So
Fout = Fin * denominator / (numerator * factor).
Current clk_factor_round_rate and clk_factor_recalc_rate use
wrong formula. This patch will fix them.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/clk/mmp/clk-frac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mmp/clk-frac.c b/drivers/clk/mmp/clk-frac.c
index f6e7691..5863a37 100644
--- a/drivers/clk/mmp/clk-frac.c
+++ b/drivers/clk/mmp/clk-frac.c
@@ -40,12 +40,12 @@ static long clk_factor_round_rate(struct clk_hw *hw, unsigned long drate,
 
 	for (i = 0; i < factor->ftbl_cnt; i++) {
 		prev_rate = rate;
-		rate = (((*prate / 10000) * factor->ftbl[i].num) /
-			(factor->ftbl[i].den * factor->masks->factor)) * 10000;
+		rate = (((*prate / 10000) * factor->ftbl[i].den) /
+			(factor->ftbl[i].num * factor->masks->factor)) * 10000;
 		if (rate > drate)
 			break;
 	}
-	if (i == 0)
+	if ((i == 0) || (i == factor->ftbl_cnt))
 		return rate;
 	else
 		return prev_rate;
@@ -85,8 +85,8 @@ static int clk_factor_set_rate(struct clk_hw *hw, unsigned long drate,
 
 	for (i = 0; i < factor->ftbl_cnt; i++) {
 		prev_rate = rate;
-		rate = (((prate / 10000) * factor->ftbl[i].num) /
-			(factor->ftbl[i].den * factor->masks->factor)) * 10000;
+		rate = (((prate / 10000) * factor->ftbl[i].den) /
+			(factor->ftbl[i].num * factor->masks->factor)) * 10000;
 		if (rate > drate)
 			break;
 	}
-- 
1.8.3.2
