From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 24 Jan 2013 17:45:55 +0100
Subject: [PATCH 3/4] clk: Introduce optional unprepare_unused callback
In-Reply-To: <1359045956-30741-1-git-send-email-ulf.hansson@stericsson.com>
References: <1359045956-30741-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1359045956-30741-4-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

An unprepare_unused callback is introduced due to the same reasons to
why the disable_unused callback was added.

During the clk_disable_unused sequence, those clk_hw that needs specific
treatment with regards to being unprepared, shall implement the
unprepare_unused callback.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clk/clk.c            |    7 +++++--
 include/linux/clk-provider.h |    5 +++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 0944348..d8dc6d7c 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -358,9 +358,12 @@ static void clk_unprepare_unused_subtree(struct clk *clk)
 	if (clk->flags & CLK_IGNORE_UNUSED)
 		return;
 
-	if (__clk_is_prepared(clk))
-		if (clk->ops->unprepare)
+	if (__clk_is_prepared(clk)) {
+		if (clk->ops->unprepare_unused)
+			clk->ops->unprepare_unused(clk->hw);
+		else if (clk->ops->unprepare)
 			clk->ops->unprepare(clk->hw);
+	}
 }
 
 /* caller must hold prepare_lock */
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 86ff6be..9e97fb4 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -49,6 +49,10 @@ struct clk_hw;
  *		This function is allowed to sleep. Optional, if this op is not
  *		set then the prepare count will be used.
  *
+ * @unprepare_unused: Unprepare the clock atomically.  Only called from
+ *		clk_disable_unused for prepare clocks with special needs.
+ *		Called with prepare mutex held. This function may sleep.
+ *
  * @enable:	Enable the clock atomically. This must not return until the
  * 		clock is generating a valid clock signal, usable by consumer
  * 		devices. Called with enable_lock held. This function must not
@@ -113,6 +117,7 @@ struct clk_ops {
 	int		(*prepare)(struct clk_hw *hw);
 	void		(*unprepare)(struct clk_hw *hw);
 	int		(*is_prepared)(struct clk_hw *hw);
+	void		(*unprepare_unused)(struct clk_hw *hw);
 	int		(*enable)(struct clk_hw *hw);
 	void		(*disable)(struct clk_hw *hw);
 	int		(*is_enabled)(struct clk_hw *hw);
-- 
1.7.10
