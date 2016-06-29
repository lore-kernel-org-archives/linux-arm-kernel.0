From: andi.shyti@gmail.com (andi.shyti at gmail.com)
Date: Wed, 29 Jun 2016 17:45:09 +0300
Subject: [PATCH v2 1/2] clk: clk-rk3*: set CLK_IS_CRITICAL flag to critical
 clocks
In-Reply-To: <1467211510-3485-1-git-send-email-andi@etezian.org>
References: <1467211510-3485-1-git-send-email-andi@etezian.org>
Message-ID: <1467211510-3485-2-git-send-email-andi@etezian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andi Shyti <andi@etezian.org>

Patch 32b9b1096 has introduced a generalized concept of critical
clock. Clocks are marked with the CLK_IS_CRITICAL, enabled during
boot and never gated.

Use the CLK_IS_CRITICAL instead of declaring a local array of
critical clock enabled during boot.

CC: Heiko Stuebner <heiko@sntech.de>
CC: Jeffy Chen <jeffy.chen@rock-chips.com>
CC: Xing Zheng <zhengxing@rock-chips.com>
Signed-off-by: Andi Shyti <andi@etezian.org>
---
 drivers/clk/rockchip/clk-rk3036.c | 17 ++-------
 drivers/clk/rockchip/clk-rk3188.c | 25 +++---------
 drivers/clk/rockchip/clk-rk3228.c | 17 ++-------
 drivers/clk/rockchip/clk-rk3288.c | 17 ++-------
 drivers/clk/rockchip/clk-rk3368.c | 21 ++--------
 drivers/clk/rockchip/clk-rk3399.c | 80 +++++++++++----------------------------
 6 files changed, 44 insertions(+), 133 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index 924f560..6dac3b3 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -205,7 +205,7 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
 	GATE(0, "gpll_cpu", "gpll", 0, RK2928_CLKGATE_CON(0), 1, GFLAGS),
 	COMPOSITE_NOGATE(0, "aclk_cpu_src", mux_busclk_p, 0,
 			RK2928_CLKSEL_CON(0), 14, 2, MFLAGS, 8, 5, DFLAGS),
-	GATE(ACLK_CPU, "aclk_cpu", "aclk_cpu_src", CLK_IGNORE_UNUSED,
+	GATE(ACLK_CPU, "aclk_cpu", "aclk_cpu_src", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(0), 3, GFLAGS),
 	COMPOSITE_NOMUX(PCLK_CPU, "pclk_cpu", "aclk_cpu_src", CLK_IGNORE_UNUSED,
 			RK2928_CLKSEL_CON(1), 12, 3, DFLAGS | CLK_DIVIDER_READ_ONLY,
@@ -218,15 +218,15 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(10), 14, 2, MFLAGS, 0, 5, DFLAGS,
 			RK2928_CLKGATE_CON(2), 0, GFLAGS),
 
-	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_src", 0,
+	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_src", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(2), 1, GFLAGS),
 	DIV(0, "pclk_peri_src", "aclk_peri_src", CLK_IGNORE_UNUSED,
 			RK2928_CLKSEL_CON(10), 12, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO),
-	GATE(PCLK_PERI, "pclk_peri", "pclk_peri_src", 0,
+	GATE(PCLK_PERI, "pclk_peri", "pclk_peri_src", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(2), 3, GFLAGS),
 	DIV(0, "hclk_peri_src", "aclk_peri_src", CLK_IGNORE_UNUSED,
 			RK2928_CLKSEL_CON(10), 8, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO),
-	GATE(HCLK_PERI, "hclk_peri", "hclk_peri_src", 0,
+	GATE(HCLK_PERI, "hclk_peri", "hclk_peri_src", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(2), 2, GFLAGS),
 
 	COMPOSITE_NODIV(SCLK_TIMER0, "sclk_timer0", mux_timer_p, CLK_IGNORE_UNUSED,
@@ -431,13 +431,6 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
 	GATE(PCLK_GPIO2, "pclk_gpio2", "pclk_peri", 0, RK2928_CLKGATE_CON(8), 11, GFLAGS),
 };
 
-static const char *const rk3036_critical_clocks[] __initconst = {
-	"aclk_cpu",
-	"aclk_peri",
-	"hclk_peri",
-	"pclk_peri",
-};
-
 static void __init rk3036_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
@@ -467,8 +460,6 @@ static void __init rk3036_clk_init(struct device_node *np)
 				   RK3036_GRF_SOC_STATUS0);
 	rockchip_clk_register_branches(ctx, rk3036_clk_branches,
 				  ARRAY_SIZE(rk3036_clk_branches));
-	rockchip_clk_protect_critical(rk3036_critical_clocks,
-				      ARRAY_SIZE(rk3036_critical_clocks));
 
 	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
 			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index d0e722a..ebbbf64 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -306,12 +306,12 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(26), 8, 1, MFLAGS, 0, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
 			RK2928_CLKGATE_CON(0), 2, GFLAGS),
 
-	GATE(0, "aclk_cpu", "aclk_cpu_pre", 0,
+	GATE(0, "aclk_cpu", "aclk_cpu_pre", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(0), 3, GFLAGS),
 
 	GATE(0, "atclk_cpu", "pclk_cpu_pre", 0,
 			RK2928_CLKGATE_CON(0), 6, GFLAGS),
-	GATE(0, "pclk_cpu", "pclk_cpu_pre", 0,
+	GATE(0, "pclk_cpu", "pclk_cpu_pre", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(0), 5, GFLAGS),
 	GATE(0, "hclk_cpu", "hclk_cpu_pre", CLK_IGNORE_UNUSED,
 			RK2928_CLKGATE_CON(0), 4, GFLAGS),
@@ -323,12 +323,12 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(31), 15, 1, MFLAGS, 8, 5, DFLAGS,
 			RK2928_CLKGATE_CON(1), 4, GFLAGS),
 
-	GATE(0, "aclk_peri", "aclk_peri_pre", 0,
+	GATE(0, "aclk_peri", "aclk_peri_pre", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(2), 1, GFLAGS),
-	COMPOSITE_NOMUX(0, "hclk_peri", "aclk_peri_pre", 0,
+	COMPOSITE_NOMUX(0, "hclk_peri", "aclk_peri_pre", CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(10), 8, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
 			RK2928_CLKGATE_CON(2), 2, GFLAGS),
-	COMPOSITE_NOMUX(0, "pclk_peri", "aclk_peri_pre", 0,
+	COMPOSITE_NOMUX(0, "pclk_peri", "aclk_peri_pre", CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(10), 12, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
 			RK2928_CLKGATE_CON(2), 3, GFLAGS),
 
@@ -458,7 +458,7 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 	GATE(HCLK_ROM, "hclk_rom", "hclk_cpu", 0, RK2928_CLKGATE_CON(5), 6, GFLAGS),
 	GATE(HCLK_I2S0, "hclk_i2s0", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 2, GFLAGS),
 	GATE(HCLK_SPDIF, "hclk_spdif", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 1, GFLAGS),
-	GATE(0, "hclk_cpubus", "hclk_cpu", 0, RK2928_CLKGATE_CON(4), 8, GFLAGS),
+	GATE(0, "hclk_cpubus", "hclk_cpu", CLK_IS_CRITICAL, RK2928_CLKGATE_CON(4), 8, GFLAGS),
 	/* hclk_ahb2apb is part of a clk branch */
 	GATE(0, "hclk_vio_bus", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 12, GFLAGS),
 	GATE(HCLK_LCDC0, "hclk_lcdc0", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 1, GFLAGS),
@@ -750,15 +750,6 @@ static struct rockchip_clk_branch rk3188_clk_branches[] __initdata = {
 	GATE(ACLK_GPS, "aclk_gps", "aclk_peri", 0, RK2928_CLKGATE_CON(8), 13, GFLAGS),
 };
 
-static const char *const rk3188_critical_clocks[] __initconst = {
-	"aclk_cpu",
-	"aclk_peri",
-	"hclk_peri",
-	"pclk_cpu",
-	"pclk_peri",
-	"hclk_cpubus"
-};
-
 static struct rockchip_clk_provider *__init rk3188_common_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
@@ -805,8 +796,6 @@ static void __init rk3066a_clk_init(struct device_node *np)
 			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
 			&rk3066_cpuclk_data, rk3066_cpuclk_rates,
 			ARRAY_SIZE(rk3066_cpuclk_rates));
-	rockchip_clk_protect_critical(rk3188_critical_clocks,
-				      ARRAY_SIZE(rk3188_critical_clocks));
 	rockchip_clk_of_add_provider(np, ctx);
 }
 CLK_OF_DECLARE(rk3066a_cru, "rockchip,rk3066a-cru", rk3066a_clk_init);
@@ -849,8 +838,6 @@ static void __init rk3188a_clk_init(struct device_node *np)
 			__func__);
 	}
 
-	rockchip_clk_protect_critical(rk3188_critical_clocks,
-				      ARRAY_SIZE(rk3188_critical_clocks));
 	rockchip_clk_of_add_provider(np, ctx);
 }
 CLK_OF_DECLARE(rk3188a_cru, "rockchip,rk3188a-cru", rk3188a_clk_init);
diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
index 016bdb0..d60159d 100644
--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -224,7 +224,7 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 			RK2928_CLKGATE_CON(0), 1, GFLAGS),
 	COMPOSITE_NOGATE(0, "aclk_cpu_src", mux_aclk_cpu_src_p, 0,
 			RK2928_CLKSEL_CON(0), 13, 2, MFLAGS, 8, 5, DFLAGS),
-	GATE(ARMCLK, "aclk_cpu", "aclk_cpu_src", 0,
+	GATE(ARMCLK, "aclk_cpu", "aclk_cpu_src", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(6), 0, GFLAGS),
 	COMPOSITE_NOMUX(0, "hclk_cpu", "aclk_cpu_src", 0,
 			RK2928_CLKSEL_CON(1), 8, 2, DFLAGS,
@@ -304,13 +304,13 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 			RK2928_CLKGATE_CON(2), 0, GFLAGS),
 	COMPOSITE_NOGATE(0, "aclk_peri_src", mux_aclk_peri_src_p, 0,
 			RK2928_CLKSEL_CON(10), 10, 2, MFLAGS, 0, 5, DFLAGS),
-	COMPOSITE_NOMUX(PCLK_PERI, "pclk_peri", "aclk_peri_src", 0,
+	COMPOSITE_NOMUX(PCLK_PERI, "pclk_peri", "aclk_peri_src", CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(10), 12, 3, DFLAGS,
 			RK2928_CLKGATE_CON(5), 2, GFLAGS),
-	COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "aclk_peri_src", 0,
+	COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "aclk_peri_src", CLK_IS_CRITICAL,
 			RK2928_CLKSEL_CON(10), 8, 2, DFLAGS,
 			RK2928_CLKGATE_CON(5), 1, GFLAGS),
-	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_src", 0,
+	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_src", CLK_IS_CRITICAL,
 			RK2928_CLKGATE_CON(5), 0, GFLAGS),
 
 	GATE(SCLK_TIMER0, "sclk_timer0", "xin24m", 0,
@@ -619,13 +619,6 @@ static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
 	MMC(SCLK_EMMC_SAMPLE,  "emmc_sample",  "sclk_emmc",  RK3228_EMMC_CON1,  0),
 };
 
-static const char *const rk3228_critical_clocks[] __initconst = {
-	"aclk_cpu",
-	"aclk_peri",
-	"hclk_peri",
-	"pclk_peri",
-};
-
 static void __init rk3228_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
@@ -649,8 +642,6 @@ static void __init rk3228_clk_init(struct device_node *np)
 				   RK3228_GRF_SOC_STATUS0);
 	rockchip_clk_register_branches(ctx, rk3228_clk_branches,
 				  ARRAY_SIZE(rk3228_clk_branches));
-	rockchip_clk_protect_critical(rk3228_critical_clocks,
-				      ARRAY_SIZE(rk3228_critical_clocks));
 
 	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
 			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 39af05a..d4864be 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -320,7 +320,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 			RK3288_CLKSEL_CON(1), 15, 1, MFLAGS, 3, 5, DFLAGS),
 	DIV(0, "aclk_cpu_pre", "aclk_cpu_src", CLK_SET_RATE_PARENT,
 			RK3288_CLKSEL_CON(1), 0, 3, DFLAGS),
-	GATE(ACLK_CPU, "aclk_cpu", "aclk_cpu_pre", CLK_IGNORE_UNUSED,
+	GATE(ACLK_CPU, "aclk_cpu", "aclk_cpu_pre", CLK_IS_CRITICAL,
 			RK3288_CLKGATE_CON(0), 3, GFLAGS),
 	COMPOSITE_NOMUX(PCLK_CPU, "pclk_cpu", "aclk_cpu_pre", CLK_IGNORE_UNUSED,
 			RK3288_CLKSEL_CON(1), 12, 3, DFLAGS,
@@ -474,7 +474,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 
 	DIV(0, "pclk_pd_alive", "gpll", 0,
 			RK3288_CLKSEL_CON(33), 8, 5, DFLAGS),
-	COMPOSITE_NOMUX(0, "pclk_pd_pmu", "gpll", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(0, "pclk_pd_pmu", "gpll", CLK_IS_CRITICAL,
 			RK3288_CLKSEL_CON(33), 0, 5, DFLAGS,
 			RK3288_CLKGATE_CON(5), 8, GFLAGS),
 
@@ -488,10 +488,10 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	COMPOSITE_NOMUX(PCLK_PERI, "pclk_peri", "aclk_peri_src", 0,
 			RK3288_CLKSEL_CON(10), 12, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
 			RK3288_CLKGATE_CON(2), 3, GFLAGS),
-	COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "aclk_peri_src", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "aclk_peri_src", CLK_IS_CRITICAL,
 			RK3288_CLKSEL_CON(10), 8, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
 			RK3288_CLKGATE_CON(2), 2, GFLAGS),
-	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_src", CLK_IGNORE_UNUSED,
+	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_src", CLK_IS_CRITICAL,
 			RK3288_CLKGATE_CON(2), 1, GFLAGS),
 
 	/*
@@ -805,13 +805,6 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	INVERTER(0, "pclk_isp", "pclk_isp_in", RK3288_CLKSEL_CON(29), 3, IFLAGS),
 };
 
-static const char *const rk3288_critical_clocks[] __initconst = {
-	"aclk_cpu",
-	"aclk_peri",
-	"hclk_peri",
-	"pclk_pd_pmu",
-};
-
 static void __iomem *rk3288_cru_base;
 
 /*
@@ -910,8 +903,6 @@ static void __init rk3288_clk_init(struct device_node *np)
 				   RK3288_GRF_SOC_STATUS1);
 	rockchip_clk_register_branches(ctx, rk3288_clk_branches,
 				  ARRAY_SIZE(rk3288_clk_branches));
-	rockchip_clk_protect_critical(rk3288_critical_clocks,
-				      ARRAY_SIZE(rk3288_critical_clocks));
 
 	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
 			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
diff --git a/drivers/clk/rockchip/clk-rk3368.c b/drivers/clk/rockchip/clk-rk3368.c
index 6cb474c..a07b8f9 100644
--- a/drivers/clk/rockchip/clk-rk3368.c
+++ b/drivers/clk/rockchip/clk-rk3368.c
@@ -347,7 +347,7 @@ static struct rockchip_clk_branch rk3368_clk_branches[] __initdata = {
 	COMPOSITE_NOGATE(0, "aclk_bus_src", mux_aclk_bus_src_p, CLK_IGNORE_UNUSED,
 			RK3368_CLKSEL_CON(8), 7, 1, MFLAGS, 0, 5, DFLAGS),
 
-	GATE(ACLK_BUS, "aclk_bus", "aclk_bus_src", CLK_IGNORE_UNUSED,
+	GATE(ACLK_BUS, "aclk_bus", "aclk_bus_src", CLK_IS_CRITICAL,
 			RK3368_CLKGATE_CON(1), 0, GFLAGS),
 	COMPOSITE_NOMUX(PCLK_BUS, "pclk_bus", "aclk_bus_src", CLK_IGNORE_UNUSED,
 			RK3368_CLKSEL_CON(8), 12, 3, DFLAGS,
@@ -501,7 +501,7 @@ static struct rockchip_clk_branch rk3368_clk_branches[] __initdata = {
 
 	/* sclk_timer has a gate in the sgrf */
 
-	COMPOSITE_NOMUX(0, "pclk_pd_pmu", "gpll", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(0, "pclk_pd_pmu", "gpll", CLK_IS_CRITICAL,
 			RK3368_CLKSEL_CON(10), 0, 5, DFLAGS,
 			RK3368_CLKGATE_CON(7), 9, GFLAGS),
 	GATE(SCLK_PVTM_PMU, "sclk_pvtm_pmu", "xin24m", 0,
@@ -529,7 +529,7 @@ static struct rockchip_clk_branch rk3368_clk_branches[] __initdata = {
 	COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "aclk_peri_src", CLK_IGNORE_UNUSED,
 			RK3368_CLKSEL_CON(9), 8, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
 			RK3368_CLKGATE_CON(3), 2, GFLAGS),
-	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_src", CLK_IGNORE_UNUSED,
+	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_src", CLK_IS_CRITICAL,
 			RK3368_CLKGATE_CON(3), 1, GFLAGS),
 
 	GATE(0, "sclk_mipidsi_24m", "xin24m", 0, RK3368_CLKGATE_CON(4), 14, GFLAGS),
@@ -709,7 +709,7 @@ static struct rockchip_clk_branch rk3368_clk_branches[] __initdata = {
 	GATE(PCLK_MAILBOX, "pclk_mailbox", "pclk_bus", 0, RK3368_CLKGATE_CON(12), 1, GFLAGS),
 	GATE(PCLK_PWM0, "pclk_pwm0", "pclk_bus", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(12), 0, GFLAGS),
 	GATE(PCLK_SIM, "pclk_sim", "pclk_bus", 0, RK3368_CLKGATE_CON(13), 8, GFLAGS),
-	GATE(PCLK_PWM1, "pclk_pwm1", "pclk_bus", 0, RK3368_CLKGATE_CON(13), 6, GFLAGS),
+	GATE(PCLK_PWM1, "pclk_pwm1", "pclk_bus", CLK_IS_CRITICAL, RK3368_CLKGATE_CON(13), 6, GFLAGS),
 	GATE(PCLK_UART2, "pclk_uart2", "pclk_bus", 0, RK3368_CLKGATE_CON(13), 5, GFLAGS),
 	GATE(0, "pclk_efuse_256", "pclk_bus", 0, RK3368_CLKGATE_CON(13), 1, GFLAGS),
 	GATE(0, "pclk_efuse_1024", "pclk_bus", 0, RK3368_CLKGATE_CON(13), 0, GFLAGS),
@@ -849,17 +849,6 @@ static struct rockchip_clk_branch rk3368_clk_branches[] __initdata = {
 	GATE(0, "sclk_timer00", "xin24m", CLK_IGNORE_UNUSED, RK3368_CLKGATE_CON(24), 0, GFLAGS),
 };
 
-static const char *const rk3368_critical_clocks[] __initconst = {
-	"aclk_bus",
-	"aclk_peri",
-	/*
-	 * pwm1 supplies vdd_logic on a lot of boards, is currently unhandled
-	 * but needs to stay enabled there (including its parents) at all times.
-	 */
-	"pclk_pwm1",
-	"pclk_pd_pmu",
-};
-
 static void __init rk3368_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
@@ -892,8 +881,6 @@ static void __init rk3368_clk_init(struct device_node *np)
 				   RK3368_GRF_SOC_STATUS0);
 	rockchip_clk_register_branches(ctx, rk3368_clk_branches,
 				  ARRAY_SIZE(rk3368_clk_branches));
-	rockchip_clk_protect_critical(rk3368_critical_clocks,
-				      ARRAY_SIZE(rk3368_critical_clocks));
 
 	rockchip_clk_register_armclk(ctx, ARMCLKB, "armclkb",
 			mux_armclkb_p, ARRAY_SIZE(mux_armclkb_p),
diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 291543f..5070b85 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -692,7 +692,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	GATE(0, "vpll_aclk_cci_src", "vpll", CLK_IGNORE_UNUSED,
 			RK3399_CLKGATE_CON(2), 3, GFLAGS),
 
-	COMPOSITE(0, "aclk_cci_pre", mux_aclk_cci_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(0, "aclk_cci_pre", mux_aclk_cci_p, CLK_IS_CRITICAL,
 			RK3399_CLKSEL_CON(5), 6, 2, MFLAGS, 0, 5, DFLAGS,
 			RK3399_CLKGATE_CON(2), 4, GFLAGS),
 
@@ -834,15 +834,15 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	/* perihp */
 	GATE(0, "cpll_aclk_perihp_src", "gpll", CLK_IGNORE_UNUSED,
 			RK3399_CLKGATE_CON(5), 0, GFLAGS),
-	GATE(0, "gpll_aclk_perihp_src", "cpll", CLK_IGNORE_UNUSED,
+	GATE(0, "gpll_aclk_perihp_src", "cpll", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(5), 1, GFLAGS),
-	COMPOSITE(ACLK_PERIHP, "aclk_perihp", mux_aclk_perihp_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(ACLK_PERIHP, "aclk_perihp", mux_aclk_perihp_p, CLK_IS_CRITICAL,
 			RK3399_CLKSEL_CON(14), 7, 1, MFLAGS, 0, 5, DFLAGS,
 			RK3399_CLKGATE_CON(5), 2, GFLAGS),
-	COMPOSITE_NOMUX(HCLK_PERIHP, "hclk_perihp", "aclk_perihp", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(HCLK_PERIHP, "hclk_perihp", "aclk_perihp", CLK_IS_CRITICAL,
 			RK3399_CLKSEL_CON(14), 8, 2, DFLAGS,
 			RK3399_CLKGATE_CON(5), 3, GFLAGS),
-	COMPOSITE_NOMUX(PCLK_PERIHP, "pclk_perihp", "aclk_perihp", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(PCLK_PERIHP, "pclk_perihp", "aclk_perihp", CLK_IS_CRITICAL,
 			RK3399_CLKSEL_CON(14), 12, 2, DFLAGS,
 			RK3399_CLKGATE_CON(5), 4, GFLAGS),
 
@@ -850,7 +850,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKGATE_CON(20), 2, GFLAGS),
 	GATE(ACLK_PCIE, "aclk_pcie", "aclk_perihp", CLK_IGNORE_UNUSED,
 			RK3399_CLKGATE_CON(20), 10, GFLAGS),
-	GATE(0, "aclk_perihp_noc", "aclk_perihp", CLK_IGNORE_UNUSED,
+	GATE(0, "aclk_perihp_noc", "aclk_perihp", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(20), 12, GFLAGS),
 
 	GATE(HCLK_HOST0, "hclk_host0", "hclk_perihp", 0,
@@ -872,7 +872,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKGATE_CON(20), 4, GFLAGS),
 	GATE(PCLK_PCIE, "pclk_pcie", "pclk_perihp", 0,
 			RK3399_CLKGATE_CON(20), 11, GFLAGS),
-	GATE(0, "pclk_perihp_noc", "pclk_perihp", CLK_IGNORE_UNUSED,
+	GATE(0, "pclk_perihp_noc", "pclk_perihp", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(20), 14, GFLAGS),
 	GATE(PCLK_HSICPHY, "pclk_hsicphy", "pclk_perihp", 0,
 			RK3399_CLKGATE_CON(31), 8, GFLAGS),
@@ -938,15 +938,15 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	/* perilp0 */
 	GATE(0, "cpll_aclk_perilp0_src", "cpll", CLK_IGNORE_UNUSED,
 			RK3399_CLKGATE_CON(7), 1, GFLAGS),
-	GATE(0, "gpll_aclk_perilp0_src", "gpll", CLK_IGNORE_UNUSED,
+	GATE(0, "gpll_aclk_perilp0_src", "gpll", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(7), 0, GFLAGS),
-	COMPOSITE(ACLK_PERILP0, "aclk_perilp0", mux_aclk_perilp0_p, CLK_IGNORE_UNUSED,
+	COMPOSITE(ACLK_PERILP0, "aclk_perilp0", mux_aclk_perilp0_p, CLK_IS_CRITICAL,
 			RK3399_CLKSEL_CON(23), 7, 1, MFLAGS, 0, 5, DFLAGS,
 			RK3399_CLKGATE_CON(7), 2, GFLAGS),
-	COMPOSITE_NOMUX(HCLK_PERILP0, "hclk_perilp0", "aclk_perilp0", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(HCLK_PERILP0, "hclk_perilp0", "aclk_perilp0", CLK_IS_CRITICAL,
 			RK3399_CLKSEL_CON(23), 8, 2, DFLAGS,
 			RK3399_CLKGATE_CON(7), 3, GFLAGS),
-	COMPOSITE_NOMUX(PCLK_PERILP0, "pclk_perilp0", "aclk_perilp0", 0,
+	COMPOSITE_NOMUX(PCLK_PERILP0, "pclk_perilp0", "aclk_perilp0", CLK_IS_CRITICAL,
 			RK3399_CLKSEL_CON(23), 12, 3, DFLAGS,
 			RK3399_CLKGATE_CON(7), 4, GFLAGS),
 
@@ -960,9 +960,9 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	GATE(SCLK_INTMEM4, "clk_intmem4", "aclk_perilp0", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(23), 6, GFLAGS),
 	GATE(SCLK_INTMEM5, "clk_intmem5", "aclk_perilp0", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(23), 7, GFLAGS),
 	GATE(ACLK_DCF, "aclk_dcf", "aclk_perilp0", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(23), 8, GFLAGS),
-	GATE(ACLK_DMAC0_PERILP, "aclk_dmac0_perilp", "aclk_perilp0", 0, RK3399_CLKGATE_CON(25), 5, GFLAGS),
+	GATE(ACLK_DMAC0_PERILP, "aclk_dmac0_perilp", "aclk_perilp0", CLK_IS_CRITICAL, RK3399_CLKGATE_CON(25), 5, GFLAGS),
 	GATE(ACLK_DMAC1_PERILP, "aclk_dmac1_perilp", "aclk_perilp0", 0, RK3399_CLKGATE_CON(25), 6, GFLAGS),
-	GATE(ACLK_PERILP0_NOC, "aclk_perilp0_noc", "aclk_perilp0", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(25), 7, GFLAGS),
+	GATE(ACLK_PERILP0_NOC, "aclk_perilp0_noc", "aclk_perilp0", CLK_IS_CRITICAL, RK3399_CLKGATE_CON(25), 7, GFLAGS),
 
 	/* hclk_perilp0 gates */
 	GATE(HCLK_ROM, "hclk_rom", "hclk_perilp0", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(24), 4, GFLAGS),
@@ -970,7 +970,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	GATE(HCLK_S_CRYPTO0, "hclk_s_crypto0", "hclk_perilp0", 0, RK3399_CLKGATE_CON(24), 6, GFLAGS),
 	GATE(HCLK_M_CRYPTO1, "hclk_m_crypto1", "hclk_perilp0", 0, RK3399_CLKGATE_CON(24), 14, GFLAGS),
 	GATE(HCLK_S_CRYPTO1, "hclk_s_crypto1", "hclk_perilp0", 0, RK3399_CLKGATE_CON(24), 15, GFLAGS),
-	GATE(HCLK_PERILP0_NOC, "hclk_perilp0_noc", "hclk_perilp0", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(25), 8, GFLAGS),
+	GATE(HCLK_PERILP0_NOC, "hclk_perilp0_noc", "hclk_perilp0", CLK_IS_CRITICAL, RK3399_CLKGATE_CON(25), 8, GFLAGS),
 
 	/* pclk_perilp0 gates */
 	GATE(PCLK_DCF, "pclk_dcf", "pclk_perilp0", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(23), 9, GFLAGS),
@@ -1003,16 +1003,16 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	/* perilp1 */
 	GATE(0, "cpll_hclk_perilp1_src", "cpll", CLK_IGNORE_UNUSED,
 			RK3399_CLKGATE_CON(8), 1, GFLAGS),
-	GATE(0, "gpll_hclk_perilp1_src", "gpll", CLK_IGNORE_UNUSED,
+	GATE(0, "gpll_hclk_perilp1_src", "gpll", CLK_IS_CRITICAL,
 			RK3399_CLKGATE_CON(8), 0, GFLAGS),
-	COMPOSITE_NOGATE(HCLK_PERILP1, "hclk_perilp1", mux_hclk_perilp1_p, CLK_IGNORE_UNUSED,
+	COMPOSITE_NOGATE(HCLK_PERILP1, "hclk_perilp1", mux_hclk_perilp1_p, CLK_IS_CRITICAL,
 			RK3399_CLKSEL_CON(25), 7, 1, MFLAGS, 0, 5, DFLAGS),
-	COMPOSITE_NOMUX(PCLK_PERILP1, "pclk_perilp1", "hclk_perilp1", CLK_IGNORE_UNUSED,
+	COMPOSITE_NOMUX(PCLK_PERILP1, "pclk_perilp1", "hclk_perilp1", CLK_IS_CRITICAL,
 			RK3399_CLKSEL_CON(25), 8, 3, DFLAGS,
 			RK3399_CLKGATE_CON(8), 2, GFLAGS),
 
 	/* hclk_perilp1 gates */
-	GATE(0, "hclk_perilp1_noc", "hclk_perilp1", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(25), 9, GFLAGS),
+	GATE(0, "hclk_perilp1_noc", "hclk_perilp1", CLK_IS_CRITICAL | CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(25), 9, GFLAGS),
 	GATE(0, "hclk_sdio_noc", "hclk_perilp1", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(25), 12, GFLAGS),
 	GATE(HCLK_I2S0_8CH, "hclk_i2s0", "hclk_perilp1", 0, RK3399_CLKGATE_CON(34), 0, GFLAGS),
 	GATE(HCLK_I2S1_8CH, "hclk_i2s1", "hclk_perilp1", 0, RK3399_CLKGATE_CON(34), 1, GFLAGS),
@@ -1043,7 +1043,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	GATE(PCLK_SPI2, "pclk_spi2", "pclk_perilp1", 0, RK3399_CLKGATE_CON(23), 12, GFLAGS),
 	GATE(PCLK_SPI4, "pclk_spi4", "pclk_perilp1", 0, RK3399_CLKGATE_CON(23), 13, GFLAGS),
 	GATE(PCLK_PERIHP_GRF, "pclk_perilp_sgrf", "pclk_perilp1", 0, RK3399_CLKGATE_CON(24), 13, GFLAGS),
-	GATE(0, "pclk_perilp1_noc", "pclk_perilp1", 0, RK3399_CLKGATE_CON(25), 10, GFLAGS),
+	GATE(0, "pclk_perilp1_noc", "pclk_perilp1", CLK_IS_CRITICAL, RK3399_CLKGATE_CON(25), 10, GFLAGS),
 
 	/* saradc */
 	COMPOSITE_NOMUX(SCLK_SARADC, "clk_saradc", "xin24m", 0,
@@ -1387,7 +1387,7 @@ static struct rockchip_clk_branch rk3399_clk_pmu_branches[] __initdata = {
 	GATE(0, "fclk_cm0s_pmu_ppll_src", "ppll", 0,
 			RK3399_PMU_CLKGATE_CON(0), 1, GFLAGS),
 
-	COMPOSITE_NOGATE(FCLK_CM0S_SRC_PMU, "fclk_cm0s_src_pmu", mux_fclk_cm0s_pmu_ppll_p, 0,
+	COMPOSITE_NOGATE(FCLK_CM0S_SRC_PMU, "fclk_cm0s_src_pmu", mux_fclk_cm0s_pmu_ppll_p, CLK_IS_CRITICAL,
 			RK3399_PMU_CLKSEL_CON(0), 15, 1, MFLAGS, 8, 5, DFLAGS),
 
 	COMPOSITE(SCLK_SPI3_PMU, "clk_spi3_pmu", mux_24m_ppll_p, 0,
@@ -1402,7 +1402,7 @@ static struct rockchip_clk_branch rk3399_clk_pmu_branches[] __initdata = {
 			RK3399_PMU_CLKSEL_CON(7), 0,
 			&rk3399_pmuclk_wifi_fracmux),
 
-	MUX(0, "clk_timer_src_pmu", mux_pll_p, CLK_IGNORE_UNUSED,
+	MUX(0, "clk_timer_src_pmu", mux_pll_p, CLK_IS_CRITICAL,
 			RK3399_PMU_CLKSEL_CON(1), 15, 1, MFLAGS),
 
 	COMPOSITE_NOMUX(SCLK_I2C0_PMU, "clk_i2c0_pmu", "ppll", 0,
@@ -1431,7 +1431,7 @@ static struct rockchip_clk_branch rk3399_clk_pmu_branches[] __initdata = {
 			RK3399_PMU_CLKGATE_CON(0), 6, GFLAGS,
 			&rk3399_uart4_pmu_fracmux),
 
-	DIV(PCLK_SRC_PMU, "pclk_pmu_src", "ppll", CLK_IGNORE_UNUSED,
+	DIV(PCLK_SRC_PMU, "pclk_pmu_src", "ppll", CLK_IS_CRITICAL,
 			RK3399_PMU_CLKSEL_CON(0), 0, 5, DFLAGS),
 
 	/* pmu clock gates */
@@ -1464,36 +1464,6 @@ static struct rockchip_clk_branch rk3399_clk_pmu_branches[] __initdata = {
 	GATE(HCLK_NOC_PMU, "hclk_noc_pmu", "fclk_cm0s_src_pmu", CLK_IGNORE_UNUSED, RK3399_PMU_CLKGATE_CON(2), 5, GFLAGS),
 };
 
-static const char *const rk3399_cru_critical_clocks[] __initconst = {
-	"aclk_cci_pre",
-	"pclk_perilp0",
-	"pclk_perilp0",
-	"hclk_perilp0",
-	"hclk_perilp0_noc",
-	"pclk_perilp1",
-	"pclk_perilp1_noc",
-	"pclk_perihp",
-	"pclk_perihp_noc",
-	"hclk_perihp",
-	"aclk_perihp",
-	"aclk_perihp_noc",
-	"aclk_perilp0",
-	"aclk_perilp0_noc",
-	"hclk_perilp1",
-	"hclk_perilp1_noc",
-	"aclk_dmac0_perilp",
-	"gpll_hclk_perilp1_src",
-	"gpll_aclk_perilp0_src",
-	"gpll_aclk_perihp_src",
-};
-
-static const char *const rk3399_pmucru_critical_clocks[] __initconst = {
-	"ppll",
-	"pclk_pmu_src",
-	"fclk_cm0s_src_pmu",
-	"clk_timer_src_pmu",
-};
-
 static void __init rk3399_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
@@ -1517,9 +1487,6 @@ static void __init rk3399_clk_init(struct device_node *np)
 	rockchip_clk_register_branches(ctx, rk3399_clk_branches,
 				  ARRAY_SIZE(rk3399_clk_branches));
 
-	rockchip_clk_protect_critical(rk3399_cru_critical_clocks,
-				      ARRAY_SIZE(rk3399_cru_critical_clocks));
-
 	rockchip_clk_register_armclk(ctx, ARMCLKL, "armclkl",
 			mux_armclkl_p, ARRAY_SIZE(mux_armclkl_p),
 			&rk3399_cpuclkl_data, rk3399_cpuclkl_rates,
@@ -1562,9 +1529,6 @@ static void __init rk3399_pmu_clk_init(struct device_node *np)
 	rockchip_clk_register_branches(ctx, rk3399_clk_pmu_branches,
 				  ARRAY_SIZE(rk3399_clk_pmu_branches));
 
-	rockchip_clk_protect_critical(rk3399_pmucru_critical_clocks,
-				  ARRAY_SIZE(rk3399_pmucru_critical_clocks));
-
 	rockchip_register_softrst(np, 2, reg_base + RK3399_PMU_SOFTRST_CON(0),
 				  ROCKCHIP_SOFTRST_HIWORD_MASK);
 
-- 
2.8.1
