From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Thu, 12 Jun 2014 10:39:28 +0800
Subject: [PATCH v2 1/2] clk: hix5hd2: add complex clk
In-Reply-To: <1402540769-6156-1-git-send-email-zhangfei.gao@linaro.org>
References: <1402540769-6156-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1402540769-6156-2-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support clk of sata, usb and ethernet

Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/clk/hisilicon/clk-hix5hd2.c       |  184 +++++++++++++++++++++++++++++
 include/dt-bindings/clock/hix5hd2-clock.h |    9 ++
 2 files changed, 193 insertions(+)

diff --git a/drivers/clk/hisilicon/clk-hix5hd2.c b/drivers/clk/hisilicon/clk-hix5hd2.c
index e5fcfb4..2114ee3 100644
--- a/drivers/clk/hisilicon/clk-hix5hd2.c
+++ b/drivers/clk/hisilicon/clk-hix5hd2.c
@@ -9,6 +9,8 @@
 
 #include <linux/of_address.h>
 #include <dt-bindings/clock/hix5hd2-clock.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
 #include "clk.h"
 
 static struct hisi_fixed_rate_clock hix5hd2_fixed_rate_clks[] __initdata = {
@@ -79,8 +81,188 @@ static struct hisi_gate_clock hix5hd2_gate_clks[] __initdata = {
 		CLK_SET_RATE_PARENT, 0xa0, 1, 0, },
 	{ HIX5HD2_MMC_CIU_RST, "rst_mmc_ciu", "clk_mmc_ciu",
 		CLK_SET_RATE_PARENT, 0xa0, 4, CLK_GATE_SET_TO_DISABLE, },
+	/* gsf */
+	{ HIX5HD2_FWD_BUS_CLK, "clk_fwd_bus", NULL, 0, 0xcc, 0, 0, },
+	{ HIX5HD2_FWD_SYS_CLK, "clk_fwd_sys", "clk_fwd_bus", 0, 0xcc, 5, 0, },
+	{ HIX5HD2_MAC0_PHY_CLK, "clk_fephy", "clk_fwd_sys",
+		 CLK_SET_RATE_PARENT, 0x120, 0, 0, },
 };
 
+enum hix5hd2_clk_type {
+	TYPE_COMPLEX,
+	TYPE_ETHER,
+};
+
+struct hix5hd2_complex_clock {
+	const char	*name;
+	const char	*parent_name;
+	u32		id;
+	u32		ctrl_reg;
+	u32		ctrl_clk_mask;
+	u32		ctrl_rst_mask;
+	u32		phy_reg;
+	u32		phy_clk_mask;
+	u32		phy_rst_mask;
+	enum hix5hd2_clk_type type;
+};
+
+struct hix5hd2_clk_complex {
+	struct clk_hw	hw;
+	u32		id;
+	void __iomem	*ctrl_reg;
+	u32		ctrl_clk_mask;
+	u32		ctrl_rst_mask;
+	void __iomem	*phy_reg;
+	u32		phy_clk_mask;
+	u32		phy_rst_mask;
+};
+
+static struct hix5hd2_complex_clock hix5hd2_complex_clks[] __initdata = {
+	{"clk_mac0", "clk_fephy", HIX5HD2_MAC0_CLK,
+		0xcc, 0xa, 0x500, 0x120, 0, 0x10, TYPE_ETHER},
+	{"clk_mac1", "clk_fwd_sys", HIX5HD2_MAC1_CLK,
+		0xcc, 0x14, 0xa00, 0x168, 0x2, 0, TYPE_ETHER},
+	{"clk_sata", NULL, HIX5HD2_SATA_CLK,
+		0xa8, 0x1f, 0x300, 0xac, 0x1, 0x0, TYPE_COMPLEX},
+	{"clk_usb", NULL, HIX5HD2_USB_CLK,
+		0xb8, 0xff, 0x3f000, 0xbc, 0x7, 0x3f00, TYPE_COMPLEX},
+};
+
+#define to_complex_clk(_hw) container_of(_hw, struct hix5hd2_clk_complex, hw)
+
+static int clk_ether_enable(struct clk_hw *hw)
+{
+	struct hix5hd2_clk_complex *clk = to_complex_clk(hw);
+	u32 val;
+
+	val = readl_relaxed(clk->ctrl_reg);
+	val |= clk->ctrl_clk_mask | clk->ctrl_rst_mask;
+	writel_relaxed(val, clk->ctrl_reg);
+	val &= ~(clk->ctrl_rst_mask);
+	writel_relaxed(val, clk->ctrl_reg);
+
+	val = readl_relaxed(clk->phy_reg);
+	val |= clk->phy_clk_mask;
+	val &= ~(clk->phy_rst_mask);
+	writel_relaxed(val, clk->phy_reg);
+	mdelay(10);
+
+	val &= ~(clk->phy_clk_mask);
+	val |= clk->phy_rst_mask;
+	writel_relaxed(val, clk->phy_reg);
+	mdelay(10);
+
+	val |= clk->phy_clk_mask;
+	val &= ~(clk->phy_rst_mask);
+	writel_relaxed(val, clk->phy_reg);
+	mdelay(30);
+	return 0;
+}
+
+static void clk_ether_disable(struct clk_hw *hw)
+{
+	struct hix5hd2_clk_complex *clk = to_complex_clk(hw);
+	u32 val;
+
+	val = readl_relaxed(clk->ctrl_reg);
+	val &= ~(clk->ctrl_clk_mask);
+	writel_relaxed(val, clk->ctrl_reg);
+}
+
+static struct clk_ops clk_ether_ops = {
+	.enable = clk_ether_enable,
+	.disable = clk_ether_disable,
+};
+
+static int clk_complex_enable(struct clk_hw *hw)
+{
+	struct hix5hd2_clk_complex *clk = to_complex_clk(hw);
+	u32 val;
+
+	val = readl_relaxed(clk->ctrl_reg);
+	val |= clk->ctrl_clk_mask;
+	val &= ~(clk->ctrl_rst_mask);
+	writel_relaxed(val, clk->ctrl_reg);
+
+	val = readl_relaxed(clk->phy_reg);
+	val |= clk->phy_clk_mask;
+	val &= ~(clk->phy_rst_mask);
+	writel_relaxed(val, clk->phy_reg);
+
+	return 0;
+}
+
+static void clk_complex_disable(struct clk_hw *hw)
+{
+	struct hix5hd2_clk_complex *clk = to_complex_clk(hw);
+	u32 val;
+
+	val = readl_relaxed(clk->ctrl_reg);
+	val |= clk->ctrl_rst_mask;
+	val &= ~(clk->ctrl_clk_mask);
+	writel_relaxed(val, clk->ctrl_reg);
+
+	val = readl_relaxed(clk->phy_reg);
+	val |= clk->phy_rst_mask;
+	val &= ~(clk->phy_clk_mask);
+	writel_relaxed(val, clk->phy_reg);
+
+	return;
+}
+
+static struct clk_ops clk_complex_ops = {
+	.enable = clk_complex_enable,
+	.disable = clk_complex_disable,
+};
+
+void __init hix5hd2_clk_register_complex_clk(struct hix5hd2_complex_clock *clks,
+				       int nums, struct hisi_clock_data *data)
+{
+	void __iomem *base = data->base;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		struct hix5hd2_clk_complex *p_clk;
+		struct clk *clk;
+		struct clk_init_data init;
+
+		p_clk = kzalloc(sizeof(*p_clk), GFP_KERNEL);
+		if (!p_clk) {
+			pr_err("%s: fail to allocate clk\n", __func__);
+			return;
+		}
+
+		init.name = clks[i].name;
+		if (clks[i].type == TYPE_ETHER)
+			init.ops = &clk_ether_ops;
+		else
+			init.ops = &clk_complex_ops;
+
+		init.flags = CLK_IS_BASIC;
+		init.parent_names =
+			(clks[i].parent_name ? &clks[i].parent_name : NULL);
+		init.num_parents = (clks[i].parent_name ? 1 : 0);
+
+		p_clk->ctrl_reg = base + clks[i].ctrl_reg;
+		p_clk->ctrl_clk_mask = clks[i].ctrl_clk_mask;
+		p_clk->ctrl_rst_mask = clks[i].ctrl_rst_mask;
+		p_clk->phy_reg = base + clks[i].phy_reg;
+		p_clk->phy_clk_mask = clks[i].phy_clk_mask;
+		p_clk->phy_rst_mask = clks[i].phy_rst_mask;
+		p_clk->hw.init = &init;
+
+		clk = clk_register(NULL, &p_clk->hw);
+		if (IS_ERR(clk)) {
+			kfree(p_clk);
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			continue;
+		}
+
+		data->clk_data.clks[clks[i].id] = clk;
+	}
+}
+
 static void __init hix5hd2_clk_init(struct device_node *np)
 {
 	struct hisi_clock_data *clk_data;
@@ -96,6 +278,8 @@ static void __init hix5hd2_clk_init(struct device_node *np)
 					clk_data);
 	hisi_clk_register_gate(hix5hd2_gate_clks,
 			ARRAY_SIZE(hix5hd2_gate_clks), clk_data);
+	hix5hd2_clk_register_complex_clk(hix5hd2_complex_clks,
+			ARRAY_SIZE(hix5hd2_complex_clks), clk_data);
 }
 
 CLK_OF_DECLARE(hix5hd2_clk, "hisilicon,hix5hd2-clock", hix5hd2_clk_init);
diff --git a/include/dt-bindings/clock/hix5hd2-clock.h b/include/dt-bindings/clock/hix5hd2-clock.h
index aad579a..e328669 100644
--- a/include/dt-bindings/clock/hix5hd2-clock.h
+++ b/include/dt-bindings/clock/hix5hd2-clock.h
@@ -53,6 +53,15 @@
 #define HIX5HD2_MMC_CIU_CLK		130
 #define HIX5HD2_MMC_BIU_CLK		131
 #define HIX5HD2_MMC_CIU_RST		132
+#define HIX5HD2_FWD_BUS_CLK		133
+#define HIX5HD2_FWD_SYS_CLK		134
+#define HIX5HD2_MAC0_PHY_CLK		135
+
+/* complex */
+#define HIX5HD2_MAC0_CLK		192
+#define HIX5HD2_MAC1_CLK		193
+#define HIX5HD2_SATA_CLK		194
+#define HIX5HD2_USB_CLK			195
 
 #define HIX5HD2_NR_CLKS			256
 #endif	/* __DTS_HIX5HD2_CLOCK_H */
-- 
1.7.9.5
