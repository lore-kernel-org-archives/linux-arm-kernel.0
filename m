From: mturquette@baylibre.com (Michael Turquette)
Date: Sat, 13 Oct 2018 18:08:10 +0200
Subject: [PATCH] clk: meson-gxbb: set fclk_div3 as CLK_IS_CRITICAL
In-Reply-To: <1539425086-10997-1-git-send-email-christianshewitt@gmail.com>
References: <1539425086-10997-1-git-send-email-christianshewitt@gmail.com>
Message-ID: <20181013160810.88481.14237@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Christian Hewitt (2018-10-13 12:04:46)
> On the Khadas VIM2 (GXM) and LePotato (GXL) board there are problems
> with reboot; e.g. a ~60 second delay between issuing reboot and the
> board power cycling (and in some OS configurations reboot will fail
> and require manual power cycling).
> 
> Similar to 'commit c987ac6f1f088663b6dad39281071aeb31d450a8 ("clk:
> meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL")' the SCPI Cortex-M4
> Co-Processor seems to depend on FCLK_DIV3 being operational.
> 
> Bisect gives 'commit 05f814402d6174369b3b29832cbb5eb5ed287059 ("clk:
> meson: add fdiv clock gates") between 4.16 and 4.16-rc1 as the first
> bad commit. This added support for the missing clock gates before the
> fixed PLL fixed dividers (FCLK_DIVx) and the clock framework which
> disabled all the unused fixed dividers, thus it disabled a critical
> clock path for the SCPI Co-Processor.
> 
> This change simply sets the FCLK_DIV3 gate as critical to ensure
> nothing can disable it.

I'm a bit skeptical of this. If FCLK_DIV3 is gated at run-time, there is
no side effect other than long and/or failed reboot?

Seems like someone should be managing this clock, and simply leaving it
on all the time isn't necessarily the right approach. Any chance that
you can dig into this behavior to better understand it?

It's easy to solve issues by leaving clocks on all the time, but this
becomes a problem later on when trying to tune a device for power.

Also, if this commit really is the right fix, it should include a
comment for FCLK_DIV3 stating why the CLK_IS_CRITICAL flag was set,
which may be helpful later on to know if it is safe to remove it. Same
is true for FCLK_DIV2 in c987ac6f1f088663b6dad39281071aeb31d450a8.

Regards,
Mike

> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  drivers/clk/meson/gxbb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index 86d3ae5..4c8925d 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -509,6 +509,7 @@ static struct clk_fixed_factor gxbb_fclk_div3_div = {
>                 .ops = &clk_fixed_factor_ops,
>                 .parent_names = (const char *[]){ "fixed_pll" },
>                 .num_parents = 1,
> +               .flags = CLK_IS_CRITICAL,
>         },
>  };
>  
> -- 
> 2.7.4
