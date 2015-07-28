From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 28 Jul 2015 06:27:21 +0000
Subject: [PATCH 3/7] clk: sirf: fix integer overflow in dto rate calculation
In-Reply-To: <1438064845-17894-1-git-send-email-21cnbao@gmail.com>
References: <1438064845-17894-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1438064845-17894-4-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yibo Cai <yibo.cai@csr.com>

I cannot believe that I spend quite a lot time in finding this bug.
It seems a pitfall people tend to fall in.

In "int64 = int32 * int32", conversion from 32-bits to 64-bits comes
after the multiplication. So this statement may not work as expected.

Signed-off-by: Yibo Cai <yibo.cai@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/clk/sirf/clk-atlas7.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sirf/clk-atlas7.c b/drivers/clk/sirf/clk-atlas7.c
index d01dce3..cf489a5 100644
--- a/drivers/clk/sirf/clk-atlas7.c
+++ b/drivers/clk/sirf/clk-atlas7.c
@@ -519,7 +519,7 @@ static unsigned long dto_clk_recalc_rate(struct clk_hw *hw,
 static long dto_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long *parent_rate)
 {
-	u64 dividend = rate * (1 << 29);
+	u64 dividend = (u64)rate * (1 << 29);
 
 	do_div(dividend, *parent_rate);
 	dividend *= *parent_rate;
@@ -531,7 +531,7 @@ static long dto_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 static int dto_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long parent_rate)
 {
-	u64 dividend = rate * (1 << 29);
+	u64 dividend = (u64)rate * (1 << 29);
 	struct clk_dto *clk = to_dtoclk(hw);
 
 	do_div(dividend, parent_rate);
-- 
1.9.1
