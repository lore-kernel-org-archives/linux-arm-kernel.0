From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue,  7 Oct 2014 01:08:01 +0200
Subject: [PATCH v1 5/5] DON'T MERGE ME: clk: pxa: migrate to the clk_core API
In-Reply-To: <1412636881-6211-1-git-send-email-robert.jarzmik@free.fr>
References: <1412636881-6211-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1412636881-6211-6-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the clock framework split structure clk and clk_core, amend the
pxa clock providers for the new API.

This patch was tested on a pxa270 on top of Tomeu's patches v9.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/clk/pxa/clk-pxa.c | 6 +++---
 drivers/clk/pxa/clk-pxa.h | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/pxa/clk-pxa.c b/drivers/clk/pxa/clk-pxa.c
index 4e83475..8cc29a9 100644
--- a/drivers/clk/pxa/clk-pxa.c
+++ b/drivers/clk/pxa/clk-pxa.c
@@ -20,7 +20,7 @@
 
 DEFINE_SPINLOCK(lock);
 
-static struct clk *pxa_clocks[CLK_MAX];
+static struct clk_core *pxa_clocks[CLK_MAX];
 static struct clk_onecell_data onecell_data = {
 	.clks = pxa_clocks,
 	.clk_num = CLK_MAX,
@@ -69,7 +69,7 @@ static struct clk_ops cken_mux_ops = {
 };
 
 void __init clkdev_pxa_register(int ckid, const char *con_id,
-				const char *dev_id, struct clk *clk)
+				const char *dev_id, struct clk_core *clk)
 {
 	if (!IS_ERR(clk) && (ckid != CLK_NONE))
 		pxa_clocks[ckid] = clk;
@@ -81,7 +81,7 @@ int __init clk_pxa_cken_init(const struct desc_clk_cken *clks, int nb_clks)
 {
 	int i;
 	struct pxa_clk *pxa_clk;
-	struct clk *clk;
+	struct clk_core *clk;
 
 	for (i = 0; i < nb_clks; i++) {
 		pxa_clk = kzalloc(sizeof(*pxa_clk), GFP_KERNEL);
diff --git a/drivers/clk/pxa/clk-pxa.h b/drivers/clk/pxa/clk-pxa.h
index 3239654..e2dd28d 100644
--- a/drivers/clk/pxa/clk-pxa.h
+++ b/drivers/clk/pxa/clk-pxa.h
@@ -25,7 +25,7 @@
 	static struct clk_ops name ## _rate_ops = {		\
 		.recalc_rate = name ## _get_rate,		\
 	};							\
-	static struct clk * __init clk_register_ ## name(void)	\
+	static struct clk_core * __init clk_register_ ## name(void)	\
 	{							\
 		return clk_register_composite(NULL, clk_name,	\
 			name ## _parents,			\
@@ -40,7 +40,7 @@
 	static struct clk_ops name ## _rate_ops = {		\
 		.recalc_rate = name ## _get_rate,		\
 	};							\
-	static struct clk * __init clk_register_ ## name(void)	\
+	static struct clk_core * __init clk_register_ ## name(void)	\
 	{							\
 		return clk_register_composite(NULL, clk_name,	\
 			name ## _parents,			\
@@ -101,8 +101,8 @@ static int dummy_clk_set_parent(struct clk_hw *hw, u8 index)
 }
 
 extern void clkdev_pxa_register(int ckid, const char *con_id,
-				const char *dev_id, struct clk *clk);
-extern int clk_pxa_cken_init(const struct desc_clk_cken *clks, int nb_clks);
+				const char *dev_id, struct clk_core *clk);
+extern int clk_pxa_cken_init(struct desc_clk_cken *clks, int nb_clks);
 void clk_pxa_dt_common_init(struct device_node *np);
 
 #endif
-- 
2.1.0
