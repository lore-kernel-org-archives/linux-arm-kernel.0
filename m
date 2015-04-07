From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  7 Apr 2015 19:43:58 +0100
Subject: [PATCH v6 3/4] clk: Provide always-on clock support
In-Reply-To: <1428432239-4114-1-git-send-email-lee.jones@linaro.org>
References: <1428432239-4114-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1428432239-4114-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lots of platforms contain clocks which if turned off would prove fatal.
The only way to recover from these catastrophic failures is to restart
the board(s).  Now, when a clock provider is registered with the
framework it is possible for a list of always-on clocks to be supplied
which must be kept ungated.  Each clock mentioned in the newly
introduced 'clock-always-on' will be clk_prepare_enable()d where the
normal references will be taken.  This will prevent the common clk
framework from attempting to gate them during the clk_disable_unused()
and disable_clock() procedures.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/clk-conf.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index aad4796..a07aced 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -116,6 +116,43 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
 	return 0;
 }
 
+static int __set_clk_always_on(struct device_node *node, bool clk_supplier)
+{
+	struct of_phandle_args clkspec;
+	struct clk *clk;
+	struct property	*prop;
+	const __be32 *cur;
+	uint32_t index;
+	int ret;
+
+	if (!clk_supplier)
+		return 0;
+
+	of_property_for_each_u32(node, "clock-always-on", prop, cur, index) {
+		clkspec.np = node;
+		clkspec.args_count = 1;
+		clkspec.args[0] = index;
+
+		clk = of_clk_get_from_provider(&clkspec);
+		if (IS_ERR(clk)) {
+			pr_err("clk: couldn't get clock %u for %s\n",
+				index, node->full_name);
+			return PTR_ERR(clk);
+		}
+
+		ret = clk_prepare_enable(clk);
+		if (ret) {
+			pr_err("Failed to enable clock %u for %s: %d\n",
+			       index, node->full_name, ret);
+			return ret;
+		}
+
+		pr_debug("Setting clock as always-on %pC\n", clk);
+	}
+
+	return 0;
+}
+
 /**
  * of_clk_set_defaults() - parse and set assigned clocks configuration
  * @node: device node to apply clock settings for
@@ -139,6 +176,10 @@ int of_clk_set_defaults(struct device_node *node, bool clk_supplier)
 	if (rc < 0)
 		return rc;
 
-	return __set_clk_rates(node, clk_supplier);
+	rc = __set_clk_rates(node, clk_supplier);
+	if (rc < 0)
+		return rc;
+
+	return __set_clk_always_on(node, clk_supplier);
 }
 EXPORT_SYMBOL_GPL(of_clk_set_defaults);
-- 
1.9.1
