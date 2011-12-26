From: jason.chen@linaro.org (Jason Chen)
Date: Mon, 26 Dec 2011 19:15:23 +0800
Subject: [PATCH] ARM: imx6q: add support for IRAM
Message-ID: <1324898123-13973-1-git-send-email-jason.chen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Chen <jason.chen@linaro.org>
Signed-off-by: Eric Miao <eric.miao@linaro.org>
---
 arch/arm/boot/dts/imx6q.dtsi    |    7 +++++++
 arch/arm/mach-imx/Kconfig       |    1 +
 arch/arm/mach-imx/clock-imx6q.c |    3 ++-
 arch/arm/mach-imx/mach-imx6q.c  |   17 +++++++++++++++++
 4 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 263e8f3..01646b8 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -80,6 +80,13 @@
 		};
 	};
 
+	ocram at 00900000 {
+		compatible = "fsl,imx6q-iram";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x00900000 0x40000>;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index fa5c10c..88eaef6 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -841,6 +841,7 @@ config SOC_IMX6Q
 	select HAVE_IMX_GPC
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
+	select IRAM_ALLOC
 	select USE_OF
 
 	help
diff --git a/arch/arm/mach-imx/clock-imx6q.c b/arch/arm/mach-imx/clock-imx6q.c
index 9273c2a..285fd06 100644
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
@@ -1982,7 +1983,7 @@ int __init mx6q_clocks_init(void)
 	/* only keep necessary clocks on */
 	writel_relaxed(0x3 << CG0  | 0x3 << CG1  | 0x3 << CG2,	CCGR0);
 	writel_relaxed(0x3 << CG8  | 0x3 << CG9  | 0x3 << CG10,	CCGR2);
-	writel_relaxed(0x3 << CG10 | 0x3 << CG12,		CCGR3);
+	writel_relaxed(0x3 << CG10 | 0x3 << CG12 | 0x1 << CG14,	CCGR3);
 	writel_relaxed(0x3 << CG4  | 0x3 << CG6  | 0x3 << CG7,	CCGR4);
 	writel_relaxed(0x3 << CG0,				CCGR5);
 	writel_relaxed(0,					CCGR6);
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index c257281..7612ef5 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -27,6 +27,7 @@
 #include <asm/mach/time.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
+#include <mach/iram.h>
 
 void imx6q_restart(char mode, const char *cmd)
 {
@@ -73,6 +74,21 @@ static int ksz9021rn_phy_fixup(struct phy_device *phydev)
 	return 0;
 }
 
+static int imx6q_init_iram(void)
+{
+	struct device_node *np;
+	struct resource res;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-iram");
+	if (np) {
+		if (!of_address_to_resource(np, 0, &res))
+			return iram_init(res.start, res.end - res.start + 1);
+		else
+			return 0;
+	} else
+		return 0;
+}
+
 static void __init imx6q_init_machine(void)
 {
 	if (of_machine_is_compatible("fsl,imx6q-sabrelite"))
@@ -81,6 +97,7 @@ static void __init imx6q_init_machine(void)
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
+	imx6q_init_iram();
 	imx6q_pm_init();
 }
 
-- 
1.7.4.1
