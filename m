From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 08 Aug 2013 18:18:20 -0700
Subject: [PATCH] ARM: OMAP4: clock: Lock PLLs in the right sequence
In-Reply-To: <1375956851-842-1-git-send-email-rnayak@ti.com>
References: <1375956851-842-1-git-send-email-rnayak@ti.com>
Message-ID: <20130809011820.5348.78407@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Rajendra Nayak (2013-08-08 03:14:11)
> On OMAP4 we have clk_set_rate()s being done for a few
> DPLL clock nodes, as part of the clock init code, since
> the bootloaders no longer locks these DPLLs.
...
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Taken into clk-next. Thanks for the fix. Besides the annoying prints is
there a functional regression fixed by this? If so I can take into
clk-fixes as needed.

I haven't spent much time thinking about this, but I wonder if
representing the DPLLs as proper mux clocks with multiple parents coming
in would have helped here? Right now the DPLL implementation sort of
manages the mux bits behind the clock framework's back, right?

Regards,
Mike

> ---
>  arch/arm/mach-omap2/cclock44xx_data.c |   20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
> index 88e37a4..1d5b529 100644
> --- a/arch/arm/mach-omap2/cclock44xx_data.c
> +++ b/arch/arm/mach-omap2/cclock44xx_data.c
> @@ -1707,6 +1707,18 @@ int __init omap4xxx_clk_init(void)
>         omap2_clk_disable_autoidle_all();
>  
>         /*
> +        * A set rate of ABE DPLL inturn triggers a set rate of USB DPLL
> +        * when its in bypass. So always lock USB before ABE DPLL.
> +        */
> +       /*
> +        * Lock USB DPLL on OMAP4 devices so that the L3INIT power
> +        * domain can transition to retention state when not in use.
> +        */
> +       rc = clk_set_rate(&dpll_usb_ck, OMAP4_DPLL_USB_DEFFREQ);
> +       if (rc)
> +               pr_err("%s: failed to configure USB DPLL!\n", __func__);
> +
> +       /*
>          * On OMAP4460 the ABE DPLL fails to turn on if in idle low-power
>          * state when turning the ABE clock domain. Workaround this by
>          * locking the ABE DPLL on boot.
> @@ -1718,13 +1730,5 @@ int __init omap4xxx_clk_init(void)
>         if (rc)
>                 pr_err("%s: failed to configure ABE DPLL!\n", __func__);
>  
> -       /*
> -        * Lock USB DPLL on OMAP4 devices so that the L3INIT power
> -        * domain can transition to retention state when not in use.
> -        */
> -       rc = clk_set_rate(&dpll_usb_ck, OMAP4_DPLL_USB_DEFFREQ);
> -       if (rc)
> -               pr_err("%s: failed to configure USB DPLL!\n", __func__);
> -
>         return 0;
>  }
> -- 
> 1.7.9.5
