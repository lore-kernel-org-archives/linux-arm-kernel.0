From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 06 Feb 2018 13:06:25 +0900
Subject: [PATCH 2/3] clk: exynos5433: Allow audio subsystem clock rate
 propagation
In-Reply-To: <20180205142230.9755-2-s.nawrocki@samsung.com>
References: <20180205142230.9755-1-s.nawrocki@samsung.com>
 <CGME20180205142308epcas2p376f8656f7e421f8474938de788cea8db@epcas2p3.samsung.com>
 <20180205142230.9755-2-s.nawrocki@samsung.com>
Message-ID: <5A7929C1.8040706@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On 2018? 02? 05? 23:22, Sylwester Nawrocki wrote:
> CLK_SET_RATE_PARENT flag is added to definitions of clocks on a path
> starting from CLK_SCLK_I2S1 up to AUD_PLL in order to allow setting
> required audio root clock frequency for the I2S1 block. This is now
> only done for the I2S1 block, related CMU_TOP, CMU_PERIC clock
> definitions are changed.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5433.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
> index 74b70ddab4d6..d74361736e64 100644
> --- a/drivers/clk/samsung/clk-exynos5433.c
> +++ b/drivers/clk/samsung/clk-exynos5433.c
> @@ -246,14 +246,14 @@ static const struct samsung_fixed_rate_clock top_fixed_clks[] __initconst = {
>  
>  static const struct samsung_mux_clock top_mux_clks[] __initconst = {
>  	/* MUX_SEL_TOP0 */
> -	MUX(CLK_MOUT_AUD_PLL, "mout_aud_pll", mout_aud_pll_p, MUX_SEL_TOP0,
> -			4, 1),
> +	MUX_F(CLK_MOUT_AUD_PLL, "mout_aud_pll", mout_aud_pll_p, MUX_SEL_TOP0,
> +	      4, 1, CLK_SET_RATE_PARENT, 0),

If you add CLK_SET_RATE_PARENT to 'mout_aud_pll' and mout_aud_pll changes the rate,
fout_aud_pll's rate will be changed. But, fout_aud_pll is also the parent
of 'mout_aud_pll_user'. It might change the rate of children of mout_aud_pll_user.
mout_aud_pll_user would not want to change the parent's clock.

    fout_aud_pll                          2            2   196608009          0 0  
       mout_aud_pll_user                  1            1   196608009          0 0  
       mout_aud_pll                       0            0   196608009          0 0  


>  	MUX(CLK_MOUT_ISP_PLL, "mout_isp_pll", mout_isp_pll_p, MUX_SEL_TOP0,
>  			0, 1),
>  
>  	/* MUX_SEL_TOP1 */
> -	MUX(CLK_MOUT_AUD_PLL_USER_T, "mout_aud_pll_user_t",
> -			mout_aud_pll_user_p, MUX_SEL_TOP1, 12, 1),
> +	MUX_F(CLK_MOUT_AUD_PLL_USER_T, "mout_aud_pll_user_t",
> +	      mout_aud_pll_user_p, MUX_SEL_TOP1, 12, 1, CLK_SET_RATE_PARENT, 0),
>  	MUX(CLK_MOUT_MPHY_PLL_USER, "mout_mphy_pll_user", mout_mphy_pll_user_p,
>  			MUX_SEL_TOP1, 8, 1),
>  	MUX(CLK_MOUT_MFC_PLL_USER, "mout_mfc_pll_user", mout_mfc_pll_user_p,
> @@ -370,8 +370,8 @@ static const struct samsung_mux_clock top_mux_clks[] __initconst = {
>  			MUX_SEL_TOP_PERIC1, 16, 1),
>  	MUX(CLK_MOUT_SCLK_SPDIF, "mout_sclk_spdif", mout_sclk_spdif_p,
>  			MUX_SEL_TOP_PERIC1, 12, 2),
> -	MUX(CLK_MOUT_SCLK_AUDIO1, "mout_sclk_audio1", mout_sclk_audio1_p,
> -			MUX_SEL_TOP_PERIC1, 4, 2),
> +	MUX_F(CLK_MOUT_SCLK_AUDIO1, "mout_sclk_audio1", mout_sclk_audio1_p,
> +			MUX_SEL_TOP_PERIC1, 4, 2, CLK_SET_RATE_PARENT, 0),
>  	MUX(CLK_MOUT_SCLK_AUDIO0, "mout_sclk_audio0", mout_sclk_audio0_p,
>  			MUX_SEL_TOP_PERIC1, 0, 2),
>  
> @@ -524,12 +524,12 @@ static const struct samsung_div_clock top_div_clks[] __initconst = {
>  			DIV_TOP_PERIC2, 0, 4),
>  
>  	/* DIV_TOP_PERIC3 */
> -	DIV(CLK_DIV_SCLK_I2S1, "div_sclk_i2s1", "sclk_audio1",
> -			DIV_TOP_PERIC3, 16, 6),
> +	DIV_F(CLK_DIV_SCLK_I2S1, "div_sclk_i2s1", "sclk_audio1",
> +			DIV_TOP_PERIC3, 16, 6, CLK_SET_RATE_PARENT, 0),
>  	DIV(CLK_DIV_SCLK_PCM1, "div_sclk_pcm1", "sclk_audio1",
>  			DIV_TOP_PERIC3, 8, 8),
> -	DIV(CLK_DIV_SCLK_AUDIO1, "div_sclk_audio1", "mout_sclk_audio1",
> -			DIV_TOP_PERIC3, 4, 4),
> +	DIV_F(CLK_DIV_SCLK_AUDIO1, "div_sclk_audio1", "mout_sclk_audio1",
> +			DIV_TOP_PERIC3, 4, 4, CLK_SET_RATE_PARENT, 0),
>  	DIV(CLK_DIV_SCLK_AUDIO0, "div_sclk_audio0", "mout_sclk_audio0",
>  			DIV_TOP_PERIC3, 0, 4),
>  
> @@ -693,7 +693,7 @@ static const struct samsung_gate_clock top_gate_clks[] __initconst = {
>  	GATE(CLK_SCLK_SLIMBUS, "sclk_slimbus", "mout_sclk_slimbus",
>  			MUX_ENABLE_TOP_PERIC1, 16, 0, 0),
>  	GATE(CLK_SCLK_AUDIO1, "sclk_audio1", "div_sclk_audio1",
> -			MUX_ENABLE_TOP_PERIC1, 4, 0, 0),
> +			MUX_ENABLE_TOP_PERIC1, 4, CLK_SET_RATE_PARENT, 0),
>  	GATE(CLK_SCLK_AUDIO0, "sclk_audio0", "div_sclk_audio0",
>  			MUX_ENABLE_TOP_PERIC1, 0, 0, 0),
>  };
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
