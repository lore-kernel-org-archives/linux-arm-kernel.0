From: b20788@freescale.com (Anson Huang)
Date: Fri, 15 Nov 2013 13:14:18 -0500
Subject: [PATCH] arm: imx: clk: correct arm clock usecount
Message-ID: <1384539258-22299-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM clock is sourcing from pll1_sw, and pll1_sw can be either from
pll1_sys or step, so we should enable arm clock during clock
initialization instead of pll1_sys, otherwise, arm clock's usecount
would be incorrect and PLL1 will never be disabled even it is not
used.

And, currently ARM clock is hold be twd clock, but if using "nosmp"
, twd will not be used, that will cause arm clock's usecount to be
0, and pll1_sw will be disabled, system will hang if we enable cpufreq
which will make pll1_sw source from pll2_pfd2 when arm running at 396M.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/clk-imx6q.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index d756d91..133feff 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -114,7 +114,7 @@ static struct clk *clk[clk_max];
 static struct clk_onecell_data clk_data;
 
 static enum mx6q_clks const clks_init_on[] __initconst = {
-	mmdc_ch0_axi, rom, pll1_sys,
+	mmdc_ch0_axi, rom, arm,
 };
 
 static struct clk_div_table clk_enet_ref_table[] = {
-- 
1.7.9.5
