From: pavel@denx.de (Pavel Machek)
Date: Wed, 15 May 2013 15:58:04 +0200
Subject: [PATCH 3/5] ARM: socfpga: Add support to gate peripheral clocks
In-Reply-To: <1368571955-6652-3-git-send-email-dinguyen@altera.com>
References: <1368571955-6652-1-git-send-email-dinguyen@altera.com>
 <1368571955-6652-3-git-send-email-dinguyen@altera.com>
Message-ID: <20130515135804.GE9066@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Add support to gate the clocks that directly feed peripherals. For clocks
> with multiple parents, add the ability to determine the correct parent,
> and also set parents. Also add support to calculate and set the clocks'
> rate.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> CC: Mike Turquette <mturquette@linaro.org>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Olof Johansson <olof@lixom.net>
> CC: Pavel Machek <pavel@denx.de>
> CC: <linux@arm.linux.org.uk>

> @@ -132,8 +147,9 @@ static __init struct clk *socfpga_clk_init(struct device_node *node,
>  
>  	socfpga_clk->hw.hw.init = &init;
>  
> -	if (strcmp(clk_name, "main_pll") || strcmp(clk_name, "periph_pll") ||
> -			strcmp(clk_name, "sdram_pll")) {
> +	if (strcmp(clk_name, "main_pll") == 0 ||
> +			strcmp(clk_name, "periph_pll") == 0 ||
> +			strcmp(clk_name, "sdram_pll") == 0) {
>  		socfpga_clk->hw.bit_idx = SOCFPGA_PLL_EXT_ENA;
>  		clk_pll_ops.enable = clk_gate_ops.enable;
>  		clk_pll_ops.disable = clk_gate_ops.disable;

Perhaps do

#define streq(a, b)   (strcmp((a), (b)) == 0)

and use that to simplify the conditions?

Actually, here are suggested cleanups. Note that there are two FIXMEs
-- I could not understand why the code is safe, and that the BUG_ON()s
are commented on. AFAICT I got them correct, but for some reason they
seem to trigger.

Thanks,
								Pavel

diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
index a0551f2..ddb340d 100644
--- a/drivers/clk/socfpga/clk.c
+++ b/drivers/clk/socfpga/clk.c
@@ -24,17 +24,17 @@
 #include <linux/of.h>
 
 /* Clock Manager offsets */
-#define CLKMGR_CTRL    0x0
-#define CLKMGR_BYPASS 0x4
+#define CLKMGR_CTRL	0x0
+#define CLKMGR_BYPASS	0x4
 #define CLKMGR_L4SRC	0x70
 #define CLKMGR_PERPLL_SRC	0xAC
 
 /* Clock bypass bits */
-#define MAINPLL_BYPASS (1<<0)
-#define SDRAMPLL_BYPASS (1<<1)
-#define SDRAMPLL_SRC_BYPASS (1<<2)
-#define PERPLL_BYPASS (1<<3)
-#define PERPLL_SRC_BYPASS (1<<4)
+#define MAINPLL_BYPASS		(1<<0)
+#define SDRAMPLL_BYPASS		(1<<1)
+#define SDRAMPLL_SRC_BYPASS	(1<<2)
+#define PERPLL_BYPASS		(1<<3)
+#define PERPLL_SRC_BYPASS	(1<<4)
 
 #define SOCFPGA_PLL_BG_PWRDWN		0
 #define SOCFPGA_PLL_EXT_ENA		1
@@ -45,14 +45,16 @@
 #define SOCFPGA_PLL_DIVQ_SHIFT	16
 #define SOCFGPA_MAX_PARENTS	3
 
-#define SOCFPGA_L4_MP_CLK			"l4_mp_clk"
-#define SOCFPGA_L4_SP_CLK			"l4_sp_clk"
+#define SOCFPGA_L4_MP_CLK		"l4_mp_clk"
+#define SOCFPGA_L4_SP_CLK		"l4_sp_clk"
 #define SOCFPGA_NAND_CLK		"nand_clk"
 #define SOCFPGA_NAND_X_CLK		"nand_x_clk"
 #define SOCFPGA_MMC_CLK			"mmc_clk"
 #define SOCFPGA_DB_CLK			"gpio_db_clk"
+#define SOCFPGA_QSPI_CLK		"qspi_clk"
 
 #define div_mask(width)	((1 << (width)) - 1)
+#define streq(a, b) (strcmp((a), (b)) == 0)
 
 extern void __iomem *clk_mgr_base_addr;
 
@@ -62,8 +64,8 @@ struct socfpga_clk {
 	char *clk_name;
 	u32 fixed_div;
 	void __iomem *div_reg;
-	u32 width;
-	u32 shift;
+	u32 width;	/* only valid if div_reg != 0 */
+	u32 shift;	/* only valid if div_reg != 0 */
 };
 #define to_socfpga_clk(p) container_of(p, struct socfpga_clk, hw.hw)
 
@@ -145,11 +147,12 @@ static __init struct clk *socfpga_clk_init(struct device_node *node,
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 
+	// FIXME: assigning automatic variable ptr into malloced structure?
 	socfpga_clk->hw.hw.init = &init;
 
-	if (strcmp(clk_name, "main_pll") == 0 ||
-			strcmp(clk_name, "periph_pll") == 0 ||
-			strcmp(clk_name, "sdram_pll") == 0) {
+	if (streq(clk_name, "main_pll") ||
+	    streq(clk_name, "periph_pll") ||
+	    streq(clk_name, "sdram_pll")) {
 		socfpga_clk->hw.bit_idx = SOCFPGA_PLL_EXT_ENA;
 		clk_pll_ops.enable = clk_gate_ops.enable;
 		clk_pll_ops.disable = clk_gate_ops.disable;
@@ -168,61 +171,57 @@ static u8 socfpga_clk_get_parent(struct clk_hw *hwclk)
 {
 	u32 l4_src;
 	u32 perpll_src;
-	u8 parent;
 
-	if (strcmp(hwclk->init->name, SOCFPGA_L4_MP_CLK) == 0) {
+	if (streq(hwclk->init->name, SOCFPGA_L4_MP_CLK)) {
 		l4_src = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
-		l4_src &= 0x1;
-		parent = l4_src;
-	} else if (strcmp(hwclk->init->name, SOCFPGA_L4_SP_CLK) == 0) {
+		return l4_src & 1;
+	}
+	if (streq(hwclk->init->name, SOCFPGA_L4_SP_CLK)) {
 		l4_src = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
-		l4_src = ((l4_src & 0x2) >> 1);
-		parent = l4_src;
-	} else {
-		perpll_src = readl(clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
-		if (strcmp(hwclk->init->name, SOCFPGA_MMC_CLK) == 0)
-			perpll_src &= 0x3;
-		else if (strcmp(hwclk->init->name, SOCFPGA_NAND_CLK) == 0 ||
-			strcmp(hwclk->init->name, SOCFPGA_NAND_X_CLK) == 0)
-			perpll_src = ((perpll_src & 0xC) >> 2);
-		else /*QSPI clock */
-			perpll_src = ((perpll_src & 0x30) >> 4);
-		parent = perpll_src;
+		return !!(l4_src & 2);
 	}
+	perpll_src = readl(clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
+	if (streq(hwclk->init->name, SOCFPGA_MMC_CLK))
+		return perpll_src & 3;
+	if (streq(hwclk->init->name, SOCFPGA_NAND_CLK) ||
+	    streq(hwclk->init->name, SOCFPGA_NAND_X_CLK))
+		return (perpll_src >> 2) & 3;
+
+	/* else QSPI clock */
+//	BUG_ON(!streq(hwclk->init->name, SOCFPGA_QSPI_CLK));
+	return (perpll_src >> 4) & 3;
+}
 
-	return parent;
+static int clrsetbits(u32 adr, u32 clr, u32 set)
+{
+	u32 reg;
+
+	reg = readl(adr);
+	reg &= ~clr;
+	reg |= set;
+	writel(reg, adr);
+	return 0;
 }
 
 static int socfpga_clk_set_parent(struct clk_hw *hwclk, u8 parent)
 {
-	u32 src_reg;
-
-	if (strcmp(hwclk->init->name, SOCFPGA_L4_MP_CLK) == 0) {
-		src_reg = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
-		src_reg &= ~0x1;
-		src_reg |= parent;
-		writel(src_reg, clk_mgr_base_addr + CLKMGR_L4SRC);
-	} else if (strcmp(hwclk->init->name, SOCFPGA_L4_SP_CLK) == 0) {
-		src_reg = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
-		src_reg &= ~0x2;
-		src_reg |= (parent << 1);
-		writel(src_reg, clk_mgr_base_addr + CLKMGR_L4SRC);
-	} else {
-		src_reg = readl(clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
-		if (strcmp(hwclk->init->name, SOCFPGA_MMC_CLK) == 0) {
-			src_reg &= ~0x3;
-			src_reg |= parent;
-		} else if (strcmp(hwclk->init->name, SOCFPGA_NAND_CLK) == 0 ||
-			strcmp(hwclk->init->name, SOCFPGA_NAND_X_CLK) == 0) {
-			src_reg &= ~0xC;
-			src_reg |= (parent << 2);
-		} else {/*QSPI clock */
-			src_reg &= ~0x30;
-			src_reg |= (parent << 4);
-		}
-		writel(src_reg, clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
-	}
+//	BUG_ON(parent & ~3);
+
+	if (streq(hwclk->init->name, SOCFPGA_L4_MP_CLK))
+		return clrsetbits(clk_mgr_base_addr + CLKMGR_L4SRC, 1, parent);
+	if (streq(hwclk->init->name, SOCFPGA_L4_SP_CLK))
+		return clrsetbits(clk_mgr_base_addr + CLKMGR_L4SRC, 2, parent << 1);
 
+	if (streq(hwclk->init->name, SOCFPGA_MMC_CLK))
+		return clrsetbits(clk_mgr_base_addr + CLKMGR_PERPLL_SRC, 3, parent);
+	if (streq(hwclk->init->name, SOCFPGA_NAND_CLK) ||
+	    streq(hwclk->init->name, SOCFPGA_NAND_X_CLK))
+		return clrsetbits(clk_mgr_base_addr + CLKMGR_PERPLL_SRC, 0xC, parent << 2);
+
+	/* else QSPI clock */
+//	BUG_ON(!streq(hwclk->init->name, SOCFPGA_QSPI_CLK));
+
+	clrsetbits(clk_mgr_base_addr + CLKMGR_PERPLL_SRC, 0x30, parent << 4);
 	return 0;
 }
 
@@ -237,7 +236,7 @@ static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
 	else if (socfpgaclk->div_reg) {
 		val = readl(socfpgaclk->div_reg) >> socfpgaclk->shift;
 		val &= div_mask(socfpgaclk->width);
-		if (strcmp(hwclk->init->name, SOCFPGA_DB_CLK) == 0)
+		if (streq(hwclk->init->name, SOCFPGA_DB_CLK))
 			div = val + 1;
 		else
 			div = (1 << val);
@@ -273,13 +272,6 @@ static void __init socfpga_gate_clk_init(struct device_node *node,
 	rc = of_property_read_u32_array(node, "clk-gate", clk_gate, 2);
 	if (rc)
 		clk_gate[0] = 0;
-
-	rc = of_property_read_u32(node, "fixed-divider", &fixed_div);
-	if (rc)
-		socfpga_clk->fixed_div = 0;
-	else
-		socfpga_clk->fixed_div = fixed_div;
-
 	if (clk_gate[0]) {
 		socfpga_clk->hw.reg = clk_mgr_base_addr + clk_gate[0];
 		socfpga_clk->hw.bit_idx = clk_gate[1];
@@ -288,6 +280,12 @@ static void __init socfpga_gate_clk_init(struct device_node *node,
 		gateclk_ops.disable = clk_gate_ops.disable;
 	}
 
+	rc = of_property_read_u32(node, "fixed-divider", &fixed_div);
+	if (rc)
+		socfpga_clk->fixed_div = 0;
+	else
+		socfpga_clk->fixed_div = fixed_div;
+
 	rc = of_property_read_u32_array(node, "div-reg", div_reg, 3);
 	if (!rc) {
 		socfpga_clk->div_reg = clk_mgr_base_addr + div_reg[0];
@@ -302,12 +300,17 @@ static void __init socfpga_gate_clk_init(struct device_node *node,
 	init.name = clk_name;
 	init.ops = ops;
 	init.flags = 0;
-	while (i < SOCFGPA_MAX_PARENTS && (parent_name[i] =
-			of_clk_get_parent_name(node, i)) != NULL)
+	while (i < SOCFGPA_MAX_PARENTS) {
+		char *name = of_clk_get_parent_name(node, i);
+		parent_name[i] = name;
+		if (name == NULL)
+			break;
 		i++;
+	}
 
 	init.parent_names = parent_name;
 	init.num_parents = i;
+	// FIXME: assigning automatic variable ptr into malloced structure?
 	socfpga_clk->hw.hw.init = &init;
 
 	clk = clk_register(NULL, &socfpga_clk->hw.hw);




-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
