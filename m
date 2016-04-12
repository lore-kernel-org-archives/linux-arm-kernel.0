From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 12 Apr 2016 09:38:21 +0800
Subject: [PATCH v3 1/9] ARM: imx: clk-vf610: fix DCU clock tree
In-Reply-To: <1459834121-25997-2-git-send-email-stefan@agner.ch>
References: <1459834121-25997-1-git-send-email-stefan@agner.ch>
 <1459834121-25997-2-git-send-email-stefan@agner.ch>
Message-ID: <20160412013820.GC15949@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 10:28:33PM -0700, Stefan Agner wrote:
> Similar to an earlier fix for the SAI clocks, the DCU clock hierarchy
> mixes the bus clock with the display controllers pixel clock. Tests
> have shown that the gates in CCM_CCGR3/9 registers do not control
> the DCU pixel clock, but only the register access clock (bus clock).
> 
> Fix this by defining the parent clock of VF610_CLK_DCUx to be the bus
> clock (ipg_bus).
> 
> Since the clock has not been used far, there are no further changes
> needed.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied 1 and 2, with updating subject prefix to be 'clk: imx: vf610: '

Shawn

> ---
>  drivers/clk/imx/clk-vf610.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
> index 0a94d96..426fde2 100644
> --- a/drivers/clk/imx/clk-vf610.c
> +++ b/drivers/clk/imx/clk-vf610.c
> @@ -321,11 +321,11 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
>  	clk[VF610_CLK_DCU0_SEL] = imx_clk_mux("dcu0_sel", CCM_CSCMR1, 28, 1, dcu_sels, 2);
>  	clk[VF610_CLK_DCU0_EN] = imx_clk_gate("dcu0_en", "dcu0_sel", CCM_CSCDR3, 19);
>  	clk[VF610_CLK_DCU0_DIV] = imx_clk_divider("dcu0_div", "dcu0_en", CCM_CSCDR3, 16, 3);
> -	clk[VF610_CLK_DCU0] = imx_clk_gate2("dcu0", "dcu0_div", CCM_CCGR3, CCM_CCGRx_CGn(8));
> +	clk[VF610_CLK_DCU0] = imx_clk_gate2("dcu0", "ipg_bus", CCM_CCGR3, CCM_CCGRx_CGn(8));
>  	clk[VF610_CLK_DCU1_SEL] = imx_clk_mux("dcu1_sel", CCM_CSCMR1, 29, 1, dcu_sels, 2);
>  	clk[VF610_CLK_DCU1_EN] = imx_clk_gate("dcu1_en", "dcu1_sel", CCM_CSCDR3, 23);
>  	clk[VF610_CLK_DCU1_DIV] = imx_clk_divider("dcu1_div", "dcu1_en", CCM_CSCDR3, 20, 3);
> -	clk[VF610_CLK_DCU1] = imx_clk_gate2("dcu1", "dcu1_div", CCM_CCGR9, CCM_CCGRx_CGn(8));
> +	clk[VF610_CLK_DCU1] = imx_clk_gate2("dcu1", "ipg_bus", CCM_CCGR9, CCM_CCGRx_CGn(8));
>  
>  	clk[VF610_CLK_ESAI_SEL] = imx_clk_mux("esai_sel", CCM_CSCMR1, 20, 2, esai_sels, 4);
>  	clk[VF610_CLK_ESAI_EN] = imx_clk_gate("esai_en", "esai_sel", CCM_CSCDR2, 30);
> -- 
> 2.7.4
> 
> 
