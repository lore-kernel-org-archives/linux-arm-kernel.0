From: mturquette@baylibre.com (Michael Turquette)
Date: Wed, 13 Jan 2016 12:00:12 -0800
Subject: [PATCH V2 1/4] clk: bcm2835: avoid the use of BCM2835_CLOCK_COUNT
 in clk-bcm2835
In-Reply-To: <1452542157-2387-2-git-send-email-kernel@martin.sperl.org>
References: <1452542157-2387-1-git-send-email-kernel@martin.sperl.org>
 <1452542157-2387-2-git-send-email-kernel@martin.sperl.org>
Message-ID: <20160113200012.1168.74515@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

Quoting kernel at martin.sperl.org (2016-01-11 11:55:53)
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> As the use of BCM2835_CLOCK_COUNT in
> include/dt-bindings/clock/bcm2835.h is frowned upon as
> it needs to get modified every time a new clock gets introduced
> this patch changes the clk-bcm2835 driver to use a different
> scheme for registration of clocks and pll, so that there
> is no more need for BCM2835_CLOCK_COUNT to be defined.
> 
> The way the patch is designed also makes sure to allow control
> the order in which the clocks are defined.
> 
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>  drivers/clk/bcm/clk-bcm2835.c       |  208 +++++++++++++++++++++++++----------
>  include/dt-bindings/clock/bcm2835.h |    2 -
>  2 files changed, 147 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index 015e687..759202a 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -288,7 +288,7 @@ struct bcm2835_cprman {
>         const char *osc_name;
> 
>         struct clk_onecell_data onecell;
> -       struct clk *clks[BCM2835_CLOCK_COUNT];
> +       struct clk *clks[];
>  };
> 
>  static inline void cprman_write(struct bcm2835_cprman *cprman, u32 reg, u32 val)
> @@ -1498,14 +1498,146 @@ static struct clk *bcm2835_register_clock(struct bcm2835_cprman *cprman,
>         return devm_clk_register(cprman->dev, &clock->hw);
>  }
> 
> +enum bcm2835_clk_register {
> +       bcm2835_clk_register_pll,
> +       bcm2835_clk_register_pll_div,
> +       bcm2835_clk_register_clock,
> +};
> +
> +/*the list of clocks and plls to register */
> +enum bcm2835_register_clock_type {

Nitpick: s/clock/clk/

It helps with grepping later on. Typically "clock" is used for OF/DT
stuff and clk is used for Linux-specific stuff. This isn't a rule, but
seems to be the de facto standard.

> +       CLK_TYPE_UNSET,
> +       CLK_TYPE_PLL,
> +       CLK_TYPE_PLL_DIV,
> +       CLK_TYPE_CLOCK,
> +};
> +
> +struct bcm2835_register_clock {

Nitpick: how about bcm2835_clk_desc ?

> +       size_t index;
> +       enum bcm2835_register_clock_type clock_type;
> +       const void *data;
> +};
> +
> +#define _REGISTER(i, t, d) { .index = i, .clock_type = t, .data = d }
> +
> +#define REGISTER_PLL(i, d)     _REGISTER(i, CLK_TYPE_PLL, d)
> +#define REGISTER_PLL_DIV(i, d) _REGISTER(i, CLK_TYPE_PLL_DIV, d)
> +#define REGISTER_CLOCK(i, d)   _REGISTER(i, CLK_TYPE_CLOCK, d)
> +
> +/*
> + * note that this array is processed first to last,
> + * so that we can define inititalization order.
> + * with the order right now: pll, pll_div and then clock
> + * this allows to retain the existing id- mapping in the device tree.
> + * ths also means we have to have some more explicit coding
> + * and can not use sparse arrays or similar.
> + */
> +static const struct bcm2835_register_clock bcm2835_register_clocks[] = {
> +       /* the PLL clocks */
> +       REGISTER_PLL(BCM2835_PLLA, &bcm2835_plla_data),
> +       REGISTER_PLL(BCM2835_PLLB, &bcm2835_pllb_data),
> +       REGISTER_PLL(BCM2835_PLLC, &bcm2835_pllc_data),
> +       REGISTER_PLL(BCM2835_PLLD, &bcm2835_plld_data),
> +       REGISTER_PLL(BCM2835_PLLH, &bcm2835_pllh_data),
> +       /* the PLL dividers */
> +       REGISTER_PLL_DIV(BCM2835_PLLA_CORE, &bcm2835_plla_core_data),
> +       REGISTER_PLL_DIV(BCM2835_PLLA_PER, &bcm2835_plla_per_data),
> +       REGISTER_PLL_DIV(BCM2835_PLLC_CORE0, &bcm2835_pllc_core0_data),
> +       REGISTER_PLL_DIV(BCM2835_PLLC_CORE1, &bcm2835_pllc_core1_data),
> +       REGISTER_PLL_DIV(BCM2835_PLLC_CORE2, &bcm2835_pllc_core2_data),
> +       REGISTER_PLL_DIV(BCM2835_PLLC_PER, &bcm2835_pllc_per_data),
> +       REGISTER_PLL_DIV(BCM2835_PLLD_CORE, &bcm2835_plld_core_data),
> +       REGISTER_PLL_DIV(BCM2835_PLLD_PER, &bcm2835_plld_per_data),
> +       REGISTER_PLL_DIV(BCM2835_PLLH_RCAL, &bcm2835_pllh_rcal_data),
> +       REGISTER_PLL_DIV(BCM2835_PLLH_AUX, &bcm2835_pllh_aux_data),
> +       REGISTER_PLL_DIV(BCM2835_PLLH_PIX, &bcm2835_pllh_pix_data),
> +       /* the clocks */
> +       REGISTER_CLOCK(BCM2835_CLOCK_TIMER, &bcm2835_clock_timer_data),
> +       REGISTER_CLOCK(BCM2835_CLOCK_OTP, &bcm2835_clock_otp_data),
> +       REGISTER_CLOCK(BCM2835_CLOCK_TSENS, &bcm2835_clock_tsens_data),
> +       REGISTER_CLOCK(BCM2835_CLOCK_VPU, &bcm2835_clock_vpu_data),
> +       REGISTER_CLOCK(BCM2835_CLOCK_V3D, &bcm2835_clock_v3d_data),
> +       REGISTER_CLOCK(BCM2835_CLOCK_ISP, &bcm2835_clock_isp_data),
> +       REGISTER_CLOCK(BCM2835_CLOCK_H264, &bcm2835_clock_h264_data),
> +       REGISTER_CLOCK(BCM2835_CLOCK_V3D, &bcm2835_clock_v3d_data),
> +       REGISTER_CLOCK(BCM2835_CLOCK_SDRAM, &bcm2835_clock_sdram_data),
> +       REGISTER_CLOCK(BCM2835_CLOCK_UART, &bcm2835_clock_uart_data),
> +       REGISTER_CLOCK(BCM2835_CLOCK_VEC, &bcm2835_clock_vec_data),
> +       REGISTER_CLOCK(BCM2835_CLOCK_HSM, &bcm2835_clock_hsm_data),
> +       REGISTER_CLOCK(BCM2835_CLOCK_EMMC, &bcm2835_clock_emmc_data),
> +       REGISTER_CLOCK(BCM2835_CLOCK_PWM, &bcm2835_clock_pwm_data),
> +};
> +
> +void bcm2835_register_duplicate_index(
> +       struct device *dev, const struct bcm2835_register_clock *reg,
> +       struct clk *clk)
> +{
> +       const char *name, *type;
> +
> +       switch (reg->clock_type) {
> +       case CLK_TYPE_PLL:
> +               name = ((struct bcm2835_pll_data *)reg->data)->name;
> +               type = "pll";
> +               break;
> +       case CLK_TYPE_PLL_DIV:
> +               name = ((struct bcm2835_pll_divider_data *)reg->data)->name;
> +               type = "pll divider";
> +               break;
> +       case CLK_TYPE_CLOCK:
> +               name = ((struct bcm2835_clock_data *)reg->data)->name;
> +               type = "clock";
> +               break;
> +       default:
> +               dev_err(dev, "Unsupported clock type %d for index %d\n",
> +                       reg->clock_type, reg->index);
> +               return;
> +       }
> +
> +       dev_err(dev,
> +               "Could not register %s \"%s\" because index %i already defined as clock: %pC\n",
> +               type, name, reg->index, clk);
> +}
> +
> +struct clk *bcm2835_register_pllclock(
> +       struct device *dev, struct bcm2835_cprman *cprman,
> +       const struct bcm2835_register_clock *reg)
> +{
> +       switch (reg->clock_type) {
> +       case CLK_TYPE_PLL:
> +               return bcm2835_register_pll(
> +                       cprman, reg->data);
> +       case CLK_TYPE_PLL_DIV:
> +               return bcm2835_register_pll_divider(
> +                       cprman, reg->data);
> +       case CLK_TYPE_CLOCK:
> +               return bcm2835_register_clock(
> +                       cprman, reg->data);
> +       default:
> +               dev_err(dev, "Unsupported clock type %d for index %d\n",
> +                       reg->clock_type, reg->index);
> +       }
> +
> +       return NULL;
> +}
> +
>  static int bcm2835_clk_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct clk **clks;
> +       size_t clk_cnt;
>         struct bcm2835_cprman *cprman;
>         struct resource *res;
> +       size_t i;
> +
> +       /* find the max clock index */
> +       clk_cnt = BCM2835_CLOCK_PERI_IMAGE; /* see below */
> +       for (i = 0; i < ARRAY_SIZE(bcm2835_register_clocks); i++)
> +               clk_cnt = max(clk_cnt, bcm2835_register_clocks[i].index);
> +       clk_cnt += 1;

I'm not sure how this solution is better than using CLOCK_COUNT. Some
other bindings use a max value, NR_CLKS or other sentinel.

Why did you not choose to set clk_cnt equal to BCM2835_CLOCK_PWM? Why
not initialize it to zero?

> 
> -       cprman = devm_kzalloc(dev, sizeof(*cprman), GFP_KERNEL);
> +       cprman = devm_kzalloc(dev,
> +                             sizeof(*cprman) + clk_cnt * sizeof(*clks),
> +                             GFP_KERNEL);
>         if (!cprman)
>                 return -ENOMEM;
> 
> @@ -1522,65 +1654,22 @@ static int bcm2835_clk_probe(struct platform_device *pdev)
> 
>         platform_set_drvdata(pdev, cprman);
> 
> -       cprman->onecell.clk_num = BCM2835_CLOCK_COUNT;
> +       cprman->onecell.clk_num = clk_cnt;
>         cprman->onecell.clks = cprman->clks;
>         clks = cprman->clks;
> 
> -       clks[BCM2835_PLLA] = bcm2835_register_pll(cprman, &bcm2835_plla_data);
> -       clks[BCM2835_PLLB] = bcm2835_register_pll(cprman, &bcm2835_pllb_data);
> -       clks[BCM2835_PLLC] = bcm2835_register_pll(cprman, &bcm2835_pllc_data);
> -       clks[BCM2835_PLLD] = bcm2835_register_pll(cprman, &bcm2835_plld_data);
> -       clks[BCM2835_PLLH] = bcm2835_register_pll(cprman, &bcm2835_pllh_data);
> -
> -       clks[BCM2835_PLLA_CORE] =
> -               bcm2835_register_pll_divider(cprman, &bcm2835_plla_core_data);
> -       clks[BCM2835_PLLA_PER] =
> -               bcm2835_register_pll_divider(cprman, &bcm2835_plla_per_data);
> -       clks[BCM2835_PLLC_CORE0] =
> -               bcm2835_register_pll_divider(cprman, &bcm2835_pllc_core0_data);
> -       clks[BCM2835_PLLC_CORE1] =
> -               bcm2835_register_pll_divider(cprman, &bcm2835_pllc_core1_data);
> -       clks[BCM2835_PLLC_CORE2] =
> -               bcm2835_register_pll_divider(cprman, &bcm2835_pllc_core2_data);
> -       clks[BCM2835_PLLC_PER] =
> -               bcm2835_register_pll_divider(cprman, &bcm2835_pllc_per_data);
> -       clks[BCM2835_PLLD_CORE] =
> -               bcm2835_register_pll_divider(cprman, &bcm2835_plld_core_data);
> -       clks[BCM2835_PLLD_PER] =
> -               bcm2835_register_pll_divider(cprman, &bcm2835_plld_per_data);
> -       clks[BCM2835_PLLH_RCAL] =
> -               bcm2835_register_pll_divider(cprman, &bcm2835_pllh_rcal_data);
> -       clks[BCM2835_PLLH_AUX] =
> -               bcm2835_register_pll_divider(cprman, &bcm2835_pllh_aux_data);
> -       clks[BCM2835_PLLH_PIX] =
> -               bcm2835_register_pll_divider(cprman, &bcm2835_pllh_pix_data);
> -
> -       clks[BCM2835_CLOCK_TIMER] =
> -               bcm2835_register_clock(cprman, &bcm2835_clock_timer_data);
> -       clks[BCM2835_CLOCK_OTP] =
> -               bcm2835_register_clock(cprman, &bcm2835_clock_otp_data);
> -       clks[BCM2835_CLOCK_TSENS] =
> -               bcm2835_register_clock(cprman, &bcm2835_clock_tsens_data);
> -       clks[BCM2835_CLOCK_VPU] =
> -               bcm2835_register_clock(cprman, &bcm2835_clock_vpu_data);
> -       clks[BCM2835_CLOCK_V3D] =
> -               bcm2835_register_clock(cprman, &bcm2835_clock_v3d_data);
> -       clks[BCM2835_CLOCK_ISP] =
> -               bcm2835_register_clock(cprman, &bcm2835_clock_isp_data);
> -       clks[BCM2835_CLOCK_H264] =
> -               bcm2835_register_clock(cprman, &bcm2835_clock_h264_data);
> -       clks[BCM2835_CLOCK_V3D] =
> -               bcm2835_register_clock(cprman, &bcm2835_clock_v3d_data);
> -       clks[BCM2835_CLOCK_SDRAM] =
> -               bcm2835_register_clock(cprman, &bcm2835_clock_sdram_data);
> -       clks[BCM2835_CLOCK_UART] =
> -               bcm2835_register_clock(cprman, &bcm2835_clock_uart_data);
> -       clks[BCM2835_CLOCK_VEC] =
> -               bcm2835_register_clock(cprman, &bcm2835_clock_vec_data);
> -       clks[BCM2835_CLOCK_HSM] =
> -               bcm2835_register_clock(cprman, &bcm2835_clock_hsm_data);
> -       clks[BCM2835_CLOCK_EMMC] =
> -               bcm2835_register_clock(cprman, &bcm2835_clock_emmc_data);
> +       /* now register */
> +       for (i = 0; i < ARRAY_SIZE(bcm2835_register_clocks); i++) {
> +               if (clks[bcm2835_register_clocks[i].index])
> +                       bcm2835_register_duplicate_index(
> +                               dev, &bcm2835_register_clocks[i],
> +                               clks[bcm2835_register_clocks[i].index]);

Why is this necessary? When do you have duplicate indices?

Regards,
Mike

> +               else
> +                       clks[bcm2835_register_clocks[i].index] =
> +                               bcm2835_register_pllclock(
> +                                       dev, cprman,
> +                                       &bcm2835_register_clocks[i]);
> +       }
> 
>         /*
>          * CM_PERIICTL (and CM_PERIACTL, CM_SYSCTL and CM_VPUCTL if
> @@ -1594,9 +1683,6 @@ static int bcm2835_clk_probe(struct platform_device *pdev)
>                                   cprman->regs + CM_PERIICTL, CM_GATE_BIT,
>                                   0, &cprman->regs_lock);
> 
> -       clks[BCM2835_CLOCK_PWM] =
> -               bcm2835_register_clock(cprman, &bcm2835_clock_pwm_data);
> -
>         return of_clk_add_provider(dev->of_node, of_clk_src_onecell_get,
>                                    &cprman->onecell);
>  }
> diff --git a/include/dt-bindings/clock/bcm2835.h b/include/dt-bindings/clock/bcm2835.h
> index 61f1d20..87235ac 100644
> --- a/include/dt-bindings/clock/bcm2835.h
> +++ b/include/dt-bindings/clock/bcm2835.h
> @@ -44,5 +44,3 @@
>  #define BCM2835_CLOCK_EMMC             28
>  #define BCM2835_CLOCK_PERI_IMAGE       29
>  #define BCM2835_CLOCK_PWM              30
> -
> -#define BCM2835_CLOCK_COUNT            31
> --
> 1.7.10.4
> 
