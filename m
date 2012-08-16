From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 16 Aug 2012 16:08:45 +0800
Subject: [PATCH 1/2] clk: add of_clk_src_onecell_get() support
In-Reply-To: <1345104526-14797-1-git-send-email-shawn.guo@linaro.org>
References: <1345104526-14797-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1345104526-14797-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For those SoCs that have hundreds of clock outputs, their clock
DT bindings could reasonably define #clock-cells as 1 and require
the client device specify the index of the clock it consumes in the
cell of its "clocks" phandle.

Add a generic of_clk_src_onecell_get() function for this purpose.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/clk.c            |   15 +++++++++++++++
 include/linux/clk-provider.h |    1 +
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index efdfd00..06bc0b5 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1582,6 +1582,21 @@ struct clk *of_clk_src_simple_get(struct of_phandle_args *clkspec,
 }
 EXPORT_SYMBOL_GPL(of_clk_src_simple_get);
 
+struct clk *of_clk_src_onecell_get(struct of_phandle_args *clkspec, void *data)
+{
+	const char *clk_name;
+	int idx = clkspec->args[0];
+	int ret;
+
+	ret = of_property_read_string_index(clkspec->np, "clock-output-names",
+					    idx, &clk_name);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	return __clk_lookup(clk_name);
+}
+EXPORT_SYMBOL_GPL(of_clk_src_onecell_get);
+
 /**
  * of_clk_add_provider() - Register a clock provider for a node
  * @np: Device node pointer associated with clock provider
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 77335fa..2afcadf 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -360,6 +360,7 @@ int of_clk_add_provider(struct device_node *np,
 void of_clk_del_provider(struct device_node *np);
 struct clk *of_clk_src_simple_get(struct of_phandle_args *clkspec,
 				  void *data);
+struct clk *of_clk_src_onecell_get(struct of_phandle_args *clkspec, void *data);
 const char *of_clk_get_parent_name(struct device_node *np, int index);
 void of_clk_init(const struct of_device_id *matches);
 
-- 
1.7.5.4
