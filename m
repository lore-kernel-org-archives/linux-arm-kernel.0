From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 11 Mar 2017 22:00:19 +0200
Subject: [PATCH v3 3/5] phy: exynos-mipi-video: Use consistent method to
 address phy registers
In-Reply-To: <20170311200021.5827-1-krzk@kernel.org>
References: <20170311200021.5827-1-krzk@kernel.org>
Message-ID: <20170311200021.5827-4-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos4 MIPI phy registers are defined with macro calculating the offset
for given phyN.  Use the same method for Exynos5420 to be consistent.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/phy/phy-exynos-mipi-video.c         | 20 ++++++++++----------
 include/linux/soc/samsung/exynos-regs-pmu.h |  4 +---
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/phy-exynos-mipi-video.c b/drivers/phy/phy-exynos-mipi-video.c
index d7fe1f8c3ac8..acef1d92691e 100644
--- a/drivers/phy/phy-exynos-mipi-video.c
+++ b/drivers/phy/phy-exynos-mipi-video.c
@@ -110,46 +110,46 @@ static const struct mipi_phy_device_desc exynos5420_mipi_phy = {
 			/* EXYNOS_MIPI_PHY_ID_CSIS0 */
 			.coupled_phy_id = EXYNOS_MIPI_PHY_ID_DSIM0,
 			.enable_val = EXYNOS5_PHY_ENABLE,
-			.enable_reg = EXYNOS5420_MIPI_PHY0_CONTROL,
+			.enable_reg = EXYNOS5420_MIPI_PHY_CONTROL(0),
 			.enable_map = EXYNOS_MIPI_REGMAP_PMU,
 			.resetn_val = EXYNOS5_MIPI_PHY_S_RESETN,
-			.resetn_reg = EXYNOS5420_MIPI_PHY0_CONTROL,
+			.resetn_reg = EXYNOS5420_MIPI_PHY_CONTROL(0),
 			.resetn_map = EXYNOS_MIPI_REGMAP_PMU,
 		}, {
 			/* EXYNOS_MIPI_PHY_ID_DSIM0 */
 			.coupled_phy_id = EXYNOS_MIPI_PHY_ID_CSIS0,
 			.enable_val = EXYNOS5_PHY_ENABLE,
-			.enable_reg = EXYNOS5420_MIPI_PHY0_CONTROL,
+			.enable_reg = EXYNOS5420_MIPI_PHY_CONTROL(0),
 			.enable_map = EXYNOS_MIPI_REGMAP_PMU,
 			.resetn_val = EXYNOS5_MIPI_PHY_M_RESETN,
-			.resetn_reg = EXYNOS5420_MIPI_PHY0_CONTROL,
+			.resetn_reg = EXYNOS5420_MIPI_PHY_CONTROL(0),
 			.resetn_map = EXYNOS_MIPI_REGMAP_PMU,
 		}, {
 			/* EXYNOS_MIPI_PHY_ID_CSIS1 */
 			.coupled_phy_id = EXYNOS_MIPI_PHY_ID_DSIM1,
 			.enable_val = EXYNOS5_PHY_ENABLE,
-			.enable_reg = EXYNOS5420_MIPI_PHY1_CONTROL,
+			.enable_reg = EXYNOS5420_MIPI_PHY_CONTROL(1),
 			.enable_map = EXYNOS_MIPI_REGMAP_PMU,
 			.resetn_val = EXYNOS5_MIPI_PHY_S_RESETN,
-			.resetn_reg = EXYNOS5420_MIPI_PHY1_CONTROL,
+			.resetn_reg = EXYNOS5420_MIPI_PHY_CONTROL(1),
 			.resetn_map = EXYNOS_MIPI_REGMAP_PMU,
 		}, {
 			/* EXYNOS_MIPI_PHY_ID_DSIM1 */
 			.coupled_phy_id = EXYNOS_MIPI_PHY_ID_CSIS1,
 			.enable_val = EXYNOS5_PHY_ENABLE,
-			.enable_reg = EXYNOS5420_MIPI_PHY1_CONTROL,
+			.enable_reg = EXYNOS5420_MIPI_PHY_CONTROL(1),
 			.enable_map = EXYNOS_MIPI_REGMAP_PMU,
 			.resetn_val = EXYNOS5_MIPI_PHY_M_RESETN,
-			.resetn_reg = EXYNOS5420_MIPI_PHY1_CONTROL,
+			.resetn_reg = EXYNOS5420_MIPI_PHY_CONTROL(1),
 			.resetn_map = EXYNOS_MIPI_REGMAP_PMU,
 		}, {
 			/* EXYNOS_MIPI_PHY_ID_CSIS2 */
 			.coupled_phy_id = EXYNOS_MIPI_PHY_ID_NONE,
 			.enable_val = EXYNOS5_PHY_ENABLE,
-			.enable_reg = EXYNOS5420_MIPI_PHY2_CONTROL,
+			.enable_reg = EXYNOS5420_MIPI_PHY_CONTROL(2),
 			.enable_map = EXYNOS_MIPI_REGMAP_PMU,
 			.resetn_val = EXYNOS5_MIPI_PHY_S_RESETN,
-			.resetn_reg = EXYNOS5420_MIPI_PHY2_CONTROL,
+			.resetn_reg = EXYNOS5420_MIPI_PHY_CONTROL(2),
 			.resetn_map = EXYNOS_MIPI_REGMAP_PMU,
 		},
 	},
diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
index 4ee54b3fcd57..c261ed927e1e 100644
--- a/include/linux/soc/samsung/exynos-regs-pmu.h
+++ b/include/linux/soc/samsung/exynos-regs-pmu.h
@@ -505,9 +505,7 @@
 	((EXYNOS5420_KFC_CORE_RESET0 | EXYNOS5420_KFC_ETM_RESET0) << (_nr))
 
 #define EXYNOS5420_USBDRD1_PHY_CONTROL				0x0708
-#define EXYNOS5420_MIPI_PHY0_CONTROL				0x0714
-#define EXYNOS5420_MIPI_PHY1_CONTROL				0x0718
-#define EXYNOS5420_MIPI_PHY2_CONTROL				0x071C
+#define EXYNOS5420_MIPI_PHY_CONTROL(n)				(0x0714 + (n) * 4)
 #define EXYNOS5420_DPTX_PHY_CONTROL				0x0728
 #define EXYNOS5420_ARM_CORE2_SYS_PWR_REG			0x1020
 #define EXYNOS5420_DIS_IRQ_ARM_CORE2_LOCAL_SYS_PWR_REG		0x1024
-- 
2.9.3
