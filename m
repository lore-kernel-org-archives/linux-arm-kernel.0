From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Fri, 4 Sep 2015 12:27:48 +0530
Subject: [PATCH v2 06/10] clk: qoriq: Add ls2080a support.
In-Reply-To: <1441349872-4560-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1441349872-4560-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1441349872-4560-7-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Scott Wood <scottwood@freescale.com>

LS2080A is the first implementation of the chassis 3 clockgen, which
has a different register layout than previous chips.  It is also little
endian, unlike previous chips.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 drivers/clk/Kconfig     |    2 +-
 drivers/clk/clk-qoriq.c |   78 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 42f7120..9f1970c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -121,7 +121,7 @@ config COMMON_CLK_AXI_CLKGEN
 
 config CLK_QORIQ
 	bool "Clock driver for Freescale QorIQ platforms"
-	depends on (PPC_E500MC || ARM) && OF
+	depends on (PPC_E500MC || ARM || ARM64) && OF
 	---help---
 	  This adds the clock driver support for Freescale QorIQ platforms
 	  using common clock framework.
diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index d9e4402..bae82ac 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -68,7 +68,10 @@ struct clockgen;
  * If not set, cmux freq must be >= platform pll/2
  */
 #define CG_CMUX_GE_PLAT		1
+
 #define CG_PLL_8BIT		2	/* PLLCnGSR[CFG] is 8 bits, not 6 */
+#define CG_VER3			4	/* version 3 cg: reg layout different */
+#define CG_LITTLE_ENDIAN	8
 
 struct clockgen_chipinfo {
 	const char *compat, *guts_compat;
@@ -94,6 +97,26 @@ struct clockgen {
 
 static struct clockgen clockgen;
 
+static void cg_out(struct clockgen *cg, u32 val, u32 __iomem *reg)
+{
+	if (cg->info.flags & CG_LITTLE_ENDIAN)
+		iowrite32(val, reg);
+	else
+		iowrite32be(val, reg);
+}
+
+static u32 cg_in(struct clockgen *cg, u32 __iomem *reg)
+{
+	u32 val;
+
+	if (cg->info.flags & CG_LITTLE_ENDIAN)
+		val = ioread32(reg);
+	else
+		val = ioread32be(reg);
+
+	return val;
+}
+
 static const struct clockgen_muxinfo p2041_cmux_grp1 = {
 	{
 		[0] = { CLKSEL_VALID, CGA_PLL1, PLL_DIV1 },
@@ -429,6 +452,17 @@ static const struct clockgen_chipinfo chipinfo[] = {
 		.pll_mask = 0x03,
 	},
 	{
+		.compat = "fsl,ls2080a-clockgen",
+		.cmux_groups = {
+			&clockgen2_cmux_cga12, &clockgen2_cmux_cgb
+		},
+		.cmux_to_group = {
+			0, 0, 1, 1, -1
+		},
+		.pll_mask = 0x37,
+		.flags = CG_VER3 | CG_LITTLE_ENDIAN,
+	},
+	{
 		.compat = "fsl,p2041-clockgen",
 		.guts_compat = "fsl,qoriq-device-config-1.0",
 		.init_periph = p2041_init_periph,
@@ -575,7 +609,7 @@ static int mux_set_parent(struct clk_hw *hw, u8 idx)
 		return -EINVAL;
 
 	clksel = hwc->parent_to_clksel[idx];
-	iowrite32be((clksel << CLKSEL_SHIFT) & CLKSEL_MASK, hwc->reg);
+	cg_out(hwc->cg, (clksel << CLKSEL_SHIFT) & CLKSEL_MASK, hwc->reg);
 
 	return 0;
 }
@@ -586,7 +620,7 @@ static u8 mux_get_parent(struct clk_hw *hw)
 	u32 clksel;
 	s8 ret;
 
-	clksel = (ioread32be(hwc->reg) & CLKSEL_MASK) >> CLKSEL_SHIFT;
+	clksel = (cg_in(hwc->cg, hwc->reg) & CLKSEL_MASK) >> CLKSEL_SHIFT;
 
 	ret = hwc->clksel_to_parent[clksel];
 	if (ret < 0) {
@@ -694,6 +728,7 @@ static struct clk * __init create_one_cmux(struct clockgen *cg, int idx)
 	if (!hwc)
 		return NULL;
 
+	hwc->cg = cg;
 	hwc->reg = cg->regs + 0x20 * idx;
 	hwc->info = cg->info.cmux_groups[cg->info.cmux_to_group[idx]];
 
@@ -704,7 +739,7 @@ static struct clk * __init create_one_cmux(struct clockgen *cg, int idx)
 	 * default clksel) may be inappropriately excluded on certain
 	 * chips.
 	 */
-	clksel = (ioread32be(hwc->reg) & CLKSEL_MASK) >> CLKSEL_SHIFT;
+	clksel = (cg_in(cg, hwc->reg) & CLKSEL_MASK) >> CLKSEL_SHIFT;
 	div = get_pll_div(cg, hwc, clksel);
 	if (!div)
 		return NULL;
@@ -873,13 +908,36 @@ static void __init create_one_pll(struct clockgen *cg, int idx)
 	if (!(cg->info.pll_mask & (1 << idx)))
 		return;
 
-	if (idx == PLATFORM_PLL)
-		reg = cg->regs + 0xc00;
-	else
-		reg = cg->regs + 0x800 + 0x20 * (idx - 1);
+	if (cg->info.flags & CG_VER3) {
+		switch (idx) {
+		case PLATFORM_PLL:
+			reg = cg->regs + 0x60080;
+			break;
+		case CGA_PLL1:
+			reg = cg->regs + 0x80;
+			break;
+		case CGA_PLL2:
+			reg = cg->regs + 0xa0;
+			break;
+		case CGB_PLL1:
+			reg = cg->regs + 0x10080;
+			break;
+		case CGB_PLL2:
+			reg = cg->regs + 0x100a0;
+			break;
+		default:
+			WARN_ONCE(1, "index %d\n", idx);
+			return;
+		}
+	} else {
+		if (idx == PLATFORM_PLL)
+			reg = cg->regs + 0xc00;
+		else
+			reg = cg->regs + 0x800 + 0x20 * (idx - 1);
+	}
 
 	/* Get the multiple of PLL */
-	mult = ioread32be(reg);
+	mult = cg_in(cg, reg);
 
 	/* Check if this PLL is disabled */
 	if (mult & PLL_KILL) {
@@ -887,7 +945,8 @@ static void __init create_one_pll(struct clockgen *cg, int idx)
 		return;
 	}
 
-	if ((cg->info.flags & CG_PLL_8BIT) && idx != PLATFORM_PLL)
+	if ((cg->info.flags & CG_VER3) ||
+	    ((cg->info.flags & CG_PLL_8BIT) && idx != PLATFORM_PLL))
 		mult = (mult & GENMASK(8, 1)) >> 1;
 	else
 		mult = (mult & GENMASK(6, 1)) >> 1;
@@ -1168,6 +1227,7 @@ err:
 CLK_OF_DECLARE(qoriq_clockgen_1, "fsl,qoriq-clockgen-1.0", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_2, "fsl,qoriq-clockgen-2.0", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1021a, "fsl,ls1021a-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_ls2080a, "fsl,ls2080a-clockgen", clockgen_init);
 
 /* Legacy nodes */
 CLK_OF_DECLARE(qoriq_sysclk_1, "fsl,qoriq-sysclk-1.0", sysclk_init);
-- 
1.7.9.5
