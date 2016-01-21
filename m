From: emilio.lopez@collabora.co.uk (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Thu, 21 Jan 2016 11:10:38 -0300
Subject: [PATCH 1/2] clk: sunxi: delay protected clocks until arch initcall
In-Reply-To: <1453385439-10154-1-git-send-email-emilio.lopez@collabora.co.uk>
References: <1453385439-10154-1-git-send-email-emilio.lopez@collabora.co.uk>
Message-ID: <1453385439-10154-2-git-send-email-emilio.lopez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clocks are registered early on, and unused clocks get disabled on
late initcall, so we can delay protecting important clocks a bit.
If we do this too early, it may happen that some clocks are orphans
and therefore enabling them may not work as intended. If we do this
too late, a driver may reparent some clock and cause another important
clock to be disabled as a byproduct.

arch_initcall should be a good spot to do this, as clock drivers using
the OF mechanisms will be all registered by then, and drivers won't
have started probing yet.

Signed-off-by: Emilio L?pez <emilio.lopez@collabora.co.uk>
---
 drivers/clk/sunxi/clk-sunxi.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 5ba2188..285e8ee 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1153,10 +1153,12 @@ static void __init of_sunxi_table_clock_setup(const struct of_device_id *clk_mat
 	}
 }
 
+/* By default, don't protect any clocks */
+static const char **protected_clocks __initdata;
+static int protected_clocks_nr __initdata;
+
 static void __init sunxi_init_clocks(const char *clocks[], int nclocks)
 {
-	unsigned int i;
-
 	/* Register divided output clocks */
 	of_sunxi_table_clock_setup(clk_divs_match, sunxi_divs_clk_setup);
 
@@ -1169,14 +1171,26 @@ static void __init sunxi_init_clocks(const char *clocks[], int nclocks)
 	/* Register mux clocks */
 	of_sunxi_table_clock_setup(clk_mux_match, sunxi_mux_clk_setup);
 
+	/* We shall protect these clocks when everything is ready */
+	protected_clocks = clocks;
+	protected_clocks_nr = nclocks;
+}
+
+static int __init sunxi_init_clock_protection(void)
+{
+	unsigned int i;
+
 	/* Protect the clocks that needs to stay on */
-	for (i = 0; i < nclocks; i++) {
-		struct clk *clk = clk_get(NULL, clocks[i]);
+	for (i = 0; i < protected_clocks_nr; i++) {
+		struct clk *clk = clk_get(NULL, protected_clocks[i]);
 
 		if (!IS_ERR(clk))
 			clk_prepare_enable(clk);
 	}
+
+	return 0;
 }
+arch_initcall(sunxi_init_clock_protection);
 
 static const char *sun4i_a10_critical_clocks[] __initdata = {
 	"pll5_ddr",
-- 
2.7.0
