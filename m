From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 01 Aug 2017 18:21:22 +0200
Subject: [PATCH 1/2] clk: fractional-divider: allow overriding of approximation
In-Reply-To: <5990882.df1suBpf8V@phil>
References: <1500624187-12165-1-git-send-email-zhangqing@rock-chips.com>
 <5990882.df1suBpf8V@phil>
Message-ID: <5453089.AIzWDZk3ey@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Elaine Zhang <zhangqing@rock-chips.com>

Fractional dividers may have special requirements concerning numerator
and denominator selection that differ from just getting the best
approximation.

For example on Rockchip socs the denominator must be at least 20 times
larger than the numerator to generate precise clock frequencies.

Therefore add the ability to provide custom approximation functions.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/clk-fractional-divider.c | 28 ++++++++++++++++++++--------
 include/linux/clk-provider.h         |  3 +++
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index aab904618eb6..fdf625fb10fa 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -49,16 +49,12 @@ static unsigned long clk_fd_recalc_rate(struct clk_hw *hw,
 	return ret;
 }
 
-static long clk_fd_round_rate(struct clk_hw *hw, unsigned long rate,
-			      unsigned long *parent_rate)
+static void clk_fd_general_approximation(struct clk_hw *hw, unsigned long rate,
+					 unsigned long *parent_rate,
+					 unsigned long *m, unsigned long *n)
 {
 	struct clk_fractional_divider *fd = to_clk_fd(hw);
 	unsigned long scale;
-	unsigned long m, n;
-	u64 ret;
-
-	if (!rate || rate >= *parent_rate)
-		return *parent_rate;
 
 	/*
 	 * Get rate closer to *parent_rate to guarantee there is no overflow
@@ -71,7 +67,23 @@ static long clk_fd_round_rate(struct clk_hw *hw, unsigned long rate,
 
 	rational_best_approximation(rate, *parent_rate,
 			GENMASK(fd->mwidth - 1, 0), GENMASK(fd->nwidth - 1, 0),
-			&m, &n);
+			m, n);
+}
+
+static long clk_fd_round_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long *parent_rate)
+{
+	struct clk_fractional_divider *fd = to_clk_fd(hw);
+	unsigned long m, n;
+	u64 ret;
+
+	if (!rate || rate >= *parent_rate)
+		return *parent_rate;
+
+	if (fd->approximation)
+		fd->approximation(hw, rate, parent_rate, &m, &n);
+	else
+		clk_fd_general_approximation(hw, rate, parent_rate, &m, &n);
 
 	ret = (u64)*parent_rate * m;
 	do_div(ret, n);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index c59c62571e4f..1fc113fbf955 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -565,6 +565,9 @@ struct clk_fractional_divider {
 	u8		nwidth;
 	u32		nmask;
 	u8		flags;
+	void		(*approximation)(struct clk_hw *hw,
+				unsigned long rate, unsigned long *parent_rate,
+				unsigned long *m, unsigned long *n);
 	spinlock_t	*lock;
 };
 
-- 
2.11.0
