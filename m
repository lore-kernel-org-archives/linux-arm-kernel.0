From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 10 Apr 2012 09:24:47 +0530
Subject: [PATCH] clk: Fix error handling paths of all basic clock register()
 routines
Message-ID: <c65c7006185c193706b401b874b59e3769f593b0.1334029502.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes following in error handling paths of register() routines of all basic
clock types:
- Free memory for clock type, allocated with kmalloc or kzalloc if
  clk_register() fails.
- No, need to free memory for clock type, if allocation fails for it.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/clk/clk-divider.c      |    2 +-
 drivers/clk/clk-fixed-factor.c |    2 +-
 drivers/clk/clk-fixed-rate.c   |   25 ++++++++++++++++++++-----
 drivers/clk/clk-gate.c         |    2 +-
 drivers/clk/clk-mux.c          |    8 +++++++-
 5 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index d5ac6a7..68158ce 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -192,8 +192,8 @@ struct clk *clk_register_divider(struct device *dev, const char *name,
 	if (clk)
 		return clk;
 
-out:
 	kfree(div->parent[0]);
+out:
 	kfree(div);
 
 	return NULL;
diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index 7c5e1fc..879b6cc 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -89,8 +89,8 @@ struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
 	if (clk)
 		return clk;
 
-out:
 	kfree(fix->parent[0]);
+out:
 	kfree(fix);
 
 	return NULL;
diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index 90c79fb..4245aa1 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -45,6 +45,7 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 {
 	struct clk_fixed_rate *fixed;
 	char **parent_names = NULL;
+	struct clk *clk;
 	u8 len;
 
 	fixed = kzalloc(sizeof(struct clk_fixed_rate), GFP_KERNEL);
@@ -61,22 +62,36 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 		parent_names = kmalloc(sizeof(char *), GFP_KERNEL);
 
 		if (! parent_names)
-			goto out;
+			goto out_register;
 
 		len = sizeof(char) * strlen(parent_name);
 
 		parent_names[0] = kmalloc(len, GFP_KERNEL);
 
-		if (!parent_names[0])
-			goto out;
+		if (!parent_names[0]) {
+			kfree(parent_names);
+			parent_names = NULL;
+			goto out_register;
+		}
 
 		strncpy(parent_names[0], parent_name, len);
 	}
 
-out:
-	return clk_register(dev, name,
+out_register:
+	clk = clk_register(dev, name,
 			&clk_fixed_rate_ops, &fixed->hw,
 			parent_names,
 			(parent_name ? 1 : 0),
 			flags);
+	if (clk)
+		return clk;
+
+	if (parent_names) {
+		kfree(parent_names[0]);
+		kfree(parent_names);
+	}
+
+	kfree(fixed);
+
+	return NULL;
 }
diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index b35eef9..7b2c473 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -138,8 +138,8 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
 			flags);
 	if (clk)
 		return clk;
-out:
 	kfree(gate->parent[0]);
+out:
 	kfree(gate);
 
 	return NULL;
diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index c71ad1f..38816bf 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -96,6 +96,7 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
 		u8 clk_mux_flags, spinlock_t *lock)
 {
 	struct clk_mux *mux;
+	struct clk *clk;
 
 	mux = kmalloc(sizeof(struct clk_mux), GFP_KERNEL);
 
@@ -111,6 +112,11 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
 	mux->flags = clk_mux_flags;
 	mux->lock = lock;
 
-	return clk_register(dev, name, &clk_mux_ops, &mux->hw,
+	clk = clk_register(dev, name, &clk_mux_ops, &mux->hw,
 			parent_names, num_parents, flags);
+	if (clk)
+		return clk;
+
+	kfree(mux);
+	return NULL;
 }
-- 
1.7.9
