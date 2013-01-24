From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 24 Jan 2013 17:45:53 +0100
Subject: [PATCH 1/4] clk: Introduce optional is_prepared callback
In-Reply-To: <1359045956-30741-1-git-send-email-ulf.hansson@stericsson.com>
References: <1359045956-30741-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1359045956-30741-2-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

To reflect whether a clk_hw is prepared the clk_hw may implement
the optional is_prepared callback. If not implemented we fall back
to use the software prepare counter.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clk/clk.c            |   21 +++++++++++++++++++++
 include/linux/clk-provider.h |    6 ++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 593a2e4..deb259a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -458,6 +458,27 @@ unsigned long __clk_get_flags(struct clk *clk)
 	return !clk ? 0 : clk->flags;
 }
 
+bool __clk_is_prepared(struct clk *clk)
+{
+	int ret;
+
+	if (!clk)
+		return false;
+
+	/*
+	 * .is_prepared is optional for clocks that can prepare
+	 * fall back to software usage counter if it is missing
+	 */
+	if (!clk->ops->is_prepared) {
+		ret = clk->prepare_count ? 1 : 0;
+		goto out;
+	}
+
+	ret = clk->ops->is_prepared(clk->hw);
+out:
+	return !!ret;
+}
+
 bool __clk_is_enabled(struct clk *clk)
 {
 	int ret;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 4989b8a..86ff6be 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -45,6 +45,10 @@ struct clk_hw;
  * 		undo any work done in the @prepare callback. Called with
  * 		prepare_lock held.
  *
+ * @is_prepared: Queries the hardware to determine if the clock is prepared.
+ *		This function is allowed to sleep. Optional, if this op is not
+ *		set then the prepare count will be used.
+ *
  * @enable:	Enable the clock atomically. This must not return until the
  * 		clock is generating a valid clock signal, usable by consumer
  * 		devices. Called with enable_lock held. This function must not
@@ -108,6 +112,7 @@ struct clk_hw;
 struct clk_ops {
 	int		(*prepare)(struct clk_hw *hw);
 	void		(*unprepare)(struct clk_hw *hw);
+	int		(*is_prepared)(struct clk_hw *hw);
 	int		(*enable)(struct clk_hw *hw);
 	void		(*disable)(struct clk_hw *hw);
 	int		(*is_enabled)(struct clk_hw *hw);
@@ -351,6 +356,7 @@ unsigned int __clk_get_enable_count(struct clk *clk);
 unsigned int __clk_get_prepare_count(struct clk *clk);
 unsigned long __clk_get_rate(struct clk *clk);
 unsigned long __clk_get_flags(struct clk *clk);
+bool __clk_is_prepared(struct clk *clk);
 bool __clk_is_enabled(struct clk *clk);
 struct clk *__clk_lookup(const char *name);
 
-- 
1.7.10
