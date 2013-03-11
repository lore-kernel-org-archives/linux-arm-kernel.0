From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 12 Mar 2013 00:43:24 +0100
Subject: [PATCH 1/4] clk: samsung: register clk_div_tables for divider clocks
In-Reply-To: <201303120042.09633.heiko@sntech.de>
References: <201303120042.09633.heiko@sntech.de>
Message-ID: <201303120043.24557.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some Samsung platforms divider clocks only use specific divider combinations
like the armdiv on s3c2443 and s3c2416. For these usecases the generic divider
clock already provides the option of providing a lookup table mapping register
values to divider values.

Therefore add a new field to samsung_div_clock and if filled with a table,
use clk_register_divider_table instead of clk_register_divider to register
a divider clock

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/samsung/clk.c |   14 +++++++++++---
 drivers/clk/samsung/clk.h |   13 +++++++++----
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 91d12f3..d36cdd5 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -183,9 +183,17 @@ void __init samsung_clk_register_div(struct samsung_div_clock *list,
 	unsigned int idx, ret;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
-		clk = clk_register_divider(NULL, list->name, list->parent_name,
-			list->flags, reg_base + list->offset, list->shift,
-			list->width, list->div_flags, &lock);
+		if (list->table)
+			clk = clk_register_divider_table(NULL, list->name,
+					list->parent_name, list->flags,
+					reg_base + list->offset, list->shift,
+					list->width, list->div_flags,
+					list->table, &lock);
+		else
+			clk = clk_register_divider(NULL, list->name,
+					list->parent_name, list->flags,
+					reg_base + list->offset, list->shift,
+					list->width, list->div_flags, &lock);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n", __func__,
 				list->name);
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 961192f..26a752b 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -150,9 +150,10 @@ struct samsung_div_clock {
 	u8			width;
 	u8			div_flags;
 	const char		*alias;
+	struct clk_div_table	*table;
 };
 
-#define __DIV(_id, dname, cname, pname, o, s, w, f, df, a)	\
+#define __DIV(_id, dname, cname, pname, o, s, w, f, df, a, t)	\
 	{							\
 		.id		= _id,				\
 		.dev_name	= dname,			\
@@ -164,16 +165,20 @@ struct samsung_div_clock {
 		.width		= w,				\
 		.div_flags	= df,				\
 		.alias		= a,				\
+		.table		= t,				\
 	}
 
 #define DIV(_id, cname, pname, o, s, w)				\
-	__DIV(_id, NULL, cname, pname, o, s, w, 0, 0, NULL)
+	__DIV(_id, NULL, cname, pname, o, s, w, 0, 0, NULL, NULL)
 
 #define DIV_A(_id, cname, pname, o, s, w, a)			\
-	__DIV(_id, NULL, cname, pname, o, s, w, 0, 0, a)
+	__DIV(_id, NULL, cname, pname, o, s, w, 0, 0, a, NULL)
 
 #define DIV_F(_id, cname, pname, o, s, w, f, df)		\
-	__DIV(_id, NULL, cname, pname, o, s, w, f, df, NULL)
+	__DIV(_id, NULL, cname, pname, o, s, w, f, df, NULL, NULL)
+
+#define DIV_T(_id, cname, pname, o, s, w, t)			\
+	__DIV(_id, NULL, cname, pname, o, s, w, 0, 0, NULL, t)
 
 /**
  * struct samsung_gate_clock: information about gate clock
-- 
1.7.2.3
