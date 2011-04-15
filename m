From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 15 Apr 2011 21:08:09 +0200
Subject: [PATCH 04/10] clk: implement parent pass through functions
In-Reply-To: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1302894495-6879-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A common case for clocks is that certain operations are not implemented
and shall be passed through to the parent. Add convenience functions
for this purpose

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
---
 drivers/clk/clk.c   |   77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk.h |    9 ++++++
 2 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 264c809..7e2c182 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -171,3 +171,80 @@ struct clk_ops clk_fixed_ops = {
 	.get_rate = clk_fixed_get_rate,
 };
 EXPORT_SYMBOL_GPL(clk_fixed_ops);
+
+int clk_parent_prepare(struct clk *clk)
+{
+	struct clk *parent = clk_get_parent(clk);
+
+	if (IS_ERR(parent))
+		return -ENOSYS;
+
+	return clk_prepare(parent);
+}
+EXPORT_SYMBOL_GPL(clk_parent_prepare);
+
+void clk_parent_unprepare(struct clk *clk)
+{
+	struct clk *parent = clk_get_parent(clk);
+
+	if (IS_ERR(parent))
+		return;
+
+	clk_unprepare(parent);
+}
+EXPORT_SYMBOL_GPL(clk_parent_unprepare);
+
+int clk_parent_enable(struct clk *clk)
+{
+	struct clk *parent = clk_get_parent(clk);
+
+	if (IS_ERR(parent))
+		return 0;
+
+	return clk_enable(parent);
+}
+EXPORT_SYMBOL_GPL(clk_parent_enable);
+
+void clk_parent_disable(struct clk *clk)
+{
+	struct clk *parent = clk_get_parent(clk);
+
+	if (IS_ERR(parent))
+		return;
+
+	clk_disable(parent);
+}
+EXPORT_SYMBOL_GPL(clk_parent_disable);
+
+unsigned long clk_parent_get_rate(struct clk *clk)
+{
+	struct clk *parent = clk_get_parent(clk);
+
+	if (IS_ERR(parent))
+		return 0;
+
+	return clk_get_rate(parent);
+}
+EXPORT_SYMBOL_GPL(clk_parent_get_rate);
+
+long clk_parent_round_rate(struct clk *clk, unsigned long rate)
+{
+	struct clk *parent = clk_get_parent(clk);
+
+	if (IS_ERR(parent))
+		return -ENOSYS;
+
+	return clk_round_rate(parent, rate);
+}
+EXPORT_SYMBOL_GPL(clk_parent_round_rate);
+
+int clk_parent_set_rate(struct clk *clk, unsigned long rate)
+{
+	struct clk *parent = clk_get_parent(clk);
+
+	if (IS_ERR(parent))
+		return -ENOSYS;
+
+	return clk_set_rate(parent, rate);
+}
+EXPORT_SYMBOL_GPL(clk_parent_set_rate);
diff --git a/include/linux/clk.h b/include/linux/clk.h
index d2f0db0..d014341 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -171,6 +171,15 @@ extern struct clk_ops clk_fixed_ops;
 #define DEFINE_CLK_FIXED(name, r) \
 	struct clk_fixed name = INIT_CLK_FIXED(name, r)
 
+/* generic pass-through-to-parent functions */
+int clk_parent_prepare(struct clk *clk);
+void clk_parent_unprepare(struct clk *clk);
+int clk_parent_enable(struct clk *clk);
+void clk_parent_disable(struct clk *clk);
+unsigned long clk_parent_get_rate(struct clk *clk);
+long clk_parent_round_rate(struct clk *clk, unsigned long rate);
+int clk_parent_set_rate(struct clk *clk, unsigned long rate);
+
 #else /* !CONFIG_USE_COMMON_STRUCT_CLK */
 
 /*
-- 
1.7.4.1
