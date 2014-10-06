From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue,  7 Oct 2014 01:07:59 +0200
Subject: [PATCH v1 3/5] clk: pxa: keep clocks initialization separated per
 variant
In-Reply-To: <1412636881-6211-1-git-send-email-robert.jarzmik@free.fr>
References: <1412636881-6211-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1412636881-6211-4-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Have each pxa variant (pxa25x, pxa27x, pxa3xx) have its own device-tree
clock initializing function, to be able to register its own specific
core clocks.

Apply that change specifically to pxa27x.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/clk/pxa/clk-pxa.c    | 3 +--
 drivers/clk/pxa/clk-pxa.h    | 1 +
 drivers/clk/pxa/clk-pxa27x.c | 7 +++++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/pxa/clk-pxa.c b/drivers/clk/pxa/clk-pxa.c
index 994fd6f..4e83475 100644
--- a/drivers/clk/pxa/clk-pxa.c
+++ b/drivers/clk/pxa/clk-pxa.c
@@ -102,8 +102,7 @@ int __init clk_pxa_cken_init(const struct desc_clk_cken *clks, int nb_clks)
 	return 0;
 }
 
-static void __init pxa_dt_clocks_init(struct device_node *np)
+void __init clk_pxa_dt_common_init(struct device_node *np)
 {
 	of_clk_add_provider(np, of_clk_src_onecell_get, &onecell_data);
 }
-CLK_OF_DECLARE(pxa_clks, "marvell,pxa-clocks", pxa_dt_clocks_init);
diff --git a/drivers/clk/pxa/clk-pxa.h b/drivers/clk/pxa/clk-pxa.h
index 7b8d48e..3239654 100644
--- a/drivers/clk/pxa/clk-pxa.h
+++ b/drivers/clk/pxa/clk-pxa.h
@@ -103,5 +103,6 @@ static int dummy_clk_set_parent(struct clk_hw *hw, u8 index)
 extern void clkdev_pxa_register(int ckid, const char *con_id,
 				const char *dev_id, struct clk *clk);
 extern int clk_pxa_cken_init(const struct desc_clk_cken *clks, int nb_clks);
+void clk_pxa_dt_common_init(struct device_node *np);
 
 #endif
diff --git a/drivers/clk/pxa/clk-pxa27x.c b/drivers/clk/pxa/clk-pxa27x.c
index 32d3e02..5f9b54b 100644
--- a/drivers/clk/pxa/clk-pxa27x.c
+++ b/drivers/clk/pxa/clk-pxa27x.c
@@ -368,3 +368,10 @@ static int __init pxa27x_clocks_init(void)
 	return clk_pxa_cken_init(pxa27x_clocks, ARRAY_SIZE(pxa27x_clocks));
 }
 postcore_initcall(pxa27x_clocks_init);
+
+static void __init pxa27x_dt_clocks_init(struct device_node *np)
+{
+	pxa27x_clocks_init();
+	clk_pxa_dt_common_init(np);
+}
+CLK_OF_DECLARE(pxa_clks, "marvell,pxa270-clocks", pxa27x_dt_clocks_init);
-- 
2.1.0
