From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 29 Jul 2014 12:44:17 +0200
Subject: [PATCH v8 6/6] clk: samsung: remove unused clock aliases and
 update clock flags
In-Reply-To: <1406611711-25112-7-git-send-email-thomas.ab@samsung.com>
References: <1406611711-25112-1-git-send-email-thomas.ab@samsung.com>
 <1406611711-25112-7-git-send-email-thomas.ab@samsung.com>
Message-ID: <53D77B01.40702@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

You can find few comments inline.

On 29.07.2014 07:28, Thomas Abraham wrote:

[snip]

> @@ -714,15 +715,24 @@ static struct samsung_div_clock exynos4_div_clks[] __initdata = {
                                                        ^^^

Keep in mind that following clocks are common for Exynos4210 and
Exynos4x12. Have you tested this series on a board based on Exynos4212
or 4412 to verify that it does not break the legacy driver? (I would
test it myself, but I am on holidays at the moment.)

>  	DIV(0, "div_clkout_rightbus", "mout_clkout_rightbus",
>  			CLKOUT_CMU_RIGHTBUS, 8, 6),
>  
> -	DIV(0, "div_core", "mout_core", DIV_CPU0, 0, 3),
> -	DIV(0, "div_corem0", "div_core2", DIV_CPU0, 4, 3),
> -	DIV(0, "div_corem1", "div_core2", DIV_CPU0, 8, 3),
> -	DIV(0, "div_periph", "div_core2", DIV_CPU0, 12, 3),

[snip]

> @@ -1501,7 +1507,7 @@ static void __init exynos4_clk_init(struct device_node *np,
>  		exynos4_soc == EXYNOS4210 ? "Exynos4210" : "Exynos4x12",
>  		_get_rate("sclk_apll"),	_get_rate("sclk_mpll"),
>  		_get_rate("sclk_epll"), _get_rate("sclk_vpll"),
> -		_get_rate("arm_clk"));
> +		_get_rate("armclk"));

This will not work on Exynos4412, because there is no "armclk" added for
this SoC. My suggestion is to simply keep name of the clock as is, move
current "arm_clk" divider to Exynos4x12-specific clocks and register
Exynos4210 CPU clock as "arm_clk".

Best regards,
Tomasz
