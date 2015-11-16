From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Mon, 16 Nov 2015 09:27:11 +0100
Subject: [PATCH] clk: st: avoid uninitialized variable use
In-Reply-To: <3719029.IbREgssWiU@wuerfel>
References: <3719029.IbREgssWiU@wuerfel>
Message-ID: <CAG374jDjjWTSwW+Sbu=fX77pWk2OB-=J1z3zbcjwuobxgJMH2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 November 2015 at 15:24, Arnd Bergmann <arnd@arndb.de> wrote:
> quadfs_pll_fs660c32_round_rate prints a few structure members
> that are never initialized, and also doesn't print the only one
> it cares about. We get a gcc warning about the ones that
> are printed:
>
> clk/st/clkgen-fsyn.c:560:93: warning: 'params.sdiv' may be used uninitialized in this function
> clk/st/clkgen-fsyn.c:560:93: warning: 'params.mdiv' may be used uninitialized in this function
> clk/st/clkgen-fsyn.c:560:93: warning: 'params.pe' may be used uninitialized in this function
> clk/st/clkgen-fsyn.c:560:93: warning: 'params.nsdiv' may be used uninitialized in this function
>
> This changes the code to no longer print uninitialized data, and
> for good measure it also prints the ndiv member that is being
> set.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 5f7aa9071e93 ("clk: st: Support for QUADFS inside ClockGenB/C/D/E/F")
>
> diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
> index 576cd0354d48..ccb324d97160 100644
> --- a/drivers/clk/st/clkgen-fsyn.c
> +++ b/drivers/clk/st/clkgen-fsyn.c
> @@ -549,19 +549,20 @@ static int clk_fs660c32_vco_get_params(unsigned long input,
>         return 0;
>  }
>
> -static long quadfs_pll_fs660c32_round_rate(struct clk_hw *hw, unsigned long rate
> -               , unsigned long *prate)
> +static long quadfs_pll_fs660c32_round_rate(struct clk_hw *hw,
> +                                          unsigned long rate,
> +                                          unsigned long *prate)
>  {
>         struct stm_fs params;
>
> -       if (!clk_fs660c32_vco_get_params(*prate, rate, &params))
> -               clk_fs660c32_vco_get_rate(*prate, &params, &rate);
> +       if (clk_fs660c32_vco_get_params(*prate, rate, &params))
> +               return rate;
>
> -       pr_debug("%s: %s new rate %ld [sdiv=0x%x,md=0x%x,pe=0x%x,nsdiv3=%u]\n",
> +       clk_fs660c32_vco_get_rate(*prate, &params, &rate);
> +
> +       pr_debug("%s: %s new rate %ld [ndiv=%u]\n",
>                  __func__, clk_hw_get_name(hw),
> -                rate, (unsigned int)params.sdiv,
> -                (unsigned int)params.mdiv,
> -                (unsigned int)params.pe, (unsigned int)params.nsdiv);
> +                rate, (unsigned int)params.ndiv);
>
>         return rate;
>  }
>
>
Acked-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>

Thanks
