From: robherring2@gmail.com (Rob Herring)
Date: Tue, 13 Mar 2012 18:22:26 -0500
Subject: [PATCH 6/7] dt/clock: add function to get parent clock name
In-Reply-To: <1331680947-29861-1-git-send-email-robherring2@gmail.com>
References: <1331680947-29861-1-git-send-email-robherring2@gmail.com>
Message-ID: <1331680947-29861-7-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 drivers/of/clock.c     |   24 ++++++++++++++++++++++++
 include/linux/of_clk.h |    2 ++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/of/clock.c b/drivers/of/clock.c
index f4a0965..8ad2dbd 100644
--- a/drivers/of/clock.c
+++ b/drivers/of/clock.c
@@ -128,6 +128,30 @@ struct clk *of_clk_get(struct device_node *np, int index)
 	return clk;
 }
 
+const char *of_clk_get_parent_name(struct device_node *np, int index)
+{
+	struct of_phandle_args clkspec;
+	const char *clk_name;
+	int rc;
+
+	if (index < 0)
+		return NULL;
+
+	rc = of_parse_phandle_with_args(np, "clocks", "#clock-cells", index,
+					&clkspec);
+	if (rc)
+		return NULL;
+
+	if (of_property_read_string_index(clkspec.np, "clock-output-names",
+					  clkspec.args_count ? clkspec.args[0] : 0,
+					  &clk_name) < 0)
+		clk_name = clkspec.np->name;
+
+	of_node_put(clkspec.np);
+	return clk_name;
+}
+
+
 /**
  * of_clk_get_by_name() - Parse and lookup a clock referenced by a device node
  * @np: pointer to clock consumer node
diff --git a/include/linux/of_clk.h b/include/linux/of_clk.h
index 02ecc98..6a07071 100644
--- a/include/linux/of_clk.h
+++ b/include/linux/of_clk.h
@@ -22,6 +22,8 @@ void of_clk_del_provider(struct device_node *np);
 struct clk *of_clk_get(struct device_node *np, int index);
 struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
 
+const char *of_clk_get_parent_name(struct device_node *np, int index);
+
 void of_clk_init(const struct of_device_id *matches);
 extern void of_fixed_clk_setup(struct device_node *np);
 
-- 
1.7.5.4
