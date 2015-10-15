From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 15 Oct 2015 10:37:19 +0900
Subject: [PATCH v1 1/2] clk: samsung: exynos5250: Add DISP1 clocks
In-Reply-To: <1444819457-27519-2-git-send-email-tomeu.vizoso@collabora.com>
References: <1444819457-27519-1-git-send-email-tomeu.vizoso@collabora.com>
 <1444819457-27519-2-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <561F034F.8000607@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.10.2015 19:44, Tomeu Vizoso wrote:
> When the DISP1 power domain is powered off, there's two clocks that need
> to be temporarily reparented to OSC, and back to their original parents
> when the domain is powered on again.
> 
> We expose these two clocks in the DT bindings so that the DT node of the
> power domain can reference them.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
> 
>  drivers/clk/samsung/clk-exynos5250.c   | 16 +++++++++++++++-
>  include/dt-bindings/clock/exynos5250.h |  4 +++-
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
> index 55b83c7ef878..918e40fa6aa1 100644
> --- a/drivers/clk/samsung/clk-exynos5250.c
> +++ b/drivers/clk/samsung/clk-exynos5250.c
> @@ -222,9 +222,14 @@ PNAME(mout_mpll_user_p)	= { "fin_pll", "mout_mpll" };
>  PNAME(mout_bpll_user_p)	= { "fin_pll", "mout_bpll" };
>  PNAME(mout_aclk166_p)	= { "mout_cpll", "mout_mpll_user" };
>  PNAME(mout_aclk200_p)	= { "mout_mpll_user", "mout_bpll_user" };
> +PNAME(mout_aclk300_p)	= { "mout_aclk300_disp1_mid",
> +			    "mout_aclk300_disp1_mid1" };
>  PNAME(mout_aclk400_p)	= { "mout_aclk400_g3d_mid", "mout_gpll" };
>  PNAME(mout_aclk200_sub_p) = { "fin_pll", "div_aclk200" };
>  PNAME(mout_aclk266_sub_p) = { "fin_pll", "div_aclk266" };
> +PNAME(mout_aclk300_sub_p) = { "fin_pll", "div_aclk300" };
> +PNAME(mout_aclk300_disp1_mid_p) = { "mout_mpll_user", "mout_bpll_user" };

There is no need for that, just use existing mout_aclk200_p.

> +PNAME(mout_aclk300_disp1_mid1_p) = { "mout_vpll", "mout_cpll" };
>  PNAME(mout_aclk333_sub_p) = { "fin_pll", "div_aclk333" };
>  PNAME(mout_aclk400_isp_sub_p) = { "fin_pll", "div_aclk400_isp" };
>  PNAME(mout_hdmi_p)	= { "div_hdmi_pixel", "sclk_hdmiphy" };
> @@ -303,9 +308,14 @@ static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
>  	 */
>  	MUX(0, "mout_aclk166", mout_aclk166_p, SRC_TOP0, 8, 1),
>  	MUX(0, "mout_aclk200", mout_aclk200_p, SRC_TOP0, 12, 1),
> +	MUX(0, "mout_aclk300_disp1_mid", mout_aclk300_disp1_mid_p, SRC_TOP0,
> +		14, 1),
> +	MUX(0, "mout_aclk300", mout_aclk300_p, SRC_TOP0, 15, 1),
>  	MUX(0, "mout_aclk333", mout_aclk166_p, SRC_TOP0, 16, 1),
>  	MUX(0, "mout_aclk400_g3d_mid", mout_aclk200_p, SRC_TOP0, 20, 1),
>  
> +	MUX(0, "mout_aclk300_disp1_mid1", mout_aclk300_disp1_mid1_p, SRC_TOP1,
> +		8, 1),
>  	MUX(0, "mout_aclk400_isp", mout_aclk200_p, SRC_TOP1, 24, 1),
>  	MUX(0, "mout_aclk400_g3d", mout_aclk400_p, SRC_TOP1, 28, 1),
>  
> @@ -316,7 +326,10 @@ static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
>  	MUX(0, "mout_bpll_user", mout_bpll_user_p, SRC_TOP2, 24, 1),
>  	MUX(CLK_MOUT_GPLL, "mout_gpll", mout_gpll_p, SRC_TOP2, 28, 1),
>  
> -	MUX(0, "mout_aclk200_disp1_sub", mout_aclk200_sub_p, SRC_TOP3, 4, 1),
> +	MUX(CLK_MOUT_ACLK200_DISP1_SUB, "mout_aclk200_disp1_sub",
> +		mout_aclk200_sub_p, SRC_TOP3, 4, 1),
> +	MUX(CLK_MOUT_ACLK300_DISP1_SUB, "mout_aclk300_disp1_sub",
> +		mout_aclk300_sub_p, SRC_TOP3, 6, 1),
>  	MUX(0, "mout_aclk266_gscl_sub", mout_aclk266_sub_p, SRC_TOP3, 8, 1),
>  	MUX(0, "mout_aclk_266_isp_sub", mout_aclk266_sub_p, SRC_TOP3, 16, 1),
>  	MUX(0, "mout_aclk_400_isp_sub", mout_aclk400_isp_sub_p,
> @@ -392,6 +405,7 @@ static struct samsung_div_clock exynos5250_div_clks[] __initdata = {
>  	DIV(0, "div_aclk333", "mout_aclk333", DIV_TOP0, 20, 3),
>  	DIV(0, "div_aclk400_g3d", "mout_aclk400_g3d", DIV_TOP0,
>  							24, 3),
> +	DIV(0, "div_aclk300", "mout_aclk300", DIV_TOP0, 28, 3),

Maybe use name "div_aclk300_disp"? There is similar clock for GSCALER,
so the div_aclk300 would be too generic.

Best regards,
Krzysztof

>  
>  	DIV(0, "div_aclk400_isp", "mout_aclk400_isp", DIV_TOP1, 20, 3),
>  	DIV(0, "div_aclk66_pre", "mout_mpll_user", DIV_TOP1, 24, 3),
> diff --git a/include/dt-bindings/clock/exynos5250.h b/include/dt-bindings/clock/exynos5250.h
> index 8183d1c237d9..15508adcdfde 100644
> --- a/include/dt-bindings/clock/exynos5250.h
> +++ b/include/dt-bindings/clock/exynos5250.h
> @@ -173,8 +173,10 @@
>  /* mux clocks */
>  #define CLK_MOUT_HDMI		1024
>  #define CLK_MOUT_GPLL		1025
> +#define CLK_MOUT_ACLK200_DISP1_SUB	1026
> +#define CLK_MOUT_ACLK300_DISP1_SUB	1027
>  
>  /* must be greater than maximal clock id */
> -#define CLK_NR_CLKS		1026
> +#define CLK_NR_CLKS		1028
>  
>  #endif /* _DT_BINDINGS_CLOCK_EXYNOS_5250_H */
> 
