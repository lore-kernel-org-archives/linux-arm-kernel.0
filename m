From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Mon, 29 Aug 2016 14:26:57 +0200
Subject: [PATCH v3 05/14] drivers: clk: st: Add clock propagation for audio
 clocks
In-Reply-To: <1472473626-15398-1-git-send-email-gabriel.fernandez@st.com>
References: <1472473626-15398-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1472473626-15398-6-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch allows fine tuning of the quads FS for audio clocks
accuracy.

Signed-off-by: Olivier Bideau <olivier.bideau@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Acked-by: Peter Griffin <peter.griffin@linaro.org>
---
 .../devicetree/bindings/clock/st/st,flexgen.txt    |  2 ++
 drivers/clk/st/clk-flexgen.c                       | 26 +++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/st/st,flexgen.txt b/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
index b7ee5c7..d68f6a5f 100644
--- a/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
+++ b/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
@@ -60,6 +60,8 @@ This binding uses the common clock binding[2].
 Required properties:
 - compatible : shall be:
   "st,flexgen"
+  "st,flexgen-audio", "st,flexgen" (enable clock propagation on parent for
+  audio use case)
 
 - #clock-cells : from common clock binding; shall be set to 1 (multiple clock
   outputs).
diff --git a/drivers/clk/st/clk-flexgen.c b/drivers/clk/st/clk-flexgen.c
index 546bd79..7ed05f0 100644
--- a/drivers/clk/st/clk-flexgen.c
+++ b/drivers/clk/st/clk-flexgen.c
@@ -15,6 +15,10 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
+struct clkgen_data {
+	unsigned long flags;
+};
+
 struct flexgen {
 	struct clk_hw hw;
 
@@ -259,6 +263,18 @@ static const char ** __init flexgen_get_parents(struct device_node *np,
 	return parents;
 }
 
+static const struct clkgen_data clkgen_audio = {
+	.flags = CLK_SET_RATE_PARENT,
+};
+
+static const struct of_device_id flexgen_of_match[] = {
+	{
+		.compatible = "st,flexgen-audio",
+		.data = &clkgen_audio,
+	},
+	{}
+};
+
 static void __init st_of_flexgen_setup(struct device_node *np)
 {
 	struct device_node *pnode;
@@ -267,6 +283,9 @@ static void __init st_of_flexgen_setup(struct device_node *np)
 	const char **parents;
 	int num_parents, i;
 	spinlock_t *rlock = NULL;
+	const struct of_device_id *match;
+	struct clkgen_data *data = NULL;
+	unsigned long flex_flags = 0;
 	int ret;
 
 	pnode = of_get_parent(np);
@@ -281,6 +300,12 @@ static void __init st_of_flexgen_setup(struct device_node *np)
 	if (!parents)
 		return;
 
+	match = of_match_node(flexgen_of_match, np);
+	if (match) {
+		data = (struct clkgen_data *)match->data;
+		flex_flags = data->flags;
+	}
+
 	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
 	if (!clk_data)
 		goto err;
@@ -307,7 +332,6 @@ static void __init st_of_flexgen_setup(struct device_node *np)
 	for (i = 0; i < clk_data->clk_num; i++) {
 		struct clk *clk;
 		const char *clk_name;
-		unsigned long flex_flags = 0;
 
 		if (of_property_read_string_index(np, "clock-output-names",
 						  i, &clk_name)) {
-- 
1.9.1
