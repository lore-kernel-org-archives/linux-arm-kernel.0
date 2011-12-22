From: eric.miao@linaro.org (Eric Miao)
Date: Thu, 22 Dec 2011 21:48:24 +0800
Subject: [PATCH] ARM: imx6q: add support for IRAM
Message-ID: <1324561704-4145-1-git-send-email-eric.miao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Chen <jason.chen@linaro.org>

Signed-off-by: Jason Chen <jason.chen@linaro.org>
Signed-off-by: Eric Miao <eric.miao@linaro.org>
---
 arch/arm/mach-imx/Kconfig             |    1 +
 arch/arm/mach-imx/clock-imx6q.c       |    3 ++-
 arch/arm/mach-imx/mach-imx6q.c        |    3 +++
 arch/arm/plat-mxc/include/mach/mx6q.h |    6 ++++++
 4 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 6ee6803..023d240 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -602,6 +602,7 @@ config SOC_IMX6Q
 	select HAVE_IMX_GPC
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
+	select IRAM_ALLOC
 	select ARM_CPU_SUSPEND if PM
 	select USE_OF
 
diff --git a/arch/arm/mach-imx/clock-imx6q.c b/arch/arm/mach-imx/clock-imx6q.c
index 039a7ab..b347a84 100644
--- a/arch/arm/mach-imx/clock-imx6q.c
+++ b/arch/arm/mach-imx/clock-imx6q.c
@@ -1777,6 +1777,7 @@ DEF_CLK(mmdc_ch0_axi_clk, CCGR3, CG10, &periph_clk,	  &mmdc_ch0_ipg_clk);
 DEF_CLK(mmdc_ch1_ipg_clk, CCGR3, CG13, &ipg_clk,	  NULL);
 DEF_CLK(mmdc_ch1_axi_clk, CCGR3, CG11, &periph2_clk,	  &mmdc_ch1_ipg_clk);
 DEF_CLK(openvg_axi_clk,   CCGR3, CG13, &axi_clk,	  NULL);
+DEF_CLK(ocram_clk,   	  CCGR3, CG14, &ahb_clk,	  NULL);
 DEF_CLK(pwm1_clk,	  CCGR4, CG8,  &ipg_perclk,	  NULL);
 DEF_CLK(pwm2_clk,	  CCGR4, CG9,  &ipg_perclk,	  NULL);
 DEF_CLK(pwm3_clk,	  CCGR4, CG10, &ipg_perclk,	  NULL);
@@ -1984,7 +1985,7 @@ int __init mx6q_clocks_init(void)
 	/* only keep necessary clocks on */
 	writel_relaxed(0x3 << CG0  | 0x3 << CG1  | 0x3 << CG2,	CCGR0);
 	writel_relaxed(0x3 << CG8  | 0x3 << CG9  | 0x3 << CG10,	CCGR2);
-	writel_relaxed(0x3 << CG10 | 0x3 << CG12,		CCGR3);
+	writel_relaxed(0x3 << CG10 | 0x3 << CG12 | 0x1 << CG14,	CCGR3);
 	writel_relaxed(0x3 << CG4  | 0x3 << CG6  | 0x3 << CG7,	CCGR4);
 	writel_relaxed(0x3 << CG0,				CCGR5);
 	writel_relaxed(0,					CCGR6);
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index bee6334..d69f99f 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -24,6 +24,7 @@
 #include <asm/mach/time.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
+#include <mach/iram.h>
 
 /* For imx6q sabrelite board: set KSZ9021RN RGMII pad skew */
 static int ksz9021rn_phy_fixup(struct phy_device *phydev)
@@ -48,6 +49,8 @@ static void __init imx6q_init_machine(void)
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
+	iram_init(MX6Q_IRAM_BASE_ADDR, MX6Q_IRAM_SIZE);
+
 	imx6q_pm_init();
 }
 
diff --git a/arch/arm/plat-mxc/include/mach/mx6q.h b/arch/arm/plat-mxc/include/mach/mx6q.h
index 254a561..e051ff1 100644
--- a/arch/arm/plat-mxc/include/mach/mx6q.h
+++ b/arch/arm/plat-mxc/include/mach/mx6q.h
@@ -13,6 +13,8 @@
 #ifndef __MACH_MX6Q_H__
 #define __MACH_MX6Q_H__
 
+#include <asm/sizes.h>
+
 #define MX6Q_IO_P2V(x)			IMX_IO_P2V(x)
 #define MX6Q_IO_ADDRESS(x)		IOMEM(MX6Q_IO_P2V(x))
 
@@ -30,4 +32,8 @@
 #define MX6Q_UART4_BASE_ADDR		0x021f0000
 #define MX6Q_UART4_SIZE			0x4000
 
+/* The last 4K is for cpu hotplug to workaround wdog issue */
+#define MX6Q_IRAM_BASE_ADDR		0x00900000
+#define MX6Q_IRAM_SIZE			(SZ_256K - SZ_4K)
+
 #endif	/* __MACH_MX6Q_H__ */
-- 
1.7.5.4
