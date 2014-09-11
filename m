From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 11 Sep 2014 16:26:23 +0200
Subject: [PATCH v11 9/9] clk: Add docs about calling clk_put after
 clk_get_parent
In-Reply-To: <1410445583-18626-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1410445421-18362-1-git-send-email-tomeu.vizoso@collabora.com>
 <1410445583-18626-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1410445583-18626-7-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As otherwise the per-user clk will be leaked.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/clk/clk.c   | 3 ++-
 include/linux/clk.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 1ad8cb7..8ac8543 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1784,7 +1784,8 @@ EXPORT_SYMBOL_GPL(clk_provider_get_parent);
  * clk_get_parent - return the parent of a clk
  * @clk_user: the clk whose parent gets returned
  *
- * Simply returns clk->parent.  Returns NULL if clk is NULL.
+ * Simply returns clk->parent.  Returns NULL if clk is NULL. Caller must call
+ * clk_put() to release the returned struct clk.
  */
 struct clk *clk_get_parent(struct clk *clk_user)
 {
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 066b100..4f54952 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -306,7 +306,8 @@ int clk_set_parent(struct clk *clk, struct clk *parent);
  * @clk: clock source
  *
  * Returns struct clk corresponding to parent clock source, or
- * valid IS_ERR() condition containing errno.
+ * valid IS_ERR() condition containing errno. Caller must call
+ * clk_put() to release the returned struct clk.
  */
 struct clk *clk_get_parent(struct clk *clk);
 
-- 
1.9.3
