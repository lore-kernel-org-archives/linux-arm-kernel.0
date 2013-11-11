From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 Nov 2013 15:47:11 +0800
Subject: [PATCH 1/2] ARM: i.MX28: define ref_xtal frequency in DT
In-Reply-To: <1383918521-4668-2-git-send-email-mkl@pengutronix.de>
References: <1383918521-4668-1-git-send-email-mkl@pengutronix.de>
 <1383918521-4668-2-git-send-email-mkl@pengutronix.de>
Message-ID: <20131111074709.GE10085@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree list is now devicetree at vger.kernel.org

Shawn

On Fri, Nov 08, 2013 at 02:48:40PM +0100, Marc Kleine-Budde wrote:
> From: Juergen Beisert <jbe@pengutronix.de>
> 
> Instead of hardcoding the ref_xtal in the clk driver, get it from the DT.
> 
> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx28.dtsi | 10 ++++++++++
>  drivers/clk/mxs/clk-imx28.c  | 18 ++++++++++++++++--
>  2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 7363fde..979c37d 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -43,6 +43,16 @@
>  		};
>  	};
>  
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		xtal-24m {
> +			compatible = "fsl,mxs-xtal-24m", "fixed-clock";
> +			clock-frequency = <24000000>;
> +		};
> +	};
> +
>  	apb at 80000000 {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
> diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
> index 4faf0af..874ca4e 100644
> --- a/drivers/clk/mxs/clk-imx28.c
> +++ b/drivers/clk/mxs/clk-imx28.c
> @@ -156,7 +156,7 @@ static enum imx28_clk clks_init_on[] __initdata = {
>  
>  int __init mx28_clocks_init(void)
>  {
> -	struct device_node *np;
> +	struct device_node *np, *np_tmp;
>  	u32 i;
>  
>  	np = of_find_compatible_node(NULL, NULL, "fsl,imx28-digctl");
> @@ -169,7 +169,21 @@ int __init mx28_clocks_init(void)
>  
>  	clk_misc_init();
>  
> -	clks[ref_xtal] = mxs_clk_fixed("ref_xtal", 24000000);
> +	/* retrieve the crystal's frequencies from device tree */
> +	for_each_compatible_node(np_tmp, NULL, "fixed-clock") {
> +		u32 rate;
> +
> +		if (of_property_read_u32(np_tmp, "clock-frequency", &rate))
> +			continue;
> +
> +		if (of_device_is_compatible(np_tmp, "fsl,mxs-xtal-24m"))
> +			clks[ref_xtal] = mxs_clk_fixed("ref_xtal", rate);
> +	}
> +
> +	/* if not set, use default frequency */
> +	if (!clks[ref_xtal])
> +		clks[ref_xtal] = mxs_clk_fixed("ref_xtal", 24000000);
> +
>  	clks[pll0] = mxs_clk_pll("pll0", "ref_xtal", PLL0CTRL0, 17, 480000000);
>  	clks[pll1] = mxs_clk_pll("pll1", "ref_xtal", PLL1CTRL0, 17, 480000000);
>  	clks[pll2] = mxs_clk_pll("pll2", "ref_xtal", PLL2CTRL0, 23, 50000000);
> -- 
> 1.8.4.rc3
> 
