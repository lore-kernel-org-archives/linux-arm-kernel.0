From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Wed, 13 Mar 2013 15:00:37 +0100
Subject: [PATCH 4/4] clk: samsung: add infrastructure to add separate aliases
In-Reply-To: <201303131458.18671.heiko@sntech.de>
References: <201303131458.18671.heiko@sntech.de>
Message-ID: <201303131500.37646.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code adds aliases, if necessary, directly when adding the clock,
limiting the number of possible aliases to one.

Some platforms need more than one alias, like the hsmmc pclocks on s3c2416
which need a "hsmmc" and "mmc_busclk.0" alias for the s3c-sdhci driver.

Therefore add the possibility to separately add clock aliases for previously
created clocks.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/samsung/clk.c |   33 +++++++++++++++++++++++++++++++++
 drivers/clk/samsung/clk.h |   21 +++++++++++++++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 1ed5716..82f27f6 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -97,6 +97,39 @@ void samsung_clk_add_lookup(struct clk *clk, unsigned int id)
 		clk_table[id] = clk;
 }
 
+/* register a list of aliases */
+void __init samsung_clk_register_alias(struct samsung_clock_alias *list,
+					unsigned int nr_clk)
+{
+	struct clk *clk;
+	unsigned int idx, ret;
+
+	if (!clk_table) {
+		pr_err("%s: clock table missing\n", __func__);
+		return;
+	}
+
+	for (idx = 0; idx < nr_clk; idx++, list++) {
+		if (!list->id) {
+			pr_err("%s: clock id missing for index %d\n", __func__,
+				idx);
+			continue;
+		}
+
+		clk = clk_table[list->id];
+		if (!clk) {
+			pr_err("%s: failed to find clock %d\n", __func__,
+				list->id);
+			continue;
+		}
+
+		ret = clk_register_clkdev(clk, list->alias, list->dev_name);
+		if (ret)
+			pr_err("%s: failed to register lookup %s\n",
+					__func__, list->alias);
+	}
+}
+
 /* register a list of fixed clocks */
 void __init samsung_clk_register_fixed_rate(
 		struct samsung_fixed_rate_clock *list, unsigned int nr_clk)
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 26a752b..6bacd6f 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -23,6 +23,25 @@
 #include <mach/map.h>
 
 /**
+ * struct samsung_clock_alias: information about mux clock
+ * @id: platform specific id of the clock.
+ * @dev_name: name of the device to which this clock belongs.
+ * @alias: optional clock alias name to be assigned to this clock.
+ */
+struct samsung_clock_alias {
+	unsigned int		id;
+	const char		*dev_name;
+	const char		*alias;
+};
+
+#define ALIAS(_id, dname, a)	\
+	{							\
+		.id		= _id,				\
+		.dev_name	= dname,			\
+		.alias		= a,				\
+	}
+
+/**
  * struct samsung_fixed_rate_clock: information about fixed-rate clock
  * @id: platform specific id of the clock.
  * @name: name of this fixed-rate clock.
@@ -251,6 +270,8 @@ extern void __init samsung_clk_of_register_fixed_ext(
 
 extern void samsung_clk_add_lookup(struct clk *clk, unsigned int id);
 
+extern void samsung_clk_register_alias(struct samsung_clock_alias *list,
+		unsigned int nr_clk);
 extern void __init samsung_clk_register_fixed_rate(
 		struct samsung_fixed_rate_clock *clk_list, unsigned int nr_clk);
 extern void __init samsung_clk_register_fixed_factor(
-- 
1.7.2.3
