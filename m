From: nm@ti.com (Nishanth Menon)
Date: Thu, 14 Mar 2013 15:58:14 -0500
Subject: [PATCH 7/8] ARM: OMAP3+: use cpu0-cpufreq driver
In-Reply-To: <1363294695-658-1-git-send-email-nm@ti.com>
References: <1363294695-658-1-git-send-email-nm@ti.com>
Message-ID: <1363294695-658-8-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With OMAP3+ and AM33xx supported SoC having defined CPU DT
entries with operating-points defined, we can now
use the SoC generic cpu0-cpufreq driver to start
using it, lets now switch to the generic driver.

As part of this change, switch the dummy clock node to use
cpufreq-cpu0. This is an suggested solution till we have
OMAP clock nodes in DT. Once the DT conversion is complete,
we can then do: clocks = <&dpll_mpu_ck>; or the SoC specific
equivalent.

Inspired by patch: https://patchwork.kernel.org/patch/2067841/
now made generic.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Beno?t Cousson" <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Keerthy <j-keerthy@ti.com>
Cc: linux-omap at vger.kernel.org
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: cpufreq at vger.kernel.org
Cc: linux-pm at vger.kernel.org

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/board-generic.c   |    4 ++++
 arch/arm/mach-omap2/cclock33xx_data.c |    2 +-
 arch/arm/mach-omap2/cclock3xxx_data.c |    2 +-
 arch/arm/mach-omap2/cclock44xx_data.c |    2 +-
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 0274ff7..970c6f4 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -49,6 +49,10 @@ static void __init omap_generic_init(void)
 		omap4_panda_display_init_of();
 	else if (of_machine_is_compatible("ti,omap4-sdp"))
 		omap_4430sdp_display_init_of();
+	if (IS_ENABLED(CONFIG_GENERIC_CPUFREQ_CPU0)) {
+		struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
+		platform_device_register_full(&devinfo);
+	}
 }
 
 #ifdef CONFIG_SOC_OMAP2420
diff --git a/arch/arm/mach-omap2/cclock33xx_data.c b/arch/arm/mach-omap2/cclock33xx_data.c
index 476b820..cf7e736 100644
--- a/arch/arm/mach-omap2/cclock33xx_data.c
+++ b/arch/arm/mach-omap2/cclock33xx_data.c
@@ -852,7 +852,7 @@ static struct omap_clk am33xx_clks[] = {
 	CLK(NULL,	"dpll_core_m5_ck",	&dpll_core_m5_ck,	CK_AM33XX),
 	CLK(NULL,	"dpll_core_m6_ck",	&dpll_core_m6_ck,	CK_AM33XX),
 	CLK(NULL,	"dpll_mpu_ck",		&dpll_mpu_ck,	CK_AM33XX),
-	CLK("cpu0",	NULL,			&dpll_mpu_ck,	CK_AM33XX),
+	CLK("cpufreq-cpu0.0",	NULL,			&dpll_mpu_ck,	CK_AM33XX),
 	CLK(NULL,	"dpll_mpu_m2_ck",	&dpll_mpu_m2_ck,	CK_AM33XX),
 	CLK(NULL,	"dpll_ddr_ck",		&dpll_ddr_ck,	CK_AM33XX),
 	CLK(NULL,	"dpll_ddr_m2_ck",	&dpll_ddr_m2_ck,	CK_AM33XX),
diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap2/cclock3xxx_data.c
index 4579c3c..5f68286 100644
--- a/arch/arm/mach-omap2/cclock3xxx_data.c
+++ b/arch/arm/mach-omap2/cclock3xxx_data.c
@@ -3501,7 +3501,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"uart4_ick",	&uart4_ick_am35xx,	CK_AM35XX),
 	CLK(NULL,	"timer_32k_ck",	&omap_32k_fck,  CK_3XXX),
 	CLK(NULL,	"timer_sys_ck",	&sys_ck,	CK_3XXX),
-	CLK(NULL,	"cpufreq_ck",	&dpll1_ck,	CK_3XXX),
+	CLK("cpufreq-cpu0.0",	NULL,	&dpll1_ck,	CK_3XXX),
 };
 
 static const char *enable_init_clks[] = {
diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
index 3d58f33..6e933e3 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -1660,7 +1660,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("4013a000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
 	CLK("4013c000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
 	CLK("4013e000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
-	CLK(NULL,	"cpufreq_ck",	&dpll_mpu_ck,	CK_443X),
+	CLK("cpufreq-cpu0.0",	NULL,	&dpll_mpu_ck,	CK_443X),
 };
 
 int __init omap4xxx_clk_init(void)
-- 
1.7.9.5
