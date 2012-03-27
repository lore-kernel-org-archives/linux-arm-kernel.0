From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 27 Mar 2012 15:23:29 +0800
Subject: [PATCH 10/10] clk: copy parent_names in clk-mux registration
In-Reply-To: <1332833009-4121-1-git-send-email-shawn.guo@linaro.org>
References: <1332833009-4121-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1332833009-4121-11-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like what all other basic clks do, copy parent_names in clk-mux
registration, so that clock driver can mark the parent_names
__initconst.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/clk-mux.c |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 1ff90a6..353fcb7 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -94,6 +94,9 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
 		u8 clk_mux_flags, spinlock_t *lock)
 {
 	struct clk_mux *mux;
+	struct clk *clk;
+	const char **parents = NULL;
+	int i = 0;
 
 	mux = kzalloc(sizeof(struct clk_mux), GFP_KERNEL);
 
@@ -109,6 +112,28 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
 	mux->flags = clk_mux_flags;
 	mux->lock = lock;
 
-	return clk_register(dev, name, &clk_mux_ops, &mux->hw,
-			parent_names, num_parents, flags);
+	if (num_parents) {
+		parents = kzalloc(sizeof(char *) * num_parents, GFP_KERNEL);
+		if (!parents)
+			goto out;
+
+		for (i = 0; i < num_parents; i++) {
+			parents[i] = kstrdup(parent_names[i], GFP_KERNEL);
+			if (!parents[i])
+				goto out;
+		}
+	}
+
+	clk =  clk_register(dev, name, &clk_mux_ops, &mux->hw,
+			parents, num_parents, flags);
+	if (clk)
+		return clk;
+
+out:
+	for (i--; i >= 0; i--)
+		kfree(parents[i]);
+	kfree(parents);
+	kfree(mux);
+
+	return NULL;
 }
-- 
1.7.5.4
