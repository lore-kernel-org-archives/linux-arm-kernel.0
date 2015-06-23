From: zyw@rock-chips.com (Chris Zhong)
Date: Tue, 23 Jun 2015 20:53:39 +0800
Subject: [PATCH v3 1/2] ARM: rockchip: add support holding 24Mhz osc during
 suspend
In-Reply-To: <1435064020-7057-1-git-send-email-zyw@rock-chips.com>
References: <1435064020-7057-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1435064020-7057-2-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we want to wake up system via usb, the 24Mhz osc could not be
disabled during suspend, read the usb phy SIDDQ bit to decide whether
to switch to 32khz clock-in.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

---

Changes in v3:
- Fixed commenting style
- Move the #define-s above the rk3288_slp_disable_osc function

 arch/arm/mach-rockchip/pm.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/pm.c b/arch/arm/mach-rockchip/pm.c
index b0dcbe2..9f862c4 100644
--- a/arch/arm/mach-rockchip/pm.c
+++ b/arch/arm/mach-rockchip/pm.c
@@ -45,6 +45,7 @@ static phys_addr_t rk3288_bootram_phy;
 
 static struct regmap *pmu_regmap;
 static struct regmap *sgrf_regmap;
+static struct regmap *grf_regmap;
 
 static u32 rk3288_pmu_pwr_mode_con;
 static u32 rk3288_sgrf_soc_con0;
@@ -66,9 +67,35 @@ static void rk3288_config_bootdata(void)
 	rkpm_bootdata_l2ctlr = rk3288_l2_config();
 }
 
+#define GRF_UOC0_CON0			0x320
+#define GRF_UOC1_CON0			0x334
+#define GRF_UOC2_CON0			0x348
+#define GRF_SIDDQ			BIT(13)
+
+static bool rk3288_slp_disable_osc(void)
+{
+	static const u32 reg_offset[] = { GRF_UOC0_CON0, GRF_UOC1_CON0,
+					  GRF_UOC2_CON0 };
+	u32 reg, i;
+
+	/*
+	 * if any usb phy is still on(GRF_SIDDQ==0), that means we need the
+	 * function of usb wakeup, so do not switch to 32khz, since the usb phy
+	 * clk does not connect to 32khz osc
+	 */
+	for (i = 0; i < ARRAY_SIZE(reg_offset); i++) {
+		regmap_read(grf_regmap, reg_offset[i], &reg);
+		if (!(reg & GRF_SIDDQ))
+			return false;
+	}
+
+	return true;
+}
+
 static void rk3288_slp_mode_set(int level)
 {
 	u32 mode_set, mode_set1;
+	bool osc_switch_to_32k = rk3288_slp_disable_osc();
 
 	regmap_read(sgrf_regmap, RK3288_SGRF_SOC_CON0, &rk3288_sgrf_soc_con0);
 
@@ -107,11 +134,13 @@ static void rk3288_slp_mode_set(int level)
 
 	if (level == ROCKCHIP_ARM_OFF_LOGIC_DEEP) {
 		/* arm off, logic deep sleep */
-		mode_set |= BIT(PMU_BUS_PD_EN) |
+		mode_set |= BIT(PMU_BUS_PD_EN) | BIT(PMU_PMU_USE_LF) |
 			    BIT(PMU_DDR1IO_RET_EN) | BIT(PMU_DDR0IO_RET_EN) |
-			    BIT(PMU_OSC_24M_DIS) | BIT(PMU_PMU_USE_LF) |
 			    BIT(PMU_ALIVE_USE_LF) | BIT(PMU_PLL_PD_EN);
 
+		if (osc_switch_to_32k)
+			mode_set |= BIT(PMU_OSC_24M_DIS);
+
 		mode_set1 |= BIT(PMU_CLR_ALIVE) | BIT(PMU_CLR_BUS) |
 			     BIT(PMU_CLR_PERI) | BIT(PMU_CLR_DMA);
 	} else {
@@ -193,6 +222,13 @@ static int rk3288_suspend_init(struct device_node *np)
 		return PTR_ERR(pmu_regmap);
 	}
 
+	grf_regmap = syscon_regmap_lookup_by_compatible(
+				"rockchip,rk3288-grf");
+	if (IS_ERR(grf_regmap)) {
+		pr_err("%s: could not find grf regmap\n", __func__);
+		return PTR_ERR(pmu_regmap);
+	}
+
 	sram_np = of_find_compatible_node(NULL, NULL,
 					  "rockchip,rk3288-pmu-sram");
 	if (!sram_np) {
-- 
1.9.1
