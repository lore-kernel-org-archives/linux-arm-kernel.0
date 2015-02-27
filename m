From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 27 Feb 2015 21:14:33 +0000
Subject: [PATCH 3/4] clk: Provide always-on clock support
In-Reply-To: <1425071674-16995-1-git-send-email-lee.jones@linaro.org>
References: <1425071674-16995-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1425071674-16995-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lots of platforms contain clocks which if turned off would prove fatal.
The only way to recover from these catastrophic failures is to restart
the board(s).  Now, when a clock is registered with the framework it is
compared against a list of provided always-on clock names which must be
kept ungated.  If it matches, we enable the existing CLK_IGNORE_UNUSED
flag, which will prevent the common clk framework from attempting to
gate it during the clk_disable_unused() procedure.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/clk.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 61c3fc5..3aab75e 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2856,6 +2856,9 @@ int of_clk_add_provider(struct device_node *np,
 			void *data)
 {
 	struct of_clk_provider *cp;
+	struct property *prop;
+	struct clk *clk;
+	const char *clkname;
 	int ret;
 
 	cp = kzalloc(sizeof(struct of_clk_provider), GFP_KERNEL);
@@ -2875,6 +2878,14 @@ int of_clk_add_provider(struct device_node *np,
 	if (ret < 0)
 		of_clk_del_provider(np);
 
+	of_property_for_each_string(np, "clock-always-on", prop, clkname) {
+		clk = __clk_lookup(clkname);
+		if (!clk)
+			continue;
+
+		clk->core->flags |= CLK_IGNORE_UNUSED;
+	}
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(of_clk_add_provider);
-- 
1.9.1
