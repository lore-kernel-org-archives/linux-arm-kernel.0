From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 10 Dec 2014 16:48:25 +0100
Subject: [RFC 07/15] clk: add DT parsing function
In-Reply-To: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
References: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1418226513-14105-8-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds function for parsing Device Tree to get
clock specifier. The function could be ultimately used
by clock core.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/clk/clkdev.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index da4bda8..bd22750 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -120,6 +120,29 @@ struct clk *of_clk_get_by_name(struct device_node *np, const char *name)
 	return clk;
 }
 EXPORT_SYMBOL(of_clk_get_by_name);
+
+static int of_get_clock_spec(struct device *dev, const char *name,
+		struct of_phandle_args *spec)
+{
+	struct device_node *np = dev->of_node;
+
+	while (np) {
+		int idx = 0;
+
+		if (name)
+			idx = of_property_match_string(np, "clock-names", name);
+
+		if (!of_parse_phandle_with_args(np, "clocks", "#clock-cells",
+						idx, spec))
+			return 0;
+
+		np = np->parent;
+		if (np && !of_get_property(np, "clock-ranges", NULL))
+			break;
+	}
+
+	return -ENOENT;
+}
 #endif
 
 /*
-- 
1.9.1
