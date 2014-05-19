From: Ranjani.Vaidyanathan@freescale.com (Ranjani.Vaidyanathan at freescale.com)
Date: Mon, 19 May 2014 17:07:45 +0000
Subject: [PATCH] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <5379B11B.3010501@de.bosch.com>
References: <1397044538-12676-1-git-send-email-festevam@gmail.com>
 <5379B11B.3010501@de.bosch.com>
Message-ID: <ba7881a0a50042ff9b2b25b6369ee2bc@BY2PR03MB379.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dirk,

There is no reason to mask the MMDC_CH1 handshake-mask after the periph2_clk2_sel bit has been set/cleared. It can be done before this step too.
Only need to make sure that the MMDC handshake-mask is set before switching periph2_clk_sel (bit 26 in CCM_CBCDR).

Thanks,
Ranjani

-----Original Message-----
From: Dirk Behme [mailto:dirk.behme at de.bosch.com] 
Sent: Monday, May 19, 2014 2:22 AM
To: Fabio Estevam; Vaidyanathan Ranjani-RA5478
Cc: Guo Shawn-R65073; Estevam Fabio-R49496; christian.gmeiner at gmail.com; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH] ARM: imx6: Fix procedure to switch the parent of LDB_DI_CLK

Hi Fabio and Ranjani,

On 09.04.2014 13:55, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Due to incorrect placement of the clock gate cell in the ldb_di[x]_clk 
> tree, the glitchy parent mux of ldb_di[x]_clk can cause a glitch to 
> enter the ldb_di_ipu_div divider. If the divider gets locked up, no 
> ldb_di[x]_clk is generated, and the LVDS display will hang when the 
> ipu_di_clk is sourced from ldb_di_clk.
>
> To fix the problem, both the new and current parent of the ldb_di_clk 
> should be disabled before the switch. This patch ensures that correct 
> steps are followed when ldb_di_clk parent is switched in the beginning of boot.
>
> Signed-off-by: Ranjani Vaidyanathan 
> <Ranjani.Vaidyanathan@freescale.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>   arch/arm/mach-imx/clk-imx6q.c | 125 ++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 121 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-imx/clk-imx6q.c 
> b/arch/arm/mach-imx/clk-imx6q.c index 20ad0d1..3ee45f4 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -140,6 +140,123 @@ static struct clk_div_table video_div_table[] = {
>   	{ /* sentinel */ }
>   };
>
> +static void init_ldb_clks(enum mx6q_clks new_parent) {
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

Just a hopefully simple question: Why do you mask MMDC_CH1 *after* switching to pll3_sw_clk above? Why not mask first, and then switch periph2_clk2_sel to pll3_sw_clk?

Thanks

Dirk
