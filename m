From: avinashphilip@ti.com (Philip Avinash)
Date: Wed, 2 Jan 2013 18:54:51 +0530
Subject: [PATCH 4/7] ARM: AM33XX: clk: Add clock node for EHRPWM TBCLK
In-Reply-To: <1357133094-30806-1-git-send-email-avinashphilip@ti.com>
References: <1357133094-30806-1-git-send-email-avinashphilip@ti.com>
Message-ID: <1357133094-30806-5-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EHRPWM module requires explicit clock gating of TBCLK from control
module. Hence add TBCLK clock node in clock tree for EHRPWM modules.

Signed-off-by: Philip Avinash <avinashphilip@ti.com>
---
- common clock frame work support

 arch/arm/mach-omap2/cclock33xx_data.c |   30 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/control.h         |    8 ++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm/mach-omap2/cclock33xx_data.c b/arch/arm/mach-omap2/cclock33xx_data.c
index ea64ad6..7ff9bc9 100644
--- a/arch/arm/mach-omap2/cclock33xx_data.c
+++ b/arch/arm/mach-omap2/cclock33xx_data.c
@@ -832,6 +832,33 @@ static struct clk_hw_omap wdt1_fck_hw = {
 
 DEFINE_STRUCT_CLK(wdt1_fck, wdt_ck_parents, gpio_fck_ops);
 
+static const char *pwmss_clk_parents[] = {
+	"dpll_per_m2_ck",
+};
+
+static const struct clk_ops ehrpwm_tbclk_ops = {
+	.enable		= &omap2_dflt_clk_enable,
+	.disable	= &omap2_dflt_clk_disable,
+};
+
+DEFINE_CLK_OMAP_MUX_GATE(ehrpwm0_tbclk, "l4ls_clkdm",
+			 0, NULL, 0,
+			 AM33XX_CTRL_REGADDR(AM33XX_PWMSS_TBCLK_CLKCTRL),
+			 AM33XX_PWMSS0_TBCLKEN_SHIFT,
+			 NULL, pwmss_clk_parents, ehrpwm_tbclk_ops);
+
+DEFINE_CLK_OMAP_MUX_GATE(ehrpwm1_tbclk, "l4ls_clkdm",
+			 0, NULL, 0,
+			 AM33XX_CTRL_REGADDR(AM33XX_PWMSS_TBCLK_CLKCTRL),
+			 AM33XX_PWMSS1_TBCLKEN_SHIFT,
+			 NULL, pwmss_clk_parents, ehrpwm_tbclk_ops);
+
+DEFINE_CLK_OMAP_MUX_GATE(ehrpwm2_tbclk, "l4ls_clkdm",
+			 0, NULL, 0,
+			 AM33XX_CTRL_REGADDR(AM33XX_PWMSS_TBCLK_CLKCTRL),
+			 AM33XX_PWMSS2_TBCLKEN_SHIFT,
+			 NULL, pwmss_clk_parents, ehrpwm_tbclk_ops);
+
 /*
  * clkdev
  */
@@ -910,6 +937,9 @@ static struct omap_clk am33xx_clks[] = {
 	CLK(NULL,	"clkout2_div_ck",	&clkout2_div_ck,	CK_AM33XX),
 	CLK(NULL,	"timer_32k_ck",		&clkdiv32k_ick,	CK_AM33XX),
 	CLK(NULL,	"timer_sys_ck",		&sys_clkin_ck,	CK_AM33XX),
+	CLK("48300200.ehrpwm",	"tbclk",	&ehrpwm0_tbclk,	CK_AM33XX),
+	CLK("48302200.ehrpwm",	"tbclk",	&ehrpwm1_tbclk,	CK_AM33XX),
+	CLK("48304200.ehrpwm",	"tbclk",	&ehrpwm2_tbclk,	CK_AM33XX),
 };
 
 
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index 3d944d3..ad4f1d8 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -358,6 +358,14 @@
 #define AM33XX_CONTROL_STATUS_SYSBOOT1_WIDTH		0x2
 #define AM33XX_CONTROL_STATUS_SYSBOOT1_MASK		(0x3 << 22)
 
+/* AM33XX PWMSS Control register */
+#define AM33XX_PWMSS_TBCLK_CLKCTRL			0x664
+
+/* AM33XX  PWMSS Control bitfields */
+#define AM33XX_PWMSS0_TBCLKEN_SHIFT			0
+#define AM33XX_PWMSS1_TBCLKEN_SHIFT			1
+#define AM33XX_PWMSS2_TBCLKEN_SHIFT			2
+
 /* CONTROL OMAP STATUS register to identify OMAP3 features */
 #define OMAP3_CONTROL_OMAP_STATUS	0x044c
 
-- 
1.7.9.5
