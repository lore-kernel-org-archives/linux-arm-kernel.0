From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 22 Jul 2015 14:04:14 +0100
Subject: [PATCH v7 4/5] clk: Provide critical clock support
In-Reply-To: <1437570255-21049-1-git-send-email-lee.jones@linaro.org>
References: <1437570255-21049-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1437570255-21049-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lots of platforms contain clocks which if turned off would prove fatal.
The only way to recover from these catastrophic failures is to restart
the board(s).  Now, when a clock provider is registered with the
framework it is possible for a list of critical clocks to be supplied
which must be kept ungated.  Each clock mentioned in the newly
introduced 'critical-clock' property will be clk_prepare_enable()d
where the normal references will be taken.  This will prevent the
common clk framework from attempting to gate them during the normal
clk_disable_unused() and disable_clock() procedures.

Note that it will still be possible for knowledgeable drivers to turn
these clocks off using clk_{enable,disable}_critical() calls.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/clk-conf.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index aad4796..f83c1c2 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -116,6 +116,45 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
 	return 0;
 }
 
+static int __set_critical_clocks(struct device_node *node, bool clk_supplier)
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
+	of_property_for_each_u32(node, "critical-clock", prop, cur, index) {
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
+		clk_init_critical(clk);
+
+		ret = clk_prepare_enable(clk);
+		if (ret) {
+			pr_err("Failed to enable clock %u for %s: %d\n",
+			       index, node->full_name, ret);
+			return ret;
+		}
+
+		pr_debug("Setting clock as critical %pC\n", clk);
+	}
+
+	return 0;
+}
+
 /**
  * of_clk_set_defaults() - parse and set assigned clocks configuration
  * @node: device node to apply clock settings for
@@ -139,6 +178,10 @@ int of_clk_set_defaults(struct device_node *node, bool clk_supplier)
 	if (rc < 0)
 		return rc;
 
-	return __set_clk_rates(node, clk_supplier);
+	rc = __set_clk_rates(node, clk_supplier);
+	if (rc < 0)
+		return rc;
+
+	return __set_critical_clocks(node, clk_supplier);
 }
 EXPORT_SYMBOL_GPL(of_clk_set_defaults);
-- 
1.9.1
