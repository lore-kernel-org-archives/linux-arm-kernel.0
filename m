From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 26 Apr 2015 22:31:05 +0800
Subject: [PATCH 04/11] ARM: imx5: let pm code map CCM block on its own
In-Reply-To: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
References: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1430058672-9267-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are about to move imx5 clock driver into drivers/clk, so let's get
imx5 pm code map CCM block on its own rather than relying on clock
driver to do the mapping.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clk-imx51-imx53.c | 2 --
 arch/arm/mach-imx/common.h          | 2 --
 arch/arm/mach-imx/pm-imx5.c         | 9 ++++-----
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 0f7e536147cb..f341464fe7e9 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -133,8 +133,6 @@ static struct clk_onecell_data clk_data;
 
 static void __init mx5_clocks_common_init(void __iomem *ccm_base)
 {
-	imx5_pm_set_ccm_base(ccm_base);
-
 	clk[IMX5_CLK_DUMMY]		= imx_clk_fixed("dummy", 0);
 	clk[IMX5_CLK_CKIL]		= imx_obtain_fixed_clock("ckil", 0);
 	clk[IMX5_CLK_OSC]		= imx_obtain_fixed_clock("osc", 0);
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 3682d094a259..fe510fbd0c8c 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -132,11 +132,9 @@ void imx6q_pm_set_ccm_base(void __iomem *base);
 #ifdef CONFIG_PM
 void imx51_pm_init(void);
 void imx53_pm_init(void);
-void imx5_pm_set_ccm_base(void __iomem *base);
 #else
 static inline void imx51_pm_init(void) {}
 static inline void imx53_pm_init(void) {}
-static inline void imx5_pm_set_ccm_base(void __iomem *base) {}
 #endif
 
 #ifdef CONFIG_NEON
diff --git a/arch/arm/mach-imx/pm-imx5.c b/arch/arm/mach-imx/pm-imx5.c
index f1f80ab73e69..b04025592d94 100644
--- a/arch/arm/mach-imx/pm-imx5.c
+++ b/arch/arm/mach-imx/pm-imx5.c
@@ -50,16 +50,19 @@
 #define IMX5_DEFAULT_CPU_IDLE_STATE WAIT_UNCLOCKED_POWER_OFF
 
 struct imx5_pm_data {
+	phys_addr_t ccm_addr;
 	phys_addr_t cortex_addr;
 	phys_addr_t gpc_addr;
 };
 
 static const struct imx5_pm_data imx51_pm_data __initconst = {
+	.ccm_addr = 0x73fd4000,
 	.cortex_addr = 0x83fa0000,
 	.gpc_addr = 0x73fd8000,
 };
 
 static const struct imx5_pm_data imx53_pm_data __initconst = {
+	.ccm_addr = 0x53fd4000,
 	.cortex_addr = 0x63fa0000,
 	.gpc_addr = 0x53fd8000,
 };
@@ -68,11 +71,6 @@ static void __iomem *ccm_base;
 static void __iomem *cortex_base;
 static void __iomem *gpc_base;
 
-void __init imx5_pm_set_ccm_base(void __iomem *base)
-{
-	ccm_base = base;
-}
-
 /*
  * set cpu low power mode before WFI instruction. This function is called
  * mx5 because it can be used for mx51, and mx53.
@@ -208,6 +206,7 @@ static int __init imx5_pm_common_init(const struct imx5_pm_data *data)
 
 	arm_pm_idle = imx5_pm_idle;
 
+	ccm_base = ioremap(data->ccm_addr, SZ_16K);
 	cortex_base = ioremap(data->cortex_addr, SZ_16K);
 	gpc_base = ioremap(data->gpc_addr, SZ_16K);
 	WARN_ON(!ccm_base || !cortex_base || !gpc_base);
-- 
1.9.1
