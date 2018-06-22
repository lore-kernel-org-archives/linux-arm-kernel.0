From: Anson.Huang@nxp.com (Anson Huang)
Date: Fri, 22 Jun 2018 13:32:48 +0800
Subject: [PATCH] ARM: imx: enable bus auto clock gating function for i.mx6sll
Message-ID: <1529645568-3786-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6SLL has HW bus auto clock gating function, enable
it by default to save VDD_SOC_IN power, about 5% ~ 20%
saved depends on different use cases.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/pm-imx6.c                 | 11 +++++++++--
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |  3 +++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 791e1fd..b08e407 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -648,10 +648,17 @@ void __init imx6dl_pm_init(void)
 
 void __init imx6sl_pm_init(void)
 {
-	if (cpu_is_imx6sl())
+	struct regmap *gpr;
+
+	if (cpu_is_imx6sl()) {
 		imx6_pm_common_init(&imx6sl_pm_data);
-	else
+	} else {
 		imx6_pm_common_init(&imx6sll_pm_data);
+		gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
+		if (!IS_ERR(gpr))
+			regmap_update_bits(gpr, IOMUXC_GPR5,
+				IMX6SLL_GPR5_AFCG_X_BYPASS_MASK, 0);
+	}
 }
 
 void __init imx6sx_pm_init(void)
diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
index e06f5f7..6c1ad16 100644
--- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
+++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
@@ -457,4 +457,7 @@
 #define MCLK_DIR(x) (x == 1 ? IMX6UL_GPR1_SAI1_MCLK_DIR : x == 2 ? \
 		     IMX6UL_GPR1_SAI2_MCLK_DIR : IMX6UL_GPR1_SAI3_MCLK_DIR)
 
+/* For imx6sll iomux gpr register field define */
+#define IMX6SLL_GPR5_AFCG_X_BYPASS_MASK		(0x1f << 11)
+
 #endif /* __LINUX_IMX6Q_IOMUXC_GPR_H */
-- 
2.7.4
