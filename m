From: zyw@rock-chips.com (Chris Zhong)
Date: Sun, 21 Jun 2015 17:44:38 +0800
Subject: [PATCH 1/2] ARM: rockchip: add support holding 24Mhz osc during
 suspend
In-Reply-To: <1434879879-25162-1-git-send-email-zyw@rock-chips.com>
References: <1434879879-25162-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1434879879-25162-2-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we want to wake up system via usb, the 24Mhz osc could not be
disabled during suspend, read the usb phy SIDDQ bit to decide whether
to switch to 32khz clock-in.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 arch/arm/mach-rockchip/pm.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-rockchip/pm.c b/arch/arm/mach-rockchip/pm.c
index b0dcbe2..6d32a82 100644
--- a/arch/arm/mach-rockchip/pm.c
+++ b/arch/arm/mach-rockchip/pm.c
@@ -29,6 +29,11 @@
 
 #include "pm.h"
 
+#define GRF_UOC0_CON0			0x320
+#define GRF_UOC1_CON0			0x334
+#define GRF_UOC2_CON0			0x348
+#define GRF_SIDDQ			BIT(13)
+
 /* These enum are option of low power mode */
 enum {
 	ROCKCHIP_ARM_OFF_LOGIC_NORMAL = 0,
@@ -45,6 +50,7 @@ static phys_addr_t rk3288_bootram_phy;
 
 static struct regmap *pmu_regmap;
 static struct regmap *sgrf_regmap;
+static struct regmap *grf_regmap;
 
 static u32 rk3288_pmu_pwr_mode_con;
 static u32 rk3288_sgrf_soc_con0;
@@ -66,9 +72,29 @@ static void rk3288_config_bootdata(void)
 	rkpm_bootdata_l2ctlr = rk3288_l2_config();
 }
 
+static bool rk3288_slp_disable_osc(void)
+{
+	static const u32 reg_offset[] = { GRF_UOC0_CON0, GRF_UOC1_CON0,
+					  GRF_UOC2_CON0 };
+	u32 reg, i;
+
+	/* if any usb phy is still on(GRF_SIDDQ==0), that means we need the
+	 * function of usb wakeup, so do not switch to 32khz, since the usb phy
+	 * clk does not connect to 32khz osc*/
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
-	u32 mode_set, mode_set1;
+	u32 mode_set, mode_set1, osc_switch_to_32k;
+
+	osc_switch_to_32k = rk3288_slp_disable_osc();
 
 	regmap_read(sgrf_regmap, RK3288_SGRF_SOC_CON0, &rk3288_sgrf_soc_con0);
 
@@ -107,11 +133,13 @@ static void rk3288_slp_mode_set(int level)
 
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
-- 
1.9.1
