From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 15 Nov 2018 23:40:47 +0100
Subject: [PATCH v2 5/6] clk: meson: meson8b: run from the XTAL when changing
 the CPU frequency
In-Reply-To: <20181115224048.13511-1-martin.blumenstingl@googlemail.com>
References: <20181115224048.13511-1-martin.blumenstingl@googlemail.com>
Message-ID: <20181115224048.13511-6-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changing the CPU clock requires changing various clocks including the
SYS PLL. The existing meson clk-pll and clk-regmap drivers can change
all of the relevant clocks already.
However, changing for exampe the SYS PLL is problematic because as long
as the CPU is running off a clock derived from SYS PLL changing the
latter results in a full system lockup.
Fix this system lockup by switching the CPU clock to run off the XTAL
while we are changing the any of the clocks in the CPU clock tree.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/meson8b.c | 63 +++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index b07a92ed7de3..c06a1a7faa4c 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -1116,6 +1116,53 @@ static const struct reset_control_ops meson8b_clk_reset_ops = {
 	.deassert = meson8b_clk_reset_deassert,
 };
 
+struct meson8b_nb_data {
+	struct notifier_block nb;
+	struct clk_hw_onecell_data *onecell_data;
+};
+
+static int meson8b_cpu_clk_notifier_cb(struct notifier_block *nb,
+				       unsigned long event, void *data)
+{
+	struct meson8b_nb_data *nb_data =
+		container_of(nb, struct meson8b_nb_data, nb);
+	struct clk_hw **hws = nb_data->onecell_data->hws;
+	struct clk_hw *cpu_clk_hw, *parent_clk_hw;
+	struct clk *cpu_clk, *parent_clk;
+	int ret;
+
+	switch (event) {
+	case PRE_RATE_CHANGE:
+		parent_clk_hw = hws[CLKID_XTAL];
+		break;
+
+	case POST_RATE_CHANGE:
+		parent_clk_hw = hws[CLKID_CPU_SCALE_OUT_SEL];
+		break;
+
+	default:
+		return NOTIFY_DONE;
+	}
+
+	cpu_clk_hw = hws[CLKID_CPUCLK];
+	cpu_clk = __clk_lookup(clk_hw_get_name(cpu_clk_hw));
+
+	parent_clk = __clk_lookup(clk_hw_get_name(parent_clk_hw));
+
+	ret = clk_set_parent(cpu_clk, parent_clk);
+	if (ret)
+		return notifier_from_errno(ret);
+
+	udelay(100);
+
+	return NOTIFY_OK;
+}
+
+static struct meson8b_nb_data meson8b_cpu_nb_data = {
+	.nb.notifier_call = meson8b_cpu_clk_notifier_cb,
+	.onecell_data = &meson8b_hw_onecell_data,
+};
+
 static const struct regmap_config clkc_regmap_config = {
 	.reg_bits       = 32,
 	.val_bits       = 32,
@@ -1125,6 +1172,8 @@ static const struct regmap_config clkc_regmap_config = {
 static void __init meson8b_clkc_init(struct device_node *np)
 {
 	struct meson8b_clk_reset *rstc;
+	const char *notifier_clk_name;
+	struct clk *notifier_clk;
 	void __iomem *clk_base;
 	struct regmap *map;
 	int i, ret;
@@ -1179,6 +1228,20 @@ static void __init meson8b_clkc_init(struct device_node *np)
 			return;
 	}
 
+	/*
+	 * FIXME we shouldn't program the muxes in notifier handlers. The
+	 * tricky programming sequence will be handled by the forthcoming
+	 * coordinated clock rates mechanism once that feature is released.
+	 */
+	notifier_clk_name = clk_hw_get_name(&meson8b_cpu_scale_out_sel.hw);
+	notifier_clk = __clk_lookup(notifier_clk_name);
+	ret = clk_notifier_register(notifier_clk, &meson8b_cpu_nb_data.nb);
+	if (ret) {
+		pr_err("%s: failed to register the CPU clock notifier\n",
+		       __func__);
+		return;
+	}
+
 	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get,
 				     &meson8b_hw_onecell_data);
 	if (ret)
-- 
2.19.1
