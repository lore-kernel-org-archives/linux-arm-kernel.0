From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 05 Aug 2015 00:51:16 +0200
Subject: [PATCH v3 2/3] ARM: rockchip: set correct stabilization thresholds in
 suspend
In-Reply-To: <2128609.Kb18M8K28F@diego>
References: <2128609.Kb18M8K28F@diego>
Message-ID: <1709899.JJDRtF09u7@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the stabilization thresholds for the oscillator and external pmu
are statically set to 30ms based on a 32kHz clock rate. This leaves out the
case when we don't switch to the 32kHz clock when only entering the shallow
suspend mode where the logic keeps running.

So, set the correct threshold after we have determined if we switch to the
32kHz clock or stay with the 24MHz one. Also set the oscillator-
stabilization to 0 if it is kept running during suspend, as it of course
does not need to stabilize then.

Reported-by: Chris Zhong <zyw@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
changes since v2:
- describe 32kHz vs 24MHz
- don't wait for oscillator stabilization if it's still running,
  as explained by Chris Zhong in v2
changes since v1:
- 24MHz oriented threshold is only needed in shallow suspend, the deep
  suspend always switches to 32kHz and only leaves the 24MHz oscillator
  running if needed for stuff like usb wakeup

 arch/arm/mach-rockchip/pm.c | 22 +++++++++++++++++++---
 arch/arm/mach-rockchip/pm.h |  4 ----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-rockchip/pm.c b/arch/arm/mach-rockchip/pm.c
index 2ca1170..c11a30b 100644
--- a/arch/arm/mach-rockchip/pm.c
+++ b/arch/arm/mach-rockchip/pm.c
@@ -145,6 +145,19 @@ static void rk3288_slp_mode_set(int level)
 
 		mode_set1 |= BIT(PMU_CLR_ALIVE) | BIT(PMU_CLR_BUS) |
 			     BIT(PMU_CLR_PERI) | BIT(PMU_CLR_DMA);
+
+		/*
+		 * In deep suspend we use PMU_PMU_USE_LF to let the rk3288
+		 * switch its main clock supply to the alternative 32kHz
+		 * source. Therefore set 30ms on a 32kHz clock for pmic
+		 * stabilization. Similar 30ms on 24MHz for the other
+		 * mode below.
+		 */
+		regmap_write(pmu_regmap, RK3288_PMU_STABL_CNT, 32 * 30);
+
+		/* only wait for stabilization, if we turned the osc off */
+		regmap_write(pmu_regmap, RK3288_PMU_OSC_CNT,
+					 osc_disable ? 32 * 30 : 0);
 	} else {
 		/*
 		 * arm off, logic normal
@@ -152,6 +165,12 @@ static void rk3288_slp_mode_set(int level)
 		 * wakeup will be error
 		 */
 		mode_set |= BIT(PMU_CLK_CORE_SRC_GATE_EN);
+
+		/* 30ms on a 24MHz clock for pmic stabilization */
+		regmap_write(pmu_regmap, RK3288_PMU_STABL_CNT, 24000 * 30);
+
+		/* oscillator is still running, so no need to wait */
+		regmap_write(pmu_regmap, RK3288_PMU_OSC_CNT, 0);
 	}
 
 	regmap_write(pmu_regmap, RK3288_PMU_PWRMODE_CON, mode_set);
@@ -262,9 +281,6 @@ static int rk3288_suspend_init(struct device_node *np)
 	memcpy(rk3288_bootram_base, rockchip_slp_cpu_resume,
 	       rk3288_bootram_sz);
 
-	regmap_write(pmu_regmap, RK3288_PMU_OSC_CNT, OSC_STABL_CNT_THRESH);
-	regmap_write(pmu_regmap, RK3288_PMU_STABL_CNT, PMU_STABL_CNT_THRESH);
-
 	return 0;
 }
 
diff --git a/arch/arm/mach-rockchip/pm.h b/arch/arm/mach-rockchip/pm.h
index b6494c2..8a55ee2 100644
--- a/arch/arm/mach-rockchip/pm.h
+++ b/arch/arm/mach-rockchip/pm.h
@@ -62,10 +62,6 @@ static inline void rockchip_suspend_init(void)
 /* PMU_WAKEUP_CFG1 bits */
 #define PMU_ARMINT_WAKEUP_EN		BIT(0)
 
-/* wait 30ms for OSC stable and 30ms for pmic stable */
-#define OSC_STABL_CNT_THRESH	(32 * 30)
-#define PMU_STABL_CNT_THRESH	(32 * 30)
-
 enum rk3288_pwr_mode_con {
 	PMU_PWR_MODE_EN = 0,
 	PMU_CLK_CORE_SRC_GATE_EN,
-- 
2.1.4
