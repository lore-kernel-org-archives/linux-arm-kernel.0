From: mturquette@ti.com (Mike Turquette)
Date: Tue, 13 Dec 2011 20:31:23 -0800
Subject: [PATCH 1/6] HACK: omap: opp: add fake 400MHz OPP to bypass MPU
In-Reply-To: <1323837088-2469-1-git-send-email-mturquette@ti.com>
References: <1323837088-2469-1-git-send-email-mturquette@ti.com>
Message-ID: <1323837088-2469-2-git-send-email-mturquette@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch is only for testing __clk_reparent as part of the
new common struct clk stuff.  It may make your board burst into flames
or otherwise void various warrantees.

This patch introduces a 400MHz OPP for the MPU, which happens to
correspond to the bypass clk rate on the 4430 Panda (with 38.4MHz
SYS_CLK).  Using CPUfreq to set the MPU to this rate puts the MPU into
Low Power Bypass, which triggers the __clk_reparent code in
drivers/clk/clk.c, which migrates the dpll_mpu_ck directory (and all of
its subdirs) to the div_mpu_hs_clk dir under dpll_core_ck.

Not-signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/opp4xxx_data.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
index 2293ba2..f1da758 100644
--- a/arch/arm/mach-omap2/opp4xxx_data.c
+++ b/arch/arm/mach-omap2/opp4xxx_data.c
@@ -68,6 +68,15 @@ struct omap_volt_data omap44xx_vdd_core_volt_data[] = {
 static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
 	/* MPU OPP1 - OPP50 */
 	OPP_INITIALIZER("mpu", true, 300000000, OMAP4430_VDD_MPU_OPP50_UV),
+	/*
+	 * MPU OPP1.5 - 400MHz - completely FAKE - not endorsed by TI
+	 *
+	 * DPLL_MPU is in Low Power Bypass driven by DPLL_CORE.  After
+	 * transitioning to this OPP you can see the migration in debugfs:
+	 * /d/clk/virt_38400000_ck/sys_clkin_ck/dpll_mpu_ck to
+	 * /d/.../dpll_core_ck/dpll_core_x2_ck/dpll_core_m5x2_ck/div_mpu_hs_clk
+	 */
+	OPP_INITIALIZER("mpu", true, 400000000, 1100000),
 	/* MPU OPP2 - OPP100 */
 	OPP_INITIALIZER("mpu", true, 600000000, OMAP4430_VDD_MPU_OPP100_UV),
 	/* MPU OPP3 - OPP-Turbo */
-- 
1.7.5.4
