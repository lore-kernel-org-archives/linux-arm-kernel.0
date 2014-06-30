From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon, 30 Jun 2014 09:56:33 -0700
Subject: [PATCH 1/4] clk: Introduce 'clk_find_nearest_rate()'
In-Reply-To: <1404147396-8041-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1404147396-8041-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1404147396-8041-2-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a new API function to find the rate a clock can provide which
is closest to a given rate.

clk_round_rate() leaves it to the clock driver how rounding is done.
Commonly implementations round down due to use-cases that have a certain
frequency maximum that must not be exceeded.

The new API call enables use-cases where accuracy is preferred. E.g.
Ethernet clocks.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---

 drivers/clk/clk.c   | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk.h |  9 +++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 8b73edef151d..fce1165cd879 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1030,6 +1030,63 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
 EXPORT_SYMBOL_GPL(clk_round_rate);
 
 /**
+ * clk_find_nearest_rate - round the given rate for a clk
+ * @clk: the clk for which we are rounding a rate
+ * @rate: the rate which is to be rounded
+ *
+ * Takes in a rate as input and finds the closest rate that the clk
+ * can actually use which is then returned.
+ * Note: This function relies on the clock's clk_round_rate() implementation.
+ * For cases clk_round_rate() rounds up, not the closest but the rounded up
+ * rate is found.
+ */
+long clk_find_nearest_rate(struct clk *clk, unsigned long rate)
+{
+	long ret, lower, upper;
+	unsigned long tmp;
+
+	clk_prepare_lock();
+
+	lower = __clk_round_rate(clk, rate);
+	if (lower >= rate || lower < 0) {
+		ret = lower;
+		goto unlock;
+	}
+
+	tmp = rate + (rate - lower) - 1;
+	if (tmp > LONG_MAX)
+		upper = LONG_MAX;
+	else
+		upper = tmp;
+
+	upper = __clk_round_rate(clk, upper);
+	if (upper <= lower || upper < 0) {
+		ret = lower;
+		goto unlock;
+	}
+
+	lower = rate + 1;
+	while (lower < upper) {
+		long rounded, mid;
+
+		mid = lower + ((upper - lower) >> 1);
+		rounded = __clk_round_rate(clk, mid);
+		if (rounded < lower)
+			lower = mid + 1;
+		else
+			upper = rounded;
+	}
+
+	ret = upper;
+
+unlock:
+	clk_prepare_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(clk_find_nearest_rate);
+
+/**
  * __clk_notify - call clk notifier chain
  * @clk: struct clk * that is changing rate
  * @msg: clk notifier type (see include/linux/clk.h)
diff --git a/include/linux/clk.h b/include/linux/clk.h
index fb5e097d8f72..f8b53c515483 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -264,6 +264,15 @@ void devm_clk_put(struct device *dev, struct clk *clk);
 long clk_round_rate(struct clk *clk, unsigned long rate);
 
 /**
+ * clk_find_nearest_rate - Find nearest rate to the exact rate a clock can provide
+ * @clk: the clk for which we are rounding a rate
+ * @rate: the rate which is to be rounded
+ *
+ * Returns the rate closest to @rate the clock can provide.
+ */
+long clk_find_nearest_rate(struct clk *clk, unsigned long rate);
+
+/**
  * clk_set_rate - set the clock rate for a clock source
  * @clk: clock source
  * @rate: desired clock rate in Hz
-- 
2.0.1.1.gfbfc394
