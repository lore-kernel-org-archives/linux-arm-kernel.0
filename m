From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Tue, 10 Feb 2015 12:24:29 +0100
Subject: [PATCH 3/3] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <1420559265-7333-3-git-send-email-p.zabel@pengutronix.de>
References: <1420559265-7333-1-git-send-email-p.zabel@pengutronix.de>
 <1420559265-7333-3-git-send-email-p.zabel@pengutronix.de>
Message-ID: <54D9EA6D.1020202@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.01.2015 16:47, Philipp Zabel wrote:
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
> followed when ldb_di_clk parent is switched in the beginning of boot. The
> glitchy muxes are then registered as read-only. The clock parent can be selected
> using the assigned-clocks and assigned-clock-parents properties of the ccm
> device tree node:
>
> 	&clks {
> 		assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
> 				  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
> 		assigned-clock-parents = <&clks IMX6QDL_CLK_MMDC_CH1_AXI>,
> 					 <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>;
> 	};
>
> Signed-off-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@freescale.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>   arch/arm/mach-imx/clk-imx6q.c | 201 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 201 insertions(+)
>
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index 2e379fb..77aa7b17 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
...
> +	/*
> +	 * The LDB_DI0/1_SEL muxes are registered read-only due to a hardware
> +	 * bug. Set the muxes to the requested values before registering the
> +	 * ldb_di_sel clocks.
> +	 */
> +	if ((imx_get_soc_revision() != IMX_CHIP_REVISION_1_0) ||
> +	    cpu_is_imx6dl())
> +		init_ldb_clks(np, base);


I've a hopefully simple understanding question regarding this if():

What does happen (or: has to be done) in the (non-existing) else case of 
this if() statement?

E.g. how to configure the clocks for the imx_get_soc_revision() == 
IMX_CHIP_REVISION_1_0 case?

For the if() case, we can configure the clocks via the assigned-clocks 
and assigned-clock-parents as described in the commit message. But how 
to configure the clocks/muxes in the else case? To my understanding, 
with the patch 2/3 [1] the clocks/muxes are configured to read only.

Sorry if I missed anything ;)

Many thanks,

Dirk

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/313619.html
