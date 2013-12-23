From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 23 Dec 2013 00:32:40 -0300
Subject: [PATCH v3 09/13] clk: sunxi: support better factor DT nodes
In-Reply-To: <1387769564-12894-1-git-send-email-emilio@elopez.com.ar>
References: <1387769564-12894-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1387769564-12894-10-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DT nodes should look like

    abc_clk: clk at deadbeef {
        ...
        clock-output-names = "abc";
    }

But our old DT nodes look like

    abc: abc at deadbeef {
        ...
    }

So, let's support both formats, until we can transition everything
to the new, correct one.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 drivers/clk/sunxi/clk-sunxi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 3497a29..2be4e46 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -435,6 +435,15 @@ static struct clk * __init sunxi_factors_clk_setup(struct device_node *node,
 	       (parents[i] = of_clk_get_parent_name(node, i)) != NULL)
 		i++;
 
+	/* Nodes should be providing the name via clock-output-names
+	 * but originally our dts didn't, and so we used node->name.
+	 * The new, better nodes look like clk at deadbeef, so we pull the
+	 * name just in this case */
+	if (!strcmp("clk", clk_name)) {
+		of_property_read_string_index(node, "clock-output-names",
+					      0, &clk_name);
+	}
+
 	factors = kzalloc(sizeof(struct clk_factors), GFP_KERNEL);
 	if (!factors)
 		return NULL;
-- 
1.8.5.2
