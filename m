From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 16 Nov 2016 11:26:56 -0800
Subject: [GIT PULL] Allwinner clock changes for 4.10
In-Reply-To: <20161115212615.lm3guceyfmdjnhfp@lukather>
References: <20161115212615.lm3guceyfmdjnhfp@lukather>
Message-ID: <20161116192656.GJ25626@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15, Maxime Ripard wrote:
> Hi Mike, Stephen,
> 
> Please pull the following patches for the next merge window.
> 
> Thanks!
> Maxime
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git sunxi-clk-for-4.10
> 
> for you to fetch changes up to 0f6f9302b819ca352cfd4f42c18ec08d521f9cae:
> 
>   clk: sunxi-ng: sun8i-h3: Set CLK_SET_RATE_PARENT for audio module clocks (2016-11-11 21:47:41 +0100)

Pulled into clk-next, but I get the following grumbles...

ERROR: space prohibited before that ',' (ctx:WxW)
#282: FILE: drivers/clk/sunxi-ng/ccu-sun50i-a64.c:206:
+                                            "pll-cpux" , "pll-cpux" };
                                                        ^

ERROR: space prohibited before that ',' (ctx:WxW)
#289: FILE: drivers/clk/sunxi-ng/ccu-sun50i-a64.c:213:
+                                            "axi" , "pll-periph0" };
                                                   ^

ERROR: space prohibited before that ',' (ctx:WxE)
#325: FILE: drivers/clk/sunxi-ng/ccu-sun50i-a64.c:249:
+                                            "pll-periph0-2x" ,
                                                              ^

ERROR: space prohibited before that ',' (ctx:WxW)
#333: FILE: drivers/clk/sunxi-ng/ccu-sun50i-a64.c:257:
+static const char * const ahb2_parents[] = { "ahb1" , "pll-periph0" };
                                                     ^

drivers/clk/sunxi-ng/ccu-sun50i-a64.c:160:16: warning: symbol 'pll_mipi_clk' was not declared. Should it be static?
drivers/clk/sunxi-ng/ccu-sun50i-a64.c:507:16: warning: symbol 'tcon1_clk' was not declared. Should it be static?

I'll go fix them this time, but please be more careful next time.

---8<----
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 0674515e2bad..e3c084cc6da5 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -157,7 +157,7 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_gpu_clk, "pll-gpu",
  */
 #define SUN50I_A64_PLL_MIPI_REG		0x040
 
-struct ccu_nkm pll_mipi_clk = {
+static struct ccu_nkm pll_mipi_clk = {
 	.enable		= BIT(31),
 	.lock		= BIT(28),
 	.n		= _SUNXI_CCU_MULT(8, 4),
@@ -203,14 +203,14 @@ static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_ddr1_clk, "pll-ddr1",
 				   CLK_SET_RATE_UNGATE);
 
 static const char * const cpux_parents[] = { "osc32k", "osc24M",
-					     "pll-cpux" , "pll-cpux" };
+					     "pll-cpux", "pll-cpux" };
 static SUNXI_CCU_MUX(cpux_clk, "cpux", cpux_parents,
 		     0x050, 16, 2, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
 
 static SUNXI_CCU_M(axi_clk, "axi", "cpux", 0x050, 0, 2, 0);
 
 static const char * const ahb1_parents[] = { "osc32k", "osc24M",
-					     "axi" , "pll-periph0" };
+					     "axi", "pll-periph0" };
 static struct ccu_div ahb1_clk = {
 	.div		= _SUNXI_CCU_DIV_FLAGS(4, 2, CLK_DIVIDER_POWER_OF_TWO),
 
@@ -246,7 +246,7 @@ static SUNXI_CCU_DIV_TABLE(apb1_clk, "apb1", "ahb1",
 			   0x054, 8, 2, apb1_div_table, 0);
 
 static const char * const apb2_parents[] = { "osc32k", "osc24M",
-					     "pll-periph0-2x" ,
+					     "pll-periph0-2x",
 					     "pll-periph0-2x" };
 static SUNXI_CCU_MP_WITH_MUX(apb2_clk, "apb2", apb2_parents, 0x058,
 			     0, 5,	/* M */
@@ -254,7 +254,7 @@ static SUNXI_CCU_MP_WITH_MUX(apb2_clk, "apb2", apb2_parents, 0x058,
 			     24, 2,	/* mux */
 			     0);
 
-static const char * const ahb2_parents[] = { "ahb1" , "pll-periph0" };
+static const char * const ahb2_parents[] = { "ahb1", "pll-periph0" };
 static const struct ccu_mux_fixed_prediv ahb2_fixed_predivs[] = {
 	{ .index = 1, .div = 2 },
 };
@@ -504,7 +504,7 @@ static SUNXI_CCU_MUX_TABLE_WITH_GATE(tcon0_clk, "tcon0", tcon0_parents,
 
 static const char * const tcon1_parents[] = { "pll-video0", "pll-video1" };
 static const u8 tcon1_table[] = { 0, 2, };
-struct ccu_div tcon1_clk = {
+static struct ccu_div tcon1_clk = {
 	.enable		= BIT(31),
 	.div		= _SUNXI_CCU_DIV(0, 4),
 	.mux		= _SUNXI_CCU_MUX_TABLE(24, 2, tcon1_table),

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
