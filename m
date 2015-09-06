From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 6 Sep 2015 16:49:45 +0800
Subject: [PATCH 1/1] ARM: imx35: Do not call mxc_timer_init twice when
 booting with DT
In-Reply-To: <1439277502-16917-1-git-send-email-alexander.stein@systec-electronic.com>
References: <1439277502-16917-1-git-send-email-alexander.stein@systec-electronic.com>
Message-ID: <20150906084945.GM30746@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 11, 2015 at 09:18:22AM +0200, Alexander Stein wrote:
> mxc_timer_init must not be called from within mx35_clocks_init_dt. It will
> eventually be called by imx31_timer_init_dt
> (drivers/clocksources/timer-imx-gpt.c).

s/clocksources/clocksource

> This arranges the initialization code similar to clk-imx27.c
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
>  drivers/clk/imx/clk-imx35.c | 49 +++++++++++++++++++++++++--------------------

Also, while you are there, can you please fix clk-imx31.c as well?

Shawn

>  1 file changed, 27 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx35.c b/drivers/clk/imx/clk-imx35.c
> index 69138ba..3e7c805 100644
> --- a/drivers/clk/imx/clk-imx35.c
> +++ b/drivers/clk/imx/clk-imx35.c
> @@ -84,7 +84,7 @@ enum mx35_clks {
>  
>  static struct clk *clk[clk_max];
>  
> -int __init mx35_clocks_init(void)
> +static void __init _mx35_clocks_init(void)
>  {
>  	void __iomem *base;
>  	u32 pdr0, consumer_sel, hsp_sel;
> @@ -219,6 +219,30 @@ int __init mx35_clocks_init(void)
>  
>  	imx_check_clocks(clk, ARRAY_SIZE(clk));
>  
> +	clk_prepare_enable(clk[spba_gate]);
> +	clk_prepare_enable(clk[gpio1_gate]);
> +	clk_prepare_enable(clk[gpio2_gate]);
> +	clk_prepare_enable(clk[gpio3_gate]);
> +	clk_prepare_enable(clk[iim_gate]);
> +	clk_prepare_enable(clk[emi_gate]);
> +	clk_prepare_enable(clk[max_gate]);
> +	clk_prepare_enable(clk[iomuxc_gate]);
> +
> +	/*
> +	 * SCC is needed to boot via mmc after a watchdog reset. The clock code
> +	 * before conversion to common clk also enabled UART1 (which isn't
> +	 * handled here and not needed for mmc) and IIM (which is enabled
> +	 * unconditionally above).
> +	 */
> +	clk_prepare_enable(clk[scc_gate]);
> +
> +	imx_print_silicon_rev("i.MX35", mx35_revision());
> +}
> +
> +int __init mx35_clocks_init(void)
> +{
> +	_mx35_clocks_init();
> +
>  	clk_register_clkdev(clk[pata_gate], NULL, "pata_imx");
>  	clk_register_clkdev(clk[can1_gate], NULL, "flexcan.0");
>  	clk_register_clkdev(clk[can2_gate], NULL, "flexcan.1");
> @@ -275,25 +299,6 @@ int __init mx35_clocks_init(void)
>  	clk_register_clkdev(clk[csi_gate], NULL, "mx3-camera.0");
>  	clk_register_clkdev(clk[admux_gate], "audmux", NULL);
>  
> -	clk_prepare_enable(clk[spba_gate]);
> -	clk_prepare_enable(clk[gpio1_gate]);
> -	clk_prepare_enable(clk[gpio2_gate]);
> -	clk_prepare_enable(clk[gpio3_gate]);
> -	clk_prepare_enable(clk[iim_gate]);
> -	clk_prepare_enable(clk[emi_gate]);
> -	clk_prepare_enable(clk[max_gate]);
> -	clk_prepare_enable(clk[iomuxc_gate]);
> -
> -	/*
> -	 * SCC is needed to boot via mmc after a watchdog reset. The clock code
> -	 * before conversion to common clk also enabled UART1 (which isn't
> -	 * handled here and not needed for mmc) and IIM (which is enabled
> -	 * unconditionally above).
> -	 */
> -	clk_prepare_enable(clk[scc_gate]);
> -
> -	imx_print_silicon_rev("i.MX35", mx35_revision());
> -
>  	mxc_timer_init(MX35_GPT1_BASE_ADDR, MX35_INT_GPT, GPT_TYPE_IMX31);
>  
>  	return 0;
> @@ -301,10 +306,10 @@ int __init mx35_clocks_init(void)
>  
>  static void __init mx35_clocks_init_dt(struct device_node *ccm_node)
>  {
> +	_mx35_clocks_init();
> +
>  	clk_data.clks = clk;
>  	clk_data.clk_num = ARRAY_SIZE(clk);
>  	of_clk_add_provider(ccm_node, of_clk_src_onecell_get, &clk_data);
> -
> -	mx35_clocks_init();
>  }
>  CLK_OF_DECLARE(imx35, "fsl,imx35-ccm", mx35_clocks_init_dt);
> -- 
> 2.4.6
> 
