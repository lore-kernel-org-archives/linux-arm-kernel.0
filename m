From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 21 Jun 2013 15:07:35 +0200
Subject: [PATCH] clk: Handle CLK_GET_RATE_NOCACHE flag in clk_set_rate()
Message-ID: <1371820055-14147-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a clock has CLK_GET_RATE_NOCACHE flag set the rate needs to
be recalculated, rather than referencing the cached value.

Currently cached clk->rate is compared with new value to see if
anything needs to be done in clk_set_rate(). This may cause required
clock controller registers update to not happen when same clock
frequency value is being set subsequently.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/clk.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 1144e8c..ffa304e 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1215,6 +1215,9 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	/* prevent racing with updates to the clock topology */
 	clk_prepare_lock();

+	if (clk->flags & CLK_GET_RATE_NOCACHE)
+		__clk_recalc_rates(clk, 0);
+
 	/* bail early if nothing to do */
 	if (rate == clk->rate)
 		goto out;
--
1.7.9.5
