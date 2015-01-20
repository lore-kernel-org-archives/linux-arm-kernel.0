From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 20 Jan 2015 09:37:55 -0800
Subject: [PATCH 1/4] clk: st: STiH410: Fix pdiv and fdiv divisor when
 setting rate
In-Reply-To: <1421767964-8798-2-git-send-email-peter.griffin@linaro.org>
References: <1421767964-8798-1-git-send-email-peter.griffin@linaro.org>
 <1421767964-8798-2-git-send-email-peter.griffin@linaro.org>
Message-ID: <20150120173755.22722.80361@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Griffin (2015-01-20 07:32:41)
> Debugging eMMC on upstream kernels it has been noticed that when the
> targetpack configures MMC0 clock to 200Mhz (required to switch to
> HS200) then everything works OK. However if the kernel sets the
> clock rate using clk_set_rate, then the eMMC card initialisation
> fails with timeouts. Lower clock speeds (the default being 50Mhz)
> work ok, but they we fail to get good eMMC transfer rates.
> 
> Looking through the vendor kernel clock driver reveals Giuseppe
> had already fixed this issue, but the patch hasn't made its way
> upstream.
> 
> The issue is fixed by changing the logic to manage the pdiv and
> fdiv divisors used for setting the rate inside the flexgen driver code.
> 
> Pdiv is mainly targeted for low freq results, while fdiv should be
> used for divs =< 64. The other way can lead to 'duty cycle'
> issues.
> 
> I have changed the original patch to keep the original behaviour
> in cases where the div is >64 which matches the original comment
> and patch description more closely. Although no clocks appear to hit
> this case currently when booting an upstream kernel.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>

Applied to clk-next.

Regards,
Mike

> ---
>  drivers/clk/st/clk-flexgen.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/st/clk-flexgen.c b/drivers/clk/st/clk-flexgen.c
> index 2282cef..3a484b3 100644
> --- a/drivers/clk/st/clk-flexgen.c
> +++ b/drivers/clk/st/clk-flexgen.c
> @@ -138,16 +138,27 @@ static int flexgen_set_rate(struct clk_hw *hw, unsigned long rate,
>         struct flexgen *flexgen = to_flexgen(hw);
>         struct clk_hw *pdiv_hw = &flexgen->pdiv.hw;
>         struct clk_hw *fdiv_hw = &flexgen->fdiv.hw;
> -       unsigned long primary_div = 0;
> +       unsigned long div = 0;
>         int ret = 0;
>  
>         pdiv_hw->clk = hw->clk;
>         fdiv_hw->clk = hw->clk;
>  
> -       primary_div = clk_best_div(parent_rate, rate);
> +       div = clk_best_div(parent_rate, rate);
>  
> -       clk_divider_ops.set_rate(fdiv_hw, parent_rate, parent_rate);
> -       ret = clk_divider_ops.set_rate(pdiv_hw, rate, rate * primary_div);
> +       /*
> +       * pdiv is mainly targeted for low freq results, while fdiv
> +       * should be used for div <= 64. The other way round can
> +       * lead to 'duty cycle' issues.
> +       */
> +
> +       if (div <= 64) {
> +               clk_divider_ops.set_rate(pdiv_hw, parent_rate, parent_rate);
> +               ret = clk_divider_ops.set_rate(fdiv_hw, rate, rate * div);
> +       } else {
> +               clk_divider_ops.set_rate(fdiv_hw, parent_rate, parent_rate);
> +               ret = clk_divider_ops.set_rate(pdiv_hw, rate, rate * div);
> +       }
>  
>         return ret;
>  }
> -- 
> 1.9.1
> 
