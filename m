From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue,  1 Mar 2016 18:07:37 +0800
Subject: [PATCH 1/5] clk: rockchip: add more mux parameters for new pll sources
In-Reply-To: <1456826861-7612-1-git-send-email-zhengxing@rock-chips.com>
References: <1456826861-7612-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1456826861-7612-2-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thers are only two parent PLLs that APLL and GPLL for core on the
previous SoCs (RK3066/RK3188/RK3288/RK3368). Hence, we set fixed
GPLL as alternate parent when core is switching freq.

Since RK3399 big.LITTLE architecture, we need to select and adapt
more PLLs (ALPLL/ABPLL/DPLL/GPLL) sources.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 drivers/clk/rockchip/clk-cpu.c    |   14 ++++++++++----
 drivers/clk/rockchip/clk-rk3036.c |    3 +++
 drivers/clk/rockchip/clk-rk3188.c |    6 ++++++
 drivers/clk/rockchip/clk-rk3228.c |    3 +++
 drivers/clk/rockchip/clk-rk3288.c |    3 +++
 drivers/clk/rockchip/clk-rk3368.c |    6 ++++++
 drivers/clk/rockchip/clk.h        |    6 ++++++
 7 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk-cpu.c b/drivers/clk/rockchip/clk-cpu.c
index 4e73ed5..5556849 100644
--- a/drivers/clk/rockchip/clk-cpu.c
+++ b/drivers/clk/rockchip/clk-cpu.c
@@ -158,12 +158,16 @@ static int rockchip_cpuclk_pre_rate_change(struct rockchip_cpuclk *cpuclk,
 
 		writel(HIWORD_UPDATE(alt_div, reg_data->div_core_mask,
 					      reg_data->div_core_shift) |
-		       HIWORD_UPDATE(1, 1, reg_data->mux_core_shift),
+		       HIWORD_UPDATE(reg_data->mux_core_alt,
+				     reg_data->mux_core_mask,
+				     reg_data->mux_core_shift),
 		       cpuclk->reg_base + reg_data->core_reg);
 	} else {
 		/* select alternate parent */
-		writel(HIWORD_UPDATE(1, 1, reg_data->mux_core_shift),
-			cpuclk->reg_base + reg_data->core_reg);
+		writel(HIWORD_UPDATE(reg_data->mux_core_alt,
+				     reg_data->mux_core_mask,
+				     reg_data->mux_core_shift),
+		       cpuclk->reg_base + reg_data->core_reg);
 	}
 
 	spin_unlock_irqrestore(cpuclk->lock, flags);
@@ -198,7 +202,9 @@ static int rockchip_cpuclk_post_rate_change(struct rockchip_cpuclk *cpuclk,
 
 	writel(HIWORD_UPDATE(0, reg_data->div_core_mask,
 				reg_data->div_core_shift) |
-	       HIWORD_UPDATE(0, 1, reg_data->mux_core_shift),
+	       HIWORD_UPDATE(reg_data->mux_core_main,
+				reg_data->mux_core_mask,
+				reg_data->mux_core_shift),
 	       cpuclk->reg_base + reg_data->core_reg);
 
 	if (ndata->old_rate > ndata->new_rate)
diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index 5759d75..1dae248 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -113,7 +113,10 @@ static const struct rockchip_cpuclk_reg_data rk3036_cpuclk_data = {
 	.core_reg = RK2928_CLKSEL_CON(0),
 	.div_core_shift = 0,
 	.div_core_mask = 0x1f,
+	.mux_core_alt = 1,
+	.mux_core_main = 0,
 	.mux_core_shift = 7,
+	.mux_core_mask = 0x1,
 };
 
 PNAME(mux_pll_p)		= { "xin24m", "xin24m" };
diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index 40bab39..e832403 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -155,7 +155,10 @@ static const struct rockchip_cpuclk_reg_data rk3066_cpuclk_data = {
 	.core_reg = RK2928_CLKSEL_CON(0),
 	.div_core_shift = 0,
 	.div_core_mask = 0x1f,
+	.mux_core_alt = 1,
+	.mux_core_main = 0,
 	.mux_core_shift = 8,
+	.mux_core_mask = 0x1,
 };
 
 #define RK3188_DIV_ACLK_CORE_MASK	0x7
@@ -191,7 +194,10 @@ static const struct rockchip_cpuclk_reg_data rk3188_cpuclk_data = {
 	.core_reg = RK2928_CLKSEL_CON(0),
 	.div_core_shift = 9,
 	.div_core_mask = 0x1f,
+	.mux_core_alt = 1,
+	.mux_core_main = 0,
 	.mux_core_shift = 8,
+	.mux_core_mask = 0x1,
 };
 
 PNAME(mux_pll_p)		= { "xin24m", "xin32k" };
diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
index c515915..55628b5 100644
--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -111,7 +111,10 @@ static const struct rockchip_cpuclk_reg_data rk3228_cpuclk_data = {
 	.core_reg = RK2928_CLKSEL_CON(0),
 	.div_core_shift = 0,
 	.div_core_mask = 0x1f,
+	.mux_core_alt = 1,
+	.mux_core_main = 0,
 	.mux_core_shift = 6,
+	.mux_core_mask = 0x1,
 };
 
 PNAME(mux_pll_p)		= { "clk_24m", "xin24m" };
diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 3cb7216..00faf3f 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -165,7 +165,10 @@ static const struct rockchip_cpuclk_reg_data rk3288_cpuclk_data = {
 	.core_reg = RK3288_CLKSEL_CON(0),
 	.div_core_shift = 8,
 	.div_core_mask = 0x1f,
+	.mux_core_alt = 1,
+	.mux_core_main = 0,
 	.mux_core_shift = 15,
+	.mux_core_mask = 0x1,
 };
 
 PNAME(mux_pll_p)		= { "xin24m", "xin32k" };
diff --git a/drivers/clk/rockchip/clk-rk3368.c b/drivers/clk/rockchip/clk-rk3368.c
index 31facd8..aaff724 100644
--- a/drivers/clk/rockchip/clk-rk3368.c
+++ b/drivers/clk/rockchip/clk-rk3368.c
@@ -165,14 +165,20 @@ static const struct rockchip_cpuclk_reg_data rk3368_cpuclkb_data = {
 	.core_reg = RK3368_CLKSEL_CON(0),
 	.div_core_shift = 0,
 	.div_core_mask = 0x1f,
+	.mux_core_alt = 1,
+	.mux_core_main = 0,
 	.mux_core_shift = 7,
+	.mux_core_mask = 0x1,
 };
 
 static const struct rockchip_cpuclk_reg_data rk3368_cpuclkl_data = {
 	.core_reg = RK3368_CLKSEL_CON(2),
 	.div_core_shift = 0,
+	.mux_core_alt = 1,
+	.mux_core_main = 0,
 	.div_core_mask = 0x1f,
 	.mux_core_shift = 7,
+	.mux_core_mask = 0x1,
 };
 
 #define RK3368_DIV_ACLKM_MASK		0x1f
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 39c198b..7aafe18 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -217,14 +217,20 @@ struct rockchip_cpuclk_rate_table {
  * @core_reg:		register offset of the core settings register
  * @div_core_shift:	core divider offset used to divide the pll value
  * @div_core_mask:	core divider mask
+ * @mux_core_alt:	mux value to select alternate parent
+ * @mux_core_main:	mux value to select main parent of core
  * @mux_core_shift:	offset of the core multiplexer
+ * @mux_core_mask:	core multiplexer mask
  */
 struct rockchip_cpuclk_reg_data {
 	int		core_reg;
 	u8		div_core_shift;
 	u32		div_core_mask;
 	int		mux_core_reg;
+	u8		mux_core_alt;
+	u8		mux_core_main;
 	u8		mux_core_shift;
+	u32		mux_core_mask;
 };
 
 struct clk *rockchip_clk_register_cpuclk(const char *name,
-- 
1.7.9.5
