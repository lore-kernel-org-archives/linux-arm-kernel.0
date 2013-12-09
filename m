From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 9 Dec 2013 22:31:13 +0100
Subject: [PATCH] clk: socfpga: Map the clk manager base address in the
 clock driver
In-Reply-To: <1386617447-1260-1-git-send-email-dinguyen@altera.com>
References: <1386617447-1260-1-git-send-email-dinguyen@altera.com>
Message-ID: <201312092231.13441.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 December 2013, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> The clk manager's base address was being mapped in SOCFPGA's arch code and
> being extern'ed out to the clock driver. This method is not correct, and the
> arch code was not really doing anything with that clk manager anyways.
> 
> This patch moves the mapping of the clk manager's base address in the clock
> driver itself.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>

Ok, thanks for doing this cleanup. A few comments for further simplification:

> -extern void __iomem *clk_mgr_base_addr;
> -
>  struct socfpga_clk {
>  	struct clk_gate hw;
>  	char *parent_name;
>  	char *clk_name;
> +	void __iomem *clk_mgr_base_addr;
>  	u32 fixed_div;
>  	void __iomem *div_reg;
>  	u32 width;	/* only valid if div_reg != 0 */


I think there is no need to make this a per-clock field, it's fine to
have a 'static' variable in the place of the 'extern' declaration you have now.

> @@ -129,7 +130,11 @@ static __init struct clk *socfpga_clk_init(struct device_node *node,
>  	if (WARN_ON(!socfpga_clk))
>  		return NULL;
>  
> -	socfpga_clk->hw.reg = clk_mgr_base_addr + reg;
> +	/* Map the clk manager register */
> +	clk_mgr_np = of_find_compatible_node(NULL, NULL, "altr,clk-mgr");
> +	socfpga_clk->hw.reg = of_iomap(clk_mgr_np, 0);
> +	BUG_ON(!socfpga_clk->hw.reg);
> +	socfpga_clk->hw.reg += reg;
>  
>  	rc = of_property_read_u32(node, "fixed-divider", &fixed_div);
>  	if (rc)

Instead of mapping it every time, I suggest something along the lines of
this patch:

diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
index 81dd31a..1a14742 100644
--- a/drivers/clk/socfpga/clk.c
+++ b/drivers/clk/socfpga/clk.c
@@ -55,7 +55,7 @@
 #define div_mask(width)	((1 << (width)) - 1)
 #define streq(a, b) (strcmp((a), (b)) == 0)
 
-extern void __iomem *clk_mgr_base_addr;
+static void __iomem *clk_mgr_base_addr;
 
 struct socfpga_clk {
 	struct clk_gate hw;
@@ -322,19 +322,30 @@ static void __init socfpga_pll_init(struct device_node *node)
 {
 	socfpga_clk_init(node, &clk_pll_ops);
 }
-CLK_OF_DECLARE(socfpga_pll, "altr,socfpga-pll-clock", socfpga_pll_init);
 
 static void __init socfpga_periph_init(struct device_node *node)
 {
 	socfpga_clk_init(node, &periclk_ops);
 }
-CLK_OF_DECLARE(socfpga_periph, "altr,socfpga-perip-clk", socfpga_periph_init);
 
 static void __init socfpga_gate_init(struct device_node *node)
 {
 	socfpga_gate_clk_init(node, &gateclk_ops);
 }
-CLK_OF_DECLARE(socfpga_gate, "altr,socfpga-gate-clk", socfpga_gate_init);
+
+static struct of_device_id socfpga_child_clocks[] = {
+	{ "altr,socfpga-pll-clock", socfpga_pll_init },
+	{ "altr,socfpga-perip-clk", socfpga_periph_init },
+	{ "altr,socfpga-gate-clk", socfpga_gate_init },
+	{},
+};
+
+static void __init socfpga_pll_init(struct device_node *node)
+{
+	clk_mgr_base_addr = of_iomap(node, 0);
+	of_clk_init(socfpga_child_clocks);
+}
+CLK_OF_DECLARE(socfpga_mgr, "altr,clk-mgr", socfpga_clkmgr_init);
 
 void __init socfpga_init_clocks(void)
 {


On a related note, I'd also like to see socfpga_init_clocks() disappear. It should
be trivial to just add the "mpuclk" into the DT as a separate
compatible = "fixed-factor-clock" node.

	Arnd
