From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 7 Mar 2013 14:33:40 +0800
Subject: [PATCH 2/9] MXS/i.MX28: add the possibility to define the
 external RTC crystal
In-Reply-To: <1362405948-12992-3-git-send-email-s.trumtrar@pengutronix.de>
References: <1362405948-12992-1-git-send-email-s.trumtrar@pengutronix.de>
 <1362405948-12992-3-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <20130307063337.GB5372@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 04, 2013 at 03:05:41PM +0100, Steffen Trumtrar wrote:
> From: Juergen Beisert <jbe@pengutronix.de>
> 
> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>

You should have your SoB added here.

> ---
>  arch/arm/boot/dts/imx28.dtsi |    6 ++++++
>  drivers/clk/mxs/clk-imx28.c  |    4 +++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 958bd10..dcd0844 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -41,6 +41,12 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> +		osc32k: rtc_oscillator {

Please use "-" than "_" in node name.

> +			compatible = "fsl,mxs-rtc", "fixed-clock";

I would suggest drop "fsl,mxs-rtc" here, and ...

> +			#clock-cells = <0>;
> +			clock-frequency = <0>;
> +		};
> +
>  		osc24m: system_oscillator {
>  			compatible = "fsl,mxs-system", "fixed-clock";
>  			#clock-cells = <0>;
> diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
> index 01048b5..a910d72 100644
> --- a/drivers/clk/mxs/clk-imx28.c
> +++ b/drivers/clk/mxs/clk-imx28.c
> @@ -141,7 +141,7 @@ enum imx28_clk {
>  	clk32k_div, rtc, lradc, spdif_div, clk32k, pwm, uart, ssp0,
>  	ssp1, ssp2, ssp3, gpmi, spdif, emi, saif0, saif1, lcdif, etm,
>  	fec, can0, can1, usb0, usb1, usb0_phy, usb1_phy, enet_out,
> -	clk_max
> +	rtc_32k, clk_max

Number it in binding doc.

>  };
>  
>  static struct clk *clks[clk_max];
> @@ -167,6 +167,8 @@ int __init mx28_clocks_init(void)
>  
>  		if (of_device_is_compatible(np, "fsl,mxs-system"))
>  			clks[ref_xtal] = mxs_clk_fixed("ref_xtal", rate);
> +		else if (of_device_is_compatible(np, "fsl,mxs-rtc"))

... use node name to match, so that we can save a custom compatible.

Shawn

> +			clks[rtc_32k] = mxs_clk_fixed("rtc32k", rate);
>  	}
>  
>  	/* if not set, guess their frequency */
> -- 
> 1.7.10.4
> 
