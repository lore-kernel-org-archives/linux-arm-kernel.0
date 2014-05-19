From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 19 May 2014 11:25:42 +0200
Subject: [PATCH] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <1397044538-12676-1-git-send-email-festevam@gmail.com>
References: <1397044538-12676-1-git-send-email-festevam@gmail.com>
Message-ID: <20140519112542.5588c492@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Fabio Estevam wrote:
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
symbolic register offsets instead of magic numbers would make the code
more readable and less error prone!


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
