From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Thu, 14 May 2015 21:29:00 +0800
Subject: [PATCH v2 2/5] clk: introduce clk_core_enable_lock and
 clk_core_disable_lock functions
In-Reply-To: <1431610143-21853-1-git-send-email-aisheng.dong@freescale.com>
References: <1431610143-21853-1-git-send-email-aisheng.dong@freescale.com>
Message-ID: <1431610143-21853-3-git-send-email-aisheng.dong@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This can be useful when clock core wants to enable/disable clocks.
Then we don't have to convert the struct clk_core to struct clk to call
clk_enable/clk_disable which is a bit un-align with exist using.

And after introduce clk_core_{enable|disable}_lock, we can refine
clk_eanble and clk_disable a bit.

As well as clk_core_{enable|disable}_lock, we also added
clk_core_{prepare|unprepare}_lock and clk_core_prepare_enable/
clk_core_unprepare_disable for clock core to easily use.

Cc: Mike Turquette <mturquette@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 drivers/clk/clk.c | 85 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 63 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 0e813ea..2f44c8c 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -565,6 +565,13 @@ static void clk_core_unprepare(struct clk_core *core)
 	clk_core_unprepare(core->parent);
 }
 
+static void clk_core_unprepare_lock(struct clk_core *core)
+{
+	clk_prepare_lock();
+	clk_core_unprepare(core);
+	clk_prepare_unlock();
+}
+
 /**
  * clk_unprepare - undo preparation of a clock source
  * @clk: the clk being unprepared
@@ -581,9 +588,7 @@ void clk_unprepare(struct clk *clk)
 	if (IS_ERR_OR_NULL(clk))
 		return;
 
-	clk_prepare_lock();
-	clk_core_unprepare(clk->core);
-	clk_prepare_unlock();
+	clk_core_unprepare_lock(clk->core);
 }
 EXPORT_SYMBOL_GPL(clk_unprepare);
 
@@ -619,6 +624,17 @@ static int clk_core_prepare(struct clk_core *core)
 	return 0;
 }
 
+static int clk_core_prepare_lock(struct clk_core *core)
+{
+	int ret;
+
+	clk_prepare_lock();
+	ret = clk_core_prepare(core);
+	clk_prepare_unlock();
+
+	return ret;
+}
+
 /**
  * clk_prepare - prepare a clock source
  * @clk: the clk being prepared
@@ -633,16 +649,10 @@ static int clk_core_prepare(struct clk_core *core)
  */
 int clk_prepare(struct clk *clk)
 {
-	int ret;
-
 	if (!clk)
 		return 0;
 
-	clk_prepare_lock();
-	ret = clk_core_prepare(clk->core);
-	clk_prepare_unlock();
-
-	return ret;
+	return clk_core_prepare_lock(clk->core);
 }
 EXPORT_SYMBOL_GPL(clk_prepare);
 
@@ -669,6 +679,15 @@ static void clk_core_disable(struct clk_core *core)
 	clk_core_disable(core->parent);
 }
 
+static void clk_core_disable_lock(struct clk_core *core)
+{
+	unsigned long flags;
+
+	flags = clk_enable_lock();
+	clk_core_disable(core);
+	clk_enable_unlock(flags);
+}
+
 /**
  * clk_disable - gate a clock
  * @clk: the clk being gated
@@ -683,14 +702,10 @@ static void clk_core_disable(struct clk_core *core)
  */
 void clk_disable(struct clk *clk)
 {
-	unsigned long flags;
-
 	if (IS_ERR_OR_NULL(clk))
 		return;
 
-	flags = clk_enable_lock();
-	clk_core_disable(clk->core);
-	clk_enable_unlock(flags);
+	clk_core_disable_lock(clk->core);
 }
 EXPORT_SYMBOL_GPL(clk_disable);
 
@@ -729,6 +744,18 @@ static int clk_core_enable(struct clk_core *core)
 	return 0;
 }
 
+static int clk_core_enable_lock(struct clk_core *core)
+{
+	unsigned long flags;
+	int ret;
+
+	flags = clk_enable_lock();
+	ret = clk_core_enable(core);
+	clk_enable_unlock(flags);
+
+	return ret;
+}
+
 /**
  * clk_enable - ungate a clock
  * @clk: the clk being ungated
@@ -744,19 +771,33 @@ static int clk_core_enable(struct clk_core *core)
  */
 int clk_enable(struct clk *clk)
 {
-	unsigned long flags;
-	int ret;
-
 	if (!clk)
 		return 0;
 
-	flags = clk_enable_lock();
-	ret = clk_core_enable(clk->core);
-	clk_enable_unlock(flags);
+	return clk_core_enable_lock(clk->core);
+}
+EXPORT_SYMBOL_GPL(clk_enable);
+
+static int clk_core_prepare_enable(struct clk_core *core)
+{
+	int ret;
+
+	ret = clk_core_prepare_lock(core);
+	if (ret)
+		return ret;
+
+	ret = clk_core_enable_lock(core);
+	if (ret)
+		clk_core_unprepare_lock(core);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(clk_enable);
+
+static void clk_core_disable_unprepare(struct clk_core *core)
+{
+	clk_core_disable_lock(core);
+	clk_core_unprepare_lock(core);
+}
 
 static unsigned long clk_core_round_rate_nolock(struct clk_core *core,
 						unsigned long rate,
-- 
1.9.1
