From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Tue, 25 Jul 2017 15:16:36 +0800
Subject: [PATCH v1] clk: rockchip: rk3128: modify rk3128 clk driver to support
 rk3126
Message-ID: <1500966996-5660-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rk3128 and rk3126 have some gate registers describe differences.
So need to make some distinctions.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3128.c      | 59 +++++++++++++++++++++++++++++++---
 include/dt-bindings/clock/rk3128-cru.h |  3 ++
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3128.c b/drivers/clk/rockchip/clk-rk3128.c
index e243f2eae68f..0039b8940900 100644
--- a/drivers/clk/rockchip/clk-rk3128.c
+++ b/drivers/clk/rockchip/clk-rk3128.c
@@ -459,9 +459,8 @@ enum rk3128_plls {
 			RK2928_CLKSEL_CON(2), 14, 2, MFLAGS, 8, 5, DFLAGS,
 			RK2928_CLKGATE_CON(10), 15, GFLAGS),
 
-	COMPOSITE(SCLK_SFC, "sclk_sfc", mux_sclk_sfc_src_p, 0,
-			RK2928_CLKSEL_CON(11), 14, 2, MFLAGS, 8, 5, DFLAGS,
-			RK2928_CLKGATE_CON(3), 15, GFLAGS),
+	COMPOSITE_NOGATE(0, "sclk_sfc_src", mux_sclk_sfc_src_p, 0,
+			RK2928_CLKSEL_CON(11), 14, 2, MFLAGS, 8, 5, DFLAGS),
 
 	COMPOSITE_NOMUX(PCLK_PMU_PRE, "pclk_pmu_pre", "cpll", 0,
 			RK2928_CLKSEL_CON(29), 8, 6, DFLAGS,
@@ -495,7 +494,6 @@ enum rk3128_plls {
 	GATE(ACLK_DMAC, "aclk_dmac", "aclk_peri", 0, RK2928_CLKGATE_CON(5), 1, GFLAGS),
 	GATE(0, "aclk_peri_niu", "aclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(9), 15, GFLAGS),
 	GATE(0, "aclk_cpu_to_peri", "aclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(4), 2, GFLAGS),
-	GATE(HCLK_GPS, "hclk_gps", "aclk_peri", 0, RK2928_CLKGATE_CON(3), 14, GFLAGS),
 
 	GATE(HCLK_I2S_8CH, "hclk_i2s_8ch", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 4, GFLAGS),
 	GATE(0, "hclk_peri_matrix", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(4), 0, GFLAGS),
@@ -541,7 +539,6 @@ enum rk3128_plls {
 	GATE(0, "hclk_rom", "hclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(5), 6, GFLAGS),
 	GATE(HCLK_CRYPTO, "hclk_crypto", "hclk_cpu", 0, RK2928_CLKGATE_CON(3), 5, GFLAGS),
 
-	GATE(PCLK_HDMI, "pclk_hdmi", "pclk_cpu", 0, RK2928_CLKGATE_CON(3), 8, GFLAGS),
 	GATE(PCLK_ACODEC, "pclk_acodec", "pclk_cpu", 0, RK2928_CLKGATE_CON(5), 14, GFLAGS),
 	GATE(0, "pclk_ddrupctl", "pclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(5), 7, GFLAGS),
 	GATE(0, "pclk_grf", "pclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(5), 4, GFLAGS),
@@ -574,6 +571,7 @@ static void __init rk3128_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
 	void __iomem *reg_base;
+	struct clk *clk;
 
 	reg_base = of_iomap(np, 0);
 	if (!reg_base) {
@@ -593,6 +591,57 @@ static void __init rk3128_clk_init(struct device_node *np)
 				   RK3128_GRF_SOC_STATUS0);
 	rockchip_clk_register_branches(ctx, rk3128_clk_branches,
 				  ARRAY_SIZE(rk3128_clk_branches));
+
+	if (of_machine_is_compatible("rockchip,rk3128")) {
+		clk = clk_register_gate(NULL, "sclk_sfc", "sclk_sfc_src", 0,
+				ctx->reg_base + RK2928_CLKGATE_CON(3), 15, GFLAGS, &ctx->lock);
+		if (IS_ERR(clk))
+			pr_warn("%s: could not register clock sclk_sfc: %ld\n",
+				__func__, PTR_ERR(clk));
+		else
+			rockchip_clk_add_lookup(ctx, clk, SCLK_SFC);
+
+		clk = clk_register_gate(NULL, "hclk_gps", "aclk_peri", 0,
+				ctx->reg_base + RK2928_CLKGATE_CON(3), 14, GFLAGS, &ctx->lock);
+		if (IS_ERR(clk))
+			pr_warn("%s: could not register clock hclk_gps: %ld\n",
+				__func__, PTR_ERR(clk));
+		else
+			rockchip_clk_add_lookup(ctx, clk, HCLK_GPS);
+
+		clk = clk_register_gate(NULL, "pclk_hdmi", "pclk_cpu", 0,
+				ctx->reg_base + RK2928_CLKGATE_CON(3), 8, GFLAGS, &ctx->lock);
+		if (IS_ERR(clk))
+			pr_warn("%s: could not register clock pclk_hdmi: %ld\n",
+				__func__, PTR_ERR(clk));
+		else
+			rockchip_clk_add_lookup(ctx, clk, PCLK_HDMI);
+	} else {
+		clk = clk_register_gate(NULL, "pclk_stimer", "pclk_cpu", CLK_IGNORE_UNUSED,
+				ctx->reg_base + RK2928_CLKGATE_CON(3), 15, GFLAGS, &ctx->lock);
+		if (IS_ERR(clk))
+			pr_warn("%s: could not register clock pclk_stimer: %ld\n",
+				__func__, PTR_ERR(clk));
+		else
+			rockchip_clk_add_lookup(ctx, clk, PCLK_STIMER);
+
+		clk = clk_register_gate(NULL, "pclk_s_efuse", "pclk_cpu", CLK_IGNORE_UNUSED,
+				ctx->reg_base + RK2928_CLKGATE_CON(3), 14, GFLAGS, &ctx->lock);
+		if (IS_ERR(clk))
+			pr_warn("%s: could not register clock pclk_s_efuse: %ld\n",
+				__func__, PTR_ERR(clk));
+		else
+			rockchip_clk_add_lookup(ctx, clk, PCLK_S_EFUSE);
+
+		clk = clk_register_gate(NULL, "pclk_sgrf", "pclk_cpu", CLK_IGNORE_UNUSED,
+				ctx->reg_base + RK2928_CLKGATE_CON(3), 8, GFLAGS, &ctx->lock);
+		if (IS_ERR(clk))
+			pr_warn("%s: could not register clock pclk_sgrf: %ld\n",
+				__func__, PTR_ERR(clk));
+		else
+			rockchip_clk_add_lookup(ctx, clk, PCLK_SGRF);
+	}
+
 	rockchip_clk_protect_critical(rk3128_critical_clocks,
 				      ARRAY_SIZE(rk3128_critical_clocks));
 
diff --git a/include/dt-bindings/clock/rk3128-cru.h b/include/dt-bindings/clock/rk3128-cru.h
index 92894f4306cf..0451c9c42375 100644
--- a/include/dt-bindings/clock/rk3128-cru.h
+++ b/include/dt-bindings/clock/rk3128-cru.h
@@ -125,6 +125,9 @@
 #define PCLK_GMAC		367
 #define PCLK_PMU_PRE		368
 #define PCLK_SIM_CARD		369
+#define PCLK_STIMER		370
+#define PCLK_S_EFUSE		371
+#define PCLK_SGRF		372
 
 /* hclk gates */
 #define HCLK_SPDIF		440
-- 
1.9.1
