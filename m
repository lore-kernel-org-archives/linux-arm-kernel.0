From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 9 Aug 2014 21:58:42 +0800
Subject: [PATCH V3 3/3] ARM: clk-imx6q: Add missing lvds and anaclk clock
 to the clock tree
In-Reply-To: <9ecf6480464cffb3b4347ad3fd8ec5f07462a0fc.1407481023.git.shengjiu.wang@freescale.com>
References: <cover.1407481023.git.shengjiu.wang@freescale.com>
 <9ecf6480464cffb3b4347ad3fd8ec5f07462a0fc.1407481023.git.shengjiu.wang@freescale.com>
Message-ID: <20140809135841.GB8849@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 08, 2014 at 03:02:49PM +0800, Shengjiu Wang wrote:
> @@ -176,8 +182,12 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
>  	 * the "output_enable" bit as a gate, even though it's really just
>  	 * enabling clock output.
>  	 */
> -	clk[IMX6QDL_CLK_LVDS1_GATE] = imx_clk_gate("lvds1_gate", "lvds1_sel", base + 0x160, 10);
> -	clk[IMX6QDL_CLK_LVDS2_GATE] = imx_clk_gate("lvds2_gate", "lvds2_sel", base + 0x160, 11);
> +	clk[IMX6QDL_CLK_LVDS1_GATE] = imx_clk_gate2("lvds1_gate", "lvds1_sel", base + 0x160, 10);
> +	clk[IMX6QDL_CLK_LVDS2_GATE] = imx_clk_gate2("lvds2_gate", "lvds2_sel", base + 0x160, 11);

I do not think you can simply change to use imx_clk_gate2() here.  It's
designed for those CCGR gate clocks, each of which is controlled by two
bits.

Shawn

> +	clk[IMX6QDL_CLK_LVDS1_IN] = imx_clk_gate2("lvds1_in", "anaclk1", base + 0x160, 12);
> +	clk[IMX6QDL_CLK_LVDS2_IN] = imx_clk_gate2("lvds2_in", "anaclk2", base + 0x160, 13);
> +	imx_clk_gate2_exclusive(clk[IMX6QDL_CLK_LVDS1_GATE], clk[IMX6QDL_CLK_LVDS1_IN]);
> +	imx_clk_gate2_exclusive(clk[IMX6QDL_CLK_LVDS2_GATE], clk[IMX6QDL_CLK_LVDS2_IN]);
>  
>  	/*                                            name              parent_name        reg       idx */
>  	clk[IMX6QDL_CLK_PLL2_PFD0_352M] = imx_clk_pfd("pll2_pfd0_352m", "pll2_bus",     base + 0x100, 0);
