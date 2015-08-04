From: 21cnbao@gmail.com (Barry Song)
Date: Tue,  4 Aug 2015 14:45:29 +0000
Subject: [PATCH 4/7 v2] clk: atlas7: replace dto resolution magic number by
 macro
In-Reply-To: <1438699532-13860-1-git-send-email-21cnbao@gmail.com>
References: <1438699532-13860-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1438699532-13860-5-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yibo Cai <yibo.cai@csr.com>

Signed-off-by: Yibo Cai <yibo.cai@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/clk/sirf/clk-atlas7.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/sirf/clk-atlas7.c b/drivers/clk/sirf/clk-atlas7.c
index cf489a5..1000421 100644
--- a/drivers/clk/sirf/clk-atlas7.c
+++ b/drivers/clk/sirf/clk-atlas7.c
@@ -465,6 +465,9 @@ static struct clk_pll clk_sys3pll = {
  *  double resolution mode:fout = fin * finc / 2^29
  *  normal mode:fout = fin * finc / 2^28
  */
+#define DTO_RESL_DOUBLE	(1ULL << 29)
+#define DTO_RESL_NORMAL	(1ULL << 28)
+
 static int dto_clk_is_enabled(struct clk_hw *hw)
 {
 	struct clk_dto *clk = to_dtoclk(hw);
@@ -509,9 +512,9 @@ static unsigned long dto_clk_recalc_rate(struct clk_hw *hw,
 	rate *= finc;
 	if (droff & BIT(0))
 		/* Double resolution off */
-		do_div(rate, 1 << 28);
+		do_div(rate, DTO_RESL_NORMAL);
 	else
-		do_div(rate, 1 << 29);
+		do_div(rate, DTO_RESL_DOUBLE);
 
 	return rate;
 }
@@ -519,11 +522,11 @@ static unsigned long dto_clk_recalc_rate(struct clk_hw *hw,
 static long dto_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long *parent_rate)
 {
-	u64 dividend = (u64)rate * (1 << 29);
+	u64 dividend = rate * DTO_RESL_DOUBLE;
 
 	do_div(dividend, *parent_rate);
 	dividend *= *parent_rate;
-	do_div(dividend, 1 << 29);
+	do_div(dividend, DTO_RESL_DOUBLE);
 
 	return dividend;
 }
@@ -531,7 +534,7 @@ static long dto_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 static int dto_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long parent_rate)
 {
-	u64 dividend = (u64)rate * (1 << 29);
+	u64 dividend = rate * DTO_RESL_DOUBLE;
 	struct clk_dto *clk = to_dtoclk(hw);
 
 	do_div(dividend, parent_rate);
-- 
1.9.1
