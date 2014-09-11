From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 11 Sep 2014 16:26:20 +0200
Subject: [PATCH v11 6/9] clk: Warn of unbalanced clk_prepare() calls
In-Reply-To: <1410445583-18626-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1410445421-18362-1-git-send-email-tomeu.vizoso@collabora.com>
 <1410445583-18626-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1410445583-18626-4-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The warning will display the clock user that is trying to unprepare the clock,
and the location of the last unprepare call.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

---

v8: * Patch added
---
 drivers/clk/clk.c           | 22 ++++++++++++++++++++--
 include/linux/clk-private.h |  3 +++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 3a961c6..3018f37 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -834,7 +834,17 @@ void clk_unprepare(struct clk *clk_user)
 	if (IS_ERR_OR_NULL(clk_user))
 		return;
 
-	clk_provider_unprepare(clk_to_clk_core(clk_user));
+	clk_prepare_lock();
+	if (!WARN(clk_user->prepare_count == 0,
+		  "incorrect unprepare clk dev %s con %s last caller of unprepare %pF\n",
+		  clk_user->dev_id, clk_user->con_id, clk_user->last_unprepare)) {
+
+		clk_user->last_unprepare = __builtin_return_address(0);
+		clk_user->prepare_count--;
+
+		__clk_unprepare(clk_to_clk_core(clk_user));
+	}
+	clk_prepare_unlock();
 }
 EXPORT_SYMBOL_GPL(clk_unprepare);
 
@@ -890,10 +900,18 @@ EXPORT_SYMBOL_GPL(clk_provider_prepare);
  */
 int clk_prepare(struct clk *clk_user)
 {
+	int ret;
+
 	if (!clk_user)
 		return 0;
 
-	return clk_provider_prepare(clk_to_clk_core(clk_user));
+	clk_prepare_lock();
+	ret = __clk_prepare(clk_to_clk_core(clk_user));
+	if (!ret)
+		clk_user->prepare_count++;
+	clk_prepare_unlock();
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(clk_prepare);
 
diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
index 8126046..cf93bde 100644
--- a/include/linux/clk-private.h
+++ b/include/linux/clk-private.h
@@ -64,6 +64,9 @@ struct clk {
 	unsigned int	enable_count;
 	void		*last_disable;
 
+	unsigned int	prepare_count;
+	void		*last_unprepare;
+
 	unsigned long	floor_constraint;
 	unsigned long	ceiling_constraint;
 	struct hlist_node child_node;
-- 
1.9.3
