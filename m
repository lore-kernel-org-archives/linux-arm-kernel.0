From: chao.xie@marvell.com (Chao Xie)
Date: Thu, 23 Jan 2014 10:47:42 +0800
Subject: [PATCH 3/3] clk: mmp: try to use closer one when do round rate
In-Reply-To: <1390445262-27486-1-git-send-email-chao.xie@marvell.com>
References: <1390445262-27486-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1390445262-27486-4-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

The orignal code will use the bigger rate between
"previous rate" and "current rate" when caculate the
rate.
In fact, hardware cares about the closest one.
So choose the closer rate between "previous rate" and
"current rate".

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/clk/mmp/clk-frac.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mmp/clk-frac.c b/drivers/clk/mmp/clk-frac.c
index 5863a37..23a56f5 100644
--- a/drivers/clk/mmp/clk-frac.c
+++ b/drivers/clk/mmp/clk-frac.c
@@ -45,10 +45,14 @@ static long clk_factor_round_rate(struct clk_hw *hw, unsigned long drate,
 		if (rate > drate)
 			break;
 	}
-	if ((i == 0) || (i == factor->ftbl_cnt))
+	if ((i == 0) || (i == factor->ftbl_cnt)) {
 		return rate;
-	else
-		return prev_rate;
+	} else {
+		if ((drate - prev_rate) > (rate - drate))
+			return rate;
+		else
+			return prev_rate;
+	}
 }
 
 static unsigned long clk_factor_recalc_rate(struct clk_hw *hw,
-- 
1.8.3.2
