From: shawnguo@kernel.org (Shawn Guo)
Date: Thu,  8 Dec 2016 17:25:57 +0800
Subject: [PATCH 2/2] clk: zte: add audio clocks for zx296718
In-Reply-To: <1481189157-8995-1-git-send-email-shawnguo@kernel.org>
References: <1481189157-8995-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1481189157-8995-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jun Nie <jun.nie@linaro.org>

The audio related clock support is missing from the existing zx296718
clock driver.  Let's add it, so that the upstream ZX SPDIF driver can
work for HDMI audio support.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/zte/clk-zx296718.c | 150 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/zte/clk.c          | 149 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/zte/clk.h          |  28 ++++++++
 3 files changed, 327 insertions(+)

diff --git a/drivers/clk/zte/clk-zx296718.c b/drivers/clk/zte/clk-zx296718.c
index 707d62956e9b..eed8581b1b25 100644
--- a/drivers/clk/zte/clk-zx296718.c
+++ b/drivers/clk/zte/clk-zx296718.c
@@ -888,10 +888,160 @@ static int __init lsp1_clocks_init(struct device_node *np)
 	return 0;
 }
 
+PNAME(audio_wclk_common_p) = {
+	"audio_99m",
+	"audio_24m",
+};
+
+PNAME(audio_timer_p) = {
+	"audio_24m",
+	"audio_32k",
+};
+
+static struct zx_clk_mux audio_mux_clk[] = {
+	MUX(0, "i2s0_wclk_mux", audio_wclk_common_p, AUDIO_I2S0_CLK, 0, 1),
+	MUX(0, "i2s1_wclk_mux", audio_wclk_common_p, AUDIO_I2S1_CLK, 0, 1),
+	MUX(0, "i2s2_wclk_mux", audio_wclk_common_p, AUDIO_I2S2_CLK, 0, 1),
+	MUX(0, "i2s3_wclk_mux", audio_wclk_common_p, AUDIO_I2S3_CLK, 0, 1),
+	MUX(0, "i2c0_wclk_mux", audio_wclk_common_p, AUDIO_I2C0_CLK, 0, 1),
+	MUX(0, "spdif0_wclk_mux", audio_wclk_common_p, AUDIO_SPDIF0_CLK, 0, 1),
+	MUX(0, "spdif1_wclk_mux", audio_wclk_common_p, AUDIO_SPDIF1_CLK, 0, 1),
+	MUX(0, "timer_wclk_mux", audio_timer_p, AUDIO_TIMER_CLK, 0, 1),
+};
+
+struct zx_clk_audio_div_table i2s_wclk_div_table[] = {
+	{2048000, 0x3000030, 0xffff5700},
+	{4096000, 0x3000018, 0xffff2b80},
+	{2822400, 0x3000011, 0xffff89cb},
+	{3072000, 0x3000010, 0xffff1d00},
+	{4096000, 0x300000c, 0xffff15c0},
+	{5644800, 0x3000008, 0xffffc4e5},
+	{6144000, 0x3000008, 0xffff0e80},
+	{11289600, 0x3000004, 0xffff6273},
+	{12288000, 0x3000004, 0xffff0740},
+	{22579200, 0x3000002, 0xffff3139},
+	{24576000, 0x3000002, 0xffff03a0},
+};
+
+struct zx_clk_audio_div_table spdif_wclk_div_table[] = {
+	{2822400, 0x00023, 0xffff1397},
+	{3072000, 0x00020, 0xffff3a00},
+	{4096000, 0x00018, 0xffff2b80},
+	{5644800, 0x00011, 0xffff89cb},
+	{6144000, 0x00010, 0xffff1d00},
+	{11289600, 0x00008, 0xffffc4e5},
+	{12288000, 0x00008, 0xffff0e80},
+	{22579200, 0x00004, 0xffff6273},
+	{24576000, 0x00004, 0xffff0740},
+};
+
+struct clk_zx_audio_divider audio_adiv_clk[] = {
+	AUDIO_DIV(0, "i2s0_wclk_div", "i2s0_wclk_mux", AUDIO_I2S0_DIV_CFG1, i2s_wclk_div_table),
+	AUDIO_DIV(0, "i2s1_wclk_div", "i2s1_wclk_mux", AUDIO_I2S1_DIV_CFG1, i2s_wclk_div_table),
+	AUDIO_DIV(0, "i2s2_wclk_div", "i2s2_wclk_mux", AUDIO_I2S2_DIV_CFG1, i2s_wclk_div_table),
+	AUDIO_DIV(0, "i2s3_wclk_div", "i2s3_wclk_mux", AUDIO_I2S3_DIV_CFG1, i2s_wclk_div_table),
+	AUDIO_DIV(0, "spdif0_wclk_div", "spdif0_wclk_mux", AUDIO_SPDIF0_DIV_CFG1, spdif_wclk_div_table),
+	AUDIO_DIV(0, "spdif1_wclk_div", "spdif1_wclk_mux", AUDIO_SPDIF1_DIV_CFG1, spdif_wclk_div_table),
+};
+
+struct zx_clk_div audio_div_clk[] = {
+	DIV_T(0, "tdm_wclk_div", "audio_16m384", AUDIO_TDM_CLK, 8, 4, 0, common_div_table),
+};
+
+struct zx_clk_gate audio_gate_clk[] = {
+	GATE(AUDIO_I2S0_WCLK, "i2s0_wclk", "i2s0_wclk_div", AUDIO_I2S0_CLK, 9, CLK_SET_RATE_PARENT, 0),
+	GATE(AUDIO_I2S1_WCLK, "i2s1_wclk", "i2s1_wclk_div", AUDIO_I2S1_CLK, 9, CLK_SET_RATE_PARENT, 0),
+	GATE(AUDIO_I2S2_WCLK, "i2s2_wclk", "i2s2_wclk_div", AUDIO_I2S2_CLK, 9, CLK_SET_RATE_PARENT, 0),
+	GATE(AUDIO_I2S3_WCLK, "i2s3_wclk", "i2s3_wclk_div", AUDIO_I2S3_CLK, 9, CLK_SET_RATE_PARENT, 0),
+	GATE(AUDIO_I2C0_WCLK, "i2c0_wclk", "i2c0_wclk_mux", AUDIO_I2C0_CLK, 9, CLK_SET_RATE_PARENT, 0),
+	GATE(AUDIO_SPDIF0_WCLK, "spdif0_wclk", "spdif0_wclk_div", AUDIO_SPDIF0_CLK, 9, CLK_SET_RATE_PARENT, 0),
+	GATE(AUDIO_SPDIF1_WCLK, "spdif1_wclk", "spdif1_wclk_div", AUDIO_SPDIF1_CLK, 9, CLK_SET_RATE_PARENT, 0),
+	GATE(AUDIO_TDM_WCLK, "tdm_wclk", "tdm_wclk_div", AUDIO_TDM_CLK, 17, CLK_SET_RATE_PARENT, 0),
+	GATE(AUDIO_TS_PCLK, "tempsensor_pclk", "clk49m5", AUDIO_TS_CLK, 1, 0, 0),
+};
+
+static struct clk_hw_onecell_data audio_hw_onecell_data = {
+	.num = AUDIO_NR_CLKS,
+	.hws = {
+		[AUDIO_NR_CLKS - 1] = NULL,
+	},
+};
+
+static int __init audio_clocks_init(struct device_node *np)
+{
+	void __iomem *reg_base;
+	int i, ret;
+
+	reg_base = of_iomap(np, 0);
+	if (!reg_base) {
+		pr_err("%s: Unable to map audio clk base\n", __func__);
+		return -ENXIO;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(audio_mux_clk); i++) {
+		if (audio_mux_clk[i].id)
+			audio_hw_onecell_data.hws[audio_mux_clk[i].id] =
+					&audio_mux_clk[i].mux.hw;
+
+		audio_mux_clk[i].mux.reg += (u64)reg_base;
+		ret = clk_hw_register(NULL, &audio_mux_clk[i].mux.hw);
+		if (ret) {
+			pr_warn("audio clk %s init error!\n",
+				audio_mux_clk[i].mux.hw.init->name);
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(audio_adiv_clk); i++) {
+		if (audio_adiv_clk[i].id)
+			audio_hw_onecell_data.hws[audio_adiv_clk[i].id] =
+					&audio_adiv_clk[i].hw;
+
+		audio_adiv_clk[i].reg_base += (u64)reg_base;
+		ret = clk_hw_register(NULL, &audio_adiv_clk[i].hw);
+		if (ret) {
+			pr_warn("audio clk %s init error!\n",
+				audio_adiv_clk[i].hw.init->name);
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(audio_div_clk); i++) {
+		if (audio_div_clk[i].id)
+			audio_hw_onecell_data.hws[audio_div_clk[i].id] =
+					&audio_div_clk[i].div.hw;
+
+		audio_div_clk[i].div.reg += (u64)reg_base;
+		ret = clk_hw_register(NULL, &audio_div_clk[i].div.hw);
+		if (ret) {
+			pr_warn("audio clk %s init error!\n",
+				audio_div_clk[i].div.hw.init->name);
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(audio_gate_clk); i++) {
+		if (audio_gate_clk[i].id)
+			audio_hw_onecell_data.hws[audio_gate_clk[i].id] =
+					&audio_gate_clk[i].gate.hw;
+
+		audio_gate_clk[i].gate.reg += (u64)reg_base;
+		ret = clk_hw_register(NULL, &audio_gate_clk[i].gate.hw);
+		if (ret) {
+			pr_warn("audio clk %s init error!\n",
+				audio_gate_clk[i].gate.hw.init->name);
+		}
+	}
+
+	if (of_clk_add_hw_provider(np, of_clk_hw_onecell_get, &audio_hw_onecell_data))
+		panic("could not register clk provider\n");
+	pr_info("audio-clk init over, nr:%d\n", AUDIO_NR_CLKS);
+
+	return 0;
+}
+
 static const struct of_device_id zx_clkc_match_table[] = {
 	{ .compatible = "zte,zx296718-topcrm", .data = &top_clocks_init },
 	{ .compatible = "zte,zx296718-lsp0crm", .data = &lsp0_clocks_init },
 	{ .compatible = "zte,zx296718-lsp1crm", .data = &lsp1_clocks_init },
+	{ .compatible = "zte,zx296718-audiocrm", .data = &audio_clocks_init },
 	{ }
 };
 
diff --git a/drivers/clk/zte/clk.c b/drivers/clk/zte/clk.c
index c4c1251bc1e7..ea97024b37aa 100644
--- a/drivers/clk/zte/clk.c
+++ b/drivers/clk/zte/clk.c
@@ -9,6 +9,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/gcd.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/slab.h>
@@ -310,3 +311,151 @@ struct clk *clk_register_zx_audio(const char *name,
 
 	return clk;
 }
+
+#define CLK_AUDIO_DIV_FRAC	BIT(0)
+#define CLK_AUDIO_DIV_INT	BIT(1)
+#define CLK_AUDIO_DIV_UNCOMMON	BIT(1)
+
+#define CLK_AUDIO_DIV_FRAC_NSHIFT	16
+#define CLK_AUDIO_DIV_INT_FRAC_RE	BIT(16)
+#define CLK_AUDIO_DIV_INT_FRAC_MAX	(0xffff)
+#define CLK_AUDIO_DIV_INT_FRAC_MIN	(0x2)
+#define CLK_AUDIO_DIV_INT_INT_SHIFT	24
+#define CLK_AUDIO_DIV_INT_INT_WIDTH	4
+
+#define to_clk_zx_audio_div(_hw) container_of(_hw, struct clk_zx_audio_divider, hw)
+
+static unsigned long audio_calc_rate(struct clk_zx_audio_divider *audio_div,
+				     u32 reg_frac, u32 reg_int,
+				     unsigned long parent_rate)
+{
+	unsigned long rate, m, n;
+
+	if (audio_div->table) {
+		const struct zx_clk_audio_div_table *divt = audio_div->table;
+
+		for (; divt->rate; divt++) {
+			if ((divt->int_reg == reg_int) && (divt->frac_reg == reg_frac))
+				return divt->rate;
+		}
+	}
+	if (audio_div->table)
+		pr_warn("cannot found the config(int_reg:0x%x, frac_reg:0x%x) in table, we will caculate it\n",
+			reg_int, reg_frac);
+
+	m = reg_frac & 0xffff;
+	n = (reg_frac >> 16) & 0xffff;
+
+	m = (reg_int & 0xffff) * n + m;
+	rate = (parent_rate * n) / m;
+
+	return rate;
+}
+
+static void audio_calc_reg(struct clk_zx_audio_divider *audio_div,
+			   struct zx_clk_audio_div_table *div_table,
+			   unsigned long rate, unsigned long parent_rate)
+{
+	unsigned int reg_int, reg_frac;
+	unsigned long m, n, div;
+
+	if (audio_div->table) {
+		const struct zx_clk_audio_div_table *divt = audio_div->table;
+
+		for (; divt->rate; divt++) {
+			if (divt->rate == rate) {
+				div_table->rate = divt->rate;
+				div_table->int_reg = divt->int_reg;
+				div_table->frac_reg = divt->frac_reg;
+				return;
+			}
+		}
+	}
+	if (audio_div->table)
+		pr_warn("cannot found the rate(%ld) in table, we will caculate the config\n",
+			rate);
+
+	reg_int = parent_rate / rate;
+
+	if (reg_int > CLK_AUDIO_DIV_INT_FRAC_MAX)
+		reg_int = CLK_AUDIO_DIV_INT_FRAC_MAX;
+	else if (reg_int < CLK_AUDIO_DIV_INT_FRAC_MIN)
+		reg_int = 0;
+	m = parent_rate - rate * reg_int;
+	n = rate;
+
+	div = gcd(m, n);
+	m = m / div;
+	n = n / div;
+
+	if ((m >> 16) || (n >> 16)) {
+		if (m > n) {
+			n = n * 0xffff / m;
+			m = 0xffff;
+		} else {
+			m = m * 0xffff / n;
+			n = 0xffff;
+		}
+	}
+	reg_frac = m | (n << 16);
+
+	div_table->rate = (ulong)(parent_rate * n) / ((ulong)reg_int * n + m);
+	div_table->int_reg = reg_int;
+	div_table->frac_reg = reg_frac;
+}
+
+static unsigned long zx_audio_div_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	struct clk_zx_audio_divider *zx_audio_div = to_clk_zx_audio_div(hw);
+	u32 reg_frac, reg_int;
+
+	reg_frac = readl_relaxed(zx_audio_div->reg_base);
+	reg_int = readl_relaxed(zx_audio_div->reg_base + 0x4);
+
+	return audio_calc_rate(zx_audio_div, reg_frac, reg_int, parent_rate);
+}
+
+static long zx_audio_div_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *prate)
+{
+	struct clk_zx_audio_divider *zx_audio_div = to_clk_zx_audio_div(hw);
+	struct zx_clk_audio_div_table divt;
+
+	audio_calc_reg(zx_audio_div, &divt, rate, *prate);
+
+	return audio_calc_rate(zx_audio_div, divt.frac_reg, divt.int_reg, *prate);
+}
+
+static int zx_audio_div_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate)
+{
+	struct clk_zx_audio_divider *zx_audio_div = to_clk_zx_audio_div(hw);
+	struct zx_clk_audio_div_table divt;
+	unsigned int val;
+
+	audio_calc_reg(zx_audio_div, &divt, rate, parent_rate);
+	if (divt.rate != rate)
+		pr_info("the real rate is:%ld", divt.rate);
+
+	writel_relaxed(divt.frac_reg, zx_audio_div->reg_base);
+
+	val = readl_relaxed(zx_audio_div->reg_base + 0x4);
+	val &= ~0xffff;
+	val |= divt.int_reg | CLK_AUDIO_DIV_INT_FRAC_RE;
+	writel_relaxed(val, zx_audio_div->reg_base + 0x4);
+
+	mdelay(1);
+
+	val = readl_relaxed(zx_audio_div->reg_base + 0x4);
+	val &= ~CLK_AUDIO_DIV_INT_FRAC_RE;
+	writel_relaxed(val, zx_audio_div->reg_base + 0x4);
+
+	return 0;
+}
+
+const struct clk_ops zx_audio_div_ops = {
+	.recalc_rate = zx_audio_div_recalc_rate,
+	.round_rate = zx_audio_div_round_rate,
+	.set_rate = zx_audio_div_set_rate,
+};
diff --git a/drivers/clk/zte/clk.h b/drivers/clk/zte/clk.h
index 0df3474b2cf3..6e7ccb752c24 100644
--- a/drivers/clk/zte/clk.h
+++ b/drivers/clk/zte/clk.h
@@ -153,6 +153,32 @@ struct zx_clk_div {
 	.id = _id,							\
 }
 
+struct zx_clk_audio_div_table {
+	unsigned long rate;
+	unsigned int int_reg;
+	unsigned int frac_reg;
+};
+
+struct clk_zx_audio_divider {
+	struct clk_hw				hw;
+	void __iomem				*reg_base;
+	const struct zx_clk_audio_div_table	*table;
+	unsigned int				rate_count;
+	spinlock_t				*lock;
+	u16					id;
+};
+
+#define AUDIO_DIV(_id, _name, _parent, _reg, _table)			\
+{									\
+	.reg_base	= (void __iomem *) _reg,			\
+	.lock		= &clk_lock,					\
+	.hw.init	= CLK_HW_INIT(_name,				\
+				      _parent,				\
+				      &zx_audio_div_ops,		\
+				      0),				\
+	.id = _id,							\
+}
+
 struct clk *clk_register_zx_pll(const char *name, const char *parent_name,
 	unsigned long flags, void __iomem *reg_base,
 	const struct zx_pll_config *lookup_table, int count, spinlock_t *lock);
@@ -167,4 +193,6 @@ struct clk *clk_register_zx_audio(const char *name,
 				  unsigned long flags, void __iomem *reg_base);
 
 extern const struct clk_ops zx_pll_ops;
+extern const struct clk_ops zx_audio_div_ops;
+
 #endif
-- 
1.9.1
