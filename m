From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Thu,  5 May 2016 15:53:27 +0000
Subject: [PATCH 4/5] clk: bcm2835: allow setting clocks flags via the dt
In-Reply-To: <1462463608-22940-1-git-send-email-kernel@martin.sperl.org>
References: <1462463608-22940-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1462463608-22940-5-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Allow setting flags for each clock via the device tree.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c | 57 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 8a44ebf..c80487e 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1125,7 +1125,8 @@ static const struct clk_ops bcm2835_vpu_clock_clk_ops = {
 };
 
 static struct clk *bcm2835_register_pll(struct bcm2835_cprman *cprman,
-					const struct bcm2835_pll_data *data)
+					const struct bcm2835_pll_data *data,
+					u32 flags)
 {
 	struct bcm2835_pll *pll;
 	struct clk_init_data init;
@@ -1152,7 +1153,8 @@ static struct clk *bcm2835_register_pll(struct bcm2835_cprman *cprman,
 
 static struct clk *
 bcm2835_register_pll_divider(struct bcm2835_cprman *cprman,
-			     const struct bcm2835_pll_divider_data *data)
+			     const struct bcm2835_pll_divider_data *data,
+			     u32 flags)
 {
 	struct bcm2835_pll_divider *divider;
 	struct clk_init_data init;
@@ -1223,8 +1225,10 @@ static u32 bcm2835_register_clock_default_parents(
 	struct device *dev,
 	const struct bcm2835_clock_data *data);
 
-static struct clk *bcm2835_register_clock(struct bcm2835_cprman *cprman,
-					  const struct bcm2835_clock_data *data)
+static struct clk *
+bcm2835_register_clock(struct bcm2835_cprman *cprman,
+		       const struct bcm2835_clock_data *data,
+		       u32 flags)
 {
 	struct bcm2835_clock *clock;
 	struct clk_init_data init;
@@ -1270,14 +1274,19 @@ static struct clk *bcm2835_register_clock(struct bcm2835_cprman *cprman,
 	clock->cprman = cprman;
 	clock->data = data;
 	clock->hw.init = &init;
-	clock->flags = bcm2835_register_clock_default_parents(
-		cprman->dev, data);
+
+	clock->flags = flags;
+	if ((clock->flags & (BIT(data->num_mux_parents) - 1)) == 0)
+		clock->flags |= bcm2835_register_clock_default_parents(
+			cprman->dev, data);
 
 	return devm_clk_register(cprman->dev, &clock->hw);
 }
 
-static struct clk *bcm2835_register_gate(struct bcm2835_cprman *cprman,
-					 const struct bcm2835_gate_data *data)
+static struct clk *
+bcm2835_register_gate(struct bcm2835_cprman *cprman,
+		      const struct bcm2835_gate_data *data,
+		      u32 flags)
 {
 	return clk_register_gate(cprman->dev, data->name, data->parent,
 				 CLK_IGNORE_UNUSED | CLK_SET_RATE_GATE,
@@ -1286,7 +1295,7 @@ static struct clk *bcm2835_register_gate(struct bcm2835_cprman *cprman,
 }
 
 typedef struct clk *(*bcm2835_clk_register)(struct bcm2835_cprman *cprman,
-					    const void *data);
+					    const void *data, int flags);
 struct bcm2835_clk_desc {
 	bcm2835_clk_register clk_register;
 	const void *data;
@@ -1861,6 +1870,10 @@ static int bcm2835_clk_probe(struct platform_device *pdev)
 	struct resource *res;
 	const struct bcm2835_clk_desc *desc;
 	const size_t asize = ARRAY_SIZE(clk_desc_array);
+	u32 flags[asize], index;
+	struct property *prop;
+	const __be32 *cur;
+	int ret;
 	size_t i;
 
 	cprman = devm_kzalloc(dev,
@@ -1869,6 +1882,29 @@ static int bcm2835_clk_probe(struct platform_device *pdev)
 	if (!cprman)
 		return -ENOMEM;
 
+	/* fill in flags from dt */
+	memset(flags, 0, sizeof(flags));
+	i = 0;
+	of_property_for_each_u32(dev->of_node, "brcm,clock-index",
+				 prop, cur, index) {
+		if (index >= asize) {
+			dev_err(dev,
+				"clock-index %d in \"brcm,clock-index\" is out of bounds at position %d\n",
+				index, i);
+		} else {
+			ret = of_property_read_u32_index(dev->of_node,
+							 "brcm,clock-flags",
+							 i, &flags[index]);
+			if (ret) {
+				dev_err(dev,
+					"no value at position %d in \"brcm,clock-flags\" - %d\n",
+					i, ret);
+			}
+		}
+		/* increment index */
+		i++;
+	}
+
 	spin_lock_init(&cprman->regs_lock);
 	cprman->dev = dev;
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1889,7 +1925,8 @@ static int bcm2835_clk_probe(struct platform_device *pdev)
 	for (i = 0; i < asize; i++) {
 		desc = &clk_desc_array[i];
 		if (desc->clk_register && desc->data)
-			clks[i] = desc->clk_register(cprman, desc->data);
+			clks[i] = desc->clk_register(cprman, desc->data,
+				flags[i]);
 	}
 
 	return of_clk_add_provider(dev->of_node, of_clk_src_onecell_get,
-- 
2.1.4
