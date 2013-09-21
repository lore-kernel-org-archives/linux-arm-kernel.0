From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Fri, 20 Sep 2013 22:03:12 -0300
Subject: [PATCH 3/3] clk: sunxi: protect core clocks from accidental shutdown
In-Reply-To: <1379725392-30202-1-git-send-email-emilio@elopez.com.ar>
References: <1379725392-30202-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1379725392-30202-4-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some important clocks may get disabled as a side effect of another clock
being disabled, because they have no consumers. This patch implements a
mechanism so those clocks can be claimed by the driver and therefore
remain enabled at all times.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 drivers/clk/sunxi/clk-sunxi.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 34ee69f..83d3eac 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -617,6 +617,31 @@ static void __init of_sunxi_table_clock_setup(const struct of_device_id *clk_mat
 	}
 }
 
+/**
+ * System clock protection
+ *
+ * By enabling these critical clocks, we prevent their accidental gating
+ * by the framework
+ */
+static void __init sunxi_clock_protect(void)
+{
+	struct clk *clk;
+
+	/* memory bus clock - sun5i+ */
+	clk = clk_get(NULL, "mbus");
+	if (!IS_ERR(clk)) {
+		clk_prepare_enable(clk);
+		clk_put(clk);
+	}
+
+	/* DDR clock - sun4i+ */
+	clk = clk_get(NULL, "pll5_ddr");
+	if (!IS_ERR(clk)) {
+		clk_prepare_enable(clk);
+		clk_put(clk);
+	}
+}
+
 void __init sunxi_init_clocks(void)
 {
 	/* Register all the simple and basic clocks on DT */
@@ -633,4 +658,7 @@ void __init sunxi_init_clocks(void)
 
 	/* Register gate clocks */
 	of_sunxi_table_clock_setup(clk_gates_match, sunxi_gates_clk_setup);
+
+	/* Enable core system clocks */
+	sunxi_clock_protect();
 }
-- 
1.8.4
