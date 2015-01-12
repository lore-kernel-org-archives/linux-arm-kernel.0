From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 12 Jan 2015 15:44:24 -0800
Subject: [RESEND PATCH] clk: at91: keep slow clk enabled to prevent system
 hang
In-Reply-To: <1421075570-31200-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1421075570-31200-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150112234424.20842.37457@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Boris Brezillon (2015-01-12 07:12:50)
> All slow clk users are not properly requesting it (get + prepare + enable)
> before using it.
> If all users properly requesting this clock decide that they don't need it
> anymore (or are removed), this lead to this clock being disabled while
> faulty users are still requiring it, which in turn hangs the system.

The correct fix is for all users to claim the clock and enable it. Is
there a plan to implement that any time soon?

> 
> Prevent slow oscillator clock from being disabled until all users are
> properly requesting it.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Reported-by: Bo Shen <voice.shen@atmel.com>
> Cc: stable at vger.kernel.org
> ---
> Hi Mike,
> 
> Sorry for the noise, but I forgot to add the LKML and LAKML in Cc.
> 
> Can you have a look at this fix and let me know if this is how you want this
> problem addressed ?
> I can also request (get + prepare + enable) the clk in the pmc probe function,
> so that it can never be disabled.
> 
> If you're fine with the approach, can you queue it for the next -rc ?

I can queue something for the next -rc, but maybe not this fix.

> 
> Best Regards,
> 
> Boris
> 
>  drivers/clk/at91/clk-slow.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-slow.c b/drivers/clk/at91/clk-slow.c
> index 32f7c1b..effe3b0 100644
> --- a/drivers/clk/at91/clk-slow.c
> +++ b/drivers/clk/at91/clk-slow.c
> @@ -96,7 +96,19 @@ static void clk_slow_osc_unprepare(struct clk_hw *hw)
>         if (tmp & AT91_SCKC_OSC32BYP)
>                 return;
>  
> -       writel(tmp & ~AT91_SCKC_OSC32EN, sckcr);
> +       /*
> +        * FIXME: All slow clk users are not properly requesting it (get +
> +        * prepare + enable) before using it.
> +        * If all users properly requesting this clock decide that they don't
> +        * need it anymore (or are removed), this lead to this clock being
> +        * disabled while faulty users are still requiring it, which in turn
> +        * hangs the system.
> +        * Prevent this clock from being disabled until all users are properly
> +        * requesting it.
> +        * Once this is done we should re-introduce this line:
> +        *
> +        * writel(tmp & ~AT91_SCKC_OSC32EN, sckcr);
> +        */

The main problem here is that the clk prepare and enable usecounts are a
lie. The use counts may be zero but the clock signal is still active. I
think a better fix is for the clock driver to get, prepare & enable this
clock in its probe function as you described above. If someone stumbles
across this clock signal and wonders why it won't quiesce, at least the
debug values will be accurate.

Regards,
Mike

>  }
>  
>  static int clk_slow_osc_is_prepared(struct clk_hw *hw)
> @@ -211,7 +223,19 @@ static void clk_slow_rc_osc_unprepare(struct clk_hw *hw)
>         struct clk_slow_rc_osc *osc = to_clk_slow_rc_osc(hw);
>         void __iomem *sckcr = osc->sckcr;
>  
> -       writel(readl(sckcr) & ~AT91_SCKC_RCEN, sckcr);
> +       /*
> +        * FIXME: All slow clk users are not properly requesting it (get +
> +        * prepare + enable) before using it.
> +        * If all users properly requesting this clock decide that they don't
> +        * need it anymore (or are removed), this lead to this clock being
> +        * disabled while faulty users are still requiring it, which in turn
> +        * hangs the system.
> +        * Prevent this clock from being disabled until all users are properly
> +        * requesting it.
> +        * Once this is done we should re-introduce this line:
> +        *
> +        * writel(readl(sckcr) & ~AT91_SCKC_RCEN, sckcr);
> +        */
>  }
>  
>  static int clk_slow_rc_osc_is_prepared(struct clk_hw *hw)
> -- 
> 1.9.1
> 
