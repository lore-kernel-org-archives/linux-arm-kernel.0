From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Thu, 16 Jun 2016 11:20:24 +0200
Subject: [RESEND PATCH v2 04/13] drivers: clk: st: Add clock propagation for
 audio clocks
In-Reply-To: <1466068833-5055-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1466068833-5055-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1466068833-5055-5-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows fine tuning of the quads FS for audio clocks
accuracy.

Signed-off-by: Olivier Bideau <olivier.bideau@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 .../devicetree/bindings/clock/st/st,flexgen.txt    |  2 ++
 drivers/clk/st/clk-flexgen.c                       | 24 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

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
index 627267c..33d6ced 100644
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
@@ -267,6 +283,8 @@ static void __init st_of_flexgen_setup(struct device_node *np)
 	const char **parents;
 	int num_parents, i;
 	spinlock_t *rlock = NULL;
+	const struct of_device_id *match;
+	struct clkgen_data *data = NULL;
 	unsigned long flex_flags = 0;
 	int ret;
 
@@ -282,6 +300,12 @@ static void __init st_of_flexgen_setup(struct device_node *np)
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
-- 
1.9.1
