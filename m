From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 9 Apr 2014 21:34:24 +0800
Subject: [PATCH] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <1397044538-12676-1-git-send-email-festevam@gmail.com>
References: <1397044538-12676-1-git-send-email-festevam@gmail.com>
Message-ID: <20140409133422.GA2334@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 08:55:38AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Due to incorrect placement of the clock gate cell in the ldb_di[x]_clk tree,
> the glitchy parent mux of ldb_di[x]_clk can cause a glitch to enter the
> ldb_di_ipu_div divider. If the divider gets locked up, no ldb_di[x]_clk is
> generated, and the LVDS display will hang when the ipu_di_clk is sourced from
> ldb_di_clk.
> 
> To fix the problem, both the new and current parent of the ldb_di_clk should
> be disabled before the switch. This patch ensures that correct steps are
> followed when ldb_di_clk parent is switched in the beginning of boot.

I'm not sure this is a full/correct fix to the problem.  You assume that
the re-parenting only happens during boot for once?  What about the
re-parenting triggered by the clk_set_parent() call?

Shawn

> 
> Signed-off-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@freescale.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-imx/clk-imx6q.c | 125 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 121 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index 20ad0d1..3ee45f4 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -140,6 +140,123 @@ static struct clk_div_table video_div_table[] = {
>  	{ /* sentinel */ }
>  };
>  
> +static void init_ldb_clks(enum mx6q_clks new_parent)
> +{
> +	struct device_node *np;
> +	static void __iomem *ccm_base;
> +	unsigned int reg;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-ccm");
> +	ccm_base = of_iomap(np, 0);
> +	WARN_ON(!ccm_base);
> +
> +	/*
> +	 * Need to follow a strict procedure when changing the LDB
> +	 * clock, else we can introduce a glitch. Things to keep in
> +	 * mind:
> +	 * 1. The current and new parent clocks must be disabled.
> +	 * 2. The default clock for ldb_dio_clk is mmdc_ch1 which has
> +	 * no CG bit.
> +	 * 3. In the RTL implementation of the LDB_DI_CLK_SEL mux
> +	 * the top four options are in one mux and the PLL3 option along
> +	 * with another option is in the second mux. There is third mux
> +	 * used to decide between the first and second mux.
> +	 * The code below switches the parent to the bottom mux first
> +	 * and then manipulates the top mux. This ensures that no glitch
> +	 * will enter the divider.
> +	 *
> +	 * Need to disable MMDC_CH1 clock manually as there is no CG bit
> +	 * for this clock. The only way to disable this clock is to move
> +	 * it topll3_sw_clk and then to disable pll3_sw_clk
> +	 * Make sure periph2_clk2_sel is set to pll3_sw_clk
> +	 */
> +	reg = readl_relaxed(ccm_base + 0x18);
> +	reg &= ~(1 << 20);
> +	writel_relaxed(reg, ccm_base + 0x18);
> +
> +	/* Set MMDC_CH1 mask bit */
> +	reg = readl_relaxed(ccm_base + 0x4);
> +	reg |= 1 << 16;
> +	writel_relaxed(reg, ccm_base + 0x4);
> +
> +	/*
> +	 * Set the periph2_clk_sel to the top mux so that
> +	 * mmdc_ch1 is from pll3_sw_clk.
> +	 */
> +	reg = readl_relaxed(ccm_base + 0x14);
> +	reg |= 1 << 26;
> +	writel_relaxed(reg, ccm_base + 0x14);
> +
> +	/* Wait for the clock switch */
> +	while (readl_relaxed(ccm_base + 0x48))
> +		;
> +
> +	/* Disable pll3_sw_clk by selecting the bypass clock source */
> +	reg = readl_relaxed(ccm_base + 0xc);
> +	reg |= 1 << 0;
> +	writel_relaxed(reg, ccm_base + 0xc);
> +
> +	/* Set the ldb_di0_clk and ldb_di1_clk to 111b */
> +	reg = readl_relaxed(ccm_base + 0x2c);
> +	reg |= ((7 << 9) | (7 << 12));
> +	writel_relaxed(reg, ccm_base + 0x2c);
> +
> +	/* Set the ldb_di0_clk and ldb_di1_clk to 100b */
> +	reg = readl_relaxed(ccm_base + 0x2c);
> +	reg &= ~((7 << 9) | (7 << 12));
> +	reg |= ((4 << 9) | (4 << 12));
> +	writel_relaxed(reg, ccm_base + 0x2c);
> +
> +	/* Perform the LDB parent clock switch */
> +	clk_set_parent(clk[ldb_di0_sel], clk[new_parent]);
> +	clk_set_parent(clk[ldb_di1_sel], clk[new_parent]);
> +
> +	/* Unbypass pll3_sw_clk */
> +	reg = readl_relaxed(ccm_base + 0xc);
> +	reg &= ~(1 << 0);
> +	writel_relaxed(reg, ccm_base + 0xc);
> +
> +	/*
> +	 * Set the periph2_clk_sel back to the bottom mux so that
> +	 * mmdc_ch1 is from its original parent.
> +	 */
> +	reg = readl_relaxed(ccm_base + 0x14);
> +	reg &= ~(1 << 26);
> +	writel_relaxed(reg, ccm_base + 0x14);
> +
> +	/* Wait for the clock switch */
> +	while (readl_relaxed(ccm_base + 0x48))
> +		;
> +
> +	/* Clear MMDC_CH1 mask bit */
> +	reg = readl_relaxed(ccm_base + 0x4);
> +	reg &= ~(1 << 16);
> +	writel_relaxed(reg, ccm_base + 0x4);
> +}
> +
> +static void disable_anatop_clocks(void __iomem *anatop_base)
> +{
> +	unsigned int reg;
> +
> +	/* Make sure PFDs are disabled at boot. */
> +	reg = readl_relaxed(anatop_base + 0x100);
> +	/* Cannot disable pll2_pfd2_396M, as it is the MMDC clock in iMX6DL */
> +	if (cpu_is_imx6dl())
> +		reg |= 0x80008080;
> +	else
> +		reg |= 0x80808080;
> +	writel_relaxed(reg, anatop_base + 0x100);
> +
> +	reg = readl_relaxed(anatop_base + 0xf0);
> +	reg |= 0x80808080;
> +	writel_relaxed(reg, anatop_base + 0xf0);
> +
> +	/* Make sure PLLs is disabled */
> +	reg = readl_relaxed(anatop_base + 0xa0);
> +	reg &= ~(1 << 13);
> +	writel_relaxed(reg, anatop_base + 0xa0);
> +}
> +
>  static void __init imx6q_clocks_init(struct device_node *ccm_node)
>  {
>  	struct device_node *np;
> @@ -232,6 +349,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
>  	clk[pll5_post_div] = clk_register_divider_table(NULL, "pll5_post_div", "pll5_video", CLK_SET_RATE_PARENT, base + 0xa0, 19, 2, 0, post_div_table, &imx_ccm_lock);
>  	clk[pll5_video_div] = clk_register_divider_table(NULL, "pll5_video_div", "pll5_post_div", CLK_SET_RATE_PARENT, base + 0x170, 30, 2, 0, video_div_table, &imx_ccm_lock);
>  
> +	disable_anatop_clocks(base);
> +
>  	np = ccm_node;
>  	base = of_iomap(np, 0);
>  	WARN_ON(!base);
> @@ -440,10 +559,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
>  	clk_register_clkdev(clk[enet_ref], "enet_ref", NULL);
>  
>  	if ((imx_get_soc_revision() != IMX_CHIP_REVISION_1_0) ||
> -	    cpu_is_imx6dl()) {
> -		clk_set_parent(clk[ldb_di0_sel], clk[pll5_video_div]);
> -		clk_set_parent(clk[ldb_di1_sel], clk[pll5_video_div]);
> -	}
> +	    cpu_is_imx6dl())
> +		init_ldb_clks(pll5_video_div);
>  
>  	/*
>  	 * The gpmi needs 100MHz frequency in the EDO/Sync mode,
> -- 
> 1.8.3.2
> 
> 
> 
